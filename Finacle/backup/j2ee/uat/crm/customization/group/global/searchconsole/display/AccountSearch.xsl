<?xml version='1.0'?>
  <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="../Renderer/common/display/SRMListTemplate.xsl"/>
        <xsl:param name="locale"/>
  <xsl:variable name="userArea" select="/SRM/SRMData[@SRMDataSpace='UserData']"/>
  <xsl:variable name="searchType" select="$userArea//Z[@n='SearchType']"/>
  <xsl:variable name="query" select="$userArea//Z[@n='options']"/>
  <xsl:variable name="ViewName" select="$userArea//Z[@n='ViewName']"/>
  <xsl:variable name="queryText" select="$userArea//Z[@n='QueryText']"/>
  <!--Begin of changes for tracker 131243 by sumeet gandhok - BANKID - -->
  <xsl:variable name="ScreenName" select="$userArea//Z[@n='ScreenName']"/>  
  <xsl:variable name="strLoggegInBankId" select="$userArea//Z[@n='StrLoggegInBankId']"/>
  <xsl:variable name="strSearchedBankId" select="$userArea//Z[@n='StrSearchedBankId']"/>
  <!--End of changes for tracker 131243 by sumeet gandhok - BANKID - -->
  <!-- Alternate BANKING CHANGES Starts-->
  <xsl:variable name="islamicResourceFileSuffix" select="//SRMData[@SRMDataSpace='UserData']/Z[@n='islamicResourceFileSuffix']"></xsl:variable>
  <!-- Alternate BANKING CHANGES Ends-->
  <xsl:param name="resfilename"/>
  <xsl:variable name="configFile_1" select="document(concat($resfilename,''))"/>
  <xsl:variable name="configLabels" select="$configFile_1/SRMBO/*"/>
  <!-- changes for 10.2.14 Finlite CoExistence start -->
   <xsl:variable name="strIsCoexistence" select="$userArea//Z[@n='strIsCoexistence']"/>
  <!-- changes for 10.2.14 Finlite CoExistence end -->
  <xsl:param name="pageIndex" select="0"/>
  <xsl:param name="NumPages"/>
<xsl:template match="/">
        <xsl:if test="$pageIndex &lt;=1">
        <xsl:call-template name="htmlstart"/>
      <head>
     <!-- vasanth's changes start -->     
     <script type="text/javascript" src="../cif/js/CheckBSNFlags.js" language="javascript"></script>
	<!-- vasanth's changes end -->
<script type="text/javascript" src="../common/js/ClientResourceBundle_{$locale}.js" language="javascript"></script>
<!--  TrackerID: 101603 Begin changes    -->
<script type="text/javascript" src="../common/js/ContextSwitch.js" language="javascript"></script>
<!--  TrackerID: 101603 End of changes   -->
<script>
var locale = '<xsl:value-of select="$locale"/>';
var NumPages = '<xsl:value-of select="$NumPages"/>';<!-- TRACKER# 92380-->
/*Begin of changes for tracker 131243 by sumeet gandhok - BANKID - */

	/* Changes for Audit Enquiry CRMBAR02 Starts*/
	/* ScreenName and viewname has been obtained */
	var ScreenName = '<xsl:value-of select="$ScreenName"/>';
	var viewnameScreenID = '<xsl:value-of select="$userArea//Z[@n='ViewName']"/>';
	/* Changes for Audit Enquiry CRMBAR02 Ends*/
var StrLoggegInBankId1 = '<xsl:value-of select="$strLoggegInBankId"/>';
var StrSearchedBankId1 = '<xsl:value-of select="$strSearchedBankId"/>';
/*End of changes for tracker 131243 by sumeet gandhok - BANKID - */
/* changes for 10.2.14 Finlite CoExistence start */
var isCoexistence = '<xsl:value-of select="$userArea//Z[@n='strIsCoexistence']"/>';
/* changes for 10.2.14 Finlite CoExistence end */	
			     

