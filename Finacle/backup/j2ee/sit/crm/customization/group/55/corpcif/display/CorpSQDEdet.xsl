<?xml version="1.0" encoding="UTF-8"?>
<!-- **********	This XSL is Regenerated using the XSLWorkBench tool **********@1994925@--> 
<!-- ***************	  Please do not alter this file manually   ***************--> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="../Renderer/common/display/getJVMProperties.xsl"></xsl:import>
<xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"></xsl:import>
<xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"></xsl:import><xsl:param name="locale" />
<xsl:variable name="resFile_ML">../Renderer/Customization/55/corpcif/resource/CorpSQDEdet</xsl:variable>
<xsl:variable name="resConfigFile" select="document(concat($resFile_ML,'_',$locale,'.xml'))"/>
<xsl:variable name="configLabels" select="$resConfigFile/SRMBO/*"/>
<xsl:variable name="boName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='boName']"></xsl:variable>
<xsl:variable name="boNameRep" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='boNameRep']"></xsl:variable>

<xsl:variable name="uniqueId" select="$customfields[@n='uniqueId']"/>
<xsl:variable name="doc_Type" select="$customfields[@n='doc_Type']"/>
<xsl:variable name="docCode" select="$customfields[@n='docCode']"/>


     	<xsl:param name="ALTCALENDAR_TYPE"/>
<xsl:variable name="docTypeCode" select="$customfields[@n='docTypeCode']"/>
<xsl:variable name="docType_docCode" select="$customfields[@n='docType_docCode']"/>
<xsl:variable name="defAddress" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='DefAdress']"/>
<!--Changes for call id 399601 and recon of call id 395278 starts-->
<xsl:variable name="preferredAddressType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='preferredAddressType']"/>
<xsl:variable name="code_country" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CountryCode']"></xsl:variable>
<xsl:variable name="stateCode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='StateCode']" />
<xsl:variable name="cityCode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CityCode']" />
<!--Changes for call id 399601 and recon of call id 395278 ends-->
<xsl:variable name="legalEntType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='legalEntType']"/>
<xsl:variable name="LegalCode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='LegalCode']"></xsl:variable>

<xsl:variable name="docTypeCodeSel" select="$customfields[@n='EntityDocumentBO.DocTypeCode']"/>
<xsl:variable name="docCodeSel" select="$customfields[@n='EntityDocumentBO.DocCode']"/>
<!--changes for call id 369315 371085 and recon of call id starts -->
<xsl:variable name="doc_TypeDesc_Old" select="$customfields[@n='doc_TypeDesc']"/>
<xsl:variable name="docCode_docDesc_Old" select="$customfields[@n='docCode_docDesc']"/>
<xsl:variable name="identification_Type" select="$customfields[@n='EntityDocumentBO.IdentificationType']"/>
<xsl:variable name="docCode_IDType" select="$customfields[@n='docCode_IDType']"/>
<!--changes for call id 371085 and recon of call id 369315 ends -->
<!--Recon of RBS FS : 714946 SET4 starts-->
<xsl:variable name="sectorValue" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='sectorValue']"></xsl:variable>
<xsl:variable name="segment" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='segment']"></xsl:variable>
<xsl:variable name="preferredPhone" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='preferredPhone']"></xsl:variable>
<!--Recon of RBS FS : 714946 SET4 ends-->
<xsl:variable name="dtValid" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='dtValid']" />

<xsl:variable name="SecCode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='SecCode']"></xsl:variable>
<!--changes for tracker 454761 begin -->
<!--changes for ticket 688464 begin -->
<!-- <xsl:variable name="sectorValue" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='sectorValue']"></xsl:variable> -->
<!--changes for ticket 688464 ends -->
<!--changes for tracker 454761 ends -->
<xsl:variable name="locDate"><xsl:value-of select="$dtValid"></xsl:value-of></xsl:variable>


<xsl:variable name="docCode_CIFType" select="$customfields[@n='docCode_CIFType']"/>
<xsl:variable name="city_code" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CorporateBO.Address.city_Code']" />
<xsl:variable name="country_code" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CorporateBO.Address.country_Code']" />
<xsl:variable name="state_code" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CorporateBO.Address.state_Code']" />
<xsl:variable name="entityType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='entityType']"></xsl:variable>
<xsl:variable name="entityKey" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='entityKey']"></xsl:variable>
<xsl:variable name="globalRM" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='GlobalRM']"></xsl:variable>
<xsl:variable name="cifAddrEntity" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CorporateRepModBO.cifAddrEntity']"></xsl:variable>
<xsl:variable name="addressCategory" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CorporateRepModBO.addressCateogry']"></xsl:variable>
<xsl:variable name="corporateURL" select="//SRMData//Z[@n=concat($boName,'.url_')]"></xsl:variable>
<xsl:variable name="NatName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='NatName']"></xsl:variable>
<xsl:variable name="choice_nameIDType" select="$customfields[@n='choice_nameIDType']"/>
<xsl:variable name="getMCRequired" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='MCRequired']"></xsl:variable>
<xsl:variable name="mcJNDIFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='mcJNDIFlag']"></xsl:variable>
<xsl:variable name="isMCEdited" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='isMCEdited']"></xsl:variable>
<xsl:variable name="customfields" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z"/>
<xsl:variable name="isAutoGenKey" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='isAutoGen']"></xsl:variable>
<xsl:variable name="keyGeneration" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='keyGeneration']"></xsl:variable>
<xsl:variable name="entityCreflg" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='entityCreflg']"/>
<xsl:variable name="corpId" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='corpId']"/>
<xsl:variable name="operationType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='operationType']"/>
<xsl:variable name="apprFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='apprFlag']"/>
<!-- changes done for ticket id 435934 starts -->
<xsl:variable name="bcName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='bcName']"></xsl:variable>
<xsl:variable name="Cat_bcName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Cat_bcName']"></xsl:variable>
<!-- changes done for ticket id 435934 ends -->	   
<!--Changes for call id 394250 starts-->
<xsl:variable name="currencyCode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='currencyCode']"/>
<!--Changes for call id 394250 ends-->
<!--Recon for Security Audit Changes from CRM10301BSUPP-->
<xsl:variable name="SECUREHKEY" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='hashkey']"/>
<xsl:variable name="FLDHASHKEY" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='fldhashkey']"/>
<!-- Changes for 391173 recon of 390032 -->
<xsl:variable name="SegmentCorp" select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n=$boName]/Z[@n=concat($boName,'.segment')]" />
<!--Recon for Security Audit Changes from CRM10301BSUPP-->
 <xsl:param name="altLocaleActv"/>
