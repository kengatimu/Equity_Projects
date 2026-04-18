<?xml version='1.0'?>
  <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="../Renderer/common/display/SRMListTemplate.xsl"/>
        <xsl:param name="locale"/>
  <xsl:variable name="userArea" select="/SRM/SRMData[@SRMDataSpace='UserData']"/>
  <xsl:variable name="searchFrom" select="/SRM/SRMData[@SRMDataSpace='UserData']/Z[@n='SearchFrom']"></xsl:variable>
  <xsl:variable name="searchType" select="$userArea//Z[@n='SearchType']"/>
  <xsl:variable name="query" select="$userArea//Z[@n='options']"/>
  <xsl:variable name="ViewName" select="$userArea//Z[@n='ViewName']"/>
  <xsl:variable name="queryText" select="$userArea//Z[@n='QueryText']"/>
  <xsl:variable name="ScreenName" select="$userArea//Z[@n='ScreenName']"/>
  <xsl:variable name="loggedusersol" select="$userArea//Z[@n='loggedusersol']"/>
  <xsl:variable name="primarygroupid" select="$userArea//Z[@n='primarygroupid']"/>
  <xsl:variable name="primarygroupname" select="$userArea//Z[@n='primarygroupname']"/>
  <xsl:param name="resfilename"/>
    <!-- Fix for Ticket 229371 Begins -->
      <xsl:variable name="sType" select="$userArea//Z[@n='sType']"/>
    <!-- FIX for ticket 229371 ENDS -->
<!--Recon MELC changes in Baseline-->
  <!-- 113066 - Begin of changes for LCIF Copy by Amit malhotra-->
      <xsl:variable name="strLoggegInBankId" select="$userArea//Z[@n='StrLoggegInBankId']"/>
      <xsl:variable name="strSearchedBankId" select="$userArea//Z[@n='StrSearchedBankId']"/>
      <xsl:variable name="StrCeTarget" select="$userArea//Z[@n='StrCeTarget']"/>
      <xsl:variable name="StrCeCopySusTarget" select="$userArea//Z[@n='StrCeCopySusTarget']"/>
      <xsl:variable name="StrCeCopyBlTarget" select="$userArea//Z[@n='StrCeCopyBlTarget']"/>
      <xsl:variable name="StrCeCopyNlTarget" select="$userArea//Z[@n='StrCeCopyNlTarget']"/>
      <xsl:variable name="StrCeSource" select="$userArea//Z[@n='StrCeSource']"/>
      <xsl:variable name="StrCeCopySusSource" select="$userArea//Z[@n='StrCeCopySusSource']"/>
      <xsl:variable name="StrCeCopyBlSource" select="$userArea//Z[@n='StrCeCopyBlSource']"/>
      <xsl:variable name="StrCeCopyNlSource" select="$userArea//Z[@n='StrCeCopyNlSource']"/>
<xsl:variable name="strIsCoexistence" select="$userArea//Z[@n='strIsCoexistence']"/>
  <!-- 113066 - End of changes for LCIF Copy by Amit malhotra -->
  	<xsl:variable name="BlackCriteriaFlag" select="$userArea//Z[@n='BlackCriteriaFlag']"/>
  	<xsl:variable name="DedupCriteriaFlag" select="$userArea//Z[@n='DedupCriteriaFlag']"/>
        <xsl:variable name="NegCriteriaFlag" select="$userArea//Z[@n='NegCriteriaFlag']"/>
<!--changes end-->
  <!-- Search Enhancement changes start -->
  <xsl:variable name="configFile_1" select="document(concat($resfilename,''))"/>
  <xsl:variable name="configLabels" select="$configFile_1/SRMBO/*"/>
  <!-- Search Enhancement changes end -->

  <xsl:param name="pageIndex" select="0"/>
  <xsl:param name="NumPages"/>
  <xsl:template match="/">
  <xsl:if test="$pageIndex &lt;=1">
  <xsl:call-template name="htmlstart"/>

  <head>
     <!-- vasanth's changes start -->
     <script type="text/javascript" src="../cif/js/CheckBSNFlags.js" language="javascript"></script>
	<!-- vasanth's changes end -->
	<script type="text/javascript" id="TableRowColor" src="../common/js/SRMTableRowColor.js"></script>