</script>
             <link rel="stylesheet" type="text/css" href="../Branding/css/common/SRMTableDisplay_{$locale}.css"/>
        <link rel="stylesheet" Type="text/css" href="../Branding/css/common/PopupMenu_{$locale}.css"/>
        <LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/SRMListTemplate_{$locale}.css"/>
    <object id="factory" style='display:none'></object>
    
    <!--Begin of changes for tracker 131243 by sumeet gandhok - BANKID - -->
    	<script language="javascript" src="../cif/js/CrossEntityCopyValidation.js"></script>
    <!--End of changes for tracker 131243 by sumeet gandhok - BANKID - -->
        <script type="text/javascript" src="../common/js/PopupMenu.js"></script>
        <script type="text/javascript" src="../common/js/SSOUtils.js"></script>
        <!-- Alternate BANKING CHANGES Starts-->
        <script type="text/javascript" src="../Customization/searchconsole/js/AccountRCLOptions_{$locale}{$islamicResourceFileSuffix}.js"></script>
        <!-- Alternate BANKING CHANGES Ends-->
        <script type="text/javascript" id="TableRowColor" src="../common/js/SRMTableRowColor.js"></script>
        <script type="text/javascript" src="../searchconsole/js/AccountListRightClick.js"></script>
        <script language="javascript" src="../common/js/ExportToExcel.js" type="text/javascript">
    </script>
        <script>
          var newWinGrpH=null;
          var prevAccountURL = "";
          var accountURL = "";
          var accountId = "";
          var accountKey = "";
          var AccessOwnerGroup = "";
          var prevAcctId = "-1";
           var expirationdate = new Date ();
          var local_prefix="SearchConsole_Customer";
	 var hLinkWindow;
		// vasanth's changes start
		var Suspended     = "";
		var BlackListed   = "";
		var Negated       = "";
		// vasanth's changes end
		var IsTampered    = "";

          function deleteall(){
             setCookie('AccountURL', "", expirationdate);
                 setCookie('AccountID', "", expirationdate);
          }
