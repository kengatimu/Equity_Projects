<?xml version='1.0'?>
  <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="../Renderer/common/display/getJVMProperties.xsl"/>
  <xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"/>
  <xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"/>
  <xsl:import href="../Renderer/common/display/SRMListTemplate.xsl"/>
        <xsl:param name="locale"/>
  <xsl:variable name="userArea" select="/SRM/SRMData[@SRMDataSpace='UserData']"/>
  <xsl:variable name="searchFrom" select="/SRM/SRMData[@SRMDataSpace='UserData']/Z[@n='SearchFrom']"></xsl:variable>
  <xsl:variable name="searchType" select="$userArea//Z[@n='SearchType']"/>
  <xsl:variable name="query" select="$userArea//Z[@n='options']"/>
  <xsl:variable name="ViewName" select="$userArea//Z[@n='ViewName']"/>
  <xsl:variable name="queryText" select="$userArea//Z[@n='QueryText']"/>
  <xsl:variable name="ScreenName" select="$userArea//Z[@n='ScreenName']"/>
  
  <!--Begin of changes for tracker 131243  by sumeet gandhok - BANKID - -->
  <xsl:variable name="strLoggegInBankId" select="$userArea//Z[@n='StrLoggegInBankId']"/>
  <xsl:variable name="strSearchedBankId" select="$userArea//Z[@n='StrSearchedBankId']"/>
  <!--changes for call id 332134 start-->
  <xsl:variable name="strCeTarget" select="$userArea//Z[@n='StrCeTarget']"/>
  <xsl:variable name="strCeCopySusTarget" select="$userArea//Z[@n='StrCeCopySusTarget']"/>
  <xsl:variable name="StrCeCopyBlTarget" select="$userArea//Z[@n='StrCeCopyBlTarget']"/>
  <xsl:variable name="StrCeCopyNlTarget" select="$userArea//Z[@n='StrCeCopyNlTarget']"/>
  <xsl:variable name="StrCeSource" select="$userArea//Z[@n='StrCeSource']"/>
  <xsl:variable name="StrCeCopySusSource" select="$userArea//Z[@n='StrCeCopySusSource']"/>
  <xsl:variable name="StrCeCopyBlSource" select="$userArea//Z[@n='StrCeCopyBlSource']"/>
  <xsl:variable name="StrCeCopyNlSource" select="$userArea//Z[@n='StrCeCopyNlSource']"/>
  <xsl:variable name="BlackCriteriaFlag" select="$userArea//Z[@n='BlackCriteriaFlag']"/>
  <xsl:variable name="DedupCriteriaFlag" select="$userArea//Z[@n='DedupCriteriaFlag']"/>
  <xsl:variable name="NegCriteriaFlag" select="$userArea//Z[@n='NegCriteriaFlag']"/>
  <!--changes for call id 332134 ends-->
  <!--End of changes for tracker 131243  by sumeet gandhok - BANKID - -->
  
  <xsl:param name="resfilename"/>
  <xsl:param name="pageIndex" select="0"/>
  <xsl:param name="NumPages"/> 
  <xsl:template match="/">
  <xsl:if test="$pageIndex &lt;=1">
  <!-- <xsl:call-template name="htmlstart"/> -->
  <html>
  <head>
    <script type="text/javascript" src="../common/js/ClientResourceBundle_{$locale}.js" language="javascript"></script>
    <script type="text/javascript" src="../common/js/SSOUtils.js" language="javascript"></script>
    <script language="javascript" src="../BaseCustomization/js/TelephonyCustom.js"></script>
    <script>
    var locale = '<xsl:value-of select="$locale"/>';
    
    <!--Begin of changes for tracker 131243  by sumeet gandhok - BANKID - -->
    var expirationdate = new Date ();
    var StrLoggegInBankId1 = '<xsl:value-of select="$strLoggegInBankId"/>';
    var StrSearchedBankId1 = '<xsl:value-of select="$strSearchedBankId"/>';
    <!--changes for call id 332134 start-->
    var StrCeTarget1 = '<xsl:value-of select="$strCeTarget"/>';
    var StrCeCopySusTarget1 = '<xsl:value-of select="$strCeCopySusTarget"/>';
    var StrCeCopyBlTarget1 = '<xsl:value-of select="$StrCeCopyBlTarget"/>';
    var StrCeCopyNlTarget1 = '<xsl:value-of select="$StrCeCopyNlTarget"/>';
    var StrCeSource1 = '<xsl:value-of select="$StrCeSource"/>';
    var StrCeCopySusSource1 = '<xsl:value-of select="$StrCeCopySusSource"/>';
    var StrCeCopyBlSource1 = '<xsl:value-of select="$StrCeCopyBlSource"/>';
    var StrCeCopyNlSource1 = '<xsl:value-of select="$StrCeCopyNlSource"/>';
    var BlackCriteriaFlag1 = '<xsl:value-of select="$BlackCriteriaFlag"/>';
    var DedupCriteriaFlag1 = '<xsl:value-of select="$DedupCriteriaFlag"/>';
    var NegCriteriaFlag1 = '<xsl:value-of select="$NegCriteriaFlag"/>';
    <!--changes for call id 332134 ends-->
    var ScreenName = '<xsl:value-of select="$ScreenName"/>';
    <!--End of changes for tracker 131243  by sumeet gandhok - BANKID - -->
    