<!--Fix for Ticket 228160-->
	<script type="text/javascript" src="../cif/js/Message_cif_{$locale}.js" language="javascript"></script>
	<!-- CRM102BETA: TrackerID:195169 Begin of Change -->
	<script type="text/javascript" src="../corpcif/js/Message_corpcif_{$locale}.js" language="javascript"></script>
	<!-- CRM102BETA: TrackerID:195169 End of Change -->
    <script type="text/javascript" src="../common/js/ClientResourceBundle_{$locale}.js" language="javascript"></script>
    <script type="text/javascript" src="../common/js/SSOUtils.js" language="javascript"></script>
    <script language="javascript" src="../BaseCustomization/js/TelephonyCustom.js"></script>
<!--Recon MELC changes to Baseline-->
     <!-- 113066 - Begin of changes for LCIF Copy by Amit malhotra-->
    <script language="javascript" src="../cif/js/CrossEntityCopyValidation.js"></script>
     <!-- 113066 - End of changes for LCIF Copy by Amit malhotra-->
<!--changes end-->
<script>
var locale = '<xsl:value-of select="$locale"/>';
var ScreenName=	'<xsl:value-of select="$ScreenName"/>';
var NumPages = '<xsl:value-of select="$NumPages"/>';<!-- TRACKER# 105752-->
<!--Recon MELC changes to Baseline-->
//113066 Begin of changes for LCIF Copy by Amit Malhotra
	    var StrLoggegInBankId1 = '<xsl:value-of select="$strLoggegInBankId"/>';
	    var StrSearchedBankId1 = '<xsl:value-of select="$strSearchedBankId"/>';
	    var StrCeTarget1 = '<xsl:value-of select="$StrCeTarget"/>';
	    var StrCeCopySusTarget1 = '<xsl:value-of select="$StrCeCopySusTarget"/>';
	    var StrCeCopyBlTarget1 = '<xsl:value-of select="$StrCeCopyBlTarget"/>';
	    var StrCeCopyNlTarget1 = '<xsl:value-of select="$StrCeCopyNlTarget"/>';
	    var StrCeSource1 = '<xsl:value-of select="$StrCeSource"/>';
	    var StrCeCopySusSource1 = '<xsl:value-of select="$StrCeCopySusSource"/>';
	    var StrCeCopyBlSource1 = '<xsl:value-of select="$StrCeCopyBlSource"/>';
	    var StrCeCopyNlSource1 = '<xsl:value-of select="$StrCeCopyNlSource"/>';
	    var isCoexistence = '<xsl:value-of select="$userArea//Z[@n='strIsCoexistence']"/>';

		//changes for RBS recon TOL 447882
		var StrIsCoexistence = '<xsl:value-of select="$userArea//Z[@n='strIsCoexistence']"/>';
		//changes for RBS recon TOL 447882
		
		
//113066 End of changes for LCIF Copy by Amit Malhotra
 	var BlackCriteriaFlag1 = '<xsl:value-of select="$BlackCriteriaFlag"/>';
	 var DedupCriteriaFlag1 = '<xsl:value-of select="$DedupCriteriaFlag"/>';
         var NegCriteriaFlag1 = '<xsl:value-of select="$NegCriteriaFlag"/>';
         var loggedusersol = '<xsl:value-of select="$loggedusersol"/>';
          var primarygroupid = '<xsl:value-of select="$primarygroupid"/>';
    var primarygroupname = '<xsl:value-of select="$primarygroupname"/>';
    var loggedusersol=loggedusersol+','+primarygroupid+','+primarygroupname;
        
         setCookie('loggedusersol', loggedusersol, expirationdate);