function selectLastSelected() {
prevAcctId= getCookie('AccountID');
    showDefTabs();
}
                               function identifyme()
                               {
                                        loadPersistData();
                                        expirationdate.setTime(expirationdate.getTime() + ( 160 * 60 * 1 * 1000));
                                        /* recon changes for call id 139795 starts */
                                        var tempTableRow = null;
                                         
					if(event.srcElement.parentElement.parentElement.id == null || event.srcElement.parentElement.parentElement.id == '') {
					   tempTableRow = event.srcElement.parentElement.parentElement.parentElement;
					    if (tempTableRow.id == null || tempTableRow.id == '') item = item.parentElement;
					} else {
						//changes for call id 564672 starts
					     //tempTableRow = event.srcElement.parentElement.parentElement.parentElement;
					     tempTableRow = event.srcElement.parentElement.parentElement;
						//changes for call id 564672 ends
					}
					/* recon changes for call id 139795 ends */
					// GroupHouseHold Changes Start
					accountURL 	= tempTableRow.getAttribute('AccountBO.url_');
					accountId 	= tempTableRow.getAttribute('AccountBO.accountID');
					accountKey 	= tempTableRow.getAttribute('AccountBO.AccountKey');
					lastName 	= tempTableRow.getAttribute('AccountBO.Cust_Last_Name');
					Suspended	= tempTableRow.getAttribute('AccountBO.Suspended');	
					BlackListed	= tempTableRow.getAttribute('AccountBO.BlackListed');	
					Negated		= tempTableRow.getAttribute('AccountBO.Negated');                        
						// vasanth's changes end
                                        IsTampered     	= tempTableRow.getAttribute('AccountBO.IsTampered');
				<!-- Tracker ID: 108381: Begin of changes : For micro edit -->
					RecordStatus  = tempTableRow.getAttribute('AccountBO.RecordStatus');
					ProcessStatus  = tempTableRow.getAttribute('AccountBO.ProcessStatus');
					
				<!-- Tracker ID: 108381: End of changes -->
                                       if(accountId==null || accountId==""){
                                                accountURL 	= event.srcElement.parentElement.parentElement.parentElement.getAttribute('AccountBO.url_');
                                                accountId 	= event.srcElement.parentElement.parentElement.parentElement.getAttribute('AccountBO.accountID');
                                                accountKey 	= event.srcElement.parentElement.parentElement.parentElement.getAttribute('AccountBO.AccountKey');
                                                lastName 	= event.srcElement.parentElement.parentElement.parentElement.getAttribute('AccountBO.Cust_Last_Name');
                                           	IsTampered 	= event.srcElement.parentElement.parentElement.parentElement.getAttribute('AccountBO.IsTampered');
						// vasanth's changes start
						Suspended	= event.srcElement.parentElement.parentElement.parentElement.getAttribute('AccountBO.Suspended');	
						BlackListed	= event.srcElement.parentElement.parentElement.parentElement.getAttribute('AccountBO.BlackListed');	
						Negated		= event.srcElement.parentElement.parentElement.parentElement.getAttribute('AccountBO.Negated');                        
						// vasanth's changes end
                                                <!--  Tracker ID : 90197 Begin of Changes for attribute masking-->
						 	AccessOwnerGroup = event.srcElement.parentElement.parentElement.getAttribute('AccountBO.accessOwnerGroup');
				 		<!-- Tracker ID : 90197 End of Changes -->
				 		<!-- Tracker ID : 160723 start of changes -->
				 		RecordStatus		= event.srcElement.parentElement.parentElement.parentElement.getAttribute('AccountBO.RecordStatus'); 
				 		ProcessStatus		= event.srcElement.parentElement.parentElement.parentElement.getAttribute('AccountBO.ProcessStatus');                        
				 		<!-- Tracker ID : 160723 end of changes -->

                                        }                                    

                                        if(accountId==null || accountId==""){
                                                accountURL = event.srcElement.parentElement.getAttribute('AccountBO.url_');
                                                accountId = event.srcElement.parentElement.getAttribute('AccountBO.accountID');
                                                accountKey = event.srcElement.parentElement.getAttribute('AccountBO.AccountKey');
                                                lastName = event.srcElement.parentElement.getAttribute('AccountBO.Cust_Last_Name');
                                                IsTampered = event.srcElement.parentElement.getAttribute('AccountBO.IsTampered');
						// vasanth's changes start
						Suspended	= event.srcElement.parentElement.getAttribute('AccountBO.Suspended');	
						BlackListed	= event.srcElement.parentElement.getAttribute('AccountBO.BlackListed');	
						Negated		= event.srcElement.parentElement.getAttribute('AccountBO.Negated');
						
						// vasanth's changes end

						<!--  Tracker ID : 90197 Begin of Changes for attribute masking-->
						AccessOwnerGroup = event.srcElement.parentElement.getAttribute('AccountBO.accessOwnerGroup');
						<!-- Tracker ID : 90197 End of Changes -->                                   
						<!-- Tracker ID : 160723 start of changes -->
						RecordStatus		= event.srcElement.parentElement.getAttribute('AccountBO.RecordStatus'); 
				 		ProcessStatus		= event.srcElement.parentElement.getAttribute('AccountBO.ProcessStatus');                        
				 		<!-- Tracker ID : 160723 end of changes -->
                                        }
                                        /* Changes for Ticket: 267711 Start*/
					setCookie('StrLoggegInBankId1', StrLoggegInBankId1, expirationdate);
					setCookie('StrSearchedBankId1', StrSearchedBankId1, expirationdate);
					/* Changes for Ticket: 267711 End*/
					 // vasanth's changes start
					setCookie('BlackListed', BlackListed, expirationdate);	
					setCookie('Suspended', Suspended, expirationdate);
					setCookie('Negated', Negated, expirationdate);	
					setCookie('entityId', accountKey, expirationdate);	
					setCookie('entityType', 'Customer', expirationdate);
					// vasanth's changes end                                        
 					// GroupHouseHold Changes End
 					<!-- Tracker ID : 160723 start of changes -->
                                        /*if(prevAcctId == accountId) {
                                            return;
                                        }*/
                                        <!-- Tracker ID : 160723 end of changes -->
                                        <!--  Tracker ID : 90197 Begin of Changes for attribute masking-->
                                       		setCookie('AccessOwnerGroup', AccessOwnerGroup, expirationdate);
					<!-- Tracker ID : 90197 End of Changes -->
					setCookie('AccountKey',accountKey,expirationdate);
					setCookie('AccountURL', accountURL, expirationdate);
                                        setCookie('AccountID', accountId, expirationdate);
				<!-- Tracker ID: 108381: Begin of changes : For micro edit -->
					setCookie('RecordStatus', RecordStatus, expirationdate);
					setCookie('ProcessStatus', ProcessStatus, expirationdate);			
				<!-- Tracker ID: 108381: End of changes -->
                                        setCookie('LastName', lastName, expirationdate);
                                        setCookie('IsTampered', IsTampered, expirationdate);
                                        if(prevAccountURL != accountURL) {
                                             prevAccountURL = accountURL;
                                        }
                                        
                                       	<!--Recon for Security Audit Changes from CRM10301BSUPP-->
							 secureKey=event.srcElement.parentElement.getAttribute('hashkey');  
							 secureField=event.srcElement.parentElement.getAttribute('fieldHashkey1');
							 deleteCookie('HASHKEY');							
							 deleteCookie('FLDHASHKEY');
							 setCookie('HASHKEY', secureKey, expirationdate);			
							 setCookie('FLDHASHKEY', secureField, expirationdate);
					<!--Recon for Security Audit Changes from CRM10301BSUPP-->
                                        savePersistData();
						   <!-- Changes for call id 149660 starts - Commented the following lines
						   if(prevAccountURL != accountURL) {
							prevAccountURL = accountURL;
						   }
						   
						  if(prevAcctId != accountId &amp;&amp; accountId != null) {
						       prevAcctId = accountId;-->
						       showDefTabs();
						       
						   <!--}
						   Changes for call id 149660 ends -->
                               }
       function sortMe(sortColumn,sortOrder) {
                var expirationdate = new Date ();
                expirationdate.setTime(expirationdate.getTime() + ( 160 * 60 * 60 * 1000));
                <![CDATA[var vName=]]>"<xsl:value-of select="$ViewName"/>"
                setCookie('SORT_ORDER_' + vName, sortOrder,expirationdate);
                setCookie('SORT_COLUMN_' + vName, sortColumn,expirationdate);
                savePersistData();
        <xsl:choose>
            <xsl:when test="normalize-space($searchType)='Advance'">
                document.AdvanceFindForm.SortOrder.value=sortOrder;
                document.AdvanceFindForm.SortColumn.value=sortColumn;
                document.AdvanceFindForm.submit();
            </xsl:when>
            <xsl:otherwise>
                var doc = parent.parent.frames(0).frames(0).document;
                <!-- Changes for callid 581736 begin -->
		var arrValue = new Array();
		arrValue[0] = doc.form_filters.FilterParam1.value;
		arrValue[1] = doc.form_filters.FilterParam2.value;
		arrValue[2] = doc.form_filters.FilterParam3.value;
		var strValue = fnCheckMandatory(arrValue,ScreenName,'',vName);
		if(strValue==false){
			showMessage(MSG51189);
			doc.form_filters.FilterParam1.value="";
			doc.form_filters.FilterParam3.value="";
			doc.form_filters.FilterParam2.value="";
			//Made the following change due to incompatibilty of JS method focus() and IE8 
			//document.form_filters.FilterParam1.focus();
			setTimeout(function() { doc.form_filters.FilterParam1.focus(); }, 0);
			return false;
		}
		<!-- Changes for callid 581736 ends -->
                doc.all.SortColumn.value = sortColumn;
                doc.all.SortOrder.value = sortOrder;
                doc.form_filters.submit();
                </xsl:otherwise>
        </xsl:choose>
          }
	// CIF GroupHouseHold Change starts
	     function onClickHouseHold() {
			entityId = getCookie('AccountKey');
			if (entityId== null || entityId=="" || entityId== 'null') {
				     return;
		}

		entityType = 'Customer';
	<!--Tracker:108382:Modal Window change-->
		var str = "";
			str = "../servlet/com.infy.cis.ui.corpcif.ListofGroupHshldLinked?EntityID=" + entityId + "&amp;EntityType=" + entityType;
		newWinGrpH = window.showModalDialog(str, 'ListofGroupsLinked','dialogHeight:460px; dialogWidth:900px;directories=No,location=no, menubar=no, resizable=yes, status=no, toolbar=no, scrollbars');
		// Tracker 109229
		setTimeout("newWinGrpH.window.focus()","3000");
 

		hLinkWindow=newWinGrpH;
		 }
		 
		 
		function setFocust(){

                        try{

                           if(hLinkWindow != null){

                             hLinkWindow.focus();

                           }

                        }catch(e){

                            hLinkWindow = null;

                        }

            	}

	<!--Tracker:108382:End of Changes-->
		 
	// CIF GroupHouseHold Change ends

        </script>
        </head>
        
			  <body class="popup" onfocus="setFocust();" onmouseover="setFocust();">
              </body>
	<form name="frmOD" target='Omnidoc' method="post" action="">
	</form>

        <xsl:call-template name="bodystart"/>
        <xsl:choose>
            <xsl:when test="normalize-space($searchType)='Advance'">
                         <form name="AdvanceFindForm" target='ResultArea' method="Get" action="../servlet/com.infy.cis.ui.common.AdvancedContactSearchResults">
                            <input type="hidden" name="Query" value="{$query}"/>
                            <input type="hidden" name="BOName" value="AccountBO"/>
                        <input type="hidden" name="ViewName" value="Account_Search"/>
                        <input type="hidden" name="QueryText" value="{$queryText}"/>
                            <input type="hidden" name="SortOrder" value=""/>
                        <input type="hidden" name="SortColumn" value=""/>
                    </form>
            </xsl:when>
        </xsl:choose>
      </xsl:if>
    <xsl:call-template name="mainbody">
        <xsl:with-param name="tablename">RecordSet</xsl:with-param>
        <xsl:with-param name="pageIndex"><xsl:value-of select="$pageIndex"/></xsl:with-param>
        <xsl:with-param name="NumPages"><xsl:value-of select="$NumPages"/></xsl:with-param><!--TRACKER# 92380-->
        <xsl:with-param name="extra_tableHeader"><xsl:value-of select='$queryText' /></xsl:with-param>
        <xsl:with-param name="showNext">true</xsl:with-param>  
	<xsl:with-param name="width">100%</xsl:with-param>
	
	<!--*************CR changes for tracker 113227 begin***********-->
	<xsl:with-param name="nameListingFlag">true</xsl:with-param>
	<!--*************CR changes for tracker 113227 end***********-->