var NumPages = '<xsl:value-of select="$NumPages"/>';
    </script>
                <!--Begin of changes for tracker 131243  by sumeet gandhok - BANKID - -->
  		<script language="javascript" src="../cif/js/CrossEntityCopyValidation.js"></script>
  		<script type="text/javascript" src="../cif/js/CheckBSNFlags.js" language="javascript"></script>
  		<!--End of changes for tracker 131243  by sumeet gandhok - BANKID - -->
  
		<script type="text/javascript" id="TableRowColor" src="../common/js/SRMTableRowColor.js"></script>
		<script language="javascript" src="../common/js/ExportToExcel.js" type="text/javascript"></script>
		<script type="text/javascript" src="../common/js/PopupMenu.js"></script>
		<!-- Changes by Elango to mask micro edit RCL option-->
		<script type="text/javascript" src="../Customization/searchconsole/js/CorpEntitySearchRCLOptions_{$locale}.js"></script>
		<script type="text/javascript" src="../searchconsole/js/CorpEntitySearch.js"></script>
		<!--changes for call id 332134 start-->
		<script type="text/javascript" src="../corpcif/js/CorpCIFCustomerRightClick.js"></script>
		<!--changes for call id 332134 ends-->
		<link rel="stylesheet" type="text/css" href="../Branding/css/common/SRMTableDisplay_{$locale}.css"/>
		<link rel="stylesheet" Type="text/css" href="../Branding/css/common/PopupMenu_{$locale}.css"/>
		<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/SRMListTemplate_{$locale}.css"/>
		<object id="factory" style='display:none'></object>
		<script>
		
      		
		function sortMe(sortColumn,sortOrder) {
                var expirationdate = new Date (); 
                expirationdate.setTime(expirationdate.getTime() + ( 160 * 60 * 60 * 1000));
                <![CDATA[var vName=]]>"<xsl:value-of select="$ViewName"/>"
                setCookie('SORT_ORDER_' + vName, sortOrder,expirationdate);
                setCookie('SORT_COLUMN_' + vName, sortColumn,expirationdate); 
                savePersistData();
        <xsl:choose>
            <xsl:when test="normalize-space($searchType)='Advance'">
						var options="<xsl:value-of select="$query"/>";
						var searchFrom="<xsl:value-of select="$searchFrom"/>";
						 eval("window.location.href='../servlet/com.infy.cis.ui.common.AdvancedContactSearchResults?SortColumn=" +sortColumn+ "&amp;SortOrder=" +sortOrder+ "&amp;Query=" +escape(options)+ "&amp;BOName=CorporateBO&amp;ViewName="+vName+"&amp;SearchFrom=" +searchFrom+"'");               </xsl:when>
            <xsl:otherwise>
                var doc = parent.parent.frames(0).frames(0).document;
                <!-- Changes for callid 581736 begin -->
                if(doc.form_filters!=undefined){
			var arrValue = new Array();
			arrValue[0] = doc.form_filters.FilterParam2.value;
			arrValue[1] = doc.form_filters.FilterParam3.value;
			var strValue = fnCheckMandatory(arrValue,ScreenName,'',vName);
			if(strValue==false){
				showMessage(MSGJ51976);
				doc.form_filters.FilterParam3.value="";
				doc.form_filters.FilterParam2.value="";
				//Made the following change due to incompatibilty of JS method focus() and IE8 
				//document.form_filters.FilterParam1.focus();
				setTimeout(function() { doc.form_filters.FilterParam2.focus(); }, 0);
				return false;
			}	
                }
                <!-- Changes for callid 581736 ends -->
                doc.all.SortColumn.value = sortColumn;
                doc.all.SortOrder.value = sortOrder;
                doc.form_filters.submit();
                </xsl:otherwise>
        </xsl:choose>
          }		
		</script>
       </head>
			<body class="popup"	>
				<!-- <xsl:attribute name="onload">load();</xsl:attribute> -->
				
			</body>
		</html>
       </xsl:if>        
     
		<xsl:call-template name="mainbody">
			 <xsl:with-param name="tablename">RecordSet</xsl:with-param>
			 <xsl:with-param name="extra_tableHeader"><xsl:value-of select='$queryText' /></xsl:with-param>
			 <xsl:with-param name="pageIndex"><xsl:value-of select="$pageIndex"/></xsl:with-param>
			<xsl:with-param name="NumPages"><xsl:value-of select="$NumPages"/></xsl:with-param>
			 <xsl:with-param name="showNext">true</xsl:with-param>
			 <!-- <xsl:with-param name="callcalme">1</xsl:with-param>
			 <xsl:with-param name="callselectLastSelected">1</xsl:with-param> -->
			 <xsl:with-param name="rclickshow">true</xsl:with-param>
			 <xsl:with-param name="rowhighlight">true</xsl:with-param>
			 <xsl:with-param name="rsfilenm"><xsl:value-of select="$resfilename"/></xsl:with-param>
			<!--Tracker:108381:Changes for 360Degree tertiary pane default tab-->
			<!--Begin of changes for tracker 131243  by sumeet gandhok - BANKID - called additional fnc setBankCookie()-->
			<xsl:with-param name="jscriptfnc">,rowHighLight(),def_TabHelper(),setBankCookie()</xsl:with-param>
			<!--End of changes for tracker 131243  by sumeet gandhok - BANKID - -->
			 <!--Tracker ID: 108381 For Iconization BEGIN -->
			 <xsl:with-param name="imgValueNameLink_one">CorporateBO.suspend_Flag</xsl:with-param>
             <xsl:with-param name="imgValueNameLink_two">CorporateBO.negative_Flag</xsl:with-param>
       		 <xsl:with-param name="imgValueNameLink_three">CorporateBO.blacklist_Flag</xsl:with-param>
  			<!--Changes done by Vinod for 274629 on 2/26/2009 start -->
			 <xsl:with-param name="imgValueNameFunc_one">rowHighLight(),ShowReasonCodes('suspend','Corporate','CorpKey')</xsl:with-param>
			 <xsl:with-param name="imgValueNameFunc_two">rowHighLight(),ShowReasonCodes('negative','Corporate','CorpKey')</xsl:with-param>
			 <xsl:with-param name="imgValueNameFunc_three">rowHighLight(),ShowReasonCodes('blacklist','Corporate','CorpKey')</xsl:with-param>
			 <!--Changes done by Vinod for 274629 on 2/26/2009 end -->
	 		 <!--Tracker ID: 108381 For Iconization END -->
			<!--vasanth's changes start-->
			<!--	<xsl:with-param name="colhrefname">CorporateBO.suspend_Flag</xsl:with-param>   -->
			<!--	<xsl:with-param name="colhref_three">CorporateBO.negative_Flag</xsl:with-param> -->
			<!--	<xsl:with-param name="colhref_two">CorporateBO.blacklist_Flag</xsl:with-param>  -->

			<xsl:with-param name="imgFieldName">CorporateBO.corp_Key,</xsl:with-param>
			<xsl:with-param name="imgFieldNameLink_one">CorporateBO.corp_Key</xsl:with-param>
			<xsl:with-param name="imgFieldNameFunc_one">populateCorpcifEntityDetails(corpID)</xsl:with-param>
			<!--Tracker ID: 108381 For Hyperlink By Bibin BEGIN -->
			<!--xsl:with-param name="colhref_four">CorporateBO.corp_Key</xsl:with-param-->
			<!--Tracker ID: 108381 For Hyperlink END -->
			 
	<!--		<xsl:with-param name="colhref_function">ShowReasonCodes('suspend','Corporate','CorpKey')</xsl:with-param>
			<xsl:with-param name="colhrefthree_function">ShowReasonCodes('negative','Corporate','CorpKey')</xsl:with-param>
			<xsl:with-param name="colhreftwo_function">ShowReasonCodes('blacklist','Corporate','CorpKey')</xsl:with-param>
	-->		<!--vasanth's changes end-->
			 <!-- <xsl:with-param name="colhrefname">CorporateBO.corporate_Name</xsl:with-param>
			 <xsl:with-param name="colhref_function">onClick()</xsl:with-param> -->

			
			<!--Tracker ID: 108381 For Hyperlink BEGIN -->
		        <!--xsl:with-param name="colhreffour_function">populateCorpcifEntityDetails(corpID)</xsl:with-param-->
			<!--Tracker ID: 108381 For Hyperlink END -->


			<!--Tracker ID: 108381 For Iconization by Bibin BEGIN -->
			<xsl:with-param name="usabilityChange">true</xsl:with-param>
			<!--Tracker ID: 167071 For record status listing  BEGIN -->
 			<xsl:with-param name="imgValueName">CorporateBO.suspend_Flag,CorporateBO.negative_Flag,CorporateBO.blacklist_Flag,CorporateBO.record_Status,CorporateBO.segment,</xsl:with-param>
			<!--Tracker ID: 167071 For record status listing  END -->
			<!--Tracker ID: 108381 For Iconization END -->
			</xsl:call-template>
		
	  	</xsl:template>
 </xsl:stylesheet>