<!-- caching changes start -->
 <xsl:param name="viewname"/>
 <xsl:variable name="PresFileName">../servlet/com.infy.cis.ui.corpcif.CorpCIF_DetPresCacheServlet?ViewName=<xsl:value-of select="$viewname"/>&amp;Locale=<xsl:value-of select="$locale"/></xsl:variable>
 <xsl:variable name="PresFile" select="document(concat($PresFileName,''))"/>
 <xsl:variable name="PresData" select="$PresFile/SRM/SRMPresentation"/>
<!-- caching changes end -->

 <!-- Changes for 'WFlow' POC start -->
<xsl:variable name="IntWFID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='strIntWFID']"></xsl:variable>
<!-- Changes for 'WFlow' POC start -->
<!-- changes for call id 371085 and recon of call id 369315 starts -->
<xsl:variable name="doc_TypeDesc">
	<xsl:call-template name="replace-string">
		<xsl:with-param name="text" select="$doc_TypeDesc_Old" />
		<xsl:with-param name="from">'</xsl:with-param>
		<xsl:with-param name="to">\'</xsl:with-param>
	</xsl:call-template>
</xsl:variable>
<xsl:variable name="docCode_docDesc">
	<xsl:call-template name="replace-string">
		<xsl:with-param name="text" select="$docCode_docDesc_Old" />
		<xsl:with-param name="from">'</xsl:with-param>
		<xsl:with-param name="to">\'</xsl:with-param>
	</xsl:call-template>
</xsl:variable>
<!-- changes for call id 371085 and recon of call id 369315 ends -->
<xsl:template match="/">
<html>
<title><xsl:value-of select="//SRMPresentation/SRMSystem[@n='Strings']/SRMString[@n='Title']/@value"></xsl:value-of></title>

<head>
<!--Changes by Niharika for CR356016-->
<script type="text/javascript" src="../Customization/cif/js/EquityProcessCustom.js" language="javascript"></script>

<!--End of changes by Niharika for CR356016-->
                                       <script type="text/javascript" src="../corpcif/js/CorpEntityDocumentForm.js" language="javascript"></script>

                                       <script type="text/javascript" src="../common/js/ClientResourceBundle_{$locale}.js" language="javascript"></script>
				       <script type="text/javascript" language="javascript" src="../corpcif/js/CorpCIFAddress.js"></script>
				       <script type="text/javascript" language="javascript" src="../corpcif/js/CorpCIFPhoneEmail.js"></script>
				       <script type="text/javascript" language="javascript" src="../Customization/corpcif/js/CorpSQDEdet.js"></script>

				       <script type="text/javascript" language="javascript" src="../corpcif/js/CorpGenCust_QDE.js"></script>
				       <script type="text/javascript" src="../common/html/Rendvalidate.js" language="javascript"></script>
				
				       <script type="text/javascript" src="../common/js/WorkFlow.js" language="javascript"></script>

                                        <script type="text/javascript" src="../common/js/ClientResourceBundle_{$locale}.js" language="javascript"></script>

					
	    				
	    				<!-- Changes for WFlow POC end -->
	                                 <script type="text/javascript" src="../common/html/utils.js" language="javascript"></script>
					<script type="text/javascript" src="../common/html/validateL2.js" language="javascript"></script>
					<script type="text/javascript" language="javascript" src="../corpcif/js/Group.js"></script>

					<script type="text/javascript" src="../common/js/MLValidate.js" language="javascript"></script>
         				<!--  START  Changes for Tracker # 209607 -->
					<script type="text/javascript" src="../common/js/Rendcurrency_cif.js" language="javascript"></script>
  					<!--  END  Changes for Tracker # 209607 -->
					<script type="text/javascript" src="../common/js/SRMTableRowColor.js" language="javascript"></script>
					<script type="text/javascript" src="../corpcif/js/Message_corpcif_{$locale}.js" language="javascript"></script>
					<!-- Field Rationalization changes start -->
					<script type="text/javascript" src="../common/js/SSOUtils.js"></script>
					<!-- Field Rationalization changes end -->
					<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
					<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/PopupMenu_{$locale}.css"/>
					<script type="text/javascript" src="../common/html/validate.js" language="javascript"></script>
					<!-- changes for 404 error -->
					<!-- <script type="text/javascript" src="../corpcif/js/CorpCustSQDE_System.js" language="javascript"></script> -->
					<!-- changes for 404 error -->
					
					<script type="text/javascript" src="../common/html/validate.js" language="javascript"></script>
					<script type="text/javascript" src="../corpcif/js/CorpFreeTxtAddress_System.js" language="javascript"></script>
														<!-- Memo padding -->
	    				
<script>
				<!-- changes for call id 371085 and recon of call id 369315 starts -->
				<![CDATA[
					function decodeSpecialCharsXML(strTempArr){

					var re = new RegExp("&amp;", "g");

					strTempArr=strTempArr.replace(re,"&");

					re = new RegExp("&apos;", "g");
					strTempArr=strTempArr.replace(re,"'");

					re = new RegExp("&lt;", "g");
					strTempArr=strTempArr.replace(re,"<");

					re = new RegExp("&gt;", "g");
					strTempArr=strTempArr.replace(re,">");

					re = new RegExp("&macr;", "g");
					strTempArr=strTempArr.replace(re,"-");

					strTempArr = decodeURIComponent(strTempArr);

					return strTempArr;
					}
					]]>
				<!-- changes for call id 371085 and recon of call id 369315 ends -->
					var boName = '<xsl:value-of select="$boName"/>';
					var boNameRep = '<xsl:value-of select="$boNameRep"/>';
		 			var altLocaleActv = '<xsl:value-of select="$altLocaleActv"/>';
		                      
		                     var doc_Type = '<xsl:value-of select="$doc_Type"/>';
		                       
		                      	var locDate = '<xsl:value-of select="$locDate"></xsl:value-of>';
		                       
		                       var docCode = '<xsl:value-of select="$docCode"/>';
