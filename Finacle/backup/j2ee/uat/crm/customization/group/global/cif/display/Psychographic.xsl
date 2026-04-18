<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!--impoting variables wich hold the jvm properties-->
    <xsl:import href="../Renderer/common/display/getJVMProperties.xsl"/>
    <xsl:import href="../Renderer/common/display/CustomerUniqueID.xsl"/>
    <xsl:import href="../Renderer/common/display/SRMListTemplate.xsl"/>
     <!--Changes for save submit not appearing on the screen Tracker : 159776-->
    <xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"/>
    <xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"/>


<!--ERPBOCF1:TRACKER113259:STORAGE OF DATES :STARTOFCHANGES-->
	<!--tracker id 113227 changes -->
	<xsl:param name="ALTCALENDAR_TYPE"/>
	<!--ERPBOCF1:TRACKER113259: STORAGE OF DATES :ENDOFCHANGES-->

        <xsl:param name="locale"/>
    <xsl:variable name="file1">../Renderer/cif/resource/PsychographicIndividualPreference_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<xsl:variable name="configFile_1" select="document(concat($file1,''))"/>
    <xsl:variable name="configLabels_1" select="$configFile_1/SRMBO/*"/>
      <xsl:variable name="SRMTips" select="$configLabels_1[@name='Tips']/@value"/>
<xsl:variable name="fileNameBen">../../../Renderer/cif/resource/ListOfRetBeneficialOwnerSelection_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<!--Changes by Niharika for CR356016-->
   <xsl:variable name="file2">../Renderer/Customization/cif/resource/PsychographicSegmentationDetails_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<!--End of changes by Niharika for CR356016-->
<xsl:variable name="configFile_2" select="document(concat($file2,''))"/>
    <xsl:variable name="configLabels_2" select="$configFile_2/SRMBO/*"/>
    <xsl:variable name="file3">../Renderer/cif/resource/PsychoFamilyDetails_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<xsl:variable name="configFile_3" select="document(concat($file3,''))"/>
    <xsl:variable name="configLabels_3" select="$configFile_3/SRMBO/*"/>


    <xsl:variable name="file4">../Renderer/cif/resource/PsychoProductPreferenceDetails_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<xsl:variable name="configFile_4" select="document(concat($file4,''))"/>
    <xsl:variable name="configLabels_4" select="$configFile_4/SRMBO/*"/>
    <xsl:variable name="fileName_Products">../../../cif/resource/PsychoProductPreferenceDetails_<xsl:value-of select="$locale"/>.xml</xsl:variable>

<!--CIF Changes - Credit Bureau - Begin-->
    <xsl:variable name="file5">../Renderer/cif/resource/PsychoCreditBureauDetails_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<xsl:variable name="configFile_5" select="document(concat($file5,''))"/>
        <xsl:variable name="configLabels_5" select="$configFile_5/SRMBO/*"/>
        <xsl:variable name="fileName_creditBureau">../../../cif/resource/PsychoCreditBureauDetails_<xsl:value-of select="$locale"/>.xml</xsl:variable>
        <!-- CIF Changes - Credit Bureau - End-->

    	<!-- CIF Changes - Membership - Begin-->
    <xsl:variable name="file6">../Renderer/cif/resource/PsychoMembership_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<xsl:variable name="configFile_6" select="document(concat($file6,''))"/>
        <xsl:variable name="configLabels_6" select="$configFile_6/SRMBO/*"/>
        <xsl:variable name="fileName_membership">../../../cif/resource/PsychoMembership_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<!-- CIF Changes - Membership - End-->

 <!--CIF LOS Bypass change:Start-->
     <xsl:variable name="byPassFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='byPassFlag']"></xsl:variable>
 <!--CIF LOS Bypass change:End-->
	<xsl:variable name="getMCRequired" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='MCRequired']"></xsl:variable>
	<xsl:variable name="mcJNDIFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='mcJNDIFlag']"></xsl:variable>
	<xsl:variable name="isMCEdited" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='isMCEdited']"></xsl:variable>
<!--Fix for SIT ticket 246679-->
	<xsl:variable name="Prefered_locale" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Prefered_locale']"></xsl:variable>
<!--Fix for SIT ticket 246679-->
	<!-- vasanth's changes start -->
<xsl:variable name="dob" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='dob']"></xsl:variable>
    <xsl:variable name="BlackListed" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='BlackListed']"></xsl:variable>
    <xsl:variable name="Suspended" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Suspended']"></xsl:variable>
    <xsl:variable name="Negated" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Negated']"></xsl:variable>
    <xsl:variable name="chkBSN" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='chkBSN']"></xsl:variable>

	<!-- vasanth's changes end -->

  <!--******************************************-->
    	<!--<xsl:variable name="boName">PsychographicBO</xsl:variable>-->
    	<!--<xsl:variable name="BOName">PsychographicBO</xsl:variable>-->
    	<xsl:variable name="boName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='boName']"></xsl:variable>
    	<xsl:variable name="boName2" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='boName2']"></xsl:variable>
    	<xsl:variable name="boName3" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='boName3']"></xsl:variable>
    	<xsl:variable name="apprFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='apprFlag']"></xsl:variable>
    	<!--operationType inserted for Save & submit-->
    	<xsl:variable name="operationType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='operationType']"></xsl:variable>
     	<xsl:variable name="mainAccId" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='mainAccId']"></xsl:variable>
	<!--passing account Key-->
	<xsl:variable name="accKey" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='accKey']"></xsl:variable>
  <!-- Core Dependency changes -->
    <xsl:variable name="susKey" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='susKey']"></xsl:variable>
    <xsl:variable name="contKey" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='contKey']"></xsl:variable>
    <!-- Core Dependency changes -->

    <xsl:variable name="allfields" select="//SRMData//Z"/>
    <xsl:variable name="concurDetectX" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Psychographic.ConcurDetect_X']"></xsl:variable>
    <xsl:variable name="psychographicID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='PsychographicID']"></xsl:variable>
    <xsl:variable name="readMode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsReadOnly']"/>

<!-- Retail CIF changes for CampaignManagement By Mamta : Start -->
    <xsl:variable name="defCampCnt" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='defCampCnt']"/>
    <xsl:variable name="defCampFreq" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='defCampFreq']"/>
<!-- Retail CIF changes for CampaignManagement By Mamta : End -->

    <!-- CIF Changes : variable for Copy : START-->
    <xsl:variable name="isCopy" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsCopy']"></xsl:variable>
    <!-- CIF Changes : variable for Copy : END-->
    <xsl:variable name="custom_fields" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z"/>
    <!--Added for displaying Other Relationship Table only for retrieve :Start -->
    <xsl:variable name="custMinor" select="/SRM/SRMData[@SRMDataSpace='CustomData']//Z[@n='custMinor']"/>
    <xsl:variable name="NewEntry" select="/SRM/SRMData[@SRMDataSpace='CustomData']//Z[@n='NewEntry']"/>
    <xsl:variable name="AccessType" select="/SRM/SRMData[@SRMDataSpace='CustomData']//Z[@n='AccessType']"/>
<!-- Changes for Deceased CIF Starts -->
<xsl:variable name="strCustStatus" select="/SRM/SRMData[@SRMDataSpace='CustomData']//Z[@n='strCustStatus']" />
<!-- Changes for Deceased CIF Ends -->
    <xsl:variable name="ID" select="/SRM/SRMData[@SRMDataSpace='CustomData']//Z[@n='ID']"/>
    <xsl:variable name="acctID" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.AccountID')]"></xsl:variable>
    <xsl:variable name="suspID" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.SuspectID')]"></xsl:variable>
    <xsl:variable name="contID" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.ContactID')]"></xsl:variable>
    <xsl:variable name="extPri" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.External_System_Pricing')]" />

    <!--Added for displaying Other Relationship Table only for retrieve :End -->
    <!--Relationship views :Start -->
    <xsl:variable name="file7">../Renderer/cif/resource/RelationshipBO_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<xsl:variable name="configFile_7" select="document(concat($file7,''))"/>
    <xsl:variable name="configLabels_9" select="$configFile_7/SRMBO/*"/>
    <xsl:variable name="fileName">../../../cif/resource/RelationshipBO_<xsl:value-of select="$locale"/>.xml</xsl:variable>
    <xsl:variable name="fileName_otherRelation">../../../cif/resource/CorporateRelationships_<xsl:value-of select="$locale"/>.xml</xsl:variable>
    <!--Relationship views :End -->
    <xsl:variable name="file8">../Renderer/cif/resource/PsychographicLifeStyleTable_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<xsl:variable name="configFile_8" select="document(concat($file8,''))"/>
    <xsl:variable name="configLabels_10" select="$configFile_8/SRMBO/*"/>
    <xsl:variable name="fileName_LifeStyle">../../../cif/resource/PsychographicLifeStyleTable_<xsl:value-of select="$locale"/>.xml</xsl:variable>
    <!--CIF Changes: Transaction: Start-->
    <xsl:variable name="file9">../Renderer/cif/resource/PsychoTransactionTable_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<xsl:variable name="configFile_9" select="document(concat($file9,''))"/>
    <xsl:variable name="configLabels_11" select="$configFile_9/SRMBO/*"/>
    <xsl:variable name="fileName_Transaction">../../../cif/resource/PsychoTransactionTable_<xsl:value-of select="$locale"/>.xml</xsl:variable>
    <!--CIF Changes: Transaction: End-->

    <!--CIF Changes: CurrencyTab: Start-->
    <xsl:variable name="file10">../Renderer/cif/resource/PsychoCurrencyTable_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<xsl:variable name="configFile_10" select="document(concat($file10,''))"/>
         <xsl:variable name="configLabels_12" select="$configFile_10/SRMBO/*"/>
         <xsl:variable name="fileName_Currency">../../../cif/resource/PsychoCurrencyTable_<xsl:value-of select="$locale"/>.xml</xsl:variable>
    <!--CIF Changes: CurrencyTab: End-->
 <!--CIF Changes: BankingRelationship: Start-->
             <xsl:variable name="file11">../Renderer/cif/resource/RelationshipDetails_<xsl:value-of select="$locale"/>.xml</xsl:variable>
         <xsl:variable name="configFile_11" select="document(concat($file11,''))"/>
             <xsl:variable name="configLabels_13" select="$configFile_11/SRMBO/*"/>
             <xsl:variable name="fileName_Banking">../../../cif/resource/RelationshipDetails_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<xsl:variable name="fileName_Banking1">../../../cif/resource/RelationshipDetails_<xsl:value-of select="$locale"/>.xml</xsl:variable>
     <!--CIF Changes: BankingRelationship: End-->


     <!--CIF Changes: SocialRelationship: Start-->
                 <xsl:variable name="file12">../Renderer/cif/resource/SocialRelationships_<xsl:value-of select="$locale"/>.xml</xsl:variable>
             <xsl:variable name="configFile_12" select="document(concat($file12,''))"/>
                 <xsl:variable name="configLabels_14" select="$configFile_12/SRMBO/*"/>
                 <xsl:variable name="fileName_Social">../../../cif/resource/SocialRelationships_<xsl:value-of select="$locale"/>.xml</xsl:variable>
     <!--CIF Changes: SocialRelationship: End-->

     <!--CIF Changes: CorporateRelationship: Start-->
                     <xsl:variable name="file13">../../../cif/resource/CorporateRelationships_<xsl:value-of select="$locale"/>.xml</xsl:variable>
                 <xsl:variable name="configFile_13" select="$file13"/>
                     <xsl:variable name="configLabels_15" select="$configFile_13/SRMBO/*"/>
		 <xsl:variable name="fileName_Corporate">../../../cif/resource/Ret_PsychoCorpRelDetails_<xsl:value-of select="$locale"/>.xml</xsl:variable>
    <!--CIF Changes: CorporateRelationship: End-->
    <!-- Currency field changes : Start-->
    <xsl:variable name="BaseCurrency" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='BaseCurrency']"></xsl:variable>
    <!-- Currency field changes : End-->
     <!--  Tracker ID : 90197 Begin of Changes for attribute masking-->
    <xsl:variable name="AccessOwnerGroup" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccessOwnerGroup']"></xsl:variable>
     <!-- Tracker ID : 90197 End of Changes -->
<!-- CIF Changes for Caching Views : Start -->
    <xsl:param name="viewname"/>
    <xsl:variable name="PresFileName">../servlet/com.infy.cis.ui.cif.CIF_DetPresCacheServlet?ViewName=<xsl:value-of select="$viewname"/>&amp;Locale=<xsl:value-of select="$locale"/></xsl:variable>
    <xsl:variable name="PresFile" select="document(concat($PresFileName,''))"/>
    <xsl:variable name="PresData" select="$PresFile/SRM/SRMPresentation"/>
<!-- CIF Changes for Caching Views : End -->

 <!-- CIF Changes for Refcodes : Start -->
    <xsl:variable name="CustCharge" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.CustCharge')]"></xsl:variable>
    <xsl:variable name="AssetClassificationDesc" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.AssetClassificationDesc')]"></xsl:variable>
    <!--  Tracker id : 253845   -->
           <xsl:variable name="convToCust" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='convToCust']"></xsl:variable>
           <xsl:variable name="oldEntityType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='oldEntityType']"></xsl:variable>
           <xsl:variable name="oldEntityID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='oldEntityID']"></xsl:variable>
    <!--  Tracker id : 253845   -->
    <!-- Tracker:161785:Start of Changes:Hidden variable is used which was not being set when edited,hence setting it to a variable-->
    <xsl:variable name="var_Preferred_Locale" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.Preferred_Locale')]"></xsl:variable>
    <xsl:variable name="var_Preferred_Rep" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.Preferred_Rep')]"></xsl:variable>
    <!-- Tracker:161785:End of Changes -->
<!-- CIF Changes for Refcodes : End -->

    <xsl:template match="/">
    <html>
    <title><xsl:value-of select="//SRMPresentation/SRMSystem[@n='Strings']/SRMString[@n='Title']/@value"/></title>
    <head>
<script type="text/javascript" src="../cif/js/Message_cif_{$locale}.js" language="javascript"></script>
<!-- TrackerID:209607,CHANGES START -->
    <script type="text/javascript" src="../common/js/Rendcurrency_cif.js" language="javascript"></script>
    <!-- TrackerID:209607,CHANGES END -->
    <!-- Added for the relationship : start-->
        <script type="text/javascript" src="../cif/js/AccForm.js" language="javascript"></script>
<!--Changes by Niharika for CR356016-->
    <script type="text/javascript" src="../Customization/cif/js/EquityProcessCustom.js" language="javascript"></script>
<!--End of changes by Niharika for CR356016-->
<!-- Retail CIF changes for CampaignManagement By Mamta : Start -->
        <script type="text/javascript" src="../cif/js/CampaignMgt.js" language="javascript"></script>
<!-- Retail CIF changes for CampaignManagement By Mamta : Start -->

   <!-- Added for the relationship : End-->
    <!--CRM61SR:SRCIUICU :TRACKER# 44233 **BEGIN OF CHANGES-->
    	<!--Ticket 349330 changes start-->
    <script type="text/javascript" src="../Customization/js/PsychographicCustom.js" language="javascript"></script>
    	<!--Ticket 349330 changes end-->
    <!--CRM61SR:SRCIUICU :TRACKER# 44233 **END OF CHANGES-->

     <!-- vasanth's changes start -->
     <script type="text/javascript" src="../cif/js/CheckBSNFlags.js" language="javascript"></script>
	<!-- vasanth's changes end -->


    <script>
    	var extPri = '<xsl:value-of select="$extPri"></xsl:value-of>';
        var locale = '<xsl:value-of select="$locale"/>';
         <!--  Tracker ID : 90197 Begin of Changes for attribute masking-->
                var AccessOwnerGroup = '<xsl:value-of select="$AccessOwnerGroup"/>';
                 <!-- Tracker ID : 90197 End of Changes -->
	var prefRep = '<xsl:value-of select="$custom_fields[@n='PreferredRep']"/>';
	var isCopy = '<xsl:value-of select="$isCopy"/>';
	<!-- Tracker id : 253845   -->
       var convToCust = '<xsl:value-of select="$convToCust"/>';
	<!-- Tracker ID : 178861 Start of Changes -->
	var isMCEdited = '<xsl:value-of select="$isMCEdited"/>';
	<!-- Tracker ID : 178861 End of Changes -->
	var appFlag = '<xsl:value-of select="$apprFlag"/>';
	var isReadOnly = '<xsl:value-of select="$readMode"/>';
        /**********Save and Submit Changes Start*********/
	        var operationType = '<xsl:value-of select="$operationType"/>';
        /**********Save and Submit Changes End*********/
	var submit=false;
	/******************************/
	var boName = '<xsl:value-of select="$boName"/>';
	var mainAccId = '<xsl:value-of select="$mainAccId"/>';
	var btnFrmSize=30;

	<!-- vasanth's changes start -->
		var BlackListed = '<xsl:value-of select="$BlackListed"/>';
<!-- Changes for Deceased CIF Starts -->
var strCustStatus = '<xsl:value-of select="$strCustStatus"></xsl:value-of>';
<!-- Changes for Deceased CIF Ends -->
		var Suspended = '<xsl:value-of select="$Suspended"/>';
		var Negated =  '<xsl:value-of select="$Negated"/>';
		var chkBSNFlg = '<xsl:value-of select="$chkBSN"/>';
		 var dob = '<xsl:value-of select="$dob"/>';
	<!-- vasanth's changes end -->

    </script>
    <LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
    <link rel="stylesheet" Type="text/css" href="../Branding/css/common/PopupMenu_{$locale}.css"/>
    <link rel="stylesheet" Type="text/css" href="../Branding/css/common/MultiTabs_{$locale}.css"/>
    <link rel="stylesheet" type="text/css" href="../Branding/css/common/SRMTableDisplay_{$locale}.css"/>
    <link rel="stylesheet" type="text/css" href="../Branding/css/common/SRMListTemplate_{$locale}.css"/>
    <script type="text/javascript" language="javascript">
       var acctID = '<xsl:value-of select="$acctID"/>';
       var psychoID = '<xsl:value-of select="$psychographicID"/>';


<!-- Tracker ID: 108385: Begin of changes : For focus on first field -->
function focusFirstField()
{

	/*try
	{
		document.getElementsByName(boName + ".Communication_Language")[0].focus();
	}
	catch (e)
	{*/ //TrackerID113276
		try
		{
			document.getElementsByName(boName + ".Life_Cycle_Stage")[0].focus();
		}
		catch (e)
		{
			try
			{
				document.getElementsByName("Relationship")[0].focus();
			}
			catch (e)
			{
				try
				{
					document.getElementsByName("2_PsychographicBO.NumberofDependants")[0].focus();
				}
				catch (e)
				{	try
					{
						/* MATT Bug Fixing - CRM11.0 MT for Defect Ticket Id 201181 and 210240 - Begin */
						//Preferred_Address_Mode is the new first field of the screen
						document.getElementsByName("PsychographicBO.Preferred_Address_Mode")[0].focus();
						/* MATT Bug Fixing - CRM11.0 MT for Defect Ticket Id 201181 and 210240 - End */
					}
					catch (e)
					{
						try
						{
							/* MATT Bug Fixing - CRM11.0 MT for Defect Ticket Id 201181 and 210240 - Begin */
							//Preferred_Address_Mode is the new first field of the screen
							document.getElementsByName("ADD_PRODUCT_PREFERENCES")[0].focus();
							/* MATT Bug Fixing - CRM11.0 MT for Defect Ticket Id 201181 and 210240 - End */


						}
						catch (e)
						{
							try
							{
							/* MATT Bug Fixing - CRM11.0 MT for Defect Ticket Id 201181 and 210240 - Begin */
							//Preferred_Address_Mode is the new first field of the screen
							document.getElementsByName("ADD_TRANSACTION")[0].focus();
							/* MATT Bug Fixing - CRM11.0 MT for Defect Ticket Id 201181 and 210240 - End */

							}
							catch (e)
							{
							}
						}
					}
				}
			}
		}
	/* }  */  //commented by TrackerID113276
}
<!-- Tracker ID: 108385: End of changes -->
<!-- CRM11.0:TRACKER:113058:ENDOFCHANGES -->