<!-- Tracker ID: 108381: Begin of changes : Removing House Hold column from listing -->
<!--
	<xsl:with-param name="name"><xsl:value-of select="$configLabels[@name='HouseHold']/@configLabel"/></xsl:with-param>
	<xsl:with-param name="hardcoded_string">true</xsl:with-param>
	<xsl:with-param name="extra_colheader2"><xsl:value-of select="$configLabels[@name='HouseHold']/@configLabel"/></xsl:with-param>
	<xsl:with-param name="colhrefone_function">onClickHouseHold()</xsl:with-param>
-->	
<!-- Tracker ID: 108381: End of changes -->

	<xsl:with-param name="callcalme">1</xsl:with-param>
	<!-- changes begin call id 138045-->
        <xsl:with-param name="callselectLastSelected"></xsl:with-param>
        <!-- changes ends call id 138045-->
        <xsl:with-param name="rclickshow">true</xsl:with-param>
        <xsl:with-param name="rowhighlight">true</xsl:with-param>
        <xsl:with-param name="rsfilenm"><xsl:value-of select="$resfilename"/></xsl:with-param>
       <!--Tracker:108381:Changes for 360Degree tertiary pane default tab--> 
        <xsl:with-param name="jscriptfnc">,identifyme(),def_TabHelper()</xsl:with-param>
       <!--Tracker:108381:End of Changes-->
	<!--vasanth's changes start-->

	<!--<xsl:with-param name="colhrefname">AccountBO.Suspended</xsl:with-param>-->
	<!--<xsl:with-param name="colhref_three">AccountBO.Negated</xsl:with-param>-->
	<!--<xsl:with-param name="colhref_two">AccountBO.BlackListed</xsl:with-param>-->