// Changes for 391173 recon of 390032 		                       
var SegmentCorp = '<xsl:value-of disable-output-escaping="yes" select="$SegmentCorp"></xsl:value-of>';
		                       
		                       var uniqueId = '<xsl:value-of select="$uniqueId"/>';
		                       <!--var uniqueIdSel = '<xsl:value-of select="$uniqueIdSel"/>';-->

		                       var docTypeCode = '<xsl:value-of select="$docTypeCode"/>';

		                        var docCode_CIFType='<xsl:value-of select="$docCode_CIFType"/>';
		                        
		                        var docType_docCode='<xsl:value-of select="$docType_docCode"/>';
		                        <!-- changes for call id 371085 and recon of call id 369315 starts -->
					var doc_TypeDesc = decodeSpecialCharsXML('<xsl:value-of select="$doc_TypeDesc"/>');
					var docCode_docDesc=decodeSpecialCharsXML('<xsl:value-of select="$docCode_docDesc"/>');	
		                        var docCode_IDType='<xsl:value-of select="$docCode_IDType"/>';
					<!-- changes for call id 371085 and recon of call id 369315 ends -->
					var city_code = '<xsl:value-of select="$city_code"></xsl:value-of>';
					var country_code = '<xsl:value-of select="$country_code"></xsl:value-of>';
			  		var state_code = '<xsl:value-of select="$state_code"></xsl:value-of>';
			         	var entityType = '<xsl:value-of select="$entityType"/>';
					var addressCategory = '<xsl:value-of select="$addressCategory"/>';
			         	var entityKey = '<xsl:value-of select="$entityKey"/>';
					var globalRM = '<xsl:value-of select="$globalRM"/>';
					var cifAddrEntity = '<xsl:value-of select="$cifAddrEntity"/>';
	                                var keyGeneration = '<xsl:value-of select="$keyGeneration"/>';
                                       
                                       var corpURL = '<xsl:value-of select="$corporateURL"/>';
					
					var isAutoGenKey = '<xsl:value-of select="$isAutoGenKey"/>';
	                                var entityCreflg ='<xsl:value-of select="$entityCreflg"/>';
					var NatName =  '<xsl:value-of select="$NatName"/>';
					var choice_nameIDType = '<xsl:value-of select="$choice_nameIDType"/>';
					var RMChanged='';
					var defaultPrimaryRM='';
					var defaultSecondaryRM=''
					var IntWFID = '<xsl:value-of select="$IntWFID"/>';
				        var locale = '<xsl:value-of select="$locale"/>';
		                        var defAddress = '<xsl:value-of select="$defAddress"/>';
					//Changes for call id 399601 and recon of call id 395278 starts
					var preferredAddressType = '<xsl:value-of select="$preferredAddressType"/>';
					var code_country = '<xsl:value-of select="$code_country"/>';
					var stateCode = '<xsl:value-of select="$stateCode"/>';
					var cityCode = '<xsl:value-of select="$cityCode"/>';
					//Changes for call id 399601 and recon of call id 395278 ends
					var legalEntType = '<xsl:value-of select="$legalEntType"/>';
    					var LegalCode = '<xsl:value-of select="$LegalCode"/>';
    					var corpId = '<xsl:value-of select="$corpId"/>';
    					var operationType = '<xsl:value-of select="$operationType"/>';
					var apprFlag = '<xsl:value-of select="$apprFlag"/>';
					var docCodeSel = '<xsl:value-of select="$docCodeSel"/>';
					var docTypeCodeSel = '<xsl:value-of select="$docTypeCodeSel"/>';
    								var SecCode = '<xsl:value-of select="$SecCode"/>';
									//Recon of RBS FS : 714946 SET4 starts
									var sectorValue = '<xsl:value-of select="$sectorValue"/>';
									var segment = '<xsl:value-of select="$segment"/>';
									var preferredPhone = '<xsl:value-of select="$preferredPhone"/>';
									//Recon of RBS FS : 714946 SET4 ends
    					//changes done for ticket id 435934 starts			
                                        var bcName = '<xsl:value-of select="$bcName"/>';
	                                var Cat_bcName = '<xsl:value-of select="$Cat_bcName"/>';
	                                //changes done for ticket id 435934 ends

<!--tracker id 113227 starts-->

					     /*ticket id 219597 tracker id 132339 changes starts*/
					    	var dualflag=1;
					      /*ticket id 219597 tracker id 132339 changes ends*/

					// Checksum changes by Rajneet Singh Bawa
					var hashkey =  '<xsl:value-of select="$SECUREHKEY"/>';
					var fldhashkey = '<xsl:value-of select="$FLDHASHKEY"/>';
					var expirationdate = new Date ();
					expirationdate.setTime(expirationdate.getTime() + ( 160 * 60 * 60 * 1000));
					deleteCookie('hashkey');
		 			deleteCookie('fldhashkey');
					setCookie('hashkey', hashkey,expirationdate);
					setCookie('fldhashkey', fldhashkey,expirationdate);
				// Checksum changes by Rajneet Singh Bawa

				


</script>
<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
					<link rel="stylesheet" Type="text/css" href="../Branding/css/common/PopupMenu_{$locale}.css"/>
					<link rel="stylesheet" Type="text/css" href="../Branding/css/common/MultiTabs_{$locale}.css"/>
					<link rel="stylesheet" type="text/css" href="../Branding/css/common/SRMListTemplate_{$locale}.css"/>


					<script type="text/javascript" src="../common/js/SRMTableRowColor.js"></script>
					<script type="text/javascript" src="../common/js/SRMFormToggle.js"></script>

					<script type="text/javascript" src="../common/html/validate.js" language="javascript"></script>

					<!-- Memo padding -->
					<script type="text/javascript" src="../common/js/ContextSwitch.js" language="javascript"></script>


</head>


<!-- DBS Enhancement tracker ID :-402520 by rattandeep_singh01 -->		
<body class="popup" onkeypress="onLoadSetTime()" onclick="onLoadSetTime()">
<!-- DBS Enhancement tracker ID :-402520 by rattandeep_singh01 -->
<!-- changes done for ticket id 435934 starts --> 
<!-- Changes for 391173 recon of 390032 -->
<!--<xsl:attribute name="onload">loadseg();populateDocTypeOnLoad();onAddrSelect();disableCorpRep();fnload();loadID();loadrel();</xsl:attribute>-->
<xsl:choose>            
<xsl:when test="normalize-space($operationType)='EditEntity'">
<xsl:attribute name="onload">loadseg();populateDocTypeOnLoad();onAddrSelect();disableCorpRep();fnload();loadID();loadrel();</xsl:attribute>
</xsl:when>