<!-- Changes for Ticketid:-()Call id:-165698 Start(makes the Locale field readonly and on blur it does not call any other function
This is introduced in order to stop users from entering Preffered Locale) -->
/* Change for 374326 and 374328 start */
/*	function localeReadOnly()
	{
		document.getElementsByName("Cat_PsychographicBO.Preferred_Locale")[0].readOnly=true;
		document.getElementsByName("Cat_PsychographicBO.Preferred_Locale")[0].onblur="";
	}
*/
/* Change for 374326 and 374328 end */
<!-- Changes for Ticketid:-()Call id:-165698 End -->
/* Retail CIF changes for CampaignManagement By Mamta : Start */
	function loadCampaignData()
	{
		var iTotalRows = 0;
		<xsl:for-each select="//SRMPresentation/L1[@n='ContactTypes']/C1">
			allCampTypes[iTotalRows] = '<xsl:value-of select="./@value"/>';
			iTotalRows++;
		</xsl:for-each>
		iTotalRows = 0;
		<xsl:for-each select="//SRMPresentation/L1[@n='ContactFrequencies']/C1">
			allCampFreq[iTotalRows] = '<xsl:value-of select="./@value"/>';
			iTotalRows++;
		</xsl:for-each>

		var iContRows = 0;
		<xsl:for-each select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CampaignTypes']">
			campContTypes[iContRows] = '<xsl:value-of select="."/>';
			iContRows++;
		</xsl:for-each>

		iContRows = 0;
		<xsl:for-each select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CampaignFrequency']">
			campContFreq[iContRows] = '<xsl:value-of select="."/>';
			iContRows++;
		</xsl:for-each>

		iContRows = 0;
		<xsl:for-each select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CampaignCanContactCount']">
			campCanContCnt[iContRows] = '<xsl:value-of select="."/>';
			iContRows++;
		</xsl:for-each>

		defaultCanContCnt = '<xsl:value-of select="$defCampCnt"/>';
		defaultContFreq = '<xsl:value-of select="$defCampFreq"/>';
		var campFlag = false;
		var j=0;
 //call id 388594 change start
 var entityType = '<xsl:value-of select="$AccessType"/>';
 if(entityType !='Contact'){
 //call id 388594 change end
		if(iContRows > 1){
			for(var i = 0;i&lt;allCampTypes.length;i++){
				campFlag = false
				for(j = 0;j&lt;campContTypes.length;j++){
					if(allCampTypes[i] == campContTypes[j]){
						campFlag = true;
						break;
					}
				}
				if(campFlag == true &amp;&amp; campCanContCnt[j] &gt; 0){
					document.getElementsByName("ContactTypes")[i].checked = false;
					document.getElementsByName("ContactFrequencies")[i].value = campContFreq[j];
					document.getElementsByName("PsychographicBO.CampaignDependency.NoOfTimesCanContact")[i].value = campCanContCnt[j];
				}
				else{
				//Changes done for Ticket id 330289 Begin
					document.getElementsByName("Do not Contact via Channel")[0].checked = true;
				//Changes done for Ticket id 330289 Begin
					document.getElementsByName("ContactTypes")[i].checked = true;
					document.getElementsByName("ContactFrequencies")[i].value = '';
					document.getElementsByName("PsychographicBO.CampaignDependency.NoOfTimesCanContact")[i].value = '';
					document.getElementsByName("ContactFrequencies")[i].disabled = true;
					document.getElementsByName("PsychographicBO.CampaignDependency.NoOfTimesCanContact")[i].disabled = true;

					//Changes done for Ticket id 330289 Begin
					campaign = true;
					//Changes done for Ticket id 330289 End

				}
			}
		}
		}
		else{
		var entityType = '<xsl:value-of select="$AccessType"/>';

			for(var i = 0;i&lt;allCampTypes.length;i++){

			if(entityType !='Contact'){
				document.getElementsByName("ContactTypes")[i].checked = false;

				document.getElementsByName("ContactFrequencies")[i].value = defaultContFreq;
				document.getElementsByName("PsychographicBO.CampaignDependency.NoOfTimesCanContact")[i].value = defaultCanContCnt;
				document.getElementsByName("ContactFrequencies")[i].disabled = false;
				document.getElementsByName("PsychographicBO.CampaignDependency.NoOfTimesCanContact")[i].disabled = false;
			}
			}
		}
	}
	//adding function func1 for call id Tracker id:299797 and Ticket Id:490790
	function func1()
	{
	
	for(var i = 0;i&lt;allCampTypes.length;i++){
	
	num = document.getElementsByName("PsychographicBO.CampaignDependency.NoOfTimesCanContact")[i].value;
	
	if(isNaN(num))
			{
				showMessage(MSGJ50161);
				document.getElementsByName("PsychographicBO.CampaignDependency.NoOfTimesCanContact")[i].value =  "";
			
				document.getElementsByName("PsychographicBO.CampaignDependency.NoOfTimesCanContact")[i].focus();
				
			return;
		}
		var num1;
		var precision;
		precision = 0 ;
		if(NUMBER_FORMAT=="lakhs")
				 num1 = formatToLakh1(num,precision,NUMBER_SEPARATOR_TYPE,DECI_SEPARATOR_TYPE);
				else
				 num1 = formatToMillion1(num,precision,NUMBER_SEPARATOR_TYPE,DECI_SEPARATOR_TYPE);
				 
		document.getElementsByName("PsychographicBO.CampaignDependency.NoOfTimesCanContact")[i].value = num1;
	}
	}
	// end of function 
/* Retail CIF changes for CampaignManagement By Mamta : End */

       function showbuttonsVisible(frmSize) {
            parent.parent.parent.parent.setCifButtonsVisible(true,frmSize);
        }
	//function to load refCodes
	function loadCode()
	{
		document.getElementsByName(boName + '.CustCharge')[0].value = '<xsl:value-of select="$CustCharge"/>';
		<!--document.getElementsByName(boName + '.AssetClassificationDesc')[0].value = '<xsl:value-of select="$AssetClassificationDesc"/>'; -->
	}


	function formatUser()
	{
		try{
	  //changes by Rozy for CNF

	    formatNumber("3_PsychographicBO.prefRelshipDiscount1");
	    formatNumber("3_PsychographicBO.prefRelshipDiscount2");
	    formatPercent("3_PsychographicBO.prefRelshipDiscountPercent1");
	    formatPercent("3_PsychographicBO.prefRelshipDiscountPercent2");
	    formatNumber("2_PsychographicBO.NumberofDependantChildren");
	    formatNumber("2_PsychographicBO.NumberofDependants");
		}catch(e){}

	    document.frm2.PreferredRep.value = prefRep;
	    if(document.frm2.byPassFlag.value=='Y'){
	    		showDependentTabOnly();
		}
	}function setMCAttModifyFlag(){
		document.frm2.isMCEditedPsycho.value="Y";

	}

	function showDependentTabOnly()
	{
		var elements = document.getElementsByTagName("input");
		for (var i=0; i&lt;elements.length ; i++) {
		    	if((elements[i].name=="Add LifeStyle")||(elements[i].name=="Remove LifeStyle")||
		    	(elements[i].name=="Add Relationship")||(elements[i].name=="Remove Relationship")||(elements[i].name=="...")){
		    		disableField (elements[i]);
		    	}

    		}
		var selElems = document.getElementsByTagName("select");
		document.getElementById("td_tpageIPre").disabled = true;
		document.getElementById("td_tpageIPre").style.visibility="hidden";
		document.getElementById("det_tpageIPre").style.visibility="hidden";
		hideDetailstabPsyForm('tpageIPre');
		document.getElementById("td_tpageSeg").disabled = true;
		document.getElementById("td_tpageSeg").style.visibility="hidden";
		document.getElementById("det_tpageSeg").style.visibility="hidden";
		hideDetailstabPsyForm('tpageSeg');
		document.getElementById("td_tpageProductPreference").disabled = true;
		document.getElementById("td_tpageProductPreference").style.visibility="hidden";
		document.getElementById("det_tpageProductPreference").style.visibility="hidden";
		hideDetailstabPsyForm('tpageProductPreference');
		document.getElementById("td_tpageTrans").disabled = true;
		document.getElementById("td_tpageTrans").style.visibility="hidden";
		document.getElementById("det_tpageTrans").style.visibility="hidden";
		hideDetailstabPsyForm('tpageTrans');
		//Tracker id 141022 start
		document.getElementById("td_tpageRel").disabled = true;
		document.getElementById("td_tpageRel").style.visibility="hidden";
		document.getElementById("det_tpageRel").style.visibility="hidden";
		hideDetailstabPsyForm('tpageRel');
		//Tracker id 141022 end
		/* Recon from 10.2.06 for TrackerId 292745 : begin */
		/* Fix for CallId 259108 : begin */
		// document.getElementById("td_tpageCurr").disabled = true;
		// document.getElementById("td_tpageCurr").style.visibility="hidden";
		// document.getElementById("det_tpageCurr").style.visibility="hidden";
		hideDetailstabPsyForm('tpageCurr');
		/* Fix for CallId 259108 : end */
		/* Recon from 10.2.06 for TrackerId 292745 : end */
		hideDetailstabPsyForm('tpageTrans');

	<!-- CRM70t-ST TrackerId : 80201 ** BEGIN OF CHANGES ** -->
		showbuttonsVisible(45);
	<!-- CRM70t-ST TrackerId : 80201 ** END OF CHANGES ** -->

	}



       //CIF Tabbing and Saving Changes
    	<!-- CRM102ST TrackerID:165886 Begin of Change -->
    	function closebtn(){
    	<!-- CRM102ST: TrackerID:166115 Begin of Change -->
    		if(psychoID ==0){
    	<!-- CRM102ST: TrackerID:166115 Begin of Change -->
    			parent.frames(0).location.href = parent.frames(0).location.href;

            <!-- Changes for call id 445750 starts here -->
    		}  //else if(!submit){
    		else{
               		top.window.close();
            <!-- Changes for call id 445750 ends here -->
               }
      	}
	function refreshParent(){
		frm = top.opener.parent.frames(1);
		frm.navigate (frm.location.href);
	}
	<!-- CRM102ST: TrackerID:165886 End of Change -->
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
       	 //BaseLineChange blFlag missed while merging
       	 function save(blFlag){
		try{
		/*ticket id 209234 tracker id 125013 changes starts*/
		//tracker id 113227 changes

		if(document.frm2.isMCEdited.value=="Y"){
			document.frm2.isMCEditedPsycho.value="Y";
		}
		else{
			document.frm2.isMCEditedPsycho.value="N"; //else added as part of TOL 365602
		}
		/*ticket id 209234 tracker id 125013 changes ends*/

		if(operationType!="Edit Entity"){
		if(operationType!="Queue"){
				document.frm2.isMCEditedPsycho.value=parent.parent.IFrmtab0.formDispFrame.document.frm2.isMCEditedGeneral.value;
			}
			else{
			      document.frm2.isMCEditedPsycho.value = isMCEdited;
			}
		}
		//changes by Rozy for CNF

		 //tracker id 113227 changes
		//FormatBeforeSave_Number('2_NumberofDependants');
		//FormatBeforeSave_Number('2_NumberofDependantChildren');

		}catch(e){
		}
		//Field Addition Tracker 172089:start of Changes

		var sSelAct = "";
		for (i=0; i &lt; document.frm2.nature_of_act.length ; i++) {
		if(document.frm2.nature_of_act.length ==1){
				sSelAct = document.frm2.nature_of_act.options[i].value;
		}else{
			sSelAct += document.frm2.nature_of_act.options[i].value + ",";
		}
		}
		document.frm2.nature_activity.value = sSelAct;
		//Field Addition Tracker 172089:end of Changes

			var hasErrors = "";
        	var selTabId;
			var frameobj;

		var chkMinID;
		//tracker id 113227 changes
		//chkMinID = document.all.CurrencyDetRecordSet.rows.length - 2;

			if(blFlag == true)
			{
				if(chkMinID &lt;= 0)
				{
					parent.parent.parent.parent.messageFrm.removeMessages(selTabId);
					parent.parent.parent.parent.messageFrm.addMessage(selTabId,getUserMessage("MSGJ50726",""),TBODY_CurrencyDetRecordSet.rows ,'NO_HLINK');
					parent.parent.parent.parent.messageFrm.showMessages(selTabId);
					return "interactive"
				}
			}
		if (top.frames(0).tabViewFrm==null)
		{
					frameobj = parent.parent.parent.parent;
					selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
				}else{
					frameobj = top.frames(0);
					selTabId = top.frames(0).tabViewFrm.getSelectedTabId();
				}

			/*
			 * Fix for save not happening
			 * This variable will come as undefined some times, hence will cause issue
			 */
			 try{
				hasErrors = ValidateDateFields(getUserMessage("MSG_DOB","dob"),dob);
			  }catch(e){}
			/* END OF CHANGES */

			if(hasErrors == "true") {
					parent.parent.parent.parent.messageFrm.showMessages(selTabId);
					return "interactive";
			}

		var newflg = "N";
		var Type = '<xsl:value-of select="$AccessType"/>';
		if(Type=="Prospect"){
			Type="Suspect";
			}
		else{
			Type = Type;
		}
		var suspID = '<xsl:value-of select="$suspID"/>';
		var contID = '<xsl:value-of select="$contID"/>';
		if(suspID !=""){
			acctID=suspID;
		}
		else if(contID!=""){
			acctID=contID;
		}


		var accountId = parent.parent.IFrmtab0.formDispFrame.document.getElementsByName("accID")[0].value;


		if(accountId != "" || acctID!="" || acctID!=null)
				{
					if(accountId!="")
					{
						//Save and Submit Changes Passing the blFlag to save1()
						temp = save1(accountId,Type, newflg,blFlag);
					}
					else {
			/****** Save and Submit Changes : If SUBMIT pressed, do the Validation for all the Form Elements: Start*****/
				/*if(blFlag == true) {
					noValidationMsg = false;
				}
				else {
					noValidationMsg = true;
			    	}*/
				//var retStat = parent.parent.parent.parent.ValidateFormContents(document.frm2,true,noValidationMsg);
				var retStat = "true";
				if(retStat=="false"){
					return "interactive";
				 }
			/****** Save and Submit Changes : If SUBMIT pressed, do the Validation for all the Form Elements: End*****/
				//Save and Submit Changes Passing the blFlag to save1()
				var temp = save1(acctID,Type, newflg,blFlag);
			}
			if(temp == true){
				return "true";
			} else {
				return "false";
			}
		} else {
			showMessage(MSGX0041);
			return "false";
		}
	   }
//Changes begin for Tracker:97346

      function check(Tab,setFlag) {

	if(setFlag == false) {
		noValidationMsg = true;
	}
	else {
		noValidationMsg = false;
	}
		removePercentFormat('3_PsychographicBO.prefRelshipDiscountPercent1');
		FormatBeforeSave_Number('3_PsychographicBO.prefRelshipDiscount1');
		removePercentFormat('3_PsychographicBO.prefRelshipDiscountPercent2');
		FormatBeforeSave_Number('3_PsychographicBO.prefRelshipDiscount2');
        return parent.parent.parent.parent.ValidateFormContents(document.frm2,true,noValidationMsg,Tab);

       }

       function setFocusOnComp(compName) {
	    var elementName = document.getElementsByName(compName)[0];
	    if(elementName) {
		if(elementName.displayFieldName){
			elementName = document.getElementsByName(elementName.displayFieldName)[0];
		}
		if (elementName.type == "text" || elementName.type == "textarea")
		{
			elementName.select();
		}else{
			elementName.focus();
		}
	    }
       }