<!--changes end-->
</script>

		<link rel="stylesheet" type="text/css" href="../Branding/css/common/SRMTableDisplay_{$locale}.css"/>
		<link rel="stylesheet" Type="text/css" href="../Branding/css/common/PopupMenu_{$locale}.css"/>
		<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/SRMListTemplate_{$locale}.css"/>
		<object id="factory" style='display:none'></object>
		<script type="text/javascript" src="../common/js/PopupMenu.js"></script>

		<!-- CORPCIF Chages - depending on the screen name, respective RCL options are populated-->
		 <xsl:choose>
		 <!-- Fix for Ticket 229371 Begins -->
		<xsl:when test="normalize-space($ScreenName)='CopyEntityCorp'">
			<script type="text/javascript" src="../corpcif/js/CrossEntityCorpCustRCLOptions_{$locale}.js">
			</script>
	    	    </xsl:when>

			<!-- Fix as part of Beta ticket 315299 starts here -->
	 	<xsl:when test="normalize-space($sType)='Corp Edit Blacklist'">
			<script type="text/javascript" src="../corpcif/js/CorpBlacklistRCLOptions_{$locale}.js"></script>
		</xsl:when>

		<xsl:when test="normalize-space($sType)='Corp DeDup'">
			<script type="text/javascript" src="../corpcif/js/CorpDedupRCLOptions_{$locale}.js"></script>
		</xsl:when>


    	<xsl:when test="normalize-space($sType)='Corp Edit Negative'">
			<script type="text/javascript" src="../corpcif/js/CorpNegativeRCLOptions_{$locale}.js"></script>
	    </xsl:when>
	      <!-- FIX for tracker 193972  START-->
    	<xsl:when test="normalize-space($ViewName)='CorpSuspAccountsLookup' and  normalize-space($ScreenName)='Operations' ">
			<script type="text/javascript" src="../corpcif/js/CorpCifRCLOptions_{$locale}.js"></script>
	    </xsl:when>
	<xsl:when test="normalize-space($ViewName)='CorpCustAccLkUpListFilter' and  normalize-space($ScreenName)='Operations' ">
			<script type="text/javascript" src="../corpcif/js/CorpCifRCLOptions_{$locale}.js"></script>
	    </xsl:when>
	    <!-- FIX for tracker 193972  END-->

		<!-- The condition has been modified because while passing type parameter in URL it was impacting a screen in 360 degree-->
    	<!-- <xsl:when test="normalize-space($sType)='Corp Suspend'"> -->
    	<xsl:when test="normalize-space($sType)='null' and  normalize-space($ScreenName)='Operations' ">
			<script type="text/javascript" src="../corpcif/js/CorpSuspendRCLOptions_{$locale}.js"></script>
	    </xsl:when>

			<!-- Fix as part of Beta ticket 315299 ends here -->


	    	    <xsl:when test="normalize-space($ScreenName)='ScreenRepBlacklist'">
		    		    	<script type="text/javascript" src="../corpcif/js/CorpRepBlacklistRCLOptions_{$locale}.js"></script>
	    	    </xsl:when>

	    	    <xsl:when test="normalize-space($ScreenName)='ScreenRepNegative'">
		    		    	<script type="text/javascript" src="../corpcif/js/CorpRepNegativeRCLOptions_{$locale}.js"></script>
	    	    </xsl:when>

	    	   <!-- Checking screen type instead of screen Name -->
		   <!-- <xsl:when test="normalize-space($ScreenName)='Screen'"> -->
		        <xsl:when test="normalize-space($sType)='Edit Corporate Entity'">
		    	<script type="text/javascript" src="../corpcif/js/CorpCifRCLOptions_{$locale}.js"></script>
	    	    </xsl:when>
	    	    <!-- Checking screen type instead of screen Name -->
	    	    <!-- <xsl:when test="normalize-space($ScreenName)='ScreenDedup'"> -->
	    	         <xsl:when test="normalize-space($sType)='Corp DeDup'">

		    		    	<script type="text/javascript" src="../corpcif/js/CorpDedupRCLOptions_{$locale}.js"></script>
	    	    </xsl:when>
	    	    <!-- Checking screen type instead of screen Name -->
	    	    <!-- <xsl:when test="normalize-space($ScreenName)='ScreenEntityBlack'"> -->
	    	          <xsl:when test="normalize-space($sType)='Corp Edit Blacklist'">
		    		    	<script type="text/javascript" src="../corpcif/js/CorpBlacklistRCLOptions_{$locale}.js"></script>
	    	    </xsl:when>
	    	    <!-- Checking screen type instead of screen Name -->
	    	    <!-- <xsl:when test="normalize-space($ScreenName)='ScreenEntityNegative'"> -->
	    	            <xsl:when test="normalize-space($sType)='Corp Edit Negative'">

		    		    	<script type="text/javascript" src="../corpcif/js/CorpNegativeRCLOptions_{$locale}.js"></script>
		    		</xsl:when>
				 <!-- <xsl:when test="normalize-space($ScreenName)='ScreenSuspend'"> -->
				         <xsl:when test="normalize-space($sType)='Corp Suspend'">
		    		    	<script type="text/javascript" src="../corpcif/js/CorpSuspendRCLOptions_{$locale}.js"></script>
	    	    </xsl:when>
	    	    <!-- FIX for ticket 229371 ENDS -->
	    	    <!--Begin of changes for tracker 131243 by sumeet gandhok - BANKID - -->
	    	    <xsl:when test="normalize-space($ScreenName)='CorpEdit'">
		    			<script type="text/javascript" src="../corpcif/js/CorpCifRCLOptions_{$locale}.js"></script>
	   	    </xsl:when>
	   	    <!--End of changes for tracker 131243 by sumeet gandhok - BANKID - -->