<xsl:otherwise>
<xsl:attribute name="onload">fnloadCorpSQDE();loadseg();loadprimesolid();populateDocTypeOnLoad();onAddrSelect();disableCorpRep();fnload();loadID();loadrel();</xsl:attribute>
</xsl:otherwise>
</xsl:choose> 
<!-- End of Changes for 391173 recon of 390032 -->
<!-- changes done for ticket id 435934 ends -->
 		<script type="text/javascript" src="../common/html/utils.js" language="javascript"></script>
					<script type="text/javascript" src="../common/html/Rendvalidate.js" language="javascript"></script>
					<script type="text/javascript" src="../common/html/validateL2.js" language="javascript"></script>
					<script type="text/javascript" language="javascript" src="../corpcif/js/Group.js"></script>

					<script type="text/javascript" src="../common/js/MLValidate.js" language="javascript"></script>
<!--  START  Changes for Tracker # 209607 -->
					<script type="text/javascript" src="../common/js/Rendcurrency_cif.js" language="javascript"></script>
<!--  END  Changes for Tracker # 209607 -->
					<script type="text/javascript" src="../corpcif/js/Message_corpcif_{$locale}.js" language="javascript"></script>
					<!-- Field Rationalization changes start -->
					<script type="text/javascript" src="../common/js/SSOUtils.js"></script>
					<script type="text/javascript" src="../Customization/corpcif/js/CorpSQDECustom.js" language="javascript"></script>
					<!-- Field Rationalization changes end -->
           
<!--   JAVASCRIPT FUNCTIONS    -->
			<script type="text/javascript" language="javascript">
			
			

				

				var RetAddr   =  new Array();
				
//113227 changes starts
				   // Tracker ID: 122044 Changes START
				var RetAddr1   =  new Array();
//113227 changes ends
				var CorpAddr1  = new Array();
				// Tracker ID: 122044 Changes END


				var CorpAddr  = new Array();
				var refreshParentToParent = true;
				
                                
				
				
			
				var iCount3 = 0;
				'<xsl:for-each select="$PresFile/SRM/SRMPresentation/L1[@n='RetailAddr']/C1">'
					RetAddr[iCount3] 		= '<xsl:value-of select="@value"/>'

				// Tracker ID: 122044 Changes START
					RetAddr1[iCount3] 		= '<xsl:value-of select="@url"/>'
					// Tracker ID: 122044 Changes END
					iCount3++;
				'</xsl:for-each>'

				


				var iCount4 = 0;
				'<xsl:for-each select="$PresFile/SRM/SRMPresentation/L1[@n='CorporateAddr']/C1">'
					CorpAddr[iCount4] 		= '<xsl:value-of select="@value"/>'
					// Tracker ID: 122044 Changes START
					CorpAddr1[iCount4] 		= '<xsl:value-of select="@url"/>'
					// Tracker ID: 122044 Changes END
					iCount4++;
				'</xsl:for-each>'
				
				function setMCAttModifyFlag(){
						document.frm2.isMCEditedGeneral.value="Y";
	}
		
				
</script>


<table width="100%" vspace="0" hspace="0" cellspacing="0" cellpadding="0" border="0">
<xsl:apply-templates select="SRM"></xsl:apply-templates>

       </table>
    </body>
   </html>
</xsl:template>

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
				<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
<!-- CRM10: Other Maintenence Change by Mamta: Flag, if the field is a NameField: ENDS  -->
				<xsl:with-param name="max_length">100</xsl:with-param>
			</xsl:call-template>
		</xsl:template>
<xsl:template name="CorporateBO.short_Name">
	<xsl:call-template name="label">
		<xsl:with-param name="ele_name">CorporateBO.short_Name</xsl:with-param>
		<xsl:with-param name="ele_val">CorporateBO.short_Name</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.short_Name']" />
		<xsl:with-param name="max_length">10</xsl:with-param>
		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>

		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template>





<xsl:template name="CorporateBO.registration_Number">
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.registration_Number']"/>
		<xsl:with-param name="selectname">CorporateBO.registration_Number</xsl:with-param>
		<xsl:with-param name="selectdisp">CorporateBO.registration_Number</xsl:with-param>
		<xsl:with-param name="ele_name">CorporateBO.registration_Number</xsl:with-param>
		</xsl:call-template>
		</xsl:template>
<xsl:template name="CorporateBO.date_Of_Incorporation">
	<xsl:call-template name="label">
		<xsl:with-param name="ele_name">CorporateBO.date_Of_Incorporation</xsl:with-param>
		<xsl:with-param name="ele_val">CorporateBO.date_Of_Incorporation</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.date_Of_Incorporation']" />
		<xsl:with-param name="fn_onBlur">validateDOI();</xsl:with-param>
		<xsl:with-param name="starshow">false</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="EntityDocumentBO.DocTypeCode">	
				<xsl:call-template name="mdrpdown">
				
					<xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.DocTypeCode']"/>
					<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
					<xsl:with-param name="selectname">EntityDocumentBO.DocTypeCode</xsl:with-param>
					<xsl:with-param name="selectdisp">EntityDocumentBO.DocTypeCode</xsl:with-param>
					<xsl:with-param name="onchangefn">loadTypeData1(this)</xsl:with-param>
					<xsl:with-param name="starshow">true</xsl:with-param>
				</xsl:call-template>			
	</xsl:template>
	
<xsl:template name="EntityDocumentBO.DocCode">	 
			<xsl:call-template name="mdrpdown">
				<xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.DocCode']"/>
				<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
				<xsl:with-param name="selectname">EntityDocumentBO.DocCode</xsl:with-param>
				<xsl:with-param name="selectdisp">EntityDocumentBO.DocCode</xsl:with-param>
				<!-- changes for call id 371085 and recon of call id 369315 starts -->
				<xsl:with-param name="onchangefn">s_loadTypeData1(this)</xsl:with-param>
				<!-- changes for call id 371085 and recon of call id 369315 ends -->
			</xsl:call-template>		
	</xsl:template>
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