//Changes end for Tracker:97346


 //CIF Tabbing and Saving Changes
       function clear() {
	     var acctID = '<xsl:value-of select="$acctID"/>';
	     var suspID = '<xsl:value-of select="$suspID"/>';
	     var contID = '<xsl:value-of select="$contID"/>';
	     if(suspID !=""){
			 acctID=suspID;
		 }
	    if(contID !=""){
		 acctID=contID;
		 }
	     if(acctID =="" || acctID == null )
		{
		//CREATE
			document.getElementsByName("accID")[0].value = parent.formSaveFrame.savedValue;
		}
		/*Ticket ID 252469 Changes Begin*/
		//Commenting code so that process selection window opens properly
		//self.location.reload(true);
		/*Ticket ID 252469 Changes End*/
    	}
  /*
   * Sanity Fix Subodh Commented this since it was a wrong fix
   */
    /*function closebtn(){
	    			top.window.close();
	}*/
  /* END OF CHANGES */
        function selectProcess(){

		if(isMCEdited=="N" &amp;&amp; document.frm2.isMCEditedPsycho.value=="N"){/* 558180 changes */
       			appFlag="false";
       		}
		submit = true;
		//...added by vishal....
		var entityType = '<xsl:value-of select="$AccessType"/>';
	     var acctID = '<xsl:value-of select="$acctID"/>';
	     var suspID = '<xsl:value-of select="$suspID"/>';
	     var contID = '<xsl:value-of select="$contID"/>';
	     if(suspID !=""){
			 acctID=suspID;
		 }
	    if(contID !=""){
		 acctID=contID;
		 }

		 var accountId  = acctID;
		 var savedID  = parent.formSaveFrame.savedValue;
		if( appFlag=='true' &amp;&amp; mainAccId == '')
		  {
		  entityType = entityType+"Mod";
		  accountId  = savedID;
		  }
	  /**********Save and Submit Changes :Setting the process for SUBMITTED entity from the EntityQueue when ApprovalDisabled:start*****/
		  if(appFlag=='false')
		   {
			 entityType = entityType;
			 accountId  = savedID;
		  }
      /**********Save and Submit Changes :Setting the process for SUBMITTED entity from the EntityQueue when ApprovalDisabled:end*********/


		  if(mainAccId != '') entityType = entityType+"Mod";


		if(!(document.frm2.byPassFlag.value=="Y")){
//Checksum recon from 10.3 SUPP
			var secureHKey = document.getElementsByName("SECUREHKEY")[0].value;
			var keyField = document.getElementsByName("FLDHASHKEY")[0].value;
			/*Tracker :93811 Fix start */
			/*Changes by Niharika for CR356016*/
			//window.open('../../../servlet/com.infy.cis.ui.cif.CIFProcessSelectionDetWizard?entityId='+accountId+'&amp;entityType='+entityType+'&amp;SECUREHKEY='+secureHKey+'&amp;FLDHASHKEY='+keyField+'&amp;isPopup=Yes','save','directories=No, height=436, left=210, top=120, width=575, location=no, menubar=no, resizable=no, status=no, toolbar=no, scrollbars=yes');
            var strProcessURL = '../servlet/com.infy.cis.custom.EquityRetailProcessSelection?entityId='+accountId+'&amp;entityType='+entityType;
			var strBOURL = 'abc';
			fnProcessSelection(strProcessURL, strBOURL);
			top.window.close();
           /*End of changes by Niharika for CR356016*/
			/*Tracker :93811 Fix End */
		}
        }



 function shouldRefresh()
 {

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
       function txtLimit(field, max,str1,str2) {
		if (field.value.length > max + 1){
		var tempList = new Array();
  tempList[0] = str2;
  tempList[1] = max;
  showUserMessage(MSGX0054,tempList);
		document.getElementsByName(str1)[0].focus();
		return "interactive"
		}
	}






       function save1(accountId,Type, newflg,blFlag) {
    // CRM61SR:SRCIUICU :TRACKER# 44233 **BEGIN OF CHANGES **
        try{
        customSave();
        }catch(e)
        { }

    // CRM61SR:SRCIUICU :TRACKER# 44233 **END OF CHANGES  **

            var flag = false;
            if(accountId != null &amp;&amp; accountId != "0"){
                getAndSetAllHobbies();

/* Retail CIF changes for CampaignManagement By Mamta : Start */
	      	if(campaignAccessType != 'Contact'){
	                getAndSetAllCampaigns();
		}
/* Retail CIF changes for CampaignManagement By Mamta : Start */

                saveRelationship();
		if(!(document.frm2.byPassFlag.value=='Y')){
		/* Tracker id : 253845   */
			if(psychoID != "0" &amp;&amp; Type == "Account"&amp;&amp; document.frm2.IsCopy.value!="Y" &amp;&amp; document.frm2.convToCust.value!="Y"){
				/* TRACKER ID : 102230 : BEGIN OF CHANGES */
				//                var retStat = hasIntro();
				                var retStat = checkPrimaryIntroducer();
				/* TRACKER ID : 102230 : END OF CHANGES */
				if(retStat=="false"){
					return "interactive";
				}
			}
		}
                saveLifeStyle();
                saveProductPref();
                <!--CIF Changes - Transaction - Begin-->
		 saveTransaction();
                <!--CIF Changes - Transaction - End-->
                saveCurrencyDet();
                <!-- CIF Changes - Credit Bureau - Begin -->
		       saveCreditBureau();
		<!-- CIF Changes - Credit Bureau - End -->
		<!-- CIF Changes - Membership - Begin-->
		       saveMembership();
                <!-- CIF Changes - Membership - End-->

                saveBeneficialOwner();

                <!--getting account Key-->
                if(Type == "Account"){
			document.getElementsByName("accKey")[0].value = parent.parent.IFrmtab0.formDispFrame.document.getElementsByName("accKey")[0].value;
			var accountKey = document.frm2.accKey.value;
			document.getElementsByName("ModAccID")[0].value = parent.parent.IFrmtab0.formDispFrame.document.getElementsByName("ModAccID")[0].value;
			document.getElementsByName("CoreCustID")[0].value = parent.parent.IFrmtab0.formDispFrame.document.getElementsByName("CoreCustID")[0].value;
		}
		else if(Type == "Suspect") {
			document.getElementsByName("accKey")[0].value = parent.parent.IFrmtab0.formDispFrame.document.getElementsByName("susKey")[0].value;
			document.getElementsByName("ModAccID")[0].value = parent.parent.IFrmtab0.formDispFrame.document.getElementsByName("modSusID")[0].value;
		}
		else if(Type == "Contact") {
			document.getElementsByName("accKey")[0].value = parent.parent.IFrmtab0.formDispFrame.document.getElementsByName("contKey")[0].value;
			document.getElementsByName("ModAccID")[0].value = parent.parent.IFrmtab0.formDispFrame.document.getElementsByName("modContID")[0].value;
		}
		/********* Save and Submit Changes : Setting saveFlag=1 for SAVE and saveFlag=0 for SUBMIT:Start***********/
		if (blFlag==false){
			document.frm2.saveFlag.value=1;
		}
		 else{
			document.frm2.saveFlag.value=0;
		}
		/********* Save and Submit Changes : Setting saveFlag=1 for SAVE and saveFlag=0 for SUBMIT:End***********/
                var approvalFlag = document.frm2.apprFlag.value;


/**********ERPBOCF1:TRACKER:113259:STORAGE OF DATES :STARTOFCHANGES***********/
	/**********ERPBOCF1:TRACKER:113259:STORAGE OF DATES :STARTOFCHANGES***********
		for defetc during MATPT CIF Retail ->
		New Entity ->Prospect 'document.getElementsByTagName(...).6.style' is null or not an object
		function fnConvertDate();was commented earlier */

		fnConvertDate();
		/*************ERPBOCF1:TRACKER:113259:STORAGE OF DATES :ENDOFCHANGES****DEFECT MATPT*******/

/*************ERPBOCF1:TRACKER:113259:STORAGE OF DATES :ENDOFCHANGES***********/

                 /* Null Changes Begin */
                    var frame = 'formSaveFrame';
                    newPara = document.getElementById("myPar");
                    phycoURL="../servlet/com.infy.cis.ui.common.PsychographicWriter?accountId=" + accountId+'&amp;operationType=' + operationType +'&amp;Type=' + Type + '&amp;newflag=' + newflg +'&amp;apprFlag='+approvalFlag;
                    fnRemoveNull(newPara,phycoURL,document.frm2,frame);
                 /* Null Chnges End */
                /****Save and Submit Changes : Passing operationType on the URL to the Writer:Start****/
                <!-- TrackerID:209607,CHANGES START -->
		 //document.frm2.action = "../servlet/com.infy.cis.ui.common.PsychographicWriter?accountId=" + accountId+'&amp;operationType=' + operationType +'&amp;Type=' + Type + '&amp;newflag=' + newflg +'&amp;apprFlag='+approvalFlag;
               /****Save and Submit Changes : Passing operationType on the URL to the Writer:End****/
                //document.frm2.target='formSaveFrame';
                //document.frm2.submit();
                <!-- TrackerID:209607,CHANGES END -->
                return true;
            }
            return flag;
        }

            /*CIF Changes: Hide Transaction Tab : start */

		function hideTransAndCurr(){
		var accessType = document.frm2.AccessType.value;
		if((accessType == "Prospect") || (accessType == "Contact")){
		document.getElementById("td_tpageTrans").disabled = true;
		document.getElementById("td_tpageTrans").style.visibility="hidden";
		document.getElementById("det_tpageTrans").style.visibility="hidden";
		hideDetailstabPsyForm('tpageTrans');
		//Hiding Currency Details Tab:start
		var accessType = document.frm2.AccessType.value;
		if((accessType == "Prospect") || (accessType == "Contact")){

		// Change for Ticket 353275
			//document.getElementById("td_tpageCurr").disabled = true;
			//document.getElementById("td_tpageCurr").style.visibility="hidden";
			//document.getElementById("det_tpageCurr").style.visibility="hidden";
			hideDetailstabPsyForm('tpageCurr');
		}
		//Hiding Currency Details Tab:end
		}
		}
	   /*CIF Changes: Hide Transaction Tab : end */

	/*function for collapse of hobbies : Start**/
        function Toggle_Hobbies(id){
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
        function getAndSetAllHobbies() {
            var e='';
            ifrm2 = document.frm2;
            for(var i=0;i &lt; ifrm2.elements.length ;i++){
                if(ifrm2.elements[i].type == 'checkbox'){
/* Retail CIF changes for CampaignManagement By Mamta : Start*/
	/* fix for call id 344978*/
	    if(ifrm2.elements[i].name != 'ContactTypes' &amp;&amp; frm2.elements[i].name != 'Do not Contact via Channel'){
                    if(ifrm2.elements[i].checked){
                        e=e + ifrm2.elements[i].name + ',';
                        var last=e.lastIndexOf(',');
                    }
               }
/* Retail CIF changes for CampaignManagement By Mamta : End*/
               }
            }
            e=e.substr(0,last);
            ifrm2.Cust_Hobbies.value=e;
        }
        /*function for collapse of hobbies : End**/
        function formatPsychoIntField(){
        	if(document.getElementsByName("3_PsychographicBO.prefRelshipDiscountPercent1")[0].value != ""){
        		formatInt(document.getElementsByName("3_PsychographicBO.prefRelshipDiscountPercent1")[0],gettingDigitGroupNumber());
        	}
        	if(document.getElementsByName("3_PsychographicBO.prefRelshipDiscountPercent2")[0].value != ""){
        		formatInt(document.getElementsByName("3_PsychographicBO.prefRelshipDiscountPercent2")[0],gettingDigitGroupNumber());
		}
        }
        function formatPsychoIntFieldRead(){
        	if(document.getElementsByName("PsychographicBO.prefRelshipDiscountPercent1")[0].value != ""){
        		formatInt(document.getElementsByName("PsychographicBO.prefRelshipDiscountPercent1")[0],gettingDigitGroupNumber());
        	}
        	if(document.getElementsByName("PsychographicBO.prefRelshipDiscountPercent2")[0].value != ""){
        		formatInt(document.getElementsByName("PsychographicBO.prefRelshipDiscountPercent2")[0],gettingDigitGroupNumber());
		}
        }

   <!-- /* TRACKER ID 49964 BEGIN OF CHANGES */ -->
   <![CDATA[
       function FieldsForValidation(){
           try{
               var selTabId = top.frames(0).tabViewFrm.getSelectedTabId();
               var numberofDependants = document.getElementsByName("2_PsychographicBO.NumberofDependants")[0];
               var numberofDependantChildren = document.getElementsByName("2_PsychographicBO.NumberofDependantChildren")[0];
               if(parseInt(numberofDependantChildren.value) > parseInt(numberofDependants.value)){
                   var msg = new Array();
                   msg[0] = new String(getLabel(numberofDependants.Display));
                   msg[1] = new String(getLabel(numberofDependantChildren.Display));
                   top.frames(0).messageFrm.addMessage(selTabId, getUserMessage('MSG017',msg), numberofDependants.name , 'HYPER_LINK');
                   top.frames(0).messageFrm.showMessages(selTabId);
                   return "false";
               }else return "true";
           }catch(e){
           }
       }
     ]]>
 <!-- /* TRACKER ID 49964 BEGIN OF CHANGES */ -->
   <![CDATA[
function fnBlurfunction(Type){
try{
var check = chkBlurFrom1();
			if(check)
			{

				var manager = "";
				//var Type = "RelationshipCreatedBy";
				if(Type == "PrefRep")
				{
				//fngetPreferred_Rep();
				 manager = document.frm2.PreferredRep.value;

				  //Changes Start:Ticket ID 210879
				 if(manager=='')
				 {
					return;
				}
              			//Changes End:Ticket ID 210879
				}
				var s_xmlHttp = new ActiveXObject("MSXML2.XMLHTTP");
				var strURL = '../servlet/com.infy.cis.ui.cif.CifLookupValidate?Manager='+manager+"&Type="+Type;
				s_xmlHttp.open("GET",strURL,false);
				s_xmlHttp.send();
				var lastName = '';
				if(s_xmlHttp.status == 200)
				{
					lastName = s_xmlHttp.responseXML.text;
					var neha = new Array();
					neha = lastName.split("^");
					if(neha=='False' || neha == 'false' ){
					showUserMessage(MSGJ50716,"");
					clearAgentLookup();
					//Start:TrackerID 125612
					document.getElementsByName("PreferredRep")[0].focus();
					//End:TrackerID125612
					}

				}

			}
			else{
				openAgentLookup();
			}


}catch(e){
	alert("error :"+e.message);
}

}
     ]]>
	/* *** Tracker# 49738, Begin of Changes *** */
	function  openAgentLookup()	{
		var url = "../servlet/com.infy.cis.ui.common.Lookup?Mode=ForAgent";
			/* Tracker-id:108379 Changes for centering Lookup BEGIN */
				// hardcoded values
				var wh = 460;
				var ww = 900;
				// end hardcoded values
				var left_x = (screen.width - ww) / 2 ;
				var left_y = (screen.height - wh) / 2 ;
				/*Tracker:108379:End of changes*/

				/*Tracker:108379:Changes for Centering popup*/
				window.open (url, "Lookup", 'height='+wh+',left='+left_x+',top='+left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes');
		/* Tracker-id:108379 Changes for centering Lookup END */
	}
	function  clearAgentLookup()	{
		document.frm2.PreferredRep.value = "";
		document.getElementsByName("PsychographicBO.Preferred_Rep")[0].value = "";
	}
	function  onRecordSelect()	{
		document.frm2.PreferredRep.value = getCookie("LookupAgentName");
		document.getElementsByName("PsychographicBO.Preferred_Rep")[0].value = getCookie("AgentID");
	       document.getElementsByName("PsychographicBO.Preferred_Rep")[0].fireEvent("onChange");
	}
	/* *** Tracker# 49738, End of Changes *** */

<!-- relationship changes-->
	function selectRecordSet()
	{
	var Relationship = document.getElementsByName("Relationship")[0].value;
	<!-- Ticket 343819:Start -->
	if(isReadOnly =='Y'){
	document.getElementsByName("Relationship")[0].disabled = false;
	}
	<!-- Ticket 343819:End -->
		  document.getElementsByName("Banking")[0].style.display="none";
		  document.getElementsByName("Social")[0].style.display="none";
		  document.getElementsByName("Corporate")[0].style.display="none";
		  document.getElementsByName("add_bankrelationship")[0].disabled = false;
		  document.getElementsByName("remove_bankrelationship")[0].disabled = false;
		 if (Relationship=='Social') {
				   document.getElementsByName("Social")[0].style.visibility="visible";
				   document.getElementsByName("Social")[0].style.display="";
				   if(isReadOnly == 'Y')
				   {
					   document.getElementsByName("add_bankrelationship")[0].disabled = true;
					   document.getElementsByName("remove_bankrelationship")[0].disabled = true;
				   }
					   document.getElementsByName("Beneficial Owner")[0].style.visibility="hidden";
				  	   document.getElementsByName("Beneficial Owner")[0].style.display="";
					   document.getElementsByName("Banking1")[0].style.visibility="hidden";
					   document.getElementsByName("Banking2")[0].style.visibility="hidden";
				} else if (Relationship=='Corporate' ) {
				   document.getElementsByName("Corporate")[0].style.visibility="visible";
				   document.getElementsByName("Corporate")[0].style.display="";
				   document.getElementsByName("add_bankrelationship")[0].disabled = true;
				   document.getElementsByName("remove_bankrelationship")[0].disabled = true;
				   document.getElementsByName("Beneficial Owner")[0].style.visibility="hidden";
				   document.getElementsByName("Beneficial Owner")[0].style.display="";
				   document.getElementsByName("Banking1")[0].style.visibility="hidden";
			           document.getElementsByName("Banking2")[0].style.visibility="hidden";

				} else {
				   document.getElementsByName("Banking")[0].style.visibility="visible";
				   document.getElementsByName("Banking")[0].style.display="";
				   document.getElementsByName("Banking1")[0].style.visibility="visible";
				   document.getElementsByName("Banking1")[0].style.display="";

				   document.getElementsByName("Banking2")[0].style.visibility="visible";
				   document.getElementsByName("Banking2")[0].style.display="";


				   document.getElementsByName("Beneficial Owner")[0].style.visibility="visible";
				   document.getElementsByName("Beneficial Owner")[0].style.display="";
				   if(isReadOnly == 'Y')
				   		   {
				   			   document.getElementsByName("add_bankrelationship")[0].disabled = true;
				   			   document.getElementsByName("remove_bankrelationship")[0].disabled = true;
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

	function enableRel()
		{
		document.getElementsByName("Relationship")[0].disabled = false;

	}

	/*Changes for CIF Pricing Enhancement - Start */
function disableCustomerPricing()
 	{
 	try{
 		document.getElementsByName("PsychographicBO.Relationship_Pricing_ID")[0].disabled=true;
 		document.getElementsByName("3_PsychographicBO.Pricing_Effective_Date")[0].disabled=true;
 		document.getElementsByTagName("img")[3].style.display="none";
 		document.getElementsByName("3_PsychographicBO.Pricing_Review_Date")[0].disabled=true;
 		document.getElementsByTagName("img")[2].style.display="none";
 		document.getElementsByName("mandStarPsychographicBO.Pricing_Effective_Date")[0].style.visibility="hidden";
 		document.getElementsByName("mandStarPsychographicBO.Pricing_Review_Date")[0].style.visibility="hidden";
 		document.getElementsByName("3_PsychographicBO.Pricing_Effective_Date")[0].IsMandatory = "false";
 		document.getElementsByName("3_PsychographicBO.Pricing_Review_Date")[0].IsMandatory = "false";
 		}catch(e){
 		}

 	}

 	function selectExtPricing()
 	{
 		try{
 		var tmpExtPri = document.getElementsByName("PsychographicBO.External_System_Pricing")[0];
 	 	var len = tmpExtPri.length;

 		validateRelationshipID("PsychographicModBO.External_System_Pricing");
 		}catch(e){
 		//alert(e.message);
 		}
 	 }

 	function validateRelationshipID(selectname)
 	{
		//alert("amit   "+boName );
		//alert("selectname   "+selectname );
		//alert("amit 1  "+document.getElementsByName(boName+".External_System_Pricing")[0].value);
		//alert("amit 2  "+document.getElementsByName("PsychographicBO.External_System_Pricing")[0].value );
		//alert("amit 3  "+document.getElementsByName("PsychographicModBO.External_System_Pricing")[0].value );

		var index = document.getElementsByName(selectname)[1].selectedIndex;
		var external_pricing = document.getElementsByName(selectname)[1].options[index].text;

		//alert("localeVal>>"+localeVal);
 		//var external_pricing = document.getElementsByName(boName+".External_System_Pricing")[0].value;
 		//var external_pricing = document.getElementsByName("PsychographicModBO.External_System_Pricing")[0].value;
 		//var external_pricing = document.getElementsByName("Psychographic.External_System_Pricing")[0].value;
		//alert("amit  "+external_pricing );

 	 	if (external_pricing == "Y" )
 	 	 {
			 document.getElementsByName("PsychographicBO.Relationship_Pricing_ID")[0].disabled=false;
 	 		 makePricingDatesMand();
 	 	  }
 		else
 		  {
 			  document.getElementsByName("mandStarPsychographicBO.Pricing_Effective_Date")[0].style.visibility="hidden";
 	    	  document.getElementsByName("mandStarPsychographicBO.Pricing_Review_Date")[0].style.visibility="hidden";
 			  document.getElementsByName("PsychographicBO.Relationship_Pricing_ID")[0].value="";
 			  document.getElementsByName("3_PsychographicBO.Pricing_Effective_Date")[0].value="";
 			  document.getElementsByName("3_PsychographicBO.Pricing_Review_Date")[0].value="";
 			  document.getElementsByName("PsychographicBO.Relationship_Pricing_ID")[0].disabled=true;
 			  document.getElementsByName("3_PsychographicBO.Pricing_Effective_Date")[0].disabled=true;
 			  document.getElementsByTagName("img")[3].style.display="none";
 		          document.getElementsByName("3_PsychographicBO.Pricing_Review_Date")[0].disabled=true;
 		          document.getElementsByTagName("img")[2].style.display="none";
 		          document.getElementsByName("3_PsychographicBO.Pricing_Effective_Date")[0].IsMandatory = "false";
 			  document.getElementsByName("3_PsychographicBO.Pricing_Review_Date")[0].IsMandatory = "false";
 		  }
 	}

 	function makePricingDatesMand()
 	{

 	   if(trim(document.getElementsByName("PsychographicBO.Relationship_Pricing_ID")[0].value)!='')
 	     {
 	         document.getElementsByName("3_PsychographicBO.Pricing_Effective_Date")[0].disabled=false;
 	    	 document.getElementsByTagName("img")[3].style.display="";
 	         document.getElementsByName("3_PsychographicBO.Pricing_Effective_Date")[0].IsMandatory = "true";
 	         document.getElementsByName("mandStarPsychographicBO.Pricing_Effective_Date")[0].style.visibility="visible";
 	         document.getElementsByName("3_PsychographicBO.Pricing_Review_Date")[0].disabled=false;
 	         document.getElementsByName("3_PsychographicBO.Pricing_Review_Date")[0].IsMandatory = "true";
 	         document.getElementsByName("mandStarPsychographicBO.Pricing_Review_Date")[0].style.visibility="visible";
 	   	 document.getElementsByTagName("img")[2].style.display="";


 	    }
 	   else
 	   {
 	   	document.getElementsByName("3_PsychographicBO.Pricing_Effective_Date")[0].IsMandatory = "false";
 	   	document.getElementsByName("mandStarPsychographicBO.Pricing_Effective_Date")[0].style.visibility="hidden";
 	   	document.getElementsByTagName("img")[3].style.display="none";
 	   	document.getElementsByName("3_PsychographicBO.Pricing_Review_Date")[0].IsMandatory = "false";
 	    	document.getElementsByName("mandStarPsychographicBO.Pricing_Review_Date")[0].style.visibility="hidden";
 	       	document.getElementsByName("3_PsychographicBO.Pricing_Effective_Date")[0].value="";
 	  	document.getElementsByName("3_PsychographicBO.Pricing_Review_Date")[0].value="";
 	  	document.getElementsByName("3_PsychographicBO.Pricing_Effective_Date")[0].disabled=true;
 	        document.getElementsByName("3_PsychographicBO.Pricing_Review_Date")[0].disabled=true;
 	        document.getElementsByTagName("img")[2].style.display="none";
 	   }

 	}

  
  function validate_Effective_Date(elem)
  {
  effective_date = document.getElementsByName(elem)[0].value;
  var todaydate = new String();
   	todaydate.value =  getTodayDate1();
   	todaydate.value = convertDate(todaydate.value);
   	var currDate = changetoMillis(todaydate.value);	
   	var mill1 = changetoMillis(effective_date);
  	if(effective_date!='') {		
  		if(currDate>mill1){
  			showMessage(MSGJ51308);
  			document.getElementsByName(elem)[0].value = "";
  			document.getElementsByName(elem)[0].focus();
  			return "false";
  		}	
  	}
  	return "true";
  }
  
  function validate_Review_Date(elem)
  {
  review_date = document.getElementsByName(elem)[0].value;
  eff_date = document.getElementsByName("3_PsychographicBO.Pricing_Effective_Date")[0].value;
  var todaydate = new String();
   	todaydate.value =  getTodayDate1();
   	todaydate.value = convertDate(todaydate.value);
   	var currDate = changetoMillis(todaydate.value);	
   	var mill1 = changetoMillis(review_date);
   	var mill2 = changetoMillis(eff_date );
  	if(review_date!='') {		
  		if(currDate>mill1){
  		 	showMessage(MSGJ51309);
  			document.getElementsByName(elem)[0].value = "";
  			document.getElementsByName(elem)[0].focus();
  			return "false";
  			}
  			if(mill2>mill1){
  				showMessage(MSGJ51310);
  				document.getElementsByName(elem)[0].value = "";
  				document.getElementsByName(elem)[0].focus();
  				return "false";
  			}		
  	}
  	return "true";
}

    /*Changes for CIF Pricing Enhancement -End */

/* Changes done by Kanika For Cif Deceased Starts */
function fnOnLoadDisableDcsd(){
	if(strCustStatus == "DCSED"){
		for(var i = 0;i&lt;allCampTypes.length;i++){
			//document.getElementsByName("ContactTypes")[i].checked = true;
			document.getElementsByName("ContactTypes")[i].disabled = true;
			//document.getElementsByName("ContactFrequencies")[i].value = "";
			document.getElementsByName("ContactFrequencies")[i].disabled = true;
			//document.getElementsByName("PsychographicBO.CampaignDependency.NoOfTimesCanContact")[i].value = "";
			document.getElementsByName("PsychographicBO.CampaignDependency.NoOfTimesCanContact")[i].disabled = true;
									
		}
		document.getElementsByName("Do not Contact via Channel")[0].checked = true;
		document.getElementsByName("Do not Contact via Channel")[0].disabled = true;
	}
}
/* Changes done by Kanika For Cif Deceased ends */

	<!-- changes for Ticket Id 343819:start  -->
	function onLoadCaller(mode){
		try{
			if(mode=='READ'){
				<!-- Change for 374326 and 374328 start -->
				<!-- Changes for Ticketid:-()Call id:-165698 Start -->
				//localeReadOnly();
				<!-- Changes for Ticketid:-()Call id:-165698 End -->
				<!-- Change for 374326 and 374328 end -->
				chkBSN();
				loadCampaignData();
				enableRel();
				showInReadOnlyMode('<xsl:value-of select="$readMode"/>');
				selectRecordSet();
				hideTransAndCurr();
				formatUser();
			}else if(mode == 'CREATE'){
				<!-- Change for 374326 and 374328 start -->
				<!-- Changes for Ticketid:-()Call id:-165698 Start -->
				//localeReadOnly();
				<!-- Changes for Ticketid:-()Call id:-165698 Start -->
				<!-- Change for 374326 and 374328 end -->
				focusFirstField();
				chkBSN();
				showbuttonsVisible(45);
				showFormTips();
				load();
				selectRecordSet();
				formatUser();
				hideTransAndCurr();
				existingURL();
			}else if(mode == 'EDIT'){
				<!-- Change for 374326 and 374328 start -->
				<!-- Changes for Ticketid:-()Call id:-165698 Start -->
				//localeReadOnly();
				<!-- Changes for Ticketid:-()Call id:-165698 Start -->
				<!-- Change for 374326 and 374328 end -->
				focusFirstField();
				chkBSN();
				load();
				selectRecordSet();
				showbuttonsVisible(30);
				showFormTips();
				formatUser();
				hideTransAndCurr();
				// Change for Ticket 353275
				//loadCode();
				existingURL();
			}
		}catch(e){
			showUserMessage(MSGJ50955,"");
		}
	}
	<!--  changes for Ticket Id 343819:end  -->
//Tracker ID 113276 Changes Start
var campaign = false;
//Tracker ID 113276 Changes End

    </script>
    </head>
    <!-- DBS Enhancement tracker ID :-402520 by rattandeep_singh01 start-->
     <body class="popup" onkeypress="onLoadSetTime()" onclick="onLoadSetTime()">
     <!-- DBS Enhancement tracker ID :-402520 by rattandeep_singh01 end-->
     <!-- lily chges for selected display of record set -->
         <xsl:choose>
         <xsl:when test="normalize-space($readMode)='Y'">
            <!-- Tracker 201512 starts -->
            <xsl:attribute name="onload">showInReadOnlyMode('<xsl:value-of select="$readMode" />');onLoadCaller('READ');selectExtPricing();</xsl:attribute>
            <!-- Tracker 201512 ends -->
         </xsl:when>
         <xsl:when test="normalize-space($acctID)='' and normalize-space($suspID)=''">
<!-- Changes for Deceased CIF Starts -->
		<!-- <xsl:attribute name="onload">onLoadCaller('CREATE');disableCustomerPricing();</xsl:attribute> -->
		<xsl:attribute name="onload">onLoadCaller('CREATE');disableCustomerPricing();fnOnLoadDisableDcsd();</xsl:attribute>
<!-- Changes for Deceased CIF Ends -->
         </xsl:when>
         <xsl:otherwise>
<!-- Changes for Deceased CIF Starts -->
            <!-- <xsl:attribute name="onload">onLoadCaller('EDIT');selectExtPricing();</xsl:attribute> -->
            <xsl:attribute name="onload">onLoadCaller('EDIT');selectExtPricing();fnOnLoadDisableDcsd();</xsl:attribute>
<!-- Changes for Deceased CIF Ends -->
         </xsl:otherwise>
         </xsl:choose>
          <!-- lily chges for selected display of record set end-->
        <script type="text/javascript" src="../common/js/SRMTableRowColor.js"></script>
        <script type="text/javascript" src="../common/js/SRMFormToggle.js"></script>
        <!-- TrackerID:209607,CHANGES START -->
        <script type="text/javascript" language="javascript" src="../common/js/Reduce_Form.js"></script>
        <!-- TrackerID:209607,CHANGES END -->
        <script type="text/javascript" src="../common/js/ListBoxFunctions.js" language="javascript"></script>
        <script type="text/javascript" src="../common/js/PopupMenu.js"></script>
        
             <xsl:apply-templates select="SRM"/>

      </body>
      </html>
      </xsl:template>
<!-- Retail CIF changes for CampaignManagement By Mamta : Start -->
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
<xsl:template name="SelectAllCampaign">
    <xsl:call-template name="checkbox1">
	<xsl:with-param name="name">ckSelectAllCampaign</xsl:with-param>
	<xsl:with-param name="checkbox_val">true</xsl:with-param>
	<xsl:with-param name="fncname">checkAllCampaign();</xsl:with-param>
</xsl:call-template>
</xsl:template>


 <xsl:template name="PsychographicBO.CampaignDependency.DoNotContact">

         <xsl:call-template name="checkbox1">
        <xsl:with-param name="dispname" select="$configLabels_2[@name='PsychographicBO.CampaignDependency.DoNotContact']/@configLabel"/>
             <!--<xsl:with-param name="dispname">Do Not Contact</xsl:with-param>-->
             <xsl:with-param name="checkbox_val">true</xsl:with-param>
             <xsl:with-param name="fncname">checkit()</xsl:with-param>
          </xsl:call-template>
 </xsl:template>

<xsl:template name="PsychographicBO.CampaignDependency.ContactFrequency">
<xsl:call-template name="mdrpdown">
<xsl:with-param name="res_name" select="$configLabels[@name='Blank']"/> <!-- Blank since, on the screen, we don't want its label -->
<xsl:with-param name="selectname">ContactFrequencies</xsl:with-param>
<xsl:with-param name="selectdisp"></xsl:with-param>
<xsl:with-param name="linkshow">false</xsl:with-param>
<xsl:with-param name="fncname"></xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template name="PsychographicBO.CampaignDependency.NoOfTimesCanContact">
<xsl:call-template name="label">
<xsl:with-param name="res_name" select="$configLabels[@name='Blank']"/><!-- Blank since, on the screen, we don't want its label -->
<xsl:with-param name="ele_name">PsychographicBO.CampaignDependency.NoOfTimesCanContact</xsl:with-param>
<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.CampaignDependency.NoOfTimesCanContact</xsl:with-param>
<xsl:with-param name="DataType">Integer</xsl:with-param>
<!-- changes for Tracker id:299797 and Ticket Id:490790 Starts Here -->
<xsl:with-param name="fn_onBlur">func1()</xsl:with-param>
<!-- changes for Tracker id:299797 and Ticket Id:490790 Ends Here -->
</xsl:call-template>
</xsl:template>
<!-- Retail CIF changes for CampaignManagement By Mamta : End -->
<!--PsychographicSegmentation : Start-->
<!--PsychographicSegmentation : End-->
    <xsl:template name="PsychographicBO.Segmentation_Class">
        <xsl:call-template name="mdrpdown">
        <xsl:with-param name="res_name" select="$configLabels_2[@name='PsychographicBO.Segmentation_Class']"/>
        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Segmentation_Class</xsl:with-param>
        <xsl:with-param name="selectdisp">PsychographicBO.Segmentation_Class</xsl:with-param>
        <xsl:with-param name="search_type">value</xsl:with-param>
        <xsl:with-param name="choice_name">PsychographicBO.Segmentation_Class</xsl:with-param>
	<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>
	<!-- CIF Changes for Caching Views : End -->
            </xsl:call-template>
    </xsl:template>
    <xsl:template name="PsychographicBO.Life_Cycle_Stage">
        <xsl:call-template name="mdrpdown">
            <xsl:with-param name="res_name" select="$configLabels_2[@name='PsychographicBO.Life_Cycle_Stage']"/>
            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Life_Cycle_Stage</xsl:with-param>
            <xsl:with-param name="selectdisp">PsychographicBO.Life_Cycle_Stage</xsl:with-param>
            <xsl:with-param name="search_type">value</xsl:with-param>
            <xsl:with-param name="choice_name">PsychographicBO.Life_Cycle_Stage</xsl:with-param>
	<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>
	<!-- CIF Changes for Caching Views : End -->
        </xsl:call-template>
    </xsl:template>
        <xsl:template name="PsychographicBO.Flag1">
            <xsl:call-template name="mdrpdown">
                <xsl:with-param name="res_name" select="$configLabels_2[@name='PsychographicBO.Flag1']"/>
                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Flag1</xsl:with-param>
                <xsl:with-param name="selectdisp">PsychographicBO.Flag1</xsl:with-param>
                <xsl:with-param name="search_type">value</xsl:with-param>
                <xsl:with-param name="choice_name">PsychographicBO.Flag1</xsl:with-param>
	<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>
	<!-- CIF Changes for Caching Views : End -->
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="PsychographicBO.prefRelshipDiscount1">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_2[@name='PsychographicBO.prefRelshipDiscount1']"/>
                <xsl:with-param name="ele_name">PsychographicBO.prefRelshipDiscount1</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.prefRelshipDiscount1</xsl:with-param>
                <xsl:with-param name="fn_onBlur">formatNumber("3_PsychographicBO.prefRelshipDiscount1");</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="PsychographicBO.prefRelshipDiscount2">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_2[@name='PsychographicBO.prefRelshipDiscount2']"/>
                <xsl:with-param name="ele_name">PsychographicBO.prefRelshipDiscount2</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.prefRelshipDiscount2</xsl:with-param>
    		<xsl:with-param name="fn_onBlur">formatNumber("3_PsychographicBO.prefRelshipDiscount2");</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="PsychographicBO.prefRelshipDiscountPercent1">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_2[@name='PsychographicBO.prefRelshipDiscountPercent1']"/>
                <xsl:with-param name="ele_name">PsychographicBO.prefRelshipDiscountPercent1</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.prefRelshipDiscountPercent1</xsl:with-param>
               <xsl:with-param name="fn_onBlur">removePercentFormat('3_PsychographicBO.prefRelshipDiscountPercent1');double96("3_PsychographicBO.prefRelshipDiscountPercent1");</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="PsychographicBO.prefRelshipDiscountPercent2">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_2[@name='PsychographicBO.prefRelshipDiscountPercent2']"/>
                <xsl:with-param name="ele_name">PsychographicBO.prefRelshipDiscountPercent2</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.prefRelshipDiscountPercent2</xsl:with-param>
                <xsl:with-param name="fn_onBlur">removePercentFormat('3_PsychographicBO.prefRelshipDiscountPercent2');double96("3_PsychographicBO.prefRelshipDiscountPercent2");</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="PsychographicBO.subSegment">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_2[@name='PsychographicBO.subSegment']"/>
                <xsl:with-param name="ele_name">PsychographicBO.subSegment</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.subSegment</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="PsychographicBO.UserFlag1">
            <xsl:call-template name="mdrpdown">
                <xsl:with-param name="res_name" select="$configLabels_2[@name='PsychographicBO.UserFlag1']"/>
                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.UserFlag1</xsl:with-param>
                <xsl:with-param name="selectdisp">PsychographicBO.UserFlag1</xsl:with-param>
                <xsl:with-param name="search_type">value</xsl:with-param>
                <xsl:with-param name="choice_name">PsychographicBO.UserFlag1</xsl:with-param>
	<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>
	<!-- CIF Changes for Caching Views : End -->
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="PsychographicBO.UserFlag2">
            <xsl:call-template name="mdrpdown">
                <xsl:with-param name="res_name" select="$configLabels_2[@name='PsychographicBO.UserFlag2']"/>
                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.UserFlag2</xsl:with-param>
                <xsl:with-param name="selectdisp">PsychographicBO.UserFlag2</xsl:with-param>
                <xsl:with-param name="search_type">value</xsl:with-param>
                <xsl:with-param name="choice_name">PsychographicBO.UserFlag2</xsl:with-param>
	<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>
	<!-- CIF Changes for Caching Views : End -->
            </xsl:call-template>
        </xsl:template>
<!-- PsychographicIndividualPreference : Start-->
<!-- Field Rationalization starts -->

    <xsl:template name="PsychographicBO.Communication_Language">
            <xsl:call-template name="mdrpdown">
            <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.Communication_Language']"/>
                <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Communication_Language</xsl:with-param>
                <xsl:with-param name="selectdisp">PsychographicBO.Communication_Language</xsl:with-param>
                <xsl:with-param name="search_type">value</xsl:with-param>
                <xsl:with-param name="choice_name">PsychographicBO.Communication_Language</xsl:with-param>
	<!-- CIF Changes for Caching Views : Start -->
         	<xsl:with-param name="presdata" select="$PresData"/>
	<!-- CIF Changes for Caching Views : End -->
            </xsl:call-template>
         </xsl:template>

<!-- Field Rationalization ends -->

    <xsl:template name="PsychographicBO.Preferred_Address_Mode">
            <xsl:call-template name="label">
            <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.Preferred_Address_Mode']"/>
              <xsl:with-param name="ele_name">PsychographicBO.Preferred_Address_Mode</xsl:with-param>
              <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Preferred_Address_Mode</xsl:with-param>
            </xsl:call-template>
         </xsl:template>

    <xsl:template name="PsychographicBO.Preferred_Locale">
	<xsl:call-template name="lookup">
		<xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.Preferred_Locale']"/>
		<xsl:with-param name="elename">PsychographicBO.Preferred_Locale</xsl:with-param>
		<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.Preferred_Locale</xsl:with-param>
		<xsl:with-param name="buttonone_name" select="$configLabels_1[@name='LOOKUP']/@configLabel"/>
		<xsl:with-param name="buttontwo_name">Clear</xsl:with-param>
		<xsl:with-param name="buttonone_fnc">categoryLookup('LOCALE', 'PsychographicBO.Preferred_Locale')</xsl:with-param>
		<xsl:with-param name="buttontwo_fnc">clearCategoryValue('PsychographicBO.Preferred_Locale')</xsl:with-param>
	</xsl:call-template>
	<!--<input type="hidden" name="PsychographicBO.Preferred_Locale" value="{$var_Preferred_Locale}"/>-->

         </xsl:template>

    <xsl:template name="PsychographicBO.Preferred_Rep">
	<xsl:call-template name="lookup">
	<xsl:with-param name="res_name" select="$configLabels_1[@name='Preferred_Rep']"/>
	<xsl:with-param name="elename">PreferredRep</xsl:with-param>
	<xsl:with-param name="eleval">PreferredRep</xsl:with-param>
	<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
	<xsl:with-param name="buttonone_name" select="$configLabels_1[@name='LOOKUP']/@configLabel"/>
	<xsl:with-param name="buttontwo_name">Clear</xsl:with-param>
	<xsl:with-param name="buttonone_fnc">fnBlurfunction('PrefRep')</xsl:with-param>
	<!--xsl:with-param name="buttonone_fnc">openAgentLookup()</xsl:with-param-->
	<xsl:with-param name="buttontwo_fnc">clearAgentLookup()</xsl:with-param>
	</xsl:call-template>
	<!-- FCRM6201RECON:TRACKER:50157:BEGIN OF CHANGES  -->
	<!-- Tracker:161785:Start of Changes -->
	<input type="hidden" name="PsychographicBO.Preferred_Rep" value="{$var_Preferred_Rep}"/>
	<!-- Tracker:161785:End of Changes -->
	<!-- FCRM6201RECON:TRACKER:50157:END OF CHANGES  -->
   <!-- Tracker# 49738, End of Changes -->
         </xsl:template>
    <xsl:template name="PsychographicBO.Profile_Field1">
            <xsl:call-template name="label">
            <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.Profile_Field1']"/>
              <xsl:with-param name="ele_name">PsychographicBO.Profile_Field1</xsl:with-param>
              <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Profile_Field1</xsl:with-param>
            </xsl:call-template>
         </xsl:template>
    <xsl:template name="PsychographicBO.Profile_Field2">
            <xsl:call-template name="label">
            <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.Profile_Field2']"/>
              <xsl:with-param name="ele_name">PsychographicBO.Profile_Field2</xsl:with-param>
              <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Profile_Field2</xsl:with-param>
            </xsl:call-template>
         </xsl:template>
    <xsl:template name="PsychographicBO.Profile_Field3">
            <xsl:call-template name="label">
            <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.Profile_Field3']"/>
              <xsl:with-param name="ele_name">PsychographicBO.Profile_Field3</xsl:with-param>
              <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Profile_Field3</xsl:with-param>
            </xsl:call-template>
         </xsl:template>
    <xsl:template name="PsychographicBO.Profile_Field4">
            <xsl:call-template name="label">
            <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.Profile_Field4']"/>
              <xsl:with-param name="ele_name">PsychographicBO.Profile_Field4</xsl:with-param>
              <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Profile_Field4</xsl:with-param>
            </xsl:call-template>
         </xsl:template>
    <xsl:template name="PsychographicBO.Behavioural_Score">
            <xsl:call-template name="label">
            <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.Behavioural_Score']"/>
              <xsl:with-param name="ele_name">PsychographicBO.Behavioural_Score</xsl:with-param>
              <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Behavioural_Score</xsl:with-param>
            </xsl:call-template>
         </xsl:template>
    <xsl:template name="PsychographicBO.Risk_Behaviour">
            <xsl:call-template name="label">
            <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.Risk_Behaviour']"/>
              <xsl:with-param name="ele_name">PsychographicBO.Risk_Behaviour</xsl:with-param>
              <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Risk_Behaviour</xsl:with-param>
            </xsl:call-template>
         </xsl:template>
    <xsl:template name="PsychographicBO.Other_Behavioural_Profile">
            <xsl:call-template name="label">
            <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.Other_Behavioural_Profile']"/>
              <xsl:with-param name="ele_name">PsychographicBO.Other_Behavioural_Profile</xsl:with-param>
              <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Other_Behavioural_Profile</xsl:with-param>
            </xsl:call-template>
         </xsl:template>
    <xsl:template name="PsychographicBO.Service_Personalise">
            <xsl:call-template name="label">
            <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.Service_Personalise']"/>
              <xsl:with-param name="ele_name">PsychographicBO.Service_Personalise</xsl:with-param>
              <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Service_Personalise</xsl:with-param>
            </xsl:call-template>
         </xsl:template>
    <xsl:template name="PsychographicBO.PreferredName">
            <xsl:call-template name="label">
            <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.PreferredName']"/>
              <xsl:with-param name="ele_name">PsychographicBO.PreferredName</xsl:with-param>
              <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.PreferredName</xsl:with-param>
                <xsl:with-param name="fn_onBlur">txtLimit(this,10,"PsychographicBO.PreferredName","PreferredName");</xsl:with-param>
              <!-- Tracker Id 62327 Begin of changes -->
              <xsl:with-param name="checkASCII">false</xsl:with-param>
              <!-- Tracker Id 62327 End of changes -->
            </xsl:call-template>
         </xsl:template>
        <xsl:template name="PsychographicBO.hobbyField1">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.hobbyField1']"/>
                <xsl:with-param name="ele_name">PsychographicBO.hobbyField1</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.hobbyField1</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="PsychographicBO.hobbyField2">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.hobbyField2']"/>
                <xsl:with-param name="ele_name">PsychographicBO.hobbyField2</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.hobbyField2</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="PsychographicBO.hobbyField3">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.hobbyField3']"/>
                <xsl:with-param name="ele_name">PsychographicBO.hobbyField3</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.hobbyField3</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="PsychographicBO.hobbyField4">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.hobbyField4']"/>
                <xsl:with-param name="ele_name">PsychographicBO.hobbyField4</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.hobbyField4</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="PsychographicBO.hobbyField5">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.hobbyField5']"/>
                <xsl:with-param name="ele_name">PsychographicBO.hobbyField5</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.hobbyField5</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="PsychographicBO.hobbyField6">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.hobbyField6']"/>
                <xsl:with-param name="ele_name">PsychographicBO.hobbyField6</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.hobbyField6</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="PsychographicBO.userField1">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.userField1']"/>
                <xsl:with-param name="ele_name">PsychographicBO.userField1</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.userField1</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="PsychographicBO.userField2">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.userField2']"/>
                <xsl:with-param name="ele_name">PsychographicBO.userField2</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.userField2</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="PsychographicBO.userField3">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.userField3']"/>
                <xsl:with-param name="ele_name">PsychographicBO.userField3</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.userField3</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="PsychographicBO.userField4">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.userField4']"/>
                <xsl:with-param name="ele_name">PsychographicBO.userField4</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.userField4</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="PsychographicBO.userField5">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.userField5']"/>
                <xsl:with-param name="ele_name">PsychographicBO.userField5</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.userField5</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="PsychographicBO.userField6">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.userField6']"/>
                <xsl:with-param name="ele_name">PsychographicBO.userField6</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.userField6</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="PsychographicBO.spServiceRequired1">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.spServiceRequired1']"/>
                <xsl:with-param name="ele_name">PsychographicBO.spServiceRequired1</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.spServiceRequired1</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="PsychographicBO.spServiceRequired2">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.spServiceRequired2']"/>
                <xsl:with-param name="ele_name">PsychographicBO.spServiceRequired2</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.spServiceRequired2</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="PsychographicBO.spServiceRequired3">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.spServiceRequired3']"/>
                <xsl:with-param name="ele_name">PsychographicBO.spServiceRequired3</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.spServiceRequired3</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="PsychographicBO.spServiceRequired4">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.spServiceRequired4']"/>
                <xsl:with-param name="ele_name">PsychographicBO.spServiceRequired4</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.spServiceRequired4</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="PsychographicBO.spServiceRequired5">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.spServiceRequired5']"/>
                <xsl:with-param name="ele_name">PsychographicBO.spServiceRequired5</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.spServiceRequired5</xsl:with-param>
            </xsl:call-template>
        </xsl:template>
        <xsl:template name="PsychographicBO.stmtDateForCombStmt">
            <xsl:call-template name="label">
                <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.stmtDateForCombStmt']"/>
                <xsl:with-param name="ele_name">PsychographicBO.stmtDateForCombStmt</xsl:with-param>
                <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.stmtDateForCombStmt</xsl:with-param>
                <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
                <!-- calling the function isGregDate for on blur functionality-->
                <xsl:with-param name="fn_onBlur">isGregDate("1_PsychographicBO.stmtDateForCombStmt");</xsl:with-param>
                <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
            </xsl:call-template>
        </xsl:template>
	<!-- CORE Fields start-->
<!--  RefCode Changes	-->
            <xsl:template name="PsychographicBO.CustCharge">
                    <xsl:call-template name="mdrpdown">
                            <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.CustChargeCode']"/>
                            <xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.CustCharge</xsl:with-param>
                            <xsl:with-param name="selectdisp">PsychographicBO.CustChargeCode</xsl:with-param>
                            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.CustChargeCode</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
                            <xsl:with-param name="choice_name">PsychographicBO.CustChargeCode</xsl:with-param>
                            <xsl:with-param name="search_type">url</xsl:with-param>
                   </xsl:call-template>
        </xsl:template>

<!--  RefCode Changes	-->
	<xsl:template name="PsychographicBO.CustomerCurrency">
		<xsl:call-template name="label">
		    <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.CustomerCurrency']"/>
		    <xsl:with-param name="ele_name">PsychographicBO.CustomerCurrency</xsl:with-param>
		    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.CustomerCurrency</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="PsychographicBO.StmtWeekOfMonth">
		<xsl:call-template name="label">
		    <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.StmtWeekOfMonth']"/>
		    <xsl:with-param name="ele_name">PsychographicBO.StmtWeekOfMonth</xsl:with-param>
		    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.StmtWeekOfMonth</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
<!--  RefCode Changes	-->
            <xsl:template name="PsychographicBO.AssetClassificationDesc">
                    <xsl:call-template name="mdrpdown">
                            <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.AssetClassification']"/>
                            <xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.AssetClassificationDesc</xsl:with-param>
                            <xsl:with-param name="selectdisp">PsychographicBO.AssetClassification</xsl:with-param>
                            <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.AssetClassification</xsl:with-param>
			<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
			<!-- CIF Changes for Caching Views : End -->
                            <xsl:with-param name="choice_name">PsychographicBO.AssetClassification</xsl:with-param>
                            <xsl:with-param name="search_type">url</xsl:with-param>
                   </xsl:call-template>
        </xsl:template>

<!--  RefCode Changes	-->
	<xsl:template name="PsychographicBO.Cust_pref_till_date">
		<xsl:call-template name="label">
		    <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.Cust_pref_till_date']"/>
		    <xsl:with-param name="ele_name">PsychographicBO.Cust_pref_till_date</xsl:with-param>
		    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_pref_till_date</xsl:with-param>
		    <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
		    <!-- calling the function isGregDate for on blur functionality-->
		    <xsl:with-param name="fn_onBlur">isGregDate("3_PsychographicBO.Cust_pref_till_date");</xsl:with-param>
		    <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
		</xsl:call-template>
	</xsl:template>
	<!-- CORE Fields Inclusion:end-->
<!--Field Addition Tracker 172089:start of Changes-->
     <xsl:template name="AvailableActivities">
       	           <xsl:call-template name="listview">
       	               <xsl:with-param name="ele_name">AvailableActivities</xsl:with-param>
       	               <xsl:with-param name="size">4</xsl:with-param>
       	               <xsl:with-param name="multiple">false</xsl:with-param>
       	               <xsl:with-param name="class">listBox</xsl:with-param>
       	               <xsl:with-param name="ondblclick">selfield_activity(AvailableActivities,nature_of_act)</xsl:with-param>
       	               <xsl:with-param name="selectname">AvailableActivities</xsl:with-param>
       	 	      <xsl:with-param name="selectdisp">AvailableActivities</xsl:with-param>
       	   	      <xsl:with-param name="search_type">url</xsl:with-param>
       	 	<xsl:with-param name="presdata" select="$PresData"/>
       	           </xsl:call-template>
       	       </xsl:template>
       	       <xsl:template name="nature_of_act">
       	           <xsl:call-template name="listview">
       	               <xsl:with-param name="ele_name">nature_of_act</xsl:with-param>
       	               <xsl:with-param name="size">4</xsl:with-param>
       	               <xsl:with-param name="multiple">false</xsl:with-param>
       	               <xsl:with-param name="class">listBox</xsl:with-param>
       	               <xsl:with-param name="ondblclick">selfield_activity(nature_of_act,AvailableActivities)</xsl:with-param>
       	               <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.nature_of_act</xsl:with-param>
       	       	      <xsl:with-param name="selectdisp"><xsl:value-of select="$boName"/>.nature_of_act</xsl:with-param>
       	 	      <xsl:with-param name="search_type">url</xsl:with-param>
       	           </xsl:call-template>
  	       </xsl:template>

<!--Field Addition Tracker 172089:end of Changes-->
<!--  Changes for the Tracker# 87509 : Start-->
<!--  Changes for the Pricing : Start-->

<xsl:template name="PsychographicBO.External_System_Pricing">
	     <xsl:call-template name="mdrpdown">
		     <xsl:with-param name="res_name" select="$configLabels_4[@name='PsychographicBO.External_System_Pricing']"/>
		     <xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.External_System_Pricing</xsl:with-param>
		     <xsl:with-param name="selectdisp">PsychographicBO.External_System_Pricing</xsl:with-param>
		     <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.External_System_Pricing</xsl:with-param>
			<xsl:with-param name="choice_name">PsychographicBO.External_System_Pricing</xsl:with-param>
			<xsl:with-param name="onchangefn">validateRelationshipID("PsychographicModBO.External_System_Pricing");</xsl:with-param>
		     <xsl:with-param name="search_type">value</xsl:with-param>
	    </xsl:call-template>
</xsl:template>

<xsl:template name="PsychographicBO.Relationship_Pricing_ID">
	<xsl:call-template name="label">
		<xsl:with-param name="ele_name">PsychographicBO.Relationship_Pricing_ID</xsl:with-param>
		<xsl:with-param name="ele_val"><xsl:value-of select="$boName"></xsl:value-of>.Relationship_Pricing_ID</xsl:with-param>
		<xsl:with-param name="fn_onBlur">makePricingDatesMand();</xsl:with-param>
		<xsl:with-param name="max_length">30</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels_4[@name='PsychographicBO.Relationship_Pricing_ID']" />

	</xsl:call-template>
</xsl:template>

<xsl:template name="PsychographicBO.Pricing_Effective_Date">
	<xsl:call-template name="label">
		<xsl:with-param name="ele_name">PsychographicBO.Pricing_Effective_Date</xsl:with-param>
		<xsl:with-param name="ele_val"><xsl:value-of select="$boName"></xsl:value-of>.Pricing_Effective_Date</xsl:with-param>
		<xsl:with-param name="fn_onBlur">isGregDate("3_PsychographicBO.Pricing_Effective_Date");validate_Effective_Date("3_PsychographicBO.Pricing_Effective_Date");validate_Review_Date("3_PsychographicBO.Pricing_Review_Date");</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels_4[@name='PsychographicBO.Pricing_Effective_Date']" />

		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template name="PsychographicBO.Pricing_Review_Date">
	<xsl:call-template name="label">
		<xsl:with-param name="ele_name">PsychographicBO.Pricing_Review_Date</xsl:with-param>
		<xsl:with-param name="ele_val"><xsl:value-of select="$boName"></xsl:value-of>.Pricing_Review_Date</xsl:with-param>
		<xsl:with-param name="fn_onBlur">isGregDate("3_PsychographicBO.Pricing_Review_Date");validate_Review_Date("3_PsychographicBO.Pricing_Review_Date");</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels_4[@name='PsychographicBO.Pricing_Review_Date']" />

		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!--  Changes for the Pricing : Ends-->

    <xsl:template name="PsychographicBO.TDSCustFloorLimit">
            <xsl:call-template name="label">
            <xsl:with-param name="res_name" select="$configLabels_1[@name='PsychographicBO.TDSCustFloorLimit']"/>
              <xsl:with-param name="ele_name">PsychographicBO.TDSCustFloorLimit</xsl:with-param>
              <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.TDSCustFloorLimit</xsl:with-param>
            </xsl:call-template>
         </xsl:template>
<!--  Changes for the Tracker# 87509 : End-->

<!-- PsychographicIndividualPreference : End-->
<!-- Psychographic Family/Lifestyle : Start-->
    <xsl:template name="PsychographicBO.NumberofDependants">
            <xsl:call-template name="label">
            <xsl:with-param name="res_name" select="$configLabels_10[@name='PsychographicBO.NumberofDependants']"/>
              <xsl:with-param name="ele_name">PsychographicBO.NumberofDependants</xsl:with-param>
              <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.NumberofDependants</xsl:with-param>
              <xsl:with-param name="max_length">2</xsl:with-param>
              <xsl:with-param name="fn_onBlur">formatNumber("2_PsychographicBO.NumberofDependants");</xsl:with-param>
            </xsl:call-template>
    </xsl:template>
     <xsl:template name="PsychographicBO.NumberofDependantChildren">
            <xsl:call-template name="label">
            <xsl:with-param name="res_name" select="$configLabels_10[@name='PsychographicBO.NumberofDependantChildren']"/>
              <xsl:with-param name="ele_name">PsychographicBO.NumberofDependantChildren</xsl:with-param>
              <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.NumberofDependantChildren</xsl:with-param>
              <xsl:with-param name="max_length">2</xsl:with-param>
              <xsl:with-param name="fn_onBlur">formatNumber("2_PsychographicBO.NumberofDependantChildren");</xsl:with-param>
            </xsl:call-template>
     </xsl:template>
<!-- Psychographic Family/Lifestyle : End-->
        <xsl:template match="*" mode="mode1">
        <form name="frm2"  method="post" action="../servlet/com.infy.cis.ui.common.PsychographicWriter">
			<input type="hidden" name="hid_concurDetectX" value="{$concurDetectX}"/>
	<!--Fix for SIT ticket 246679-->
	<!-- Tracker:161785:Start of Changes -->
			<xsl:choose>
				<xsl:when test="$Prefered_locale != '' and $Prefered_locale != 'undefined'">
				<script>
				var value='<xsl:value-of select="$Prefered_locale"/>';

				</script>

					<input type="hidden" name="hid_Prefered_locale" value="{$Prefered_locale}"/>
				</xsl:when>
				<xsl:otherwise>
				<script>
					var value='<xsl:value-of select="$var_Preferred_Locale"/>';

				</script>
					<input type="hidden" name="hid_Prefered_locale" value="{$var_Preferred_Locale}"/>
				</xsl:otherwise>
        		</xsl:choose>

	<!-- Tracker:161785:End of Changes -->
        <!--Fix for SIT ticket 246679-->
			<input type="hidden" name="hid_UserID" value=""/>
			<input type="hidden" name="ID" value="{$ID}"/>
			<input type="hidden" name="psychographicID" value="{$psychographicID}"/>
			<input type="hidden" name="custMinor" value="{$custMinor}"/>
			<input type="hidden" name="AccessType" value="{$AccessType}"/>
			<!-- new added hidden : for :Copy :start -->
			<input type="hidden" name="IsCopy" value="{$isCopy}"/>
                        <!-- new added hidden : for :Copy :end -->

		<!-- Tracker id : 253845   -->
		        <input type="hidden" name="convToCust" value="{$convToCust}"/>
		        <input type="hidden" name="oldEntityType" value="{$oldEntityType}"/>
		        <input type="hidden" name="oldEntityID" value="{$oldEntityID}"/>
                <!--  Tracker id : 253845   -->
		<!-- CORE Fields inclusion:start-->

		<input type="hidden" name="Community_code" value=""/>
		<input type="hidden" name="Cust_health_ref_code" value=""/>

		<!-- CORE Fields inclusion:end-->
		<!--palani : psycho :start  -->
		<!-- new added hidden : for :relation Lookup :start -->
			<input type="hidden" name="InputTypeFromLookup" value=""/>
			<input type="hidden" name="attachedConts" value=""/>
			<input type="hidden" name="detachedConts" value=""/>
		<!-- new added hidden : for :relation Lookup :end -->
           <!-- the hidden field required to pass the value in popup window :  Start-->
             <input type="hidden" name="KnownYears" value=""/>
             <input type="hidden" name="Gender" value=""/>
             <input type="hidden" name="IsDependent" value=""/>
             <input type="hidden" name="LastName" value=""/>
             <input type="hidden" name="RelationshipURL" value=""/>
             <input type="hidden" name="RelationshipID" value=""/>
             <input type="hidden" name="Salutation" value=""/>
             <input type="hidden" name="FirstName" value=""/>
             <input type="hidden" name="MiddleName" value=""/>
             <!--  TrackerID 113227 Ankit  changes START  -->
	     <input type="hidden" name="FirstName_alt1" value=""/>
	     <input type="hidden" name="MiddleName_alt1" value=""/>
	     <input type="hidden" name="LastName_alt1" value=""/>
             <!--  TrackerID 113227 Ankit changes END  -->
             <input type="hidden" name="Relation" value=""/>
             <input type="hidden" name="DOB" value=""/>
             <input type="hidden" name="Bank_Entity" value=""/>
             <input type="hidden" name="Bank_Entity2" value=""/>
             <input type="hidden" name="Bank_Entity_Name" value=""/>
             <input type="hidden" name="Deleted_Relationship_URL" value=""/>
              <!-- added for relationship -->
             <input type="hidden" name="cifType" value=""/>
             <input type="hidden" name="IsSocial" value=""/>
        <!-- Added after ckecked in : Start-->
            <input type="hidden" name="BankEntityID" value=""/>
	    <input type="hidden" name="Guard_Code" value=""/>
<!-- Post ST changes for Relation Category Starts -->
	    <input type="hidden" name="Relationship_Category" value=""/>
<!-- Post ST changes for Relation Category Ends -->
	    <input type="hidden" name="PrimaryIntroducer" value=""/>
	    <input type="hidden" name="PrimaryIntroducer2" value=""/>
	    <input type="hidden" name="accID" value=""/>
	    <!--hidden variable for account Key-->
	    <input type="hidden" name="accKey" value="{$accKey}"/>
	    <!-- Core Dependency changes -->
	    <input type="hidden" name="contKey" value="{$contKey}"/>
	    <input type="hidden" name="susKey" value="{$susKey}"/>
	    <!-- Core Dependency changes -->
	    <input type="hidden" name="childCoreID" value=""/>
	     <input type="hidden" name="ModAccID" value=""/>
	     <!-- Core Dependency changes -->
	     <input type="hidden" name="modSusID" value=""/>
	     <input type="hidden" name="modContID" value=""/>
	     <!-- Core Dependency changes -->
	     <input type="hidden" name="CoreCustID" value=""/>
	     <input type="hidden" name="mainAccId" value="{$mainAccId}"/>
        <!-- Added after ckecked in : End-->
<!-- hidden variable for the Hobbies :Start -->
<input type="hidden" name="Cust_Hobbies" value=""/>
<!-- hidden variable for the Hobbies :End -->

<!-- Retail CIF changes for CampaignManagement By Mamta : Start -->
<input type="hidden" name="AllCampaigns_Type" value=""/>
<input type="hidden" name="Campaigns_Type" value=""/>
<input type="hidden" name="Campaigns_Freq" value=""/>
<input type="hidden" name="Campaigns_Count" value=""/>
<!-- Retail CIF changes for CampaignManagement By Mamta : End -->

<!-- hidden variable for the LifeStyle :Start -->
    <input type="hidden" name="hLifeStylePsychoURL" value=""/>
    <input type="hidden" name="hLifeStyleAssetType" value=""/>
    <input type="hidden" name="hLifeStyleYrOfPurchase" value=""/>
    <input type="hidden" name="hLifeStyleModel" value=""/>
    <input type="hidden" name="hLifeStyleFinanceMode" value=""/>

    <!-- TrackerID113276 changes start -->
    <input type="hidden" name="hLifeStyleTypeOfProperty" value=""/>
    <input type="hidden" name="hLifeStyleTotalSpace" value=""/>
    <input type="hidden" name="hLifeStyleUsableArea" value=""/>
    <!--  TrackerID113276 changes end -->


    <input type="hidden" name="hLifeStyleField1" value=""/>
    <input type="hidden" name="hLifeStyleField2" value=""/>
    <input type="hidden" name="hLifeStyleField3" value=""/>
    <input type="hidden" name="hLifeStyleDate1" value=""/>
    <input type="hidden" name="hLifeStyleDate2" value=""/>
    <input type="hidden" name="hLifeStyleDate3" value=""/>
    <input type="hidden" name="hLifeStyleHypothecatedTo" value=""/>
    <input type="hidden" name="hDeletedLifeStyleID" value=""/>
    <input type="hidden" name="hDeletedLifeStyleType" value=""/>
<!-- hidden variable for the LifeStyle :End -->
<!--palani : psycho :end  -->
<!-- hidden variables for transaction:start -->
    <input type="hidden" name="hTransactionPsychoURL" value=""/>
    <input type="hidden" name="hTransactionType" value=""/>
    <input type="hidden" name="hTransactionChannel" value=""/>
    <input type="hidden" name="hTransactionIndicator" value=""/>
    <input type="hidden" name="hTransactionAmount" value=""/>
    <input type="hidden" name="hTransactionCurrency" value=""/>
    <input type="hidden" name="hTransactionRemarks" value=""/>
    <input type="hidden" name="hTransactionDate1" value=""/>

    <input type="hidden" name="hDeletedTransactionID" value=""/>
    <input type="hidden" name="hDeletedTransactionType" value=""/>
<!-- hidden variable for transaction :End -->
<!-- hidden variables for Currency Details:start-->
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
 <!--hidden variable for Currency Details :End -->
<!-- hidden variable for the ProductPref :Start -->
    <input type="hidden" name="hProductPrefPsychoURL" value=""/>
    <input type="hidden" name="hProductPrefInterestType" value=""/>
    <input type="hidden" name="hProductPrefProductID" value=""/>
    <input type="hidden" name="hProductPrefEffectiveDate" value=""/>
    <input type="hidden" name="hProductPrefExpirydate" value=""/>
    <input type="hidden" name="hProductPrefNotes" value=""/>
<!--ticket id 203491,tracker 121698 changes starts -->
     <input type="hidden" name="hBeneficialOwnerFirstName_alt1" value=""/>
    <input type="hidden" name="hBeneficialOwnerLastName_alt1" value=""/>
    <input type="hidden" name="hBeneficialOwnerMiddleName_alt1" value=""/>
<!--ticket id 203491,tracker 121698 changes ends -->


    <input type="hidden" name="hDeletedProductPrefID" value=""/>
    <input type="hidden" name="hDeletedProductPrefType" value=""/>

<!-- hidden variable for the ProductPref :End -->
<!-- CIF Changes - Credit Bureau - Begin -->
<!-- hidden variable for the credit bureau :Start -->
    <input type="hidden" name="hCreditBureauPsychoURL" value=""/>
    <input type="hidden" name="hCreditBureauBureauID" value=""/>
    <input type="hidden" name="hCreditBureauSequenceOfPreference" value=""/>
    <input type="hidden" name="hDeletedCreditBureauID" value=""/>
    <input type="hidden" name="hDeletedCreditBureauBureauID" value=""/>
<!-- hidden variable for the credit bureau :End -->
<!-- CIF Changes - Credit Bureau - Begin -->
<!-- CIF Changes - Membership - Begin -->
<!-- hidden variable for the membership :Start -->
    <input type="hidden" name="hMembership_PsychoURL" value=""/>
    <input type="hidden" name="hMembership_MembershipType" value=""/>
    <input type="hidden" name="hMembership_MemberOf" value=""/>
    <input type="hidden" name="hMembership_Remarks" value=""/>
    <input type="hidden" name="hDeletedMembershipID" value=""/>
    <input type="hidden" name="hDeletedMembershipType" value=""/>
<!-- hidden variable for the membership :End -->
<!-- CIF Changes - Membership - End -->
	<input type="hidden" name="isMCEditedPsycho" value=""/>
	<input type="hidden" name="isMCEdited" value="{$isMCEdited}"/>
	<input type="hidden" name="mcJNDIFlag" value="{$mcJNDIFlag}"/>
	<input type="hidden" name="getMCRequired" value="{$getMCRequired}"/>

	<!-- *********************************** :Start -->
	<input type="hidden" name="boName" value="{$boName}"/>
	<input type="hidden" name="boName2" value="{$boName2}"/>
	<input type="hidden" name="boName3" value="{$boName3}"/>
	<input type="hidden" name="apprFlag" value="{$apprFlag}"/>
	<input type="hidden" name="readOnly" value="{$readMode}"/>

	<!-- ******Save and Submit Passing the saveFlag to the Writer : Start***** -->
		<input type="hidden" name="saveFlag" value=""/>
	<!-- ******Save and Submit Passing the saveFlag to the Writer : End***** -->
	<!-- *********************************** :End -->

	<!--CIF LOS Bypass change:Start-->
	   <input type="hidden" name="byPassFlag" value="{$byPassFlag}"/>
	<!--CIF LOS Bypass change:End-->

	<!--CIF CoreFields Inclusion changes:Start-->
	<input type="hidden" name="introName" value=""/>
	<input type="hidden" name="introSalutation" value=""/>
	<input type="hidden" name="introID" value=""/>
	<!--CIF CoreFields Inclusion changes:End-->




	<input type="hidden" name="hBeneficialOwnerPsychoURL" value=""/>
	<input type="hidden" name="hBeneficialOwnerSalutation" value=""/>
	<input type="hidden" name="hBeneficialOwnerFirstName" value=""/>
	<input type="hidden" name="hBeneficialOwnerLastName" value=""/>
	<input type="hidden" name="hBeneficialOwnerMiddleName" value=""/>
	<input type="hidden" name="hBeneficialOwnerDateOfIncorporation" value=""/>
	<input type="hidden" name="hBeneficialOwnerEntityKey" value=""/>

	<input type="hidden" name="hDeletedBeneficialID" value=""/>
	<input type="hidden" name="hBeneficialOwnerCIFType" value=""/>
	<input type="hidden" name="hBeneficialOwnerEntityType" value=""/>
	<input type="hidden" name="hBeneficialOwnerPercentage" value=""/>
	<input type="hidden" name="hBeneficialOwnerEntityID" value=""/>
	<input type="hidden" name="hEntityDocumentURL" value=""/>
	<input type="hidden" name="hRepEntityDocumentURL" value=""/>
	<input type="hidden" name="hidentifier_type_Code" value=""/>
	<input type="hidden" name="hunique_id" value=""/>
	<input type="hidden" name="hdateofissue" value=""/>
	<input type="hidden" name="hvalidity_date" value=""/>
	<input type="hidden" name="hDocCode" value=""/>
	<input type="hidden" name="hDocDescr" value=""/>
	<input type="hidden" name="hDocTypeCode" value=""/>
	<input type="hidden" name="hDocTypeDescr" value=""/>
	<input type="hidden" name="hDocReceivedDate" value=""/>
	<input type="hidden" name="hDocRemarks" value=""/>
	<input type="hidden" name="hStatus" value=""/>
	<input type="hidden" name="hIsMandatory" value=""/>
	<input type="hidden" name="hScanRequired" value=""/>
	<input type="hidden" name="hplaceofissue" value=""/>
	<input type="hidden" name="hplaceofissue_cat" value=""/>
	<input type="hidden" name="hcountryofissue" value=""/>
	<!-- Tracker 208703 start -->
	<input type="hidden" name="hcountryofissue_cat" value=""/>
	<!-- Tracker 208703 end -->
	<input type="hidden" name="hRepidentifier_type_Code" value=""/>
	<input type="hidden" name="hRepunique_id" value=""/>
	<input type="hidden" name="hRepdateofissue" value=""/>
	<input type="hidden" name="hRepvalidity_date" value=""/>
	<input type="hidden" name="hRepDocCode" value=""/>
	<input type="hidden" name="hRepDocDescr" value=""/>
	<input type="hidden" name="hRepDocTypeCode" value=""/>
	<input type="hidden" name="hRepDocTypeDescr" value=""/>
	<input type="hidden" name="hRepDocReceivedDate" value=""/>
	<input type="hidden" name="hRepDocRemarks" value=""/>
	<input type="hidden" name="hRepStatus" value=""/>
	<input type="hidden" name="hRepIsMandatory" value=""/>
	<input type="hidden" name="hRepScanRequired" value=""/>
	<input type="hidden" name="hRepplaceofissue" value=""/>
	<input type="hidden" name="hRepplaceofissue_cat" value=""/>
	<input type="hidden" name="hRepcountryofissue" value=""/>
	<input type="hidden" name="hDocDueDate" value=""/>
	<!-- CRM102ST: Tracker ID:181582 Being of Change -->
	<input type="hidden" name="hIsDocumentVerified" value=""/>
	<input type="hidden" name="hIDIssuedOrg" value=""/>
	<!-- CRM102ST: Tracker ID:181582 End of Change -->

<!--ERPBOCF1:TRACKER:113259:STORAGE OF DATES :STARTOFCHANGES-->

<input type="hidden" name="stmtDateForCombStmt" value=""/>
<input type="hidden" name="Cust_pref_till_date" value=""/>

<input type="hidden" value="{$ALTCALENDAR_TYPE}" name="ALTCALENDAR_TYPE"/>
<!--ERPBOCF1:TRACKER:113259:STORAGE OF DATES :ENDOFCHANGES-->
<!--Field Addition Tracker 172089:start of Changes-->
	 <input type="hidden" name="nature_activity" value=""/>
<!--Field Addition Tracker 172089:end of Changes-->
<!-- Hobbies and Interest : Start -->
                <xsl:choose>
                   <xsl:when test="normalize-space($acctID)='' and normalize-space($suspID)=''">
				<xsl:call-template name="BeginTabView">
				    <xsl:with-param name="tabViewName">tabPsyForm</xsl:with-param>
				    <xsl:with-param name="tabPageHeight">550</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
 		<xsl:when test="(not(normalize-space($acctID)='') or not(normalize-space($suspID)='')) and $boName ='PsychographicModBO'">
				<xsl:call-template name="BeginTabView">
				    <xsl:with-param name="tabViewName">tabPsyForm</xsl:with-param>
				    <xsl:with-param name="tabPageHeight">550</xsl:with-param>
				 </xsl:call-template>
                   </xsl:when>
                <xsl:when test="($byPassFlag) ='Y'">
				<xsl:call-template name="BeginTabView">
				    <xsl:with-param name="tabViewName">tabPsyForm</xsl:with-param>
				    <xsl:with-param name="tabPageHeight">550</xsl:with-param>
				 </xsl:call-template>
                </xsl:when>

                      <xsl:otherwise>
                        	<xsl:call-template name="BeginTabView">
				    <xsl:with-param name="tabViewName">tabPsyForm</xsl:with-param>
				    <xsl:with-param name="colSpan">6</xsl:with-param>
				    <xsl:with-param name="tabPageHeight">550</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
                <!-- View : PsychographicIndividualPre :Start   -->
	<xsl:choose>
             <xsl:when test= "not(normalize-space($byPassFlag)='Y')">

                <xsl:call-template name="BeginTabPage">
                    <xsl:with-param name="tabViewName">tabPsyForm</xsl:with-param>
                    <xsl:with-param name="tabPageName">tpageIPre</xsl:with-param>
                    <xsl:with-param name="spanWidth">3</xsl:with-param>
                    <xsl:with-param name="tabPageDisplayNameHardCoded">false</xsl:with-param>
                    <xsl:with-param name="tabPageDisplayNameRes" select="$configLabels_1[@name='Header']"/>
                    <xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
                </xsl:call-template>

			  <!-- TrackerID113276 changes start -->
              <!--Realignment of screen (TrackerID113276) -->
              <!-- Tracker id 113276 changes MATP FIX subheader not coming start -->
                              <xsl:call-template name="apply">
			                           <xsl:with-param name="apply_head">
			                           <xsl:value-of select="$configLabels_1[@name='Profile Details']/@configLabel"/>
			                           </xsl:with-param>
                            </xsl:call-template>
<!-- Tracker id 113276 changes MATP FIX subheader not coming end -->
                <xsl:call-template name="Begin"/>
                        	<xsl:call-template name="PsychographicBO.Preferred_Address_Mode"/>
		 		<xsl:call-template name="PsychographicBO.Behavioural_Score"/>
		 	<xsl:call-template name="End"/>


                        <xsl:call-template name="Begin"/>
                        	<xsl:call-template name="PsychographicBO.Risk_Behaviour"/>
				 <xsl:call-template name="PsychographicBO.Other_Behavioural_Profile"/>
                        <xsl:call-template name="End"/>

                        <xsl:call-template name="Begin"/>
                        	<xsl:call-template name="PsychographicBO.stmtDateForCombStmt"/>
		 		<xsl:call-template name="PsychographicBO.TDSCustFloorLimit"/>
                        <xsl:call-template name="End"/>



<!-- Tracker id 113276 changes MATP FIX subheader not coming start -->
				<xsl:call-template name="apply">
					   <xsl:with-param name="apply_head">
					   <xsl:value-of select="$configLabels_1[@name='Preferences Details']/@configLabel"/>
					   </xsl:with-param>
				</xsl:call-template>
<!-- Tracker id 113276 changes MATP FIX subheader not coming end -->
				<xsl:call-template name="Begin"/>
					<xsl:call-template name="PsychographicBO.Preferred_Rep"/>
					<xsl:call-template name="PsychographicBO.Cust_pref_till_date"/>
                        	<xsl:call-template name="End"/>
<!-- Change for 374326 and 374328 start -->
                        	<xsl:call-template name="Begin"/>
<!--                        		<xsl:call-template name="PsychographicBO.Preferred_Locale"/>-->
                        	<xsl:call-template name="End"/>
<!-- change for 374326 and 374328 end -->
               <!-- TrackerID113276 changes end -->
                <!-- commented by TrackerID113276:start -->
                <!-- <xsl:call-template name="Begin"/>
                            <xsl:call-template name="PsychographicBO.Communication_Language"/>
                            <xsl:call-template name="PsychographicBO.Preferred_Address_Mode"/>
                <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                            <xsl:call-template name="PsychographicBO.Preferred_Rep"/>
                            <xsl:call-template name="PsychographicBO.Profile_Field1"/>
                <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                            <xsl:call-template name="PsychographicBO.PreferredName"/>
                            <xsl:call-template name="PsychographicBO.Profile_Field2"/>
			    <xsl:call-template name="PsychographicBO.TDSCustFloorLimit"/>
                <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                            <xsl:call-template name="PsychographicBO.Profile_Field3"/>
                            <xsl:call-template name="PsychographicBO.Profile_Field4"/>
                <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                            <xsl:call-template name="PsychographicBO.Behavioural_Score"/>
                            <xsl:call-template name="PsychographicBO.Risk_Behaviour"/>
                <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                            <xsl:call-template name="PsychographicBO.Other_Behavioural_Profile"/>
                            <xsl:call-template name="PsychographicBO.Service_Personalise"/>
                <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                            <xsl:call-template name="PsychographicBO.userField1"/>
                            <xsl:call-template name="PsychographicBO.userField2"/>
                <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                            <xsl:call-template name="PsychographicBO.userField3"/>
                            <xsl:call-template name="PsychographicBO.userField4"/>
                <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                            <xsl:call-template name="PsychographicBO.userField5"/>
                            <xsl:call-template name="PsychographicBO.userField6"/>
                <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                            <xsl:call-template name="PsychographicBO.spServiceRequired1"/>
                            <xsl:call-template name="PsychographicBO.spServiceRequired2"/>
                <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                            <xsl:call-template name="PsychographicBO.spServiceRequired3"/>
                            <xsl:call-template name="PsychographicBO.spServiceRequired4"/>
                <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>

                            <xsl:call-template name="PsychographicBO.spServiceRequired5"/>
                            <xsl:call-template name="PsychographicBO.stmtDateForCombStmt"/>
                <xsl:call-template name="End"/>	-->
                <!-- commented by TrackerID113276:end -->

	<!-- CORE Fields start-->
	<!-- Tracker ID 92380 Ends -->
		<!-- <xsl:call-template name="Begin"/>
			     <xsl:call-template name="PsychographicBO.CustCharge"/> -->
	<!-- CRM70t-St Tracker# 78381, Begin of Changes -->
			   <!-- <xsl:call-template name="PsychographicBO.CustomerCurrency"/> -->
	<!-- CRM70t-St Tracker# 78381, Begin of Changes -->
				<!--<xsl:call-template name="PsychographicBO.AssetClassificationDesc"/>
				<xsl:call-template name="PsychographicBO.Cust_pref_till_date"/>
				<xsl:call-template name="PsychographicBO.Preferred_Locale"/>
                <xsl:call-template name="End"/> -->

                <!-- <xsl:call-template name="Begin"/>
                	<xsl:call-template name="PsychographicBO.StmtWeekOfMonth"/>
			<xsl:call-template name="PsychographicBO.AssetClassificationDesc"/>
                <xsl:call-template name="End"/>

                <xsl:call-template name="Begin"/>
			<xsl:call-template name="PsychographicBO.Cust_pref_till_date"/>
                <xsl:call-template name="End"/> -->
	<!-- CORE Fields end-->
                           <!--Hobbies And Interest  : palani : start : psycho-->
						   <!-- Changes for ticket 354247 starts -->
<!--                <xsl:variable name="HOBBIES"><xsl:value-of select="$configLabels_1[@name='HOBBIES_AND_INTERESTS']/@configLabel"/></xsl:variable>
                <table  bgcolor='ffffff' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
                <tr style="cursor:hand" STYLE="border-bottom: 10px black;" ID="row{$HOBBIES}" name="row{$HOBBIES}">
		<xsl:attribute name="oncontextmenu">setClickedArea();doContextMenu();</xsl:attribute>
		<td onclick="Toggle_Address('native');" colspan = "2" NOWRAP="true" class="LabelFont">-->
		 <!--  TrackerID113276 changes start -->

		<!-- <A ><IMG onclick="Toggle_Hobbies('Hobbies');" SRC="../reports/images/minus.gif" ID="Hobbiesgif"
                          BORDER="0" ALIGN="absmiddle" HEIGHT="12" WIDTH="12" HSPACE="3" VSPACE="4"/></A> -->
                           <!--  TrackerID113276 changes end -->
      <!--                   <label FOR="CPD" class="LabelFont"><xsl:value-of select="$HOBBIES"/>
                         </label>
                    </td>
                    </tr>
                </table>
                <DIV ID = 'Hobbies' STYLE= 'visibility:visible;'>
                    <table  bgcolor='ffffff' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
                        <TR ID='rowHobbies' name='rowHobbies'> -->
                        <!--  TrackerID113276 changes start -->
                      <!--  <xsl:call-template name="PsychographicBO.hobbyField1">
                            <xsl:with-param name="ele_name">PsychographicBO.hobbyField1</xsl:with-param>
                            </xsl:call-template>     -->


                  <!--          <xsl:call-template name="PsychographicBO.hobbyField2">
                            <xsl:with-param name="ele_name">PsychographicBO.hobbyField2</xsl:with-param>
                            </xsl:call-template> -->
                        <!-- </TR>
                        <TR ID='rowHobbies' name='rowHobbies'> -->
               <!--         <xsl:call-template name="PsychographicBO.hobbyField3">
                        <xsl:with-param name="ele_name">PsychographicBO.hobbyField3</xsl:with-param>
                        </xsl:call-template>

                        </TR>
                        <TR ID='rowHobbies' name='rowHobbies'>
                        <xsl:call-template name="PsychographicBO.hobbyField4">
                        <xsl:with-param name="ele_name">PsychographicBO.hobbyField4</xsl:with-param>
                        </xsl:call-template> -->
                        <!-- </TR>
                        <TR ID='rowHobbies' name='rowHobbies'> -->
                         <!--   <xsl:call-template name="PsychographicBO.hobbyField5">
                            <xsl:with-param name="ele_name">PsychographicBO.hobbyField5</xsl:with-param>
                            </xsl:call-template>
                        </TR> -->

                	 <!-- <TR ID='rowHobbies' name='rowHobbies'>
                            <xsl:call-template name="PsychographicBO.hobbyField6">
                            <xsl:with-param name="ele_name">PsychographicBO.hobbyField6</xsl:with-param>
                            </xsl:call-template>

                    </table>
                         </DIV> -->

					<xsl:call-template name="apply">
					<xsl:with-param name="apply_head">
					<xsl:value-of select="$configLabels_1[@name='HOBBIES_AND_INTERESTS']/@configLabel"/>
					</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="Begin"/>
					<xsl:call-template name="PsychographicBO.hobbyField2"/>
					<xsl:call-template name="PsychographicBO.hobbyField3"/>
					<xsl:call-template name="End"/>
					<xsl:call-template name="Begin"/>
					<xsl:call-template name="PsychographicBO.hobbyField4"/>
					<xsl:call-template name="PsychographicBO.hobbyField5"/>
					<xsl:call-template name="End"/>
					<table  bgcolor='ffffff' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
					</table>
					<!-- Changes for ticket 354247 ends -->

                         <DIV ID = 'Campaigns' STYLE= 'visibility:visible;'>
			    <table  bgcolor='ffffff' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >

                       <TR></TR><TR></TR>
                        <TR>
						<td colspan="3">
                        <b><font class="fntColData" id = "FONT"><xsl:value-of select="$configLabels[@name='Hobbies']/@configLabel"/></font></b>
                        </td></TR>
                        <!-- TrackerID113276 changes end -->

                    </table>
                    </DIV>
                    <table  bgcolor='ffffff' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
                         <td rowspan = "8"></td>
                         <xsl:call-template name="checkbox_list"/>
                         <td rowspan ="8"></td>
                    </table>


<!-- Retail CIF changes for CampaignManagement By Mamta : Start -->
 <!-- Tracker id 113276 changes MATP FIX subheader coming twice start -->
		<xsl:choose>
                <xsl:when test= "$AccessType !='Contact'">
			<!-- <xsl:variable name="CAMPAIGNS"><xsl:value-of select="$configLabels_1[@name='CAMPAIGNS']/@configLabel"/></xsl:variable>
			<table  bgcolor='ffffff' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
			    <tr style="cursor:hand" STYLE="border-bottom: 10px black;" ID="row{$CAMPAIGNS}" name="row{$CAMPAIGNS}">
			    <xsl:attribute name="oncontextmenu">setClickedArea();doContextMenu();</xsl:attribute>
			    <td onclick="Toggle_Address('native');" colspan = "2" NOWRAP="true" class="LabelFont">
			    <A ><IMG onclick="Toggle_Campaigns('Campaigns');" SRC="../reports/images/minus.gif" ID="Campaignsgif"
				  BORDER="0" ALIGN="absmiddle" HEIGHT="12" WIDTH="12" HSPACE="3" VSPACE="4"/></A>
				 <label FOR="CPD" class="LabelFont"><xsl:value-of select="$CAMPAIGNS"/>
				 </label>
			    </td>
			    </tr>
			</table>-->
 <!-- Tracker id 113276 changes MATP FIX subheader coming twice end -->

			<!-- TrackerID 113276 CIF Changes - CAMPAIGN - Begin -->
			<!--for CIF Retail > New Entity > Customer-> Psychographic tab
				Individual Profile or Preference Details:
				In the Campaign Dependency Information section there is not alignment
				between the headers and the values/field below them -->
				<xsl:call-template name="mainbody">
					<xsl:with-param name="tablename">CampaignRecordSet</xsl:with-param>
					<xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels_1[@name='CAMPAIGNS']/@configLabel"/></xsl:with-param>
					<xsl:with-param name="align">Center</xsl:with-param>
					<xsl:with-param name="width">100%</xsl:with-param>
					<xsl:with-param name="IsInnerComposite">true</xsl:with-param>
					<xsl:with-param name="UsrDataSpace">MembershipInfo</xsl:with-param>
					<xsl:with-param name="button">true</xsl:with-param>
					<xsl:with-param name="name">...</xsl:with-param>
					<xsl:with-param name="jscriptfnc">,rowHighLight_Membership()</xsl:with-param>
					<xsl:with-param name="onClick">editMembershipDetails()</xsl:with-param>
					<xsl:with-param name="rowhighlight">true</xsl:with-param>
					<!-- <xsl:with-param name="rsfilenm" select="$fileName_campaign"/> -->
					<!-- <xsl:with-param name="checkbox">true</xsl:with-param> -->
					<!-- Tracker 123433 Changes Start-->
					<!-- Changes for ticket 354247 starts -->
					<!--<xsl:with-param name="extra_colheader2"><xsl:value-of select="$configLabels[@name='Channel']/@configLabel"/></xsl:with-param>-->
					<xsl:with-param name="extra_colheader8"><xsl:value-of select="$configLabels[@name='Channel']/@configLabel"/></xsl:with-param>
					<!-- Changes for ticket 354247 ends -->
					<xsl:with-param name="extra_colheadercheckbox">Y</xsl:with-param>
					<xsl:with-param name="extra_colheaderfn8">checkit()</xsl:with-param>
					<!-- Tracker 123433 Changes Start-->
					<xsl:with-param name="extra_colheader4"><xsl:value-of select="$configLabels[@name='MLHeader3']/@configLabel"/></xsl:with-param>
					<xsl:with-param name="extra_colheader5"><xsl:value-of select="$configLabels[@name='MLHeader4']/@configLabel"/></xsl:with-param>
					<!-- Tracker 123433 Changes End-->
				<!-- <xsl:with-param name="extra_colheader2">Channel</xsl:with-param> -->
					<xsl:with-param name="IsEnabledInReadMode">true</xsl:with-param>
			</xsl:call-template>
		  <br></br>

               <!-- TrackerID113276 CIF Changes - CAMPAIGN - End -->
			<DIV ID = 'Campaigns' STYLE= 'visibility:visible;'>
			    <table  bgcolor='ffffff' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >

			<!-- TrackerID113276 changes start -->

			<!-- commented for 113276 changes -->
				<!--  <tr>
					<td colspan="3">
				<xsl:call-template name="SelectAllCampaign"/>
					<b><font class="fntColData" id = "FONT"> <xsl:value-of select="$configLabels[@name='MLHeader1']/@configLabel"/></font></b>
					</td>

					<td colspan="3">
						<b><font class="fntColData" id = "FONT"><xsl:value-of select="$configLabels[@name='MLHeader2']/@configLabel"/></font></b>
					</td>
					<td colspan="2">
						<b><font class="fntColData" id = "FONT"><xsl:value-of select="$configLabels[@name='MLHeader3']/@configLabel"/></font></b>
					</td>
					<td colspan="2">
						<b><font class="fntColData" id = "FONT">  <xsl:value-of select="$configLabels[@name='MLHeader4']/@configLabel"/></font></b>
					</td>
				</tr>-->
				<!-- commented for 113276 changes end -->
			       <xsl:for-each select="//SRMPresentation/L1[@n='ContactTypes']/C1">
			        <!-- Tracker 123433 Changes Start-->
				<xsl:variable name="one_campaign" select="@value"/>
				<!-- Tracker 123433 Changes End-->

				<tr>
				<!-- tracker id 113276 changes start for CIF Retail > New Entity > Customer-> Psychographic tab ->
					Individual Profile or Preference Details:
					In the Campaign Dependency Information section there is not alignment
					between the headers and the values/field below them -->
					<!-- Changes for ticket 354247 starts -->
					<td class="checkbox_listnew" >
					<input name='ContactTypes' id='{$one_campaign}' type='checkbox'  onClick='campSetting(this)' /><xsl:value-of select="$one_campaign"/>
					</td>
					<td><xsl:call-template name="addemptycell"/></td>
					<td><xsl:call-template name="addemptycell"/></td>
					<td><xsl:call-template name="addemptycell"/></td>
					<td><xsl:call-template name="addemptycell"/></td>
					<td><xsl:call-template name="addemptycell"/></td>
					<td><xsl:call-template name="addemptycell"/></td>
					<td><xsl:call-template name="addemptycell"/></td>
					<td><xsl:call-template name="PsychographicBO.CampaignDependency.ContactFrequency"/></td>
					<td><xsl:call-template name="addemptycell"/></td>
					<td><xsl:call-template name="addemptycell"/></td>
					<td><xsl:call-template name="PsychographicBO.CampaignDependency.NoOfTimesCanContact"/></td>
					<td><xsl:call-template name="addemptycell"/></td>
					<td><xsl:call-template name="addemptycell"/></td>
					<td><xsl:call-template name="addemptycell"/></td>
				<!-- Changes for ticket 354247 ends -->
				</tr>
				<!-- tracker id 113276 changes END for CIF Retail > New Entity > Customer-> Psychographic tab ->
				Individual Profile or Preference Details:
				In the Campaign Dependency Information section there is not alignment
				between the headers and the values/field below them -->
				</xsl:for-each>

			    </table>
			</DIV>
		</xsl:when>
		</xsl:choose>
<!-- Retail CIF changes for CampaignManagement By Mamta : End -->

                <!-- CIF Changes - Membership - Begin -->




                <table bgcolor = "ffffff" align="center" border = "0"  cellspacing="3" cellpadding="2" width="100%">
		<!-- Tracker Id 92380 -->
		<tr align="left">


			<td align="left">
				<xsl:call-template name="user_button_withText">
				<xsl:with-param name="button_name">ADD_MEMBERSHIP_DETAILS</xsl:with-param>
				<xsl:with-param name="button_text"><xsl:value-of select="$configLabels_6[@name='ADD_MEMBERSHIP_DETAILS']/@configLabel"/></xsl:with-param>
				<xsl:with-param name="button_fnc">addMembership()</xsl:with-param>
				</xsl:call-template>&#160;
				<xsl:call-template name="user_button_withText">
				<xsl:with-param name="button_name">REMOVE_MEMBERSHIP_DETAILS</xsl:with-param>
				<xsl:with-param name="button_text"><xsl:value-of select="$configLabels_6[@name='REMOVE_MEMBERSHIP_DETAILS']/@configLabel"/></xsl:with-param>
				<xsl:with-param name="button_fnc">removeMembership()</xsl:with-param>
				</xsl:call-template>
			</td>
		</tr>
		</table>


		<xsl:call-template name="mainbody">
				<xsl:with-param name="tablename">MembershipRecordSet</xsl:with-param>
				<xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels_1[@name='MEMBERDET']/@configLabel"/></xsl:with-param>
				<xsl:with-param name="align">Center</xsl:with-param>
				<xsl:with-param name="width">100%</xsl:with-param>
				<xsl:with-param name="IsInnerComposite">true</xsl:with-param>
				<xsl:with-param name="UsrDataSpace">MembershipInfo</xsl:with-param>
				<xsl:with-param name="button">true</xsl:with-param>
				<xsl:with-param name="name">...</xsl:with-param>
				<xsl:with-param name="jscriptfnc">,rowHighLight_Membership()</xsl:with-param>
				<xsl:with-param name="onClick">editMembershipDetails()</xsl:with-param>
				<xsl:with-param name="rowhighlight">true</xsl:with-param>
				<xsl:with-param name="rsfilenm" select="$fileName_membership"/>
				<xsl:with-param name="extra_colheader">Select</xsl:with-param>
				<xsl:with-param name="IsEnabledInReadMode">true</xsl:with-param>
		</xsl:call-template>
	  <br></br>

               <!-- CIF Changes - Membership - End -->


	       <xsl:call-template name="EndTabPage"/>
	</xsl:when>
     <xsl:otherwise>

      <xsl:call-template name="BeginTabPage">
                         <xsl:with-param name="tabViewName">tabPsyForm</xsl:with-param>
                         <xsl:with-param name="tabPageName">tpageFamily</xsl:with-param>
                         <xsl:with-param name="spanWidth">3</xsl:with-param>
                         <xsl:with-param name="tabPageDisplayNameHardCoded">Yes</xsl:with-param>
                         <xsl:with-param name="tabPageDisplayNameRes" select="$configLabels_3[@name='Header']"/>
                     </xsl:call-template>

                     <xsl:call-template name="Begin"/>
                         <xsl:call-template name="PsychographicBO.NumberofDependants"/>
                         <xsl:call-template name="PsychographicBO.NumberofDependantChildren"/>
                     <xsl:call-template name="End"/>




                        <xsl:call-template name="EndTabPage"/>
   	</xsl:otherwise>
    </xsl:choose>



	      <!-- View : IndividualPreferenceInfo :END -->
                <!-- View : segmentation : start   -->

                <xsl:call-template name="BeginTabView">
		    <xsl:with-param name="tabViewName">tabPsyForm</xsl:with-param>
		    <xsl:with-param name="tabPageHeight">285</xsl:with-param>
		</xsl:call-template>
                <xsl:call-template name="BeginTabPage">
                    <xsl:with-param name="tabViewName">tabPsyForm</xsl:with-param>
                    <xsl:with-param name="tabPageName">tpageSeg</xsl:with-param>
                    <xsl:with-param name="spanWidth">3</xsl:with-param>
                    <xsl:with-param name="tabPageDisplayNameHardCoded">false</xsl:with-param>
                    <xsl:with-param name="tabPageDisplayNameRes" select="$configLabels_2[@name='Header']"/>
                     <xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
                </xsl:call-template>
                            <xsl:call-template name="apply1">
		                     <xsl:with-param name="apply_head">
		                     <xsl:value-of select="$configLabels_2[@name='SEG_DET']/@configLabel"/>
		                     </xsl:with-param>
                            </xsl:call-template>
                <xsl:call-template name="Begin"/>
		    <!--<xsl:call-template name="PsychographicBO.Segmentation_Class"/>-->
		    <xsl:call-template name="PsychographicBO.Life_Cycle_Stage"/>
		    <xsl:call-template name="PsychographicBO.Flag1"/>
		<xsl:call-template name="End"/>
		<xsl:call-template name="Begin"/>
		    <xsl:call-template name="PsychographicBO.prefRelshipDiscount1"/>
		    <xsl:call-template name="PsychographicBO.prefRelshipDiscount2"/>
		<xsl:call-template name="End"/>
		<xsl:call-template name="Begin"/>
		    <xsl:call-template name="PsychographicBO.prefRelshipDiscountPercent1"/>
		    <xsl:call-template name="PsychographicBO.prefRelshipDiscountPercent2"/>
		<xsl:call-template name="End"/>
		<xsl:call-template name="Begin"/>
		    <xsl:call-template name="PsychographicBO.UserFlag1"/>
		    <xsl:call-template name="PsychographicBO.UserFlag2"/>
		<xsl:call-template name="End"/>
		<xsl:call-template name="Begin"/>
		    <!--<xsl:call-template name="PsychographicBO.subSegment"/>-->
		<xsl:call-template name="End"/>
                <xsl:call-template name="EndTabPage"/>
                               <!-- View : segmentation : END   -->


   <!-- CIF Changes: Relationship :Start-->
    	<xsl:call-template name="BeginTabPage">
    	    <xsl:with-param name="tabViewName">tabPsyForm</xsl:with-param>
    	    <xsl:with-param name="tabPageName">tpageRel</xsl:with-param>
    	    <xsl:with-param name="spanWidth">1</xsl:with-param>
    	   <xsl:with-param name="tabPageDisplayNameHardCoded">false</xsl:with-param>
    	   <xsl:with-param name="tabPageDisplayNameRes" select="$configLabels_13[@name='RELATIONSHIP']"/>
    	     <!--<xsl:with-param name="tabPageDisplayNameHardCoded">Yes</xsl:with-param>-->
  	    <!--<xsl:with-param name="tabPageDisplayNameRes">Relationship</xsl:with-param>-->
  	    <xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
    	</xsl:call-template>

     <!-- Banking Table Templete: Start-->
    	<table bgcolor = "ffffff" align="center"   cellspacing="0" cellpadding="2" width="100%">
    	 <tr>


   	             <xsl:call-template name="mdrpdown">
  	             <xsl:with-param name="res_name" select="$configLabels_13[@name='Relationship']"/>
  	             <xsl:with-param name="selectname">Relationship</xsl:with-param>
  	             <xsl:with-param name="selectdisp">Relationship</xsl:with-param>
  	             <xsl:with-param name="defaultValue">Banking</xsl:with-param>
  	             <xsl:with-param name="search_type">url</xsl:with-param>
  	             <xsl:with-param name="onchangefn">selectRecordSet()</xsl:with-param>
  	             <xsl:with-param name="choice_name">Relationship</xsl:with-param>

  	     	<!-- CIF Changes for Caching Views : Start -->
  	              	<xsl:with-param name="presdata" select="$PresData"/>
  	     	<!-- CIF Changes for Caching Views : End -->
  	                 </xsl:call-template>&#160;



    	 <!-- Tracker Id 92380 -->
    	     <td align="left">
    	      <xsl:call-template name="user_button_withText">
    		<xsl:with-param name="button_name">add_bankrelationship</xsl:with-param>
    		<xsl:with-param name="button_text"><xsl:value-of select="$configLabels_13[@name='add_bankrelationship']/@configLabel"/></xsl:with-param>
    		<xsl:with-param name="button_fnc">addBankRelationship()</xsl:with-param>
     		<xsl:with-param name="class">sbttn</xsl:with-param>
     		<xsl:with-param name="button_type">button</xsl:with-param>

    		</xsl:call-template>&#160;

          <xsl:call-template name="user_button_withText">
          <xsl:with-param name="button_name">remove_bankrelationship</xsl:with-param>
    	<xsl:with-param name="button_text"><xsl:value-of select="$configLabels_13[@name='remove_bankrelationship']/@configLabel"/></xsl:with-param>
    		<xsl:with-param name="button_fnc">removeBankRelationship()</xsl:with-param>
    		</xsl:call-template>&#160;


    	     </td>
    	  </tr>
    	</table>


   <div style='visibility:hidden' id='Banking' name='Banking' >
    	  <xsl:call-template name="mainbody">
    	  <xsl:with-param name="tablename">RelationRecordSet</xsl:with-param>
    	  <!-- Tracker ID 124007 changes -->
    		<xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels_13[@name='INTRODUCER']/@configLabel"/></xsl:with-param>
    	  <!-- Tracker ID 124007 changes -->
    		<xsl:with-param name="align">Center</xsl:with-param>
    	  <xsl:with-param name="width">100%</xsl:with-param>
          <!-- Manupulation for the table representation : Start-->
    	<xsl:with-param name="IsInnerComposite">true</xsl:with-param>
          <!-- Manupulation for the table representation : End-->
    	  <xsl:with-param name="UsrDataSpace">RelationshipInfo</xsl:with-param>
    	  <xsl:with-param name="button">true</xsl:with-param>
    	  <xsl:with-param name="name">...</xsl:with-param>
    	  <xsl:with-param name="jscriptfnc">,call()</xsl:with-param>
    	  <xsl:with-param name="onClick">editRelationshipDetails()</xsl:with-param>
    	  <xsl:with-param name="rowhighlight">true</xsl:with-param>
    	  <xsl:with-param name="rsfilenm" select="$fileName_Banking"/>
    	  <xsl:with-param name="extra_colheader">Select</xsl:with-param>
    	  <xsl:with-param name="IsEnabledInReadMode">true</xsl:with-param>
    	  </xsl:call-template>
    	  <br></br>
  </div>
      <!--BankingRelationship Table Template : End-->

      <!-- Social Table Templete: Start-->
    <!--    	<table bgcolor = "ffffff" align="center" border = "0"  cellspacing="0" cellpadding="2" width="100%">
        	 <tr align="left">
        	     <td>
        	      <xsl:call-template name="user_button_withText">
        		<xsl:with-param name="button_name">add_SocialRelationship</xsl:with-param>
        		<xsl:with-param name="button_text"><xsl:value-of select="$configLabels_14[@name='add_socialrelationship']/@configLabel"/></xsl:with-param>
        		<xsl:with-param name="button_fnc">addBankRelationship()</xsl:with-param>
        		</xsl:call-template>&#160;
              <xsl:call-template name="user_button_withText">
              <xsl:with-param name="button_name">remove_Bankrelationship</xsl:with-param>
        	<xsl:with-param name="button_text"><xsl:value-of select="$configLabels_13[@name='remove_bankrelationship']/@configLabel"/></xsl:with-param>
        		<xsl:with-param name="button_fnc">removeBankRelationship()</xsl:with-param>
        		</xsl:call-template>
        	     </td>
        	  </tr>
        	</table> -->

  <div style='visibility:hidden' id='Social' name='Social' >
        	  <xsl:call-template name="mainbody">
        	  <xsl:with-param name="tablename">SocialRecordSet</xsl:with-param>
        	  <!-- Tracker ID 124007 changes -->
        		<xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels_14[@name='Social Relationship']/@configLabel"/></xsl:with-param>
        	  <!-- Tracker ID 124007 changes -->
        		<xsl:with-param name="align">Center</xsl:with-param>
        	  <xsl:with-param name="width">100%</xsl:with-param>
              <!-- Manupulation for the table representation : Start-->
        	<xsl:with-param name="IsInnerComposite">true</xsl:with-param>
              <!-- Manupulation for the table representation : End-->
        	  <xsl:with-param name="UsrDataSpace">SocialInfo</xsl:with-param>
        	  <xsl:with-param name="button">true</xsl:with-param>
        	  <xsl:with-param name="name">...</xsl:with-param>
        	  <xsl:with-param name="jscriptfnc">,callSocial()</xsl:with-param>
        	  <xsl:with-param name="onClick">editSocialRelationship()</xsl:with-param>
        	  <xsl:with-param name="rowhighlight">true</xsl:with-param>
        	  <xsl:with-param name="rsfilenm" select="$fileName_Social"/>
        	  <xsl:with-param name="extra_colheader">Select</xsl:with-param>
        	  <xsl:with-param name="IsEnabledInReadMode">true</xsl:with-param>
        	  </xsl:call-template>
        	  <br></br>
 </div>
          <!--SocialRelationship Table Template : End-->

          <!-- Corporate Table Templete: Start-->
 <div style='visibility:hidden' id='Corporate' name='Corporate' >
  	      	  <xsl:call-template name="mainbody">
  	      	  <xsl:with-param name="tablename">CorporateRecordSet</xsl:with-param>
  	      	  <!-- Tracker ID 124007 changes -->
  	      		<xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels_15[@name='Corporate Relationship']/@configLabel"/></xsl:with-param>
  	      	  <!-- Tracker ID 124007 changes -->
  	      		<xsl:with-param name="align">Center</xsl:with-param>
  	      	  <xsl:with-param name="width">100%</xsl:with-param>
  	            <!-- Manupulation for the table representation : Start-->
  	      	<xsl:with-param name="IsInnerComposite">true</xsl:with-param>
  	            <!-- Manupulation for the table representation : End-->
  	      	  <xsl:with-param name="UsrDataSpace">CorporateInfo</xsl:with-param>
  	      	  <xsl:with-param name="rowhighlight">true</xsl:with-param>
  	      	  <xsl:with-param name="rsfilenm" select="$fileName_Corporate"/>
  	      	   </xsl:call-template>
  	      	  <br></br>
  </div>
          <!--CorporateRelationship Table Template : End-->
<!--GREETY : START -->
   <div style='visibility:hidden' id='Banking1' name='Banking1' >
    	  <xsl:call-template name="mainbody">
    	  <xsl:with-param name="tablename">RelationRecordSet1</xsl:with-param>
    	  <!-- Tracker ID 124007 changes -->
    	  <xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels_13[@name='GUARANTOR']/@configLabel"/></xsl:with-param>
    	  <!-- Tracker ID 124007 changes -->
    	  <xsl:with-param name="align">Center</xsl:with-param>
    	  <xsl:with-param name="width">100%</xsl:with-param>
    	  <xsl:with-param name="IsInnerComposite">true</xsl:with-param>
    	  <xsl:with-param name="UsrDataSpace">RelationshipInfo1</xsl:with-param>
    	  <xsl:with-param name="button">true</xsl:with-param>
    	  <xsl:with-param name="name">...</xsl:with-param>
    	  <xsl:with-param name="jscriptfnc">,call()</xsl:with-param>
    	  <xsl:with-param name="onClick">editRelationshipDetails()</xsl:with-param>
   	  <xsl:with-param name="rowhighlight">true</xsl:with-param>
    	  <xsl:with-param name="extra_colheader">Select</xsl:with-param>
    	  <xsl:with-param name="rsfilenm" select="$fileName_Banking1"/>
    	  <xsl:with-param name="IsEnabledInReadMode">true</xsl:with-param>
    	  </xsl:call-template>
    	  <br></br>
  </div>

     <div style='visibility:hidden' id='Banking2' name='Banking2' >
      	  <xsl:call-template name="mainbody">
      	  <xsl:with-param name="tablename">RelationRecordSet2</xsl:with-param>
      	  <!-- Tracker ID 124007 changes -->
      	  <xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels_13[@name='REFERENCE']/@configLabel"/></xsl:with-param>
      	  <!-- Tracker ID 124007 changes -->
      	  <xsl:with-param name="align">Center</xsl:with-param>
      	  <xsl:with-param name="width">100%</xsl:with-param>
      	  <xsl:with-param name="UsrDataSpace">RelationshipInfo2</xsl:with-param>
      	  <xsl:with-param name="button">true</xsl:with-param>
      	  <xsl:with-param name="name">...</xsl:with-param>
    	  <xsl:with-param name="jscriptfnc">,call()</xsl:with-param>
    	  <xsl:with-param name="onClick">editRelationshipDetails()</xsl:with-param>
      	  <xsl:with-param name="rowhighlight">true</xsl:with-param>
      	  <xsl:with-param name="extra_colheader">Select</xsl:with-param>
      	  <xsl:with-param name="rsfilenm" select="$fileName_Banking1"/>
      	  <xsl:with-param name="rowhighlight">true</xsl:with-param>
    	  <xsl:with-param name="IsEnabledInReadMode">true</xsl:with-param>
      	  </xsl:call-template>
    	  <br></br>
  </div>
<!--GREETY : END -->


<div style='visibility:hidden' id='Beneficial Owner' name='BeneficialOwner' >
			<xsl:call-template name="mainbody">
			<xsl:with-param name="tablename">BeneficialOwnerRecordSet</xsl:with-param>
			<!-- Tracker ID 124007 changes -->
			<xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels_13[@name='BENEFICIAL OWNER']/@configLabel"/></xsl:with-param>
			<!-- Tracker ID 124007 changes -->
			<xsl:with-param name="align">Center</xsl:with-param>
			<xsl:with-param name="width">100%</xsl:with-param>
			<!-- Manupulation for the table representation : Start-->
			<!--<xsl:with-param name="IsInnerComposite">true</xsl:with-param>-->
			<!-- Manupulation for the table representation : End-->
			<xsl:with-param name="UsrDataSpace">BeneficialOwnerInfo</xsl:with-param>
			<xsl:with-param name="button">true</xsl:with-param>
			<xsl:with-param name="name">...</xsl:with-param>
			<!-- Change for ticket 334923 : BEGIN  -->
			<xsl:with-param name="jscriptfnc">,call()</xsl:with-param>
			<!-- Change for ticket 334923 : END  -->
			<xsl:with-param name="onClick">editBeneficialOwner();</xsl:with-param>
			<xsl:with-param name="IsEnabledInReadMode">true</xsl:with-param>
			<xsl:with-param name="rowhighlight">true</xsl:with-param>
			<xsl:with-param name="rsfilenm" select="$fileNameBen"/>
			<xsl:with-param name="extra_colheader">Select</xsl:with-param>
			</xsl:call-template>
<br></br>
</div>
          <xsl:call-template name="EndTabPage"/>
<!-- relationship table changes end -->


                <!-- View : Family : Start   -->
	<xsl:choose>
             <xsl:when test= "not(normalize-space($byPassFlag)='Y')">
                <xsl:call-template name="BeginTabPage">
                    <xsl:with-param name="tabViewName">tabPsyForm</xsl:with-param>
                    <xsl:with-param name="tabPageName">tpageFamily</xsl:with-param>
                    <xsl:with-param name="spanWidth">3</xsl:with-param>
                    <xsl:with-param name="tabPageDisplayNameHardCoded">false</xsl:with-param>
                    <xsl:with-param name="tabPageDisplayNameRes" select="$configLabels_3[@name='Header']"/>
                      <xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
                </xsl:call-template>
                <xsl:call-template name="Begin"/>
                    <xsl:call-template name="PsychographicBO.NumberofDependants"/>
                    <xsl:call-template name="PsychographicBO.NumberofDependantChildren"/>
                <xsl:call-template name="End"/>
            <xsl:call-template name="Begin"/>
                    <!-- LifeStyle Table Templete: palani : psycho : Start-->

                <table bgcolor = "ffffff" align="center" border = "0"  cellspacing="0" cellpadding="2" width="100%">
                         <!-- Tracker Id 92380 -->
                         <tr align="left">
                             <td>
                              <xsl:call-template name="user_button_withText">
                                <xsl:with-param name="button_name">ADD_LIFESTYLE</xsl:with-param>
                                <xsl:with-param name="button_text"><xsl:value-of select="$configLabels_10[@name='ADD_LIFESTYLE']/@configLabel"/></xsl:with-param>
                                <xsl:with-param name="button_fnc">addLifeStyle()</xsl:with-param>
                                </xsl:call-template>&#160;
                      <xsl:call-template name="user_button_withText">
                      <xsl:with-param name="button_name">REMOVE_LIFESTYLE</xsl:with-param>
                                <xsl:with-param name="button_text"><xsl:value-of select="$configLabels_10[@name='REMOVE_LIFESTYLE']/@configLabel"/></xsl:with-param>
                                <xsl:with-param name="button_fnc">removeLifeStyle()</xsl:with-param>
                                </xsl:call-template>
                             </td>
                          </tr>
                </table>


                  <xsl:call-template name="mainbody">
                  <xsl:with-param name="tablename">LifeStyleRecordSet</xsl:with-param>
                        <xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels_10[@name='LifeStyle Details']/@configLabel"/></xsl:with-param>
                        <xsl:with-param name="align">Center</xsl:with-param>
                  <xsl:with-param name="width">100%</xsl:with-param>
              <!-- Manupulation for the table representation : Start-->
                <xsl:with-param name="IsInnerComposite">true</xsl:with-param>
              <!-- Manupulation for the table representation : End-->
                  <xsl:with-param name="UsrDataSpace">LifeStyleInfo</xsl:with-param>
                  <xsl:with-param name="button">true</xsl:with-param>
                        <xsl:with-param name="name">...</xsl:with-param>
                  <xsl:with-param name="jscriptfnc">,callLifeStyle()</xsl:with-param>
                  <xsl:with-param name="onClick">editLifeStyleDetails()</xsl:with-param>
                      <xsl:with-param name="rowhighlight">true</xsl:with-param>
                  <xsl:with-param name="rsfilenm" select="$fileName_LifeStyle"/>
                  <xsl:with-param name="extra_colheader">Select</xsl:with-param>
                  <xsl:with-param name="IsEnabledInReadMode">true</xsl:with-param>
                  </xsl:call-template>
                        <br></br>
              <!--LifeStyle Table Templete : End-->
            <xsl:call-template name="End"/>
                   <xsl:call-template name="EndTabPage"/>

       	</xsl:when>
    <xsl:otherwise>

         <xsl:call-template name="BeginTabPage">
                    <xsl:with-param name="tabViewName">tabPsyForm</xsl:with-param>
                    <xsl:with-param name="tabPageName">tpageIPre</xsl:with-param>
                    <xsl:with-param name="spanWidth">3</xsl:with-param>
                    <xsl:with-param name="tabPageDisplayNameHardCoded">false</xsl:with-param>
                    <xsl:with-param name="tabPageDisplayNameRes" select="$configLabels_1[@name='Header']"/>
                </xsl:call-template>
                <xsl:call-template name="Begin"/>
                            <xsl:call-template name="PsychographicBO.Communication_Language"/>
                            <xsl:call-template name="PsychographicBO.Preferred_Address_Mode"/>
                            <xsl:call-template name="PsychographicBO.Preferred_Rep"/>
                <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                            <!-- <xsl:call-template name="PsychographicBO.PreferredName"/> -->
                            <xsl:call-template name="PsychographicBO.Profile_Field1"/>
                            <xsl:call-template name="PsychographicBO.Profile_Field2"/>
                <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                            <xsl:call-template name="PsychographicBO.Profile_Field3"/>
                            <xsl:call-template name="PsychographicBO.Profile_Field4"/>
                            <xsl:call-template name="PsychographicBO.Behavioural_Score"/>
                <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                            <xsl:call-template name="PsychographicBO.Risk_Behaviour"/>
                            <xsl:call-template name="PsychographicBO.Other_Behavioural_Profile"/>
                            <xsl:call-template name="PsychographicBO.Service_Personalise"/>
                <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                            <xsl:call-template name="PsychographicBO.userField1"/>
                            <xsl:call-template name="PsychographicBO.userField2"/>
                            <xsl:call-template name="PsychographicBO.userField3"/>
                <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                            <xsl:call-template name="PsychographicBO.userField4"/>
                            <xsl:call-template name="PsychographicBO.userField5"/>
                            <xsl:call-template name="PsychographicBO.userField6"/>
                <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                            <xsl:call-template name="PsychographicBO.spServiceRequired1"/>
                            <xsl:call-template name="PsychographicBO.spServiceRequired2"/>
                            <xsl:call-template name="PsychographicBO.spServiceRequired3"/>
                <xsl:call-template name="End"/>
                <xsl:call-template name="Begin"/>
                            <xsl:call-template name="PsychographicBO.spServiceRequired4"/>
                            <xsl:call-template name="PsychographicBO.spServiceRequired5"/>
                            <xsl:call-template name="PsychographicBO.stmtDateForCombStmt"/>
                <xsl:call-template name="End"/>
	<!-- CORE Fields start-->
		<xsl:call-template name="Begin"/>
		<xsl:call-template name="Begin"/>
			    <!-- <xsl:call-template name="PsychographicBO.CustCharge"/> -->
	<!-- CRM70t-St Tracker# 78381, Begin of Changes -->
			   <!-- <xsl:call-template name="PsychographicBO.CustomerCurrency"/> -->
	<!-- CRM70t-St Tracker# 78381, Begin of Changes -->
				<!--<xsl:call-template name="PsychographicBO.AssetClassificationDesc"/>-->
				<xsl:call-template name="PsychographicBO.Cust_pref_till_date"/>
                <xsl:call-template name="End"/>

                <!-- <xsl:call-template name="Begin"/>
                	<xsl:call-template name="PsychographicBO.StmtWeekOfMonth"/>
			<xsl:call-template name="PsychographicBO.AssetClassificationDesc"/>
                <xsl:call-template name="End"/>

                <xsl:call-template name="Begin"/>
			<xsl:call-template name="PsychographicBO.Cust_pref_till_date"/>
                <xsl:call-template name="End"/> -->
	<!-- CORE Fields end-->
                           <!--Hobbies And Interest  : palani : start : psycho-->
                <xsl:variable name="HOBBIES"><xsl:value-of select="$configLabels_1[@name='HOBBIES_AND_INTERESTS']/@configLabel"/></xsl:variable>
                <table  bgcolor='ffffff' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
                    <tr style="cursor:hand" STYLE="border-bottom: 10px black;" ID="row{$HOBBIES}" name="row{$HOBBIES}">
                    <td colspan = "2">
                         <A ><IMG onclick="Toggle_Hobbies('Hobbies');" SRC="../reports/images/minus.gif" ID="Hobbiesgif"
                          BORDER="0" ALIGN="absmiddle" HEIGHT="12" WIDTH="12" HSPACE="3" VSPACE="4"/></A>
                         <label FOR="CPD" class="LabelFont"><xsl:value-of select="$HOBBIES"/>
                         </label>
                    </td>
                    </tr>
                </table>
                <DIV ID = 'Hobbies' STYLE= 'visibility:visible;'>
                    <table  bgcolor='ffffff' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
                        <TR ID='rowHobbies' name='rowHobbies'>
                            <xsl:call-template name="PsychographicBO.hobbyField1">
                            <xsl:with-param name="ele_name">PsychographicBO.hobbyField1</xsl:with-param>
                            </xsl:call-template>
                            <xsl:call-template name="addemptycell"/>
                            <xsl:call-template name="PsychographicBO.hobbyField2">
                            <xsl:with-param name="ele_name">PsychographicBO.hobbyField2</xsl:with-param>
                            </xsl:call-template>
                        </TR>
                        <TR ID='rowHobbies' name='rowHobbies'>
                        <xsl:call-template name="PsychographicBO.hobbyField3">
                        <xsl:with-param name="ele_name">PsychographicBO.hobbyField3</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="addemptycell"/>
                        <xsl:call-template name="PsychographicBO.hobbyField4">
                        <xsl:with-param name="ele_name">PsychographicBO.hobbyField4</xsl:with-param>
                        </xsl:call-template>
                        </TR>
                        <TR ID='rowHobbies' name='rowHobbies'>
                            <xsl:call-template name="PsychographicBO.hobbyField5">
                            <xsl:with-param name="ele_name">PsychographicBO.hobbyField5</xsl:with-param>
                            </xsl:call-template>
                            <xsl:call-template name="addemptycell"/>
                            <xsl:call-template name="PsychographicBO.hobbyField6">
                            <xsl:with-param name="ele_name">PsychographicBO.hobbyField6</xsl:with-param>
                            </xsl:call-template>
                        </TR>
                    </table>
                    <table  bgcolor='ffffff' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
                          <xsl:call-template name="checkbox_list"/>
                    </table>
                </DIV>

<!-- Retail CIF changes for CampaignManagement By Mamta : Start -->
		<xsl:choose>
                <xsl:when test= "$AccessType !='Contact'">
			<xsl:variable name="CAMPAIGNS"><xsl:value-of select="$configLabels_1[@name='CAMPAIGNS']/@configLabel"/></xsl:variable>
			<table  bgcolor='ffffff' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
			    <tr style="cursor:hand" STYLE="border-bottom: 10px black;" ID="row{$CAMPAIGNS}" name="row{$CAMPAIGNS}">
			    <xsl:attribute name="oncontextmenu">setClickedArea();doContextMenu();</xsl:attribute>
			    <td onclick="Toggle_Address('native');" colspan = "2" NOWRAP="true" class="LabelFont">
				<A ><IMG onclick="Toggle_Campaigns('Campaigns');" SRC="../reports/images/minus.gif" ID="Campaignsgif"
				  BORDER="0" ALIGN="absmiddle" HEIGHT="12" WIDTH="12" HSPACE="3" VSPACE="4"/></A>
				 <label FOR="CPD" class="LabelFont"><xsl:value-of select="$CAMPAIGNS"/>
				 </label>
			    </td>
			    </tr>
			</table>
			<DIV ID = 'Campaigns' STYLE= 'visibility:visible;'>
			    <table  bgcolor='ffffff' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
			      <tr class='d1' align='center' style='TEXT-ALIGN: left;'>
				<xsl:call-template name="SelectAllCampaign"/>
				<xsl:value-of select="$configLabels[@name='MLHeader1']/@configLabel"/>
			      </tr>
				<tr>
					<td colspan="3">
						<b><font class="fntColData" id = "FONT"><xsl:value-of select="$configLabels[@name='MLHeader2']/@configLabel"/></font></b>
					</td>
					<td colspan="2">
						<b><font class="fntColData" id = "FONT"><xsl:value-of select="$configLabels[@name='MLHeader3']/@configLabel"/></font></b>
					</td>
					<td colspan="2" >
						<b><font class="fntColData" id = "FONT"><xsl:value-of select="$configLabels[@name='MLHeader4']/@configLabel"/></font></b>
					</td>
				</tr>
			       <xsl:for-each select="//SRMPresentation/L1[@n='ContactTypes']/C1">
				<xsl:variable name="one_campaign" select="@url"/>
				<tr>
				      <td class="checkbox_list" colspan="2">
				      <input name='ContactTypes' id='{$one_campaign}' type='checkbox' onClick='campSetting(this)' /><xsl:value-of select="$one_campaign"/>
				      </td>
				      <xsl:call-template name="PsychographicBO.CampaignDependency.ContactFrequency"/>
				      <xsl:call-template name="PsychographicBO.CampaignDependency.NoOfTimesCanContact"/>
				</tr>
				</xsl:for-each>
			    </table>
			</DIV>
		</xsl:when>
		</xsl:choose>
<!-- Retail CIF changes for CampaignManagement By Mamta : End -->

                <!-- CIF Changes - Membership - Begin -->


                <table bgcolor = "ffffff" align="center" border = "0"  cellspacing="0" cellpadding="2" width="100%">
		<!-- Tracker Id 92380 -->
		<tr align="left">
			<td>
				<xsl:call-template name="user_button_withText">
				<xsl:with-param name="button_name">ADD_MEMBERSHIP_DETAILS</xsl:with-param>
				<xsl:with-param name="button_text"><xsl:value-of select="$configLabels_6[@name='ADD_MEMBERSHIP_DETAILS']/@configLabel"/></xsl:with-param>
				<xsl:with-param name="button_fnc">addMembership()</xsl:with-param>
				</xsl:call-template>&#160;
				<xsl:call-template name="user_button_withText">
				<xsl:with-param name="button_name">REMOVE_MEMBERSHIP_DETAILS</xsl:with-param>
				<xsl:with-param name="button_text"><xsl:value-of select="$configLabels_6[@name='REMOVE_MEMBERSHIP_DETAILS']/@configLabel"/></xsl:with-param>
				<xsl:with-param name="button_fnc">removeMembership()</xsl:with-param>
				</xsl:call-template>
			</td>
		</tr>
		</table>


		<xsl:call-template name="mainbody">
				<xsl:with-param name="tablename">MembershipRecordSet</xsl:with-param>
				<xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels_1[@name='MEMBERDET']/@configLabel"/></xsl:with-param>
				<xsl:with-param name="align">Center</xsl:with-param>
				<xsl:with-param name="width">100%</xsl:with-param>

				<xsl:with-param name="IsInnerComposite">true</xsl:with-param>

				<xsl:with-param name="UsrDataSpace">MembershipInfo</xsl:with-param>
				<xsl:with-param name="button">true</xsl:with-param>
				<xsl:with-param name="name">...</xsl:with-param>
				<xsl:with-param name="onClick">editMembershipDetails()</xsl:with-param>
				<xsl:with-param name="rowhighlight">true</xsl:with-param>
				<xsl:with-param name="rsfilenm" select="$fileName_membership"/>
				<xsl:with-param name="extra_colheader">Select</xsl:with-param>
		</xsl:call-template>
	  <br></br>

               <!-- CIF Changes - Membership - End -->

               <xsl:call-template name="EndTabPage"/>
            </xsl:otherwise>
	</xsl:choose>




                              <!-- View : Family : END   -->
<!-- View : Product Preference : Start   -->
	<xsl:call-template name="BeginTabPage">
	    <xsl:with-param name="tabViewName">tabPsyForm</xsl:with-param>
	    <xsl:with-param name="tabPageName">tpageProductPreference</xsl:with-param>
	    <xsl:with-param name="spanWidth">3</xsl:with-param>
	    <!-- <xsl:with-param name="tabPageDisplayNameHardCoded">Yes</xsl:with-param>-->
	    <!--<xsl:with-param name="tabPageDisplayNameRes">Product Preference</xsl:with-param>-->
	    <xsl:with-param name="tabPageDisplayNameHardCoded">false</xsl:with-param>
	    <xsl:with-param name="tabPageDisplayNameRes" select="$configLabels_4[@name='PRODUCT_PREFERENCES']"/>
	 <!-- CRM11.0:TRACKER:113058:BEGINOFCHANGES -->
            <xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
         <!-- CRM11.0:TRACKER:113058:ENDOFCHANGES -->
	</xsl:call-template>

	<!--  Header customer pricing details -->

	<xsl:choose>
 	<xsl:when test= "$AccessType ='Account'">

    <xsl:call-template name="apply">
			   <xsl:with-param name="apply_head">
			   <xsl:value-of select="$configLabels_4[@name='MLHeader7']/@configLabel"/>
			   </xsl:with-param>
	</xsl:call-template>

	<!--  Header customer pricing details -->

	<!--  call to customer pricing fields starts -->

	<xsl:call-template name="Begin" />
		 	<xsl:call-template name="addemptycell" />
		 	<xsl:call-template name="addemptycell" />
	<xsl:call-template name="End" />

	 <xsl:call-template name="Begin"/>
		      	<xsl:call-template name="PsychographicBO.External_System_Pricing"/>
		      	<xsl:call-template name="PsychographicBO.Relationship_Pricing_ID"/>
       <xsl:call-template name="End"/>
       <xsl:call-template name="Begin"/>
	   		      	<xsl:call-template name="PsychographicBO.Pricing_Effective_Date"/>
	   		      	<xsl:call-template name="PsychographicBO.Pricing_Review_Date"/>
     <xsl:call-template name="End"/>

     <xsl:call-template name="Begin" />
	 	<xsl:call-template name="addemptycell" />
	 	<xsl:call-template name="addemptycell" />
	 <xsl:call-template name="End" />

	  </xsl:when>
	    </xsl:choose>

     <!--  call to customer pricing fields ends -->


	<xsl:call-template name="Begin"/>
	<!-- LifeStyle Table Templete: palani : psycho : Start-->
	<table bgcolor = "ffffff" align="center" border = "0"  cellspacing="0" cellpadding="2" width="100%">
		<!-- Tracker Id 92380 -->
		<tr align="left">
			<td>
				<xsl:call-template name="user_button_withText">
				<xsl:with-param name="button_name">ADD_PRODUCT_PREFERENCES</xsl:with-param>
				<xsl:with-param name="button_text"><xsl:value-of select="$configLabels_4[@name='ADD_PRODUCT_PREFERENCES']/@configLabel"/></xsl:with-param>
				<xsl:with-param name="button_fnc">addProductPref()</xsl:with-param>
				</xsl:call-template>&#160;
				<xsl:call-template name="user_button_withText">
				<xsl:with-param name="button_name">REMOVE_PRODUCT_PREFERENCES</xsl:with-param>
				<xsl:with-param name="button_text"><xsl:value-of select="$configLabels_4[@name='REMOVE_PRODUCT_PREFERENCES']/@configLabel"/></xsl:with-param>
				<xsl:with-param name="button_fnc">removeProductPref()</xsl:with-param>
				</xsl:call-template>
			</td>
		</tr>
	</table>

	<xsl:call-template name="mainbody">
                <xsl:with-param name="tablename">ProductPrefRecordSet</xsl:with-param>
		<xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels_1[@name='MLHeader5']/@configLabel"/></xsl:with-param>
		<!-- <xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels_4[@name='INTERESTED_PRODUCT_DETAILS']/@configLabel"/></xsl:with-param> -->
		<xsl:with-param name="align">Center</xsl:with-param>
		<xsl:with-param name="width">100%</xsl:with-param>
	<!-- Manupulation for the table representation : Start-->
		<xsl:with-param name="IsInnerComposite">true</xsl:with-param>
	<!-- Manupulation for the table representation : End-->
		<xsl:with-param name="UsrDataSpace">ProductPrefInfo</xsl:with-param>
		<xsl:with-param name="button">true</xsl:with-param>
		<xsl:with-param name="name">...</xsl:with-param>
		<xsl:with-param name="jscriptfnc">,callProductPref()</xsl:with-param>
		<xsl:with-param name="onClick">editProductPrefDetails()</xsl:with-param>
		<xsl:with-param name="rowhighlight">true</xsl:with-param>
		<xsl:with-param name="rsfilenm" select="$fileName_Products"/>
		<xsl:with-param name="extra_colheader">Select</xsl:with-param>
		<xsl:with-param name="IsEnabledInReadMode">true</xsl:with-param>
	</xsl:call-template>

	<br></br>
	 <!-- CIF Changes - Credit Bureau - Begin -->
	<!-- Template for Multirec -->
	<table bgcolor = "ffffff" align="center" border = "0"  cellspacing="0" cellpadding="2" width="100%">
		<!-- Tracker Id 92380 -->
		<tr align="left">
			<td>
				<xsl:call-template name="user_button_withText">
				<xsl:with-param name="button_name">ADD_CREDITBUREAU_DETAILS</xsl:with-param>
				<xsl:with-param name="button_text"><xsl:value-of select="$configLabels_5[@name='ADD_CREDITBUREAU_DETAILS']/@configLabel"/></xsl:with-param>
				<xsl:with-param name="button_fnc">addCreditBureau()</xsl:with-param>
				</xsl:call-template>&#160;
				<xsl:call-template name="user_button_withText">
				<xsl:with-param name="button_name">REMOVE_CREDITBUREAU_DETAILS</xsl:with-param>
				<xsl:with-param name="button_text"><xsl:value-of select="$configLabels_5[@name='REMOVE_CREDITBUREAU_DETAILS']/@configLabel"/></xsl:with-param>
				<xsl:with-param name="button_fnc">removeCreditBureau()</xsl:with-param>
				</xsl:call-template>
			</td>
		</tr>
	</table>
	<xsl:call-template name="mainbody">
		<xsl:with-param name="tablename">CreditBureauRecordSet</xsl:with-param>
		<xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels_1[@name='MLHeader6']/@configLabel"/></xsl:with-param>
		<xsl:with-param name="align">Center</xsl:with-param>
		<xsl:with-param name="width">100%</xsl:with-param>
	<!-- Manupulation for the table representation : Start-->
		<xsl:with-param name="IsInnerComposite">true</xsl:with-param>
	<!-- Manupulation for the table representation : End-->
		<xsl:with-param name="UsrDataSpace">CreditBureauInfo</xsl:with-param>
		<xsl:with-param name="button">true</xsl:with-param>
		<xsl:with-param name="name">...</xsl:with-param>
		<xsl:with-param name="jscriptfnc">,rowHighLight_creditBureau()</xsl:with-param>
		<xsl:with-param name="onClick">editCreditBureauDetails()</xsl:with-param>
		<xsl:with-param name="rowhighlight">true</xsl:with-param>
		<xsl:with-param name="rsfilenm" select="$fileName_creditBureau"/>
		<xsl:with-param name="extra_colheader">Select</xsl:with-param>
		<xsl:with-param name="IsEnabledInReadMode">true</xsl:with-param>
	</xsl:call-template>
	<br></br>
	<!-- CIF Changes - Credit Bureau - Begin -->

            <xsl:call-template name="End"/>
<xsl:call-template name="EndTabPage"/>
<!-- View : Product Preference : END   -->
<!-- CIF Changes: Transaction :Start-->
	<xsl:call-template name="BeginTabPage">
	    <xsl:with-param name="tabViewName">tabPsyForm</xsl:with-param>
	    <xsl:with-param name="tabPageName">tpageTrans</xsl:with-param>
	    <xsl:with-param name="spanWidth">1</xsl:with-param>
	    <xsl:with-param name="tabPageDisplayNameHardCoded">false</xsl:with-param>
	    <xsl:with-param name="tabPageDisplayNameRes" select="$configLabels_11[@name='TRANSACTION_PLAN']"/>
  <!-- CRM11.0:TRACKER:113058:BEGINOFCHANGES -->
	    <xsl:with-param name="fn_tabSelect">focusFirstField();</xsl:with-param>
   <!-- CRM11.0:TRACKER:113058:ENDOFCHANGES -->
	</xsl:call-template>

 <!-- Transaction Table Templete: Start-->
	<table bgcolor = "ffffff" align="center" border = "0"  cellspacing="0" cellpadding="2" width="100%">
<!--Field Addition Tracker 172089:start of Changes-->
	<table width="100%" bgcolor='ffffff' cellspacing="0" vspace="15" hspace="0" border="0" align = "center">
	<TR></TR><TR></TR><TR></TR><TR></TR><TR></TR>
	<TR >

		<TD nowrap="true" align="left" valign ="top" class="d1" style="width:22%"><xsl:value-of select="$configLabels_11[@name='AvailableActivities']/@configLabel"/>
		</TD>
		<TD style="width:0.05%">
			<xsl:call-template name="AvailableActivities"/>
		</TD>
		<TD width="19%" align="center">
			<input class='sbttn' Type='button' value='&gt;&gt;'
			onclick="selfield_activity(AvailableActivities, nature_of_act)"/><BR/>
			<input class='sbttn' Type='button' value='&lt;&lt;'
			onclick="selfield_activity(nature_of_act, AvailableActivities)"/>
			</TD>
		<TD  nowrap="true" valign ="top" class="d1" style="width:22%"><xsl:value-of select="$configLabels_11[@name='PsychographicBO.nature_of_act']/@configLabel"/></TD>
		<TD>
			<xsl:call-template name="nature_of_act"/>
		</TD>

	</TR>
	<TR></TR><TR></TR><TR></TR><TR></TR><TR></TR>
	</table>
<!--Field Addition Tracker 172089:end of Changes-->

	 <!-- Tracker Id 92380 -->
	 <tr align="left">
	     <td>
	      <xsl:call-template name="user_button_withText">
		<xsl:with-param name="button_name">ADD_TRANSACTION</xsl:with-param>
		<xsl:with-param name="button_text"><xsl:value-of select="$configLabels_11[@name='ADD_TRANSACTION']/@configLabel"/></xsl:with-param>
		<xsl:with-param name="button_fnc">addTransaction()</xsl:with-param>
		</xsl:call-template>&#160;
      <xsl:call-template name="user_button_withText">
      <xsl:with-param name="button_name">REMOVE_TRANSACTION</xsl:with-param>
	<xsl:with-param name="button_text"><xsl:value-of select="$configLabels_11[@name='REMOVE_TRANSACTION']/@configLabel"/></xsl:with-param>
		<xsl:with-param name="button_fnc">removeTransaction()</xsl:with-param>
		</xsl:call-template>
	     </td>
	  </tr>
	</table>
	  <xsl:call-template name="mainbody">
	  <xsl:with-param name="tablename">TransactionRecordSet</xsl:with-param>
		<xsl:with-param name="tableHeader">Transaction Plan Details</xsl:with-param>
		<xsl:with-param name="align">Center</xsl:with-param>
	  <xsl:with-param name="width">100%</xsl:with-param>
      <!-- Manupulation for the table representation : Start-->
	<xsl:with-param name="IsInnerComposite">true</xsl:with-param>
      <!-- Manupulation for the table representation : End-->
	  <xsl:with-param name="UsrDataSpace">TransactionPlanInfo</xsl:with-param>
	  <xsl:with-param name="button">true</xsl:with-param>
	  <xsl:with-param name="name">...</xsl:with-param>
	  <xsl:with-param name="jscriptfnc">,callTransaction()</xsl:with-param>
	  <xsl:with-param name="onClick">editTransactionDetails()</xsl:with-param>
	  <xsl:with-param name="rowhighlight">true</xsl:with-param>
 	  <xsl:with-param name="rsfilenm" select="$fileName_Transaction"/>
	  <xsl:with-param name="extra_colheader">Select</xsl:with-param>
	  <xsl:with-param name="IsEnabledInReadMode">true</xsl:with-param>
	  </xsl:call-template>
	  <br></br>
<xsl:call-template name="EndTabPage"/>
  <!--Transaction Table Template : End-->

  <!-- TrackerID113276 changes for making currency tab hidden start -->


  <!-- 209607 CIF Changes: Currency Details :Start-->

      <!-- Changes for 353275 :Start-->

    <!-- <xsl:call-template name="BeginTabPage">
  		    <xsl:with-param name="tabViewName">tabPsyForm</xsl:with-param>
  		    <xsl:with-param name="tabPageName">tpageCurr</xsl:with-param>
  		    <xsl:with-param name="spanWidth">1</xsl:with-param>
  		    <xsl:with-param name="tabPageDisplayNameHardCoded">false</xsl:with-param>
  		    <xsl:with-param name="tabPageDisplayNameRes" select="$configLabels_12[@name='CURRENCY_DETAILS']"/>
  	</xsl:call-template> -->
  	 <!-- Changes for 353275 :End-->

   	<!--Currency Table Template: Start-->

    	<!-- <table bgcolor = "ffffff" align="center" border = "0"  cellspacing="0" cellpadding="2" width="100%"> -->
    	 <!-- Tracker Id 92380 -->
    	 <!-- <tr align="left">
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
    	  <xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels_12[@name='CURRENCYDET']/@configLabel"/></xsl:with-param>
    		<xsl:with-param name="align">Center</xsl:with-param>
    	  <xsl:with-param name="width">100%</xsl:with-param> -->

          <!-- Manupulation for the table representation : Start-->

    	<!-- <xsl:with-param name="IsInnerComposite">true</xsl:with-param> -->

          <!-- Manupulation for the table representation : End-->

    	 <!-- <xsl:with-param name="UsrDataSpace">CurrencyDetInfo</xsl:with-param>
    	  <xsl:with-param name="button">true</xsl:with-param>
    	  <xsl:with-param name="name">...</xsl:with-param>
    	  <xsl:with-param name="jscriptfnc">,callCurrencyDet()</xsl:with-param>
    	  <xsl:with-param name="onClick">editCurrencyDet()</xsl:with-param>
    	  <xsl:with-param name="rowhighlight">true</xsl:with-param>
	      <xsl:with-param name="rsfilenm" select="$fileName_Currency"/>
    	  <xsl:with-param name="extra_colheader">Select</xsl:with-param>
    	  </xsl:call-template>
    	  <br></br>

    <xsl:call-template name="EndTabPage"/> -->
    <!--Currency Table Template : End-->

     <!-- CIF Changes: Currency Details :End-->

	<xsl:choose>
   	  <xsl:when test= "not(normalize-space($byPassFlag)='Y')">

     		<xsl:call-template name="EndTabView">
                     <xsl:with-param name="tabViewName">tabPsyForm</xsl:with-param>
                     <xsl:with-param name="selectedTabPageName">tpageIPre</xsl:with-param>
                </xsl:call-template>
          </xsl:when>
	  <xsl:otherwise>
	  	<xsl:call-template name="EndTabView">
	              <xsl:with-param name="tabViewName">tabPsyForm</xsl:with-param>
	              <xsl:with-param name="selectedTabPageName">tpageFamily</xsl:with-param>
                </xsl:call-template>
          </xsl:otherwise>
	</xsl:choose>
<!-- tracker id 113276 changes end -->
       <!-- Currency Changes:Start DataArray  -->

      	   <!-- <script>
      		var DataArray = new Array;
      		var DataCount = 0;
      		<xsl:for-each select="/SRM/SRMData[@SRMDataSpace='Currency']/SRMComposite[@n='CurrencyRecordSet']/SRMRow">
      		    DataArray[DataCount] = '<xsl:value-of select="./Z[@n='CurrencyBO.CurrencyCode']"/>' + "|" + '<xsl:value-of select="./Z[@n='CurrencyBO.Format']"/>' + "|" + '<xsl:value-of select="./Z[@n='CurrencyBO.NumberOfDecimals']"/>' + "|" + '<xsl:value-of select="./Z[@n='CurrencyBO.MantissaSeperator']"/>'+"|"+'<xsl:value-of select="./Z[@n='CurrencyBO.DecimalSeperator']"/>';
      		    DataCount++;
      		</xsl:for-each>

      		var iCount = 0;
      		ExArray = new Array;
      		<xsl:for-each select="/SRM/SRMData[@SRMDataSpace='ExRate']/SRMComposite[@n='ExRateRecordSet']/SRMRow">
      		    ExArray[iCount] = '<xsl:value-of select="./Z[@n='ExchangeRateBO.FixedCurrencyCode']"/>' + "|" + '<xsl:value-of select="./Z[@n='ExchangeRateBO.VariableCurrencyCode']"/>' + "|" + '<xsl:value-of select="./Z[@n='ExchangeRateBO.NumberOfUnits']"/>' + "|" + '<xsl:value-of select="./Z[@n='ExchangeRateBO.ExchangeRate']"/>'
      		    iCount++;
      		</xsl:for-each>
      	   </script> -->
       <!-- Currency Changes:End DataArray -->

<!-- TrackerID113276 changes for making currency tab hidden end -->

             </form>
             <!-- TrackerID:209607,CHANGES START -->
             <p id="myPar"></p>
             <!-- TrackerID:209607,CHANGES END -->
                <xsl:call-template name="End"/>
                </xsl:template>
        <xsl:template match="SRM">
        <xsl:for-each select=".">
             <xsl:call-template name="startTable"/>
             <!-- Tracker ID 92380 -->
               <!-- <table bgcolor='ffffff' border="0" cellspacing="0" cellpadding="2" width="100%" vspace="0" hspace="0">
                   <tr>
                     <xsl:call-template name="apply">
                     <xsl:with-param name="apply_head">
                     <b><xsl:value-of select="$configLabels_1[@name='Header']/@configLabels_1"/></b>
                     </xsl:with-param>
                     </xsl:call-template>
                   </tr>
              	</table>
              	--><!-- Tracker ID 92380 -->
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		       <xsl:apply-templates select="." mode="mode1"/>
		</table>
             <xsl:call-template name="endTable"/>
         </xsl:for-each>
        </xsl:template>
</xsl:stylesheet>



