<!--Recon MELC changes to Baseline-->
<!--Changes end-->
		</xsl:choose>
		<!--END OF CORPCIF Chages - depending on the screen name, respective RCL options are populated-->
		<script type="text/javascript" src="../Customization/corpcif/js/CorpCIFCustomerRightClick.js"></script>

		<script language="javascript" src="../common/js/ExportToExcel.js" type="text/javascript"></script>
	<script>

		  <![CDATA[

          function sortMe(sortColumn,sortOrder) {
				var expirationdate = new Date ();
				expirationdate.setTime(expirationdate.getTime() + ( 160 * 60 * 60 * 1000));
				var searchType=]]>"<xsl:value-of select="$searchType"/>"<![CDATA[;
				var vName=]]>"<xsl:value-of select="$ViewName"/>"<![CDATA[;
				var ScreenName=]]>"<xsl:value-of select="$ScreenName"/>"<![CDATA[;
				var searchFrom=]]>"<xsl:value-of select="$searchFrom"/>"<![CDATA[;
				setCookie('SORT_ORDER_'+vName, sortOrder,expirationdate);
				setCookie('SORT_COLUMN_'+vName, sortColumn,expirationdate);
				savePersistData();
					if (searchType== 'Advance') {
					var options=]]>"<xsl:value-of select="$query"/>"<![CDATA[;
				//Changes for tracker ID 457177 start
					var queryText=]]>"<xsl:value-of select="$queryText"/>"<![CDATA[;
						 eval("window.location.href='../servlet/com.infy.cis.ui.common.AdvancedContactSearchResults?SortColumn=" +sortColumn+ "&amp;SortOrder=" +sortOrder+ "&amp;Query=" +escape(options)+ "&amp;QueryText=" +escape(queryText)+ "&amp;BOName=CorporateBO&amp;ViewName="+vName+"&amp;SearchFrom=" +searchFrom+"'");
				//Changes for tracker ID 457177 end
				} else {
				try{
					var doc = parent.frames(0).frames(0).document;
				<!-- changes for TOL 557453 -->
            label = doc.form_filters.FilterParam19.value;
	    
	                                                    if (doc.form_filters.FilterParam19.value == "Blacklisted") {                                                           
	                                                                    doc.form_filters.FilterParam19.value = "*";         
	                                                    }
	                                                    else if (doc.form_filters.FilterParam19.value == "Negated") {                                                     
	                                                                    doc.form_filters.FilterParam19.value = "*";                         
	                                                    }
	                                                    else if (doc.form_filters.FilterParam19.value == "Suspended") {                                                                
	                                                                    doc.form_filters.FilterParam19.value = "*";                         
	                                    
                                                } 
            
            
            <!-- changes for TOL 557453 -->
            <!-- Changes for callid 581736 begin -->
            
		var arrValue = new Array();
		var strValue = true;
		arrValue[0] = doc.form_filters.FilterParam2.value;
		arrValue[1] = doc.form_filters.FilterParam3.value;
		arrValue[2] = doc.form_filters.FilterParam8.value;
		//Changes for Tracker Id Ends
		//strValue    = fnCheckMandatory(arrValue,'',subScreen,vName);
		var strValue    = fnCheckMandatory(arrValue,ScreenName,'',vName);
		if(strValue == false){
			showMessage(MSGJ61721);
			doc.form_filters.ViewName.value =  vName; 
			doc.form_filters.FilterParam2.value="";
			doc.form_filters.FilterParam3.value="";
		    	doc.form_filters.FilterParam8.value="";
			//Made the following change due to incompatibilty of JS method focus() and IE8 
			//document.form_filters.FilterParam2.focus();
			setTimeout(function() { doc.form_filters.FilterParam2.focus(); }, 0);
		    return false;
		}    

            <!-- Changes for callid 581736 ends -->
					doc.form_filters.SortColumn.value = sortColumn;
					doc.form_filters.SortOrder.value = sortOrder;
					doc.form_filters.ViewName.value = vName;
					doc.form_filters.submit();
			<!-- changes for TOL 557453 -->
            doc.form_filters.FilterParam19.value = label;
            <!-- changes for TOL 557453 -->		
					}catch(e){
					var doc1 = parent.frames(0).frames(0).document;
										
										
									<!-- changes for TOL 557453 -->
					            label = doc1.form_filters.FilterParam19.value;
						    
						                                                    if (doc1.form_filters.FilterParam19.value == "Blacklisted") {                                                           
						                                                                    doc1.form_filters.FilterParam19.value = "*";         
						                                                    }
						                                                    else if (doc1.form_filters.FilterParam19.value == "Negated") {                                                     
						                                                                    doc1.form_filters.FilterParam19.value = "*";                         
						                                                    }
						                                                    else if (doc1.form_filters.FilterParam19.value == "Suspended") {                                                                
						                                                                    doc1.form_filters.FilterParam19.value = "*";                         
						                                    
					                                                } 
					            
					            
					            <!-- changes for TOL 557453 -->
					            	
										
										
										
										doc1.form_filters.SortColumn.value = sortColumn;
										doc1.form_filters.SortOrder.value = sortOrder;
										doc1.form_filters.ViewName.value = vName;
										doc1.form_filters.submit();
										
										
								<!-- changes for TOL 557453 -->
					            doc1.form_filters.FilterParam19.value = label;
            <!-- changes for TOL 557453 -->		
					
					
					}
				}
           }]]>
		<!-- Search Enhancement changes start -->
		function onClickGroup() {
		 /*Begin of changes for ticket 219040 by sumeet gandhok - BANKID - */
		   bank_id = checkBankPrivilege();
		   if((bank_id!=null) &amp;&amp; (!(ScreenName == "CopyEntityRet" || ScreenName== "CopyEntityCorp"))){
			showMessage(MSGJ50789);
		   }
		   else{
   /*End of changes for ticket 219040 by sumeet gandhok - BANKID - */
			corpID = getCookie('corpId');
			if (corpID== null || corpID=="" || corpID== 'null') {
				return;
			}
					
			entityId = getCookie('corpId');
			//changes for RBS recon TOL 447882
			var AccountId = "";
			AccountId= entityId;
			//changes for RBS recon TOL 447882
			entityType = 'Corporate'
			isGroup = 'Y';
			var str = "";
			
			//changes for RBS recon TOL 447882
			//str = "../servlet/com.infy.cis.ui.corpcif.ListofGroupHshldLinked?EntityID=" + entityId + "&amp;EntityType=" + entityType + //"&amp;isGroup=" + isGroup;
			
			str = "../servlet/com.infy.cis.ui.corpcif.ListofGroupHshldLinked?EntityID=" + entityId + "&amp;EntityType=" + entityType + "&amp;isGroup=" + isGroup +"&amp;AccountId=" + AccountId;
			//changes for RBS recon TOL 447882
			
			/* Tracker: 108382: Changes for centering popup */
        	        windowAlign();
			//var newWin = window.open(str, 'ListofGroupsLinked','height=436, left=70, top=120, width=860,resizable=no,menubar=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
			var newWin = window.open(str, 'ListofGroupsLinked','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,menubar=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
			/* Tracker: 108382: End of Changes */
		   }
		}
		<!-- Search Enhancement changes start -->

   </script>
        </head>


      <xsl:call-template name="bodystart"/>
    <script type="text/javascript" src="../common/js/PopupMenu.js"></script>

       </xsl:if>
      <!-- Ticket Id 201963 : Begin
           Function populateCorpcifEntityDetails_Operations should be called only if the screen
           is Dedup/Ssuspend/Blacklist/Negate -->
        <xsl:choose>
     	    <xsl:when test="normalize-space($ScreenName)='ScreenDedup' or normalize-space($ScreenName)='ScreenEntityBlack' or normalize-space($ScreenName)='ScreenEntityNegative' or normalize-space($ScreenName)='ScreenRepBlacklist' or normalize-space($ScreenName)='ScreenRepNegative' or normalize-space($ScreenName)='ScreenSuspend'  ">
		<xsl:call-template name="mainbody">
			 <xsl:with-param name="tablename">RecordSet</xsl:with-param>
			 <xsl:with-param name="extra_tableHeader"><xsl:value-of select='$queryText' /></xsl:with-param>
			 <xsl:with-param name="pageIndex"><xsl:value-of select="$pageIndex"/></xsl:with-param>
			 <xsl:with-param name="NumPages"><xsl:value-of select="$NumPages"/></xsl:with-param><!--TRACKER# 92380-->
			 <!-- <xsl:with-param name="callcalme">1</xsl:with-param> -->
			 <xsl:with-param name="showNext">true</xsl:with-param>
			 <xsl:with-param name="callselectLastSelected">1</xsl:with-param>
			 <xsl:with-param name="rclickshow">true</xsl:with-param>
			 <xsl:with-param name="rowhighlight">true</xsl:with-param>
			 <xsl:with-param name="rsfilenm"><xsl:value-of select="$resfilename"/></xsl:with-param>
			 <xsl:with-param name="jscriptfnc">,identifyme()</xsl:with-param>
			 <xsl:with-param name="usabilityChange">true</xsl:with-param>
			 <!--Tracker ID: 167071 For record status listing  BEGIN -->
			 <xsl:with-param name="imgValueName">CorporateBO.blacklist_Flag,CorporateBO.negative_Flag,CorporateBO.suspend_Flag,CorporateBO.segment,CorporateBO.record_Status,</xsl:with-param>
			 <!--Tracker ID: 167071 For record status listing  END -->
			 <xsl:with-param name="imgValueNameLink_one">CorporateBO.suspend_Flag</xsl:with-param>
			 <xsl:with-param name="imgValueNameLink_two">CorporateBO.negative_Flag</xsl:with-param>
			 <xsl:with-param name="imgValueNameLink_three">CorporateBO.blacklist_Flag</xsl:with-param>
			 <xsl:with-param name="imgValueNameFunc_one">ShowNewReasonCodes('suspend','Corporate','corpKey')</xsl:with-param>
			 <xsl:with-param name="imgValueNameFunc_two">ShowNewReasonCodes('negative','Corporate','corpKey')</xsl:with-param>
			 <xsl:with-param name="imgValueNameFunc_three">ShowNewReasonCodes('blacklist','Corporate','corpKey')</xsl:with-param>
			 <!--xsl:with-param name="colhrefname">CorporateBO.corp_Key</xsl:with-param-->
			 <!-- Ticket Id 201963 - Commenting the already called function and calling populateCorpcifEntityDetails_Operations -->
			 <!--<xsl:with-param name="colhref_function">populateCorpcifEntityDetails(corpId)</xsl:with-param> -->
			 <!--xsl:with-param name="colhref_function">populateCorpcifEntityDetails_Operations(corpId)</xsl:with-param-->
			 <!-- Ticket Id 201963 - Commenting the already called function and calling populateCorpcifEntityDetails_Operations -->
			<xsl:with-param name="imgFieldName">CorporateBO.corp_Key,</xsl:with-param>
			<xsl:with-param name="imgFieldNameLink_one">CorporateBO.corp_Key</xsl:with-param>
			<xsl:with-param name="imgFieldNameFunc_one">populateCorpcifEntityDetails_Operations(corpId)</xsl:with-param>
			<!-- Search Enhancement changes start -->
	        	<xsl:with-param name="name"><xsl:value-of select="$configLabels[@name='Group']/@configLabel"/></xsl:with-param>
			<xsl:with-param name="hardcoded_string">true</xsl:with-param>
  	  		<xsl:with-param name="extra_colheader2"><xsl:value-of select="$configLabels[@name='Group']/@configLabel"/></xsl:with-param>
		        <xsl:with-param name="colhrefone_function">onClickGroup()</xsl:with-param>
			<!-- Search Enhancement changes end -->
		</xsl:call-template>
	    </xsl:when>
            <xsl:otherwise>
		<xsl:call-template name="mainbody">
			 <xsl:with-param name="tablename">RecordSet</xsl:with-param>
			 <xsl:with-param name="extra_tableHeader"><xsl:value-of select='$queryText' /></xsl:with-param>
			 <xsl:with-param name="pageIndex"><xsl:value-of select="$pageIndex"/></xsl:with-param>
			 <xsl:with-param name="NumPages"><xsl:value-of select="$NumPages"/></xsl:with-param><!--TRACKER# 92380-->
			 <!-- <xsl:with-param name="callcalme">1</xsl:with-param> -->
			 <xsl:with-param name="showNext">true</xsl:with-param>
			 <xsl:with-param name="callselectLastSelected">1</xsl:with-param>
			 <xsl:with-param name="rclickshow">true</xsl:with-param>
			 <xsl:with-param name="rowhighlight">true</xsl:with-param>
			 <xsl:with-param name="rsfilenm"><xsl:value-of select="$resfilename"/></xsl:with-param>
			 <xsl:with-param name="jscriptfnc">,identifyme()</xsl:with-param>
			 <xsl:with-param name="usabilityChange">true</xsl:with-param>
			 <!--Tracker ID: 167071 For record status listing  BEGIN -->
			 <xsl:with-param name="imgValueName">CorporateBO.blacklist_Flag,CorporateBO.negative_Flag,CorporateBO.suspend_Flag,CorporateBO.segment,CorporateBO.record_Status,</xsl:with-param>
			 <!--Tracker ID: 167071 For record status listing  END -->
			 <xsl:with-param name="imgValueNameLink_one">CorporateBO.suspend_Flag</xsl:with-param>
			 <xsl:with-param name="imgValueNameLink_two">CorporateBO.negative_Flag</xsl:with-param>
			 <xsl:with-param name="imgValueNameLink_three">CorporateBO.blacklist_Flag</xsl:with-param>
			 <xsl:with-param name="imgValueNameFunc_one">ShowNewReasonCodes('suspend','Corporate','corpKey')</xsl:with-param>
			 <xsl:with-param name="imgValueNameFunc_two">ShowNewReasonCodes('negative','Corporate','corpKey')</xsl:with-param>
			 <xsl:with-param name="imgValueNameFunc_three">ShowNewReasonCodes('blacklist','Corporate','corpKey')</xsl:with-param>
			 <!--xsl:with-param name="colhrefname">CorporateBO.corp_Key</xsl:with-param>
			 <xsl:with-param name="colhref_function">populateCorpcifEntityDetails(corpId)</xsl:with-param-->
			<xsl:with-param name="imgFieldName">CorporateBO.corp_Key,</xsl:with-param>
			<xsl:with-param name="imgFieldNameLink_one">CorporateBO.corp_Key</xsl:with-param>
			<xsl:with-param name="imgFieldNameFunc_one">populateCorpcifEntityDetails(corpId)</xsl:with-param>
			<!-- Search Enhancement changes start -->
	            <xsl:with-param name="name"><xsl:value-of select="$configLabels[@name='Group']/@configLabel"/></xsl:with-param>
		    <xsl:with-param name="hardcoded_string">true</xsl:with-param>
  	  	    <xsl:with-param name="extra_colheader2"><xsl:value-of select="$configLabels[@name='Group']/@configLabel"/></xsl:with-param>
			<xsl:with-param name="colhrefone_function">onClickGroup()</xsl:with-param>
			<!-- Search Enhancement changes end -->

		</xsl:call-template>
	    </xsl:otherwise>
        </xsl:choose>
         <!-- Ticket Id 201963 : End -->


	  	</xsl:template>
 </xsl:stylesheet>