<xsl:template name="EntityDocumentBO.ReferenceNumber">
	<xsl:call-template name="label">
		<xsl:with-param name="ele_name">EntityDocumentBO.ReferenceNumber</xsl:with-param>
		<xsl:with-param name="ele_val">EntityDocumentBO.ReferenceNumber</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.ReferenceNumber']" />
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="CorporateBO.Address.Address_Line1">
	<xsl:call-template name="label">
<!--Changes for call id 399601 and recon of call id 395278 starts-->
	<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
<!--Changes for call id 399601 and recon of call id 395278 ends-->
		<xsl:with-param name="ele_name">CorporateBO.Address.Address_Line1</xsl:with-param>
		<xsl:with-param name="ele_val">CorporateBO.Address.Address_Line1</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.Address_Line1']" />
		<!--Changes for tracker 407920 Starts here-->
				<xsl:with-param name="max_length">45</xsl:with-param>	
		<!--Changes for tracker 407920 ends here-->
		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="CorporateBO.Address.Address_Line2">
	<xsl:call-template name="label">
<!--Changes for call id 399601 and recon of call id 395278 starts-->
	<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
<!--Changes for call id 399601 and recon of call id 395278 ends-->
		<xsl:with-param name="ele_name">CorporateBO.Address.Address_Line2</xsl:with-param>
		<xsl:with-param name="ele_val">CorporateBO.Address.Address_Line2</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.Address_Line2']" />
		<!--Changes for tracker 407920 Starts here-->
				<xsl:with-param name="max_length">45</xsl:with-param>	
		<!--Changes for tracker 407920 ends here-->
		<xsl:with-param name="starshow">false</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="CorporateBO.Address.Address_Line3">
	<xsl:call-template name="label">
<!--Changes for call id 3399601 and recon of call id 95278 starts-->
	<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
<!--Changes for call id 399601 and recon of call id 395278 ends-->
		<xsl:with-param name="ele_name">CorporateBO.Address.Address_Line3</xsl:with-param>
		<xsl:with-param name="ele_val">CorporateBO.Address.Address_Line3</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.Address_Line3']" />
		<!--Changes for tracker 407920 Starts here-->
				<xsl:with-param name="max_length">45</xsl:with-param>	
		<!--Changes for tracker 407920 ends here-->
		<xsl:with-param name="starshow">false</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template name="CorporateBO.Address.Start_Date">
	<xsl:call-template name="label">
<!--Changes for call id 399601 and recon of call id 395278 starts-->
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
<!--Changes for call id 399601 and recon of call id 395278 endss-->
		<xsl:with-param name="ele_name">CorporateBO.Address.Start_Date</xsl:with-param>
		<xsl:with-param name="ele_val">CorporateBO.Address.Start_Date</xsl:with-param>
		<xsl:with-param name="fn_onBlur">validateIssueDate1()</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.Start_Date']" />
		
	</xsl:call-template>
</xsl:template>
<xsl:template name="CorporateBO.Address.city">
	<xsl:call-template name="lookup">
<!--Changes for call id 399601 and recon of call id 395278 starts-->
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
<!--Changes for call id 399601 and recon of call id 395278 ends-->
		<xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('CITY', 'CorporateBO.Address.city','city_code','CorporateBO.Address.state','CorporateBO.Address.country')</xsl:with-param>
		<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel" />
		
		<xsl:with-param name="buttontwo_fnc">clearLocValue('CorporateBO.Address.city','CITY')</xsl:with-param>
		<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel" />
		
		<xsl:with-param name="checkASCII">false</xsl:with-param>
		<xsl:with-param name="elename">CorporateBO.Address.city</xsl:with-param>
		<xsl:with-param name="eleval">CorporateBO.Address.city</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.city']" />
		
		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="CorporateBO.Address.state">
	<xsl:call-template name="lookup">
<!--Changes for call id 399601 and recon of call id 395278 starts-->
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
<!--Changes for call id 399601 and recon of call id 395278 ends-->
		<xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('STATE', 'CorporateBO.Address.state','state_code','CorporateBO.Address.city','CorporateBO.Address.country')</xsl:with-param>
		<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel" />		
		<xsl:with-param name="buttontwo_fnc">clearLocValue('CorporateBO.Address.state','STATE','CorporateBO.Address.city')</xsl:with-param>
		<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel" />		
		<xsl:with-param name="checkASCII">false</xsl:with-param>
		<xsl:with-param name="elename">CorporateBO.Address.state</xsl:with-param>
		<xsl:with-param name="eleval">CorporateBO.Address.state</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.state']" />		
		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="CorporateBO.Address.country">
	<xsl:call-template name="lookup">
<!--Changes for call id 399601 and recon of call id 395278 starts-->
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
<!--Changes for call id 399601 and recon of call id 395278 ends-->
		<xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('COUNTRY', 'CorporateBO.Address.country','country_code','CorporateBO.Address.state','CorporateBO.Address.city')</xsl:with-param>
		<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel" />		
		<xsl:with-param name="buttontwo_fnc">clearLocValue('CorporateBO.Address.country','COUNTRY','CorporateBO.Address.state','CorporateBO.Address.city')</xsl:with-param>
		<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel" />		
		<xsl:with-param name="checkASCII">false</xsl:with-param>
		<xsl:with-param name="code_req">true</xsl:with-param>
		<xsl:with-param name="elename">CorporateBO.Address.country</xsl:with-param>
		<xsl:with-param name="eleval">CorporateBO.Address.country</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.country']" />		
		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="CorporateBO.Address.zip">
	<xsl:call-template name="label">
		<xsl:with-param name="ele_name">CorporateBO.Address.zip</xsl:with-param>
		<xsl:with-param name="ele_val">CorporateBO.Address.zip</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Address.zip']" />
		<xsl:with-param name="fn_onBlur">fnAutoPopulate('CorporateBO.Address.zip','CorporateBO.Address.city','CorporateBO.Address.country','CorporateBO.Address.state','');</xsl:with-param>
		<xsl:with-param name="starshow">true</xsl:with-param>
<!--Changes for call id 399601 and recon of call id 395278 starts-->
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
<!--Changes for call id 399601 and recon of call id 395278 ends-->
	</xsl:call-template>