<!-- Tracker ID: 108381: Begin of changes : Removing hyperlinks for BL/Negated/Suspended -->
<!--
	<xsl:with-param name="colhref_function">ShowReasonCodes('suspend','Retail','entityId','Customer')</xsl:with-param>
	<xsl:with-param name="colhrefthree_function">ShowReasonCodes('negative','Retail','entityId','Customer')</xsl:with-param>
	<xsl:with-param name="colhreftwo_function">ShowReasonCodes('blacklist','Retail','entityId','Customer')</xsl:with-param>
-->
<!-- Tracker ID: 108381: End of changes -->

<!-- Tracker ID: 108381: Begin of changes : For iconisation -->

	<xsl:with-param name="usabilityChange">true</xsl:with-param>
<!--	
<xsl:with-param name="imgName">AccountBO.BlackListed,AccountBO.Negated,AccountBO.Suspended,AccountBO.Segmentation_Class</xsl:with-param>
-->

<!--<xsl:with-param name="imgName">AccountBO.Segmentation_Class</xsl:with-param>-->

<!--<xsl:with-param name="imgValueName">AccountBO.BlackListed,AccountBO.Negated,AccountBO.Suspended,AccountBO.Segmentation_Class,AccountBO.status,AccountBO.preferredPhoneType</xsl:with-param>-->