</xsl:template>
                    <!-- changes for the ticket 435611 starts -->
	
		     <xsl:template name="CorporateBO.legalEntity_Type">
		        <xsl:call-template name="mdrpdown">
		        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.legalEntity_Type_Code']"/>
		       
			        <xsl:with-param name="selectdisp">CorporateBO.legalEntity_Type_Code</xsl:with-param>
		        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.legalEntity_Type</xsl:with-param>
		        <xsl:with-param name="choice_name">CorporateBO.legalEntity_Type_Code</xsl:with-param>
		        <xsl:with-param name="max_length">30</xsl:with-param>
		        <xsl:with-param name="search_type">url</xsl:with-param>
		        
		        <xsl:with-param name="presdata" select="$PresData"/>
		       
		        </xsl:call-template>
        </xsl:template>
         <!-- changes for the ticket 435611 ends -->



		<xsl:template name="CorporateBO.PhoneEmail.PhoneEmailType">
			<xsl:call-template name="mdrpdown">
			<xsl:with-param name="res_name" select="$configLabels[@name='PREFERRED_PHONE']"/>
			<xsl:with-param name="selectname">CorporateBO.PhoneEmail.PhoneEmailType</xsl:with-param>
			<xsl:with-param name="selectdisp">CorporateBO.PhoneEmail.PhoneEmailType</xsl:with-param>
			<xsl:with-param name="search_type">value</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			<xsl:with-param name="presdata" select="$PresData"/>
			</xsl:call-template>
		</xsl:template>

		<xsl:template name="CorporateBO.PhoneEmail.PhoneEmailType1">
			<xsl:call-template name="mdrpdown">
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			<xsl:with-param name="res_name" select="$configLabels[@name='PREFERRED_EMAIL']"/>
			<xsl:with-param name="selectname">CorporateBO.PhoneEmail.PhoneEmailType1</xsl:with-param>
			<xsl:with-param name="selectdisp">CorporateBO.PhoneEmail.PhoneEmailType1</xsl:with-param>
			<xsl:with-param name="search_type">value</xsl:with-param>
			<xsl:with-param name="presdata" select="$PresData"/>
			</xsl:call-template>
		</xsl:template>
<xsl:template name="CorporateBO.PhoneEmail.PhoneNo">
	<xsl:call-template name="label">
		<!--<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>-->
		<xsl:with-param name="ele_name">CorporateBO.PhoneEmail.PhoneNo</xsl:with-param>
		<xsl:with-param name="ele_val">CorporateBO.PhoneEmail.PhoneNo</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.PhoneEmail.PhoneNo']" />
		
		<xsl:with-param name="showphonelabels">false</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="CorporateBO.PhoneEmail.Email">
	<xsl:call-template name="label">
		<!--<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>-->
		<xsl:with-param name="ele_name">CorporateBO.PhoneEmail.Email</xsl:with-param>
		<xsl:with-param name="ele_val">CorporateBO.PhoneEmail.Email</xsl:with-param>
		<xsl:with-param name="fn_onBlur">validateEmail(document.getElementsByName('CorporateBO.PhoneEmail.Email')[0])</xsl:with-param>
		<xsl:with-param name="isPhoneTemplateFlag">false</xsl:with-param>
		<xsl:with-param name="max_length">50</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.PhoneEmail.Email']" />
		
		<xsl:with-param name="showphonelabels">false</xsl:with-param>
	</xsl:call-template>
</xsl:template>
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

 	
 	
 		<xsl:template name="CorporateRepBO.entityKey">
			<xsl:call-template name="lookup">
				<xsl:with-param name="res_name" select="$configLabels[@name='CorporateRepBO.entityKey']"/>
				<xsl:with-param name="elename">CorporateRepBO.entityKey</xsl:with-param>
	<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : START -->
				<xsl:with-param name="eleval">CorporateRepBO.entityKey</xsl:with-param>
	<!-- Corp CIF changes for SaveSubmit LastEditedPage By Mamta : END -->
				<xsl:with-param name="max_length">30</xsl:with-param>
				<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
				<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
				<!--Look up CR changes -->
				<xsl:with-param name="buttonone_fnc">fnBluropenLastLookup("entityKey")</xsl:with-param>
				<!--Look up CR changes -->
				<xsl:with-param name="IsMandatory">false</xsl:with-param>
				<xsl:with-param name="starshow">true</xsl:with-param>
				<xsl:with-param name="buttontwo_fnc">clearLookupOne("entityKey")</xsl:with-param>
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
 	
 	
 	
 	
<!-- CODE ADDED BY KAMAL for tracker id 349409 -->
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
                                        
  <!-- CODE ADDED BY KAMAL for tracker id 349409 -->



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
<xsl:template name="CorporateRepBO.addressCateogry">
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


	 <xsl:template name="CorporateBO.sector">
	        <xsl:call-template name="mdrpdown">
	        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.sector']"/>
	        <!-- <xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.sector</xsl:with-param> -->
	        <xsl:with-param name="selectdisp">CorporateBO.sector</xsl:with-param>
	        <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.sector</xsl:with-param>
	        <xsl:with-param name="choice_name">CorporateBO.sector</xsl:with-param>
	        <xsl:with-param name="max_length">30</xsl:with-param>
	        <xsl:with-param name="search_type">url</xsl:with-param>
	        <!-- caching changes start -->
	        <xsl:with-param name="presdata" select="$PresData"/>
	        <!-- caching changes end -->
	        </xsl:call-template>
        </xsl:template>
        
        <!-- changes for the ticket 435611 starts -->
        <!--<xsl:template name="CorporateBO.Subsector_Code">
		<xsl:call-template name="mdrpdown">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.Subsector_Code']"/>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			<xsl:with-param name="selectDesc">CorporateBO.subSector</xsl:with-param>


			<xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.Subsector_Code</xsl:with-param>

			<xsl:with-param name="selectdisp">CorporateBO.Subsector_Code</xsl:with-param>
			<xsl:with-param name="choice_name">CorporateBO.Subsector_Code</xsl:with-param>
			<xsl:with-param name="search_type">url</xsl:with-param>
			<xsl:with-param name="max_length">30</xsl:with-param>
			<xsl:with-param name="presdata" select="$PresData"/>
		</xsl:call-template>
		</xsl:template>-->
       <!-- changes for the ticket 435611 ends -->

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
<xsl:template name="CorporateBO.trade_Services_Availed">
	<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.trade_Services_Availed']" />
		
		<xsl:with-param name="selectdisp">CorporateBO.trade_Services_Availed</xsl:with-param>
		<xsl:with-param name="selectname">CorporateBO.trade_Services_Availed</xsl:with-param>
		<xsl:with-param name="starshow">false</xsl:with-param>
	</xsl:call-template>
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
<xsl:template name="CorporateBO.RiskProfileScore">
	<xsl:call-template name="label">
		<xsl:with-param name="ele_name">CorporateBO.RiskProfileScore</xsl:with-param>
		<xsl:with-param name="ele_val">CorporateBO.RiskProfileScore</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.RiskProfileScore']" />
		
		<xsl:with-param name="starshow">false</xsl:with-param>
	</xsl:call-template>
</xsl:template>
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
   				<!--<xsl:with-param name="onchangefn">changeSubSeg();</xsl:with-param>-->
<!-- Core dependency changes end -->
				</xsl:call-template>
		</xsl:template>
<xsl:template name="MLHeader">
	<xsl:call-template name="label">
		<xsl:with-param name="ele_name">MLHeader</xsl:with-param>
		<xsl:with-param name="ele_val">MLHeader</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='MLHeader']" />
		
		<xsl:with-param name="starshow">false</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="MLHeader1">
	<xsl:call-template name="label">
		<xsl:with-param name="ele_name">MLHeader1</xsl:with-param>
		<xsl:with-param name="ele_val">MLHeader1</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='MLHeader1']" />
		
		<xsl:with-param name="starshow">false</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="MLHeader2">
	<xsl:call-template name="label">
		<xsl:with-param name="ele_name">MLHeader2</xsl:with-param>
		<xsl:with-param name="ele_val">MLHeader2</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='MLHeader2']" />
		
		<xsl:with-param name="starshow">false</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="MLHeader3">
	<xsl:call-template name="label">
		<xsl:with-param name="ele_name">MLHeader3</xsl:with-param>
		<xsl:with-param name="ele_val">MLHeader3</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='MLHeader3']" />
		
		<xsl:with-param name="starshow">false</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="MLHeader4">
	<xsl:call-template name="label">
		<xsl:with-param name="ele_name">MLHeader4</xsl:with-param>
		<xsl:with-param name="ele_val">MLHeader4</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='MLHeader4']" />
		
		<xsl:with-param name="starshow">false</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template mode="mode1" match="*">
<xsl:call-template name="Begin"></xsl:call-template>
<!--  START  Changes for Tracker # 209607 -->
        <p id="myPar"></p>
<!--  END  Changes for Tracker # 209607 -->
 <!-- Naved Changes start -->
<td><form name="frm2" method="post" action="">

           <IFRAME name="hdifrm_empform" width="0" height="0" src="../common/html/SSOblank.html"/>
	   <!-- frame added for population of corporate fields -->
	   <IFRAME name="hdifrm_rescifid" width="0" height="0" src="../common/html/SSOblank.html"/>

         <input type="hidden" name="addr_city_code" value=""/>
	<input type="hidden" name="addr_state_code" value=""/>
	<input type="hidden" name="addr_cntry_code" value=""/>
	       <input type="hidden" name="prim_id" value=""/>
<!--Changes for call id 394250 starts-->
	<input type="hidden" name="currencyCode" value="{$currencyCode}" />