<xsl:with-param name="hyphonereq">false</xsl:with-param>
<!-- Begin changes : Tracker id 153274 -->
<xsl:with-param name="imgValueName">AccountBO.BlackListed,AccountBO.Negated,AccountBO.Suspended,AccountBO.Segmentation_Class,AccountBO.RecordStatus,AccountBO.preferredPhoneType,AccountBO.UniqueIdType,</xsl:with-param>
<!-- End changes : Tracker id 153274 -->
<xsl:with-param name="phone_elements">AccountBO.preferredPhoneType,</xsl:with-param><!-- Fix for ticket 282349 -->


<!--
<xsl:with-param name="imgValueName">AccountBO.Suspended,AccountBO.Negated,AccountBO.BlackListed,</xsl:with-param>
<xsl:with-param name="imgName">AccountBO.Segmentation_Class,AccountBO.preferredPhoneType,</xsl:with-param>
<xsl:with-param name="imgFieldValueName">AccountModBO.LastOperPerformed,</xsl:with-param>

<xsl:with-param name="hyphonereq">false</xsl:with-param>
<xsl:with-param name="phone_elements">AccountBO.preferredPhoneType,</xsl:with-param>
-->


	<xsl:with-param name="imgValueNameLink_one">AccountBO.Suspended</xsl:with-param>
	<xsl:with-param name="imgValueNameLink_two">AccountBO.Negated</xsl:with-param>
	<xsl:with-param name="imgValueNameLink_three">AccountBO.BlackListed</xsl:with-param>
	<!--Changes done by Vinod for 274629 on 2/26/2009  start-->
	<xsl:with-param name="imgValueNameFunc_one">identifyme(),ShowReasonCodes('suspend','Retail','entityId','Customer')</xsl:with-param>
	<xsl:with-param name="imgValueNameFunc_two">identifyme(),ShowReasonCodes('negative','Retail','entityId','Customer')</xsl:with-param>
	<xsl:with-param name="imgValueNameFunc_three">identifyme(),ShowReasonCodes('blacklist','Retail','entityId','Customer')</xsl:with-param>
	<!--Changes done by Vinod for 274629 on 2/26/2009  end -->
<!-- Tracker ID: 108381: End of changes -->

	<!--vasanth's changes end-->

<!-- Tracker ID: 108381: Begin of changes : For hyperlinks CIF ID, Last name and Preferred Unique ID-->
	
	<xsl:with-param name="colhrefname">AccountBO.AccountKey</xsl:with-param>
	<xsl:with-param name="colhref_function">populateCifEntityDetails('Main','Account',accountId,ScreenName,viewnameScreenID)</xsl:with-param>
	
	<xsl:with-param name="colhref_two">AccountBO.UniqueId</xsl:with-param>
	<xsl:with-param name="colhreftwo_function">populateUniqueIDs(accountId,'Account')</xsl:with-param>
	
	<xsl:with-param name="colhref_four">AccountBO.Cust_Last_Name</xsl:with-param>
	<xsl:with-param name="colhreffour_function">composeHTMLEmail('Account',accountId)</xsl:with-param>

<!-- Tracker ID: 108381: End of changes -->

    </xsl:call-template>
  </xsl:template>
 </xsl:stylesheet>