<!--Changes for call id 394250 ends-->
	<!--Changes for call id 334833 STARTS-->
	<input type="hidden" name="hid_reservestatus" value=""/>
	<!--Changes for call id 334833 ENDS-->
	<input type="hidden" name="altLocaleActv" value="{$altLocaleActv}"/>
        <input name="country_code" type="hidden" value="{$country_code}"/>
	<input name="state_code" type="hidden" value="{$state_code}"/>
	<input name="city_code" type="hidden" value="{$city_code}"/>
	<input name="entityType" type="hidden" value="{$entityType}" />
	<input name="entityKey" type="hidden" value="{$entityKey}" />
	<input type="hidden" name="hid_corporateURL" value="{$corporateURL}"/>
	<input type="hidden" name="EntityDocumentBO.DocTypeDescr" value=""/>	
	<input type="hidden" name="EntityDocumentBO.DocDescr" value=""/>
	<!--changes for call id 371085 and recon of call id 369315 starts -->
	<input type="hidden" name="hidIdentificationType" value="{$identification_Type}"/>
	<!--changes for call id 371085 and recon of call id 369315 ends -->
	<input type="hidden" name="date_Of_Incorporation" value=""/>
	<input type="hidden" name="RiskProfileExpiryDate" value=""/>
	<input type="hidden" name="isMCEdited" value="{$isMCEdited}"/>
	<input type="hidden" name="mcJNDIFlag" value="{$mcJNDIFlag}"/>
	<input type="hidden" name="getMCRequired" value="{$getMCRequired}"/>
	<input type="hidden" name="isMCEditedGeneral" value="N"/>
	<input type="hidden" name="IntWFID" value="{$IntWFID}"/>
	<input type="hidden" value="{$isAutoGenKey}" name="isAutoGenKey"/>
	<input type="hidden" value="{$ALTCALENDAR_TYPE}" name="ALTCALENDAR_TYPE"/>
	<input type="hidden" name="zip" value=""/>
        <input type="hidden" name="PhoneOrEmail" value=""/>
	<input type="hidden" name="PhoneNoCountryCode" value=""/>
	<input type="hidden" name="PhoneNoCityCode" value=""/>
	<input type="hidden" name="PhoneNoLocalCode" value=""/>
	<input type="hidden" name="PhoneNo" value=""/>
	<input type="hidden" name="PhoneEmailID" value=""/>
	<input type="hidden" name="PhoneEmailType" value=""/>
	<input type="hidden" name="Email" value=""/>
					<input type="hidden" name="AddressLine1" value=""/>
					<input type="hidden" name="AddressLine2" value=""/>
				<input type="hidden" name="AddressLine3" value=""/>
		<input type="hidden" name="address_type" value=""/>
     <input type="hidden" name="addType" value=""/>
     				<input type="hidden" name="apprFlag" value="{$apprFlag}"/>
      <input type="hidden" name="hidCorprepID" value=""/>
	
	<!--<xsl:call-template name="Begin" />
		<xsl:call-template name="LOOKUP" />
		<xsl:call-template name="CLEAR" />-->
	<xsl:call-template name="End" />
	
      <!--  <xsl:call-template name="apply">
	<xsl:with-param name="apply_head"><b><xsl:value-of select="'Basic Details'" /></b></xsl:with-param>
        </xsl:call-template>-->
           <xsl:call-template name="Begin"/>
	               		<xsl:call-template name="CorporateBO.corp_Key"/>
	               		<xsl:call-template name="CorporateBO.legalEntity_Type"/>
       	 <xsl:call-template name="End"/>
       	 
       	  	
	<xsl:call-template name="Begin" />
		<xsl:call-template name="CorporateBO.corporate_Name" />
		<xsl:call-template name="CorporateBO.short_Name" />
	<xsl:call-template name="End" />
	
	<xsl:call-template name="Begin" />
		<xsl:call-template name="CorporateBO.date_Of_Incorporation" />
		<xsl:call-template name="EntityDocumentBO.ReferenceNumber" />
	<xsl:call-template name="End" />
	
	<xsl:call-template name="Begin" />

			<xsl:call-template name="EntityDocumentBO.DocTypeCode" />
			<xsl:call-template name="EntityDocumentBO.DocCode" />
	<xsl:call-template name="End" />
		
	<xsl:call-template name="apply">
		<xsl:with-param name="apply_head"><b><xsl:value-of select="'Contact Details'" /></b></xsl:with-param>
        </xsl:call-template>
	
	  	<!-- <xsl:call-template name="Begin"/>
   	 	<xsl:call-template name="CorporateBO.registration_Number"/>
  	 <xsl:call-template name="End"/>-->
	<xsl:call-template name="Begin" />
		<xsl:call-template name="CorporateBO.Address.Address_Line1" />
		<xsl:call-template name="CorporateBO.Address.Address_Line2" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="CorporateBO.Address.Address_Line3" />
		<xsl:call-template name="CorporateBO.Address.city" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="CorporateBO.Address.state" />
		<xsl:call-template name="CorporateBO.Address.country" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="CorporateBO.Address.zip" />
		<xsl:call-template name="CorporateBO.Address.Start_Date" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="CorporateBO.PhoneEmail.PhoneEmailType" />
		<xsl:call-template name="CorporateBO.PhoneEmail.PhoneNo" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="CorporateBO.PhoneEmail.PhoneEmailType1" />
		<xsl:call-template name="CorporateBO.PhoneEmail.Email" />
	<xsl:call-template name="End" />
	<xsl:call-template name="apply">
			<xsl:with-param name="apply_head"><b><xsl:value-of select="'Corporate Representative Details'" /></b></xsl:with-param>
        </xsl:call-template>
	<xsl:call-template name="Begin" />
		<xsl:call-template name="CorporateRepBO.entity_Type"/>
		<xsl:call-template name="CorporateRepBO.entityKey" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="CorporateRepBO.designation" />
		<xsl:call-template name="CorporateRepBO.cifAddrEntity" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="CorporateRepBO.addressCateogry" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
	<xsl:call-template name="apply">
	<xsl:with-param name="apply_head"><b><xsl:value-of select="'Other Details'" /></b></xsl:with-param>
       </xsl:call-template>
	<xsl:call-template name="Begin" />
	     <xsl:call-template name="CorporateBO.sector" />
	     <xsl:call-template name="CorporateBO.primary_Service_Center" />
		<!--<xsl:call-template name="CorporateBO.Subsector_Code" />-->
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
	        
		<xsl:call-template name="CorporateBO.segment" />
		
	<xsl:call-template name="End" />
	<!--<xsl:call-template name="CorporateBO.trade_Services_Availed" />
			
			<xsl:call-template name="CorporateBO.subSegment"/>-->
	<xsl:call-template name="End" />
	<xsl:call-template name="apply">
		<xsl:with-param name="apply_head"><b><xsl:value-of select="'Bank Defined Details for CIF'" /></b></xsl:with-param>
       </xsl:call-template>
	<xsl:call-template name="Begin"/>
		<xsl:call-template name="CorporateBO.PrimaryRMLogin_ID">
		<xsl:with-param name="ele_name">CorporateBO.PrimaryRMLogin_ID</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="CorporateBO.SecondRMLogin_ID">
		<xsl:with-param name="ele_name">CorporateBO.SecondRMLogin_ID</xsl:with-param>
		</xsl:call-template>
	<xsl:call-template name="End"/>
	<xsl:call-template name="Begin" />
	<xsl:call-template name="CorporateBO.RiskProfileScore" />
		
		<!--<xsl:call-template name="MLHeader" />-->
	<xsl:call-template name="End" />
	<!--<xsl:call-template name="Begin" />
		<xsl:call-template name="MLHeader1" />
		<xsl:call-template name="MLHeader2" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="MLHeader3" />
		<xsl:call-template name="MLHeader4" />
	<xsl:call-template name="End" />-->
	<!--<xsl:call-template name="Begin" />
		
		<xsl:call-template name="CorporateBO.PhoneEmail.PhoneNoCityCode" />
	<xsl:call-template name="End" />
	<xsl:call-template name="Begin" />
		<xsl:call-template name="CorporateBO.PhoneEmail.PhoneNoCountryCode" />
		

	<xsl:call-template name="addemptycell" />
	<xsl:call-template name="End" />-->
	</form>
</td>
<xsl:call-template name="End"></xsl:call-template>
</xsl:template><xsl:template match="SRM">
<xsl:for-each select=".">
<xsl:call-template name="startTable"></xsl:call-template>
<table width="100%" vspace="0" hspace="0" cellspacing="0" cellpadding="2" border="0">
<tr>
 <xsl:call-template name="apply">
	<xsl:with-param name="apply_head"><b><xsl:value-of select="'Basic Details'" /></b></xsl:with-param>
        </xsl:call-template>
</tr>
</table>
<table width="100%" cellspacing="0" cellpadding="2" border="0">
<xsl:apply-templates select="." mode="mode1"></xsl:apply-templates>
</table>
<xsl:call-template name="endTable"></xsl:call-template>
</xsl:for-each>
</xsl:template></xsl:stylesheet>
