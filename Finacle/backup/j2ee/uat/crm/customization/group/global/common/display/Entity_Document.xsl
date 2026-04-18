<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="../Renderer/common/display/getJVMProperties.xsl"/>
	<xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"/>
	<xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"/>

	<xsl:param name="locale"/>
 	<!--ticket id 209960 tracker id 125299 starts-->
	    <xsl:param name="altLocaleType"/>
	    <xsl:param name="baseLocaleType"/>
	    <xsl:param name="altLocaleActv"/>
	<!--ticket id 209960 tracker id 125299 ends-->  	
	<xsl:param name="configFileName"/>
	<xsl:variable name="configFile" select="document(concat($configFileName,''))"/>

	<xsl:variable name="configLabels" select="$configFile/SRMBO/*"/>

	<xsl:variable name="customfields" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z"/>
	<xsl:variable name="CustomerURL" select="$customfields[@n='CorporateBO.url_']"/>
	<xsl:variable name="allfields" select="//SRMData//Z"/>
	<xsl:variable name="readMode" select="$customfields[@n='IsReadOnly']"/>
	<xsl:variable name="mode" select="$customfields[@n='mode']"/>
	<xsl:variable name="docExpiryDate" select="$customfields[@n='EntityDocumentBO.DocExpiryDate']"/>
	<xsl:variable name="identification_Type" select="$customfields[@n='EntityDocumentBO.IdentificationType']"/>
	<xsl:variable name="placeofissue" select="$customfields[@n='EntityDocumentBO.placeofissue']"/>
<!--changes for recon -->
	<xsl:variable name="cat_placeofissue" select="$customfields[@n='EntityDocumentBO.PlaceOfIssue_cat']"/>
	<xsl:variable name="countryofissue" select="$customfields[@n='EntityDocumentBO.CountryOfIssue']"/>
	<xsl:variable name="doc_Type" select="$customfields[@n='doc_Type']"/>
	<xsl:variable name="docCode" select="$customfields[@n='docCode']"/>
	<xsl:variable name="isExpiryDateMandatory" select="$customfields[@n='isExpiryDateMandatory']"/>
	<xsl:variable name="docType_docCode" select="$customfields[@n='docType_docCode']"/>
	<!-- Ticket 359180 Changes Start-->
	<xsl:variable name="doc_TypeDesc_Old" select="$customfields[@n='doc_TypeDesc']"/>
	<xsl:variable name="docCode_docDesc_Old" select="$customfields[@n='docCode_docDesc']"/>
	<!-- Ticket 359180 Changes end-->
	<xsl:variable name="docCode_IDType" select="$customfields[@n='docCode_IDType']"/>
	<xsl:variable name="docCode_CIFType" select="$customfields[@n='docCode_CIFType']"/>
	<xsl:variable name="choice_nameIDType" select="$customfields[@n='choice_nameIDType']"/>
	<!-- Call id 433921 Changes Start-->
	<xsl:variable name="incorporationDate1" select="$customfields[@n='incorporationDate1']"/>
	<!-- Call id 433921 Changes End-->
	<xsl:variable name="fromProcess" select="$customfields[@n='fromProcess']"/>
	<xsl:variable name="strDocCode" select="$customfields[@n='EntityDocumentBO.DocCode']"/>
	<xsl:variable name="idIssuedOrg" select="$customfields[@n='EntityDocumentBO.IDIssuedOrganisation']"/>

	<!-- Tracker 113227 Changes Start-->
	<!-- Ticket 359180 Changes Start-->
	<xsl:variable name="doc_TypeDesc_alt1_Old" select="$customfields[@n='EntityDocumentBO.DocTypeDescr_alt1']"/>	
	<xsl:variable name="docCode_docDesc_alt1_Old" select="$customfields[@n='EntityDocumentBO.DocDescr_alt1']"/>
	
	<!-- Tracker 113227 Changes End-->
	<xsl:variable name="Entity_doc_TypeDesc_Old" select="$customfields[@n='EntityDocumentBO.DocTypeDescr']"/>	
	<xsl:variable name="Entity_docCode_docDesc_Old" select="$customfields[@n='EntityDocumentBO.DocDescr']"/>

<xsl:variable name="doc_TypeDesc"> 
                <xsl:call-template name="replace-string"> 
                  <xsl:with-param name="text" select="$doc_TypeDesc_Old"/> 
                  <xsl:with-param name="from">'</xsl:with-param> 
                  <xsl:with-param name="to">\'</xsl:with-param> 
                </xsl:call-template> 
    </xsl:variable> 
<xsl:variable name="docCode_docDesc"> 
                <xsl:call-template name="replace-string"> 
                  <xsl:with-param name="text" select="$docCode_docDesc_Old"/> 
                  <xsl:with-param name="from">'</xsl:with-param> 
                  <xsl:with-param name="to">\'</xsl:with-param> 
                </xsl:call-template> 
    </xsl:variable>
    
    <xsl:variable name="doc_TypeDesc_alt1"> 
                    <xsl:call-template name="replace-string"> 
                      <xsl:with-param name="text" select="$doc_TypeDesc_alt1_Old"/> 
                      <xsl:with-param name="from">'</xsl:with-param> 
                      <xsl:with-param name="to">\'</xsl:with-param> 
                    </xsl:call-template> 
        </xsl:variable> 
    <xsl:variable name="docCode_docDesc_alt1"> 
                    <xsl:call-template name="replace-string"> 
                      <xsl:with-param name="text" select="$docCode_docDesc_alt1_Old"/> 
                      <xsl:with-param name="from">'</xsl:with-param> 
                      <xsl:with-param name="to">\'</xsl:with-param> 
                    </xsl:call-template> 
    </xsl:variable> 
    <xsl:variable name="Entity_doc_TypeDesc"> 
                        <xsl:call-template name="replace-string"> 
                          <xsl:with-param name="text" select="$Entity_doc_TypeDesc_Old"/> 
                          <xsl:with-param name="from">'</xsl:with-param> 
                          <xsl:with-param name="to">\'</xsl:with-param> 
                        </xsl:call-template> 
    </xsl:variable> 
    <xsl:variable name="Entity_docCode_docDesc"> 
                        <xsl:call-template name="replace-string"> 
                          <xsl:with-param name="text" select="$Entity_docCode_docDesc_Old"/> 
                          <xsl:with-param name="from">'</xsl:with-param> 
                          <xsl:with-param name="to">\'</xsl:with-param> 
                        </xsl:call-template> 
    </xsl:variable> 
<!-- Ticket 359180 Changes end-->


<!-- caching changes start -->
	<xsl:param name="viewname"/>
	<xsl:variable name="PresFileName">../servlet/com.infy.cis.ui.corpcif.CorpCIF_DetPresCacheServlet?ViewName=<xsl:value-of select="$viewname"/>&amp;Locale=<xsl:value-of select="$locale"/></xsl:variable>
	<xsl:variable name="PresFile" select="document(concat($PresFileName,''))"/>
	<xsl:variable name="PresData" select="$PresFile/SRM/SRMPresentation"/>
<!-- caching changes end -->

	<xsl:template match="/">
	<html>
	<title><xsl:value-of select="//SRMPresentation/SRMSystem[@n='Strings']/SRMString[@n='Title']/@value"/></title>
	<head>
		<script type="text/javascript" src="../corpcif/js/Message_corpcif_{$locale}.js" language="javascript"></script>
		<!--Tracker:161726 begin-->
		<script type="text/javascript" src="../common/js/Message_common_{$locale}.js" language="javascript"></script>
		<!--Tracker:161726 end-->
		<script>
			var locale = '<xsl:value-of select="$locale"/>';
			<!--ticket id 209960 tracker id 125299 starts-->
			
			 		/*ticket id 219597 tracker id 132339 changes starts*/
					var dualflag=1;
			   		/*ticket id 219597 tracker id 132339 changes ends*/
			   
					var altLocaleType = '<xsl:value-of select="$altLocaleType"/>';
					var baseLocaleType = '<xsl:value-of select="$baseLocaleType"/>';
					var altLocaleActv = '<xsl:value-of select="$altLocaleActv"/>';
					 var locale = '<xsl:value-of select="$locale"/>';
					if (altLocaleActv=="true"){
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
					 /*ticket id 219597 tracker id 132339 changes starts*/
			
               			<!--ticket id 209960 tracker id 125299 starts-->
		</script>
		<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
		<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/SRMTableDisplay_{$locale}.css"/>
		
		<script type="text/javascript" src="/FinacleCRM/Customization/common/js/Entity_Document.js" language="javascript"></script>
		<SCRIPT LANGUAGE='javascript' SRC='../common/js/FieldValidate.js'></SCRIPT>
		<!--Tracker 113227 Changes start-->
		<!--Tracker 113227 Changes End-->

		<script type="text/javascript" language="javascript">
		//Change for ticket 363466 start
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
			<!-- Changes for the ticketid:365866 Starts -->
			strTempArr = decodeURIComponent(strTempArr);
			<!-- Changes for the ticketid:365866 Ends -->
			return strTempArr;
			}
	     		]]>
	     		//Change for ticket 363466 end
			var curDate = new Date();
			var curDay = curDate.getDate();
			var curMonth = curDate.getMonth()+1;
			var curYear = curDate.getYear();
			var mode ='<xsl:value-of select="$mode"/>';
			var strDocCode ='<xsl:value-of select="$strDocCode"/>';
<!--			var identification_Type = '<xsl:value-of select="$identification_Type"/>';-->
			var placeofissue = '<xsl:value-of select="$placeofissue"/>';
<!-- changes for recon -->
			var cat_placeofissue = '<xsl:value-of select="$cat_placeofissue"/>';
			var countryofissue = '<xsl:value-of select="$countryofissue"/>';

			var choice_nameIDType = '<xsl:value-of select="$choice_nameIDType"/>';
	<!-- Call id 433921 Changes Start-->
			var incorporationDate1 = '<xsl:value-of select="$incorporationDate1"/>';
	<!-- Call id 433921 Changes End-->
			var CIF_Type=null;
			if(choice_nameIDType=="IDENT_TYPE")
			{
				CIF_Type="Retail";
			}
			if(choice_nameIDType=="ID_TYPE")
			{
				CIF_Type="Corporate";
			}
			var indexOfDtOfIssCalender=0;
			var doc_Type = '<xsl:value-of select="$doc_Type"/>';
			var docCode = '<xsl:value-of select="$docCode"/>';
			var docExpiryDate = '<xsl:value-of select="$docExpiryDate"/>';
			var fromProcess = '<xsl:value-of select="$fromProcess"/>';
			var isExpiryDateMandatory = '<xsl:value-of select="$isExpiryDateMandatory"/>';
			<!--Change for ticket 363466 start -->
			var docType_docCode = '<xsl:value-of select="$docType_docCode"/>';
			var doc_TypeDesc = decodeSpecialCharsXML('<xsl:value-of select="$doc_TypeDesc"/>');
			var docCode_docDesc=decodeSpecialCharsXML('<xsl:value-of select="$docCode_docDesc"/>');
			<!--Change for ticket 363466 end -->
			var docCode_IDType='<xsl:value-of select="$docCode_IDType"/>';
			var docCode_CIFType='<xsl:value-of select="$docCode_CIFType"/>';
			
			<!-- Tracker 113227 Changes Start-->
			<!--Change for ticket 363466 start -->
			var doc_TypeDesc_alt1 = decodeSpecialCharsXML('<xsl:value-of select="$doc_TypeDesc_alt1"/>');
			var docCode_docDesc_alt1 = decodeSpecialCharsXML('<xsl:value-of select="$docCode_docDesc_alt1"/>');
			<!--Change for ticket 363466 end -->			
			<!-- Tracker 113227 Changes End-->
			
			var arraydoc_Type = new Array();
			var docCodearr = new Array();
			var isExpiryDateMandatoryarr = new Array();
			var docType_docCodearr=new Array();
			var doc_TypeDescarr=new Array();
			var docCode_docDescarr=new Array();
 			
			<!-- Tracker 113227 Changes Start-->
			
			var doc_TypeDescarr_alt1=new Array();
			var docCode_docDescarr_alt1=new Array();
			
			<!-- Tracker 113227 Changes End-->			
	
			var docCode_IDTypearr=new Array();
			var docCode_CIFTypearr=new Array();
			var elemStr;
			elemStr = new String(doc_Type);
			if (elemStr!= ""){
				arraydoc_Type= elemStr.split("|");
			}
			elemStr = new String(docCode);
			if (elemStr!= ""){
				docCodearr= elemStr.split("|");
			}
			
			elemStr = new String(isExpiryDateMandatory);
			if (elemStr!= ""){
				isExpiryDateMandatoryarr= elemStr.split("|");
			}
			elemStr = new String(docType_docCode);
			<!-- Changes for the ticketid:365866 Starts -->
			if (elemStr!= ""){
				docType_docCodearr= elemStr.split("$");
			<!-- Changes for the ticketid:365866 Ends -->
			}
			elemStr = new String(doc_TypeDesc);
			if (elemStr!= ""){
				doc_TypeDescarr= elemStr.split("|");
			}
			
			elemStr = new String(docCode_docDesc);
			if (elemStr!= ""){
				docCode_docDescarr= elemStr.split("|");
			}
 			
			<!-- Tracker 113227 Changes Start-->
			
			elemStr = new String(doc_TypeDesc_alt1);
			if (elemStr!= ""){
				doc_TypeDescarr_alt1= elemStr.split("|");
			}
			
			elemStr = new String(docCode_docDesc);
			if (elemStr!= ""){
				docCode_docDescarr_alt1= elemStr.split("|");
			}
			
			<!-- Tracker 113227 Changes End-->
			
			elemStr = new String(docCode_IDType);
			if (elemStr!= ""){
				docCode_IDTypearr= elemStr.split("|");
			}
			elemStr = new String(docCode_CIFType);
			if (elemStr!= ""){
				docCode_CIFTypearr= elemStr.split("|");
			}
			function enableFields(){
				document.getElementsByName("EntityDocumentBO.DocDescr")[0].readOnly = true;
				document.getElementsByName("EntityDocumentBO.DocTypeDescr")[0].readOnly = true;
			}
			
			<!-- TRACKER ID 108387 begin changes for close button -->
			function cancel()
			{
				// Fix for Ticket: 207304 STARTS
								
				//if ( !this.parent.parent.showConfirmMessage("Are you sure you want to close this operation?")) {
				if ( !this.parent.parent.showConfirmMessage(MSG022)) {
					return;
				}
								
				// Fix for Ticket: 207304 ENDS
			 
			   try {
					window.close();
					window.opener.focus();
				}catch(e) {
				}
			}
			<!-- TRACKER ID 108387 end changes for close button -->

			function ChangeStatusDate(recStatus)
			{
//alert('in entitydoc xsl::ChangeStatusDaterec>>Status: ' + recStatus);
//alert('docExpiryDate: ' + docExpiryDate);
				document.getElementsByName("3_EntityDocumentBO.DocExpiryDate")[0].IsMandatory="false";
				document.getElementsByName("mandStarEntityDocumentBO.DocExpiryDate")[0].style.visibility="hidden";
				document.getElementsByName("EntityDocumentBO.DocRemarks")[0].IsMandatory="false";
				document.getElementsByName("mandStarEntityDocumentBO.DocRemarks")[0].style.visibility="hidden";
				document.getElementsByName("EntityDocumentBO.ReferenceNumber")[0].IsMandatory="false";
				document.getElementsByName("mandStarEntityDocumentBO.ReferenceNumber")[0].style.visibility="hidden";
				//alert('333: making PlaceOfIssue non mandatory');
				document.getElementsByName("Cat_EntityDocumentBO.PlaceOfIssue")[0].IsMandatory="false";
				document.getElementsByName("mandStarEntityDocumentBO.PlaceOfIssue")[0].style.visibility="hidden";
				//alert('336: making PlaceOfIssue non mandatory');
				document.getElementsByName("Cat_EntityDocumentBO.CountryOfIssue")[0].IsMandatory="false";
				document.getElementsByName("mandStarEntityDocumentBO.CountryOfIssue")[0].style.visibility="hidden";
				document.getElementsByName("3_EntityDocumentBO.DocIssueDate")[0].IsMandatory="false";
				document.getElementsByName("mandStarEntityDocumentBO.DocIssueDate")[0].style.visibility="hidden";
				//alert('340: making PlaceOfIssue non mandatory');

				document.getElementsByName("3_EntityDocumentBO.DocReceivedDate")[0].IsMandatory="false";
				document.getElementsByName("mandStarEntityDocumentBO.DocReceivedDate")[0].style.visibility="hidden";
//				document.getElementsByName('3_EntityDocumentBO.DocReceivedDate')[0].value = "";
				document.getElementsByName('3_EntityDocumentBO.DocReceivedDate')[0].readOnly = true;
				document.getElementsByTagName("img")[indexOfDtOfIssCalender+3].style.visibility='hidden';
				//alert('347: making PlaceOfIssue non mandatory');

				document.getElementsByName("3_EntityDocumentBO.WaivedOrDeferedDate")[0].IsMandatory="false";
				document.getElementsByName("mandStarEntityDocumentBO.WaivedOrDeferedDate")[0].style.visibility="hidden";
				document.getElementsByName('3_EntityDocumentBO.WaivedOrDeferedDate')[0].value = "";
				document.getElementsByName('3_EntityDocumentBO.WaivedOrDeferedDate')[0].readOnly = true;
				document.getElementsByTagName("img")[indexOfDtOfIssCalender+4].style.visibility='hidden';
				<!-- change for callid 392983 begins -->
                                document.getElementsByName("3_EntityDocumentBO.DocDueDate")[0].IsMandatory="false";
				document.getElementsByName("mandStarEntityDocumentBO.DocDueDate")[0].style.visibility="hidden";
				<!-- change for callid 392983 ends -->
				//alert('358: making PlaceOfIssue non mandatory');
				var statusObj = document.getElementsByName('EntityDocumentBO.Status')[0];
				document.getElementsByName("EntityDocumentBO.Scanned")[0].disabled = true;
				//alert('361: recStatus:'+recStatus);

			  if(recStatus.toUpperCase() == "RECEIVED") {
				    document.getElementsByName("EntityDocumentBO.Scanned")[0].disabled = false;

					document.getElementsByName('3_EntityDocumentBO.DocReceivedDate')[0].readOnly = false;
					document.getElementsByTagName("img")[indexOfDtOfIssCalender+3].style.visibility='visible';
					document.getElementsByName("3_EntityDocumentBO.DocReceivedDate")[0].IsMandatory="true";
					document.getElementsByName("mandStarEntityDocumentBO.DocReceivedDate")[0].style.visibility="visible";
					strDocRecvDate=document.getElementsByName('3_EntityDocumentBO.DocReceivedDate')[0].value;
					if(strDocRecvDate=='' || strDocRecvDate=='null' || strDocRecvDate==null || strDocRecvDate=='undefined'){
						document.getElementsByName('3_EntityDocumentBO.DocReceivedDate')[0].value = getTodayDate();
					}
					document.getElementsByName('3_EntityDocumentBO.DocReceivedDate')[0].focus();

					if(boolIsExpDtMand==true){
						//Changes begin for tracker id: 242179
						document.getElementsByName("3_EntityDocumentBO.DocExpiryDate")[0].readOnly = false;
						document.getElementsByTagName("img")[indexOfDtOfIssCalender+1].style.visibility='visible';
						document.getElementsByTagName("img")[1].style.display='';
                        			//Changes end for tracker id: 242179
						document.getElementsByName("3_EntityDocumentBO.DocExpiryDate")[0].IsMandatory="true";
						document.getElementsByName("mandStarEntityDocumentBO.DocExpiryDate")[0].style.visibility="visible";
					}
					document.getElementsByName("EntityDocumentBO.ReferenceNumber")[0].IsMandatory="true";
					document.getElementsByName("mandStarEntityDocumentBO.ReferenceNumber")[0].style.visibility="visible";
					//alert('382:: making placeofissue mandatory');
					document.getElementsByName("Cat_EntityDocumentBO.PlaceOfIssue")[0].IsMandatory="true";
					document.getElementsByName("mandStarEntityDocumentBO.PlaceOfIssue")[0].style.visibility="visible";
					document.getElementsByName("Cat_EntityDocumentBO.CountryOfIssue")[0].IsMandatory="true";
					document.getElementsByName("mandStarEntityDocumentBO.CountryOfIssue")[0].style.visibility="visible";
					document.getElementsByName("3_EntityDocumentBO.DocIssueDate")[0].IsMandatory="true";
					document.getElementsByName("mandStarEntityDocumentBO.DocIssueDate")[0].style.visibility="visible";
			  }
			  else if(recStatus.toUpperCase() == "WAIVED"|| recStatus.toUpperCase() == "DEFERRED") {
			  //alert('392::in waived');
					document.getElementsByName("EntityDocumentBO.Scanned")[0].selectedIndex = 0;
					document.getElementsByName('3_EntityDocumentBO.DocReceivedDate')[0].value="";
					//khushi changes
					//alert('395:: making placeofissue non mandatory');
				document.getElementsByName("Cat_EntityDocumentBO.PlaceOfIssue")[0].IsMandatory="false";
				document.getElementsByName("mandStarEntityDocumentBO.PlaceOfIssue")[0].style.visibility="hidden";
				document.getElementsByName("Cat_EntityDocumentBO.CountryOfIssue")[0].IsMandatory="false";
				document.getElementsByName("mandStarEntityDocumentBO.CountryOfIssue")[0].style.visibility="hidden";
				
					document.getElementsByName('3_EntityDocumentBO.WaivedOrDeferedDate')[0].readOnly = false;
					document.getElementsByTagName("img")[indexOfDtOfIssCalender+4].style.visibility='visible';
					document.getElementsByName("3_EntityDocumentBO.WaivedOrDeferedDate")[0].IsMandatory="true";
					document.getElementsByName("mandStarEntityDocumentBO.WaivedOrDeferedDate")[0].style.visibility="visible";
					document.getElementsByName('3_EntityDocumentBO.WaivedOrDeferedDate')[0].value = getTodayDate();
					document.getElementsByName('3_EntityDocumentBO.WaivedOrDeferedDate')[0].focus();

					document.getElementsByName("EntityDocumentBO.DocRemarks")[0].IsMandatory="true";
					document.getElementsByName("mandStarEntityDocumentBO.DocRemarks")[0].style.visibility="visible";
					<!-- change for callid 392983 begins -->
					if(recStatus.toUpperCase() == "DEFERRED") {
					document.getElementsByName("3_EntityDocumentBO.DocDueDate")[0].IsMandatory="true";
					document.getElementsByName("mandStarEntityDocumentBO.DocDueDate")[0].style.visibility="visible";
					document.getElementsByName('3_EntityDocumentBO.DocDueDate')[0].readOnly = false;
					document.getElementsByTagName("img")[indexOfDtOfIssCalender+4].style.visibility='true';
					}
			                <!-- change for callid 392983 ends -->
			  }
			  else{
					document.getElementsByName('3_EntityDocumentBO.DocReceivedDate')[0].value="";
					document.getElementsByName("EntityDocumentBO.Scanned")[0].selectedIndex = 0;
					 //Changes for Tracker ID 430228 - TOL 414857 starts
					 //Khushi changes
						/*
					//alert('425:: making placeofissue mandatory');
						document.getElementsByName("EntityDocumentBO.PlaceOfIssue")[0].IsMandatory="true";
						document.getElementsByName("mandStarEntityDocumentBO.PlaceOfIssue")[0].style.visibility="visible";				
		
						document.getElementsByName("EntityDocumentBO.CountryOfIssue")[0].IsMandatory="true";
						document.getElementsByName("mandStarEntityDocumentBO.CountryOfIssue")[0].style.visibility="visible";	*/	
				
						document.getElementsByName("EntityDocumentBO.ReferenceNumber")[0].IsMandatory="true";
						document.getElementsByName("mandStarEntityDocumentBO.ReferenceNumber")[0].style.visibility="visible";
						
						document.getElementsByName("3_EntityDocumentBO.DocIssueDate")[0].IsMandatory="true";
						document.getElementsByName("mandStarEntityDocumentBO.DocIssueDate")[0].style.visibility="visible";
						if(boolIsExpDtMand==true){
					
						document.getElementsByName("3_EntityDocumentBO.DocExpiryDate")[0].readOnly = false;
						document.getElementsByTagName("img")[indexOfDtOfIssCalender+1].style.visibility='visible';
						document.getElementsByTagName("img")[1].style.display='';
                        		
						document.getElementsByName("3_EntityDocumentBO.DocExpiryDate")[0].IsMandatory="true";
						document.getElementsByName("mandStarEntityDocumentBO.DocExpiryDate")[0].style.visibility="visible";
					}
					
					 //Changes for Tracker ID 430228 - TOL 414857 ends
			  }
			  statusObj.oldSelection = statusObj.selectedIndex;
			}

			function bodyload(){
				try {
<!-- changes for recon -->
				document.getElementsByName('EntityDocumentBO.PlaceOfIssue')[0].value=placeofissue;
				document.getElementsByName('Cat_EntityDocumentBO.PlaceOfIssue')[0].value=cat_placeofissue;
				<!-- Changes for the ticketid:376621 Starts -->
				var remarks = document.getElementsByName('EntityDocumentBO.DocRemarks')[0].value;
				if(remarks != null &amp;&amp; remarks != ""){
					document.getElementsByName('EntityDocumentBO.DocRemarks')[0].value = decodeSpecialCharsXML(remarks);
				}
				<!-- Changes for the ticketid:376621 Ends-->
//					alert('inside bodyload');
//					alert('fromProcess: ' + fromProcess);
					disableFields();
					if(fromProcess=="Y"){
						var status = document.getElementsByName("EntityDocumentBO.Status")[0].value;
//						alert('status: ' + status);
						ChangeStatusDate(status);
						/*For testing*/
						try{
						document.getElementsByName("EntityDocumentBO.DocDescr")[0].disabled = true;
						document.getElementsByName("EntityDocumentBO.DocTypeCode")[0].disabled = true;
						document.getElementsByName("EntityDocumentBO.DocCode")[0].disabled = true;
						document.getElementsByName("EntityDocumentBO.DocTypeDescr")[0].disabled = true;
						document.getElementsByName("EntityDocumentBO.ReferenceNumber")[0].disabled = true;
						document.getElementsByName("EntityDocumentBO.IDIssuedOrganisation")[0].disabled = true;
						//document.getElementsByName("3_EntityDocumentBO.DocIssueDate")[0].disabled = true;
						//document.getElementsByName("3_EntityDocumentBO.DocExpiryDate")[0].disabled = true;
						
						//document.getElementsByName("3_EntityDocumentBO.DocIssueDate")[0].disabled = true;
						//document.getElementsByName("3_EntityDocumentBO.DocExpiryDate")[0].disabled = true;
						
						
						//'EntityDocumentBO.CountryOfIssue'
						 document.getElementsByName("EntityDocumentBO.CountryOfIssue")[0].disabled=true;
						 document.getElementsByName("Cat_EntityDocumentBO.CountryOfIssue")[0].disabled=true;
						 document.getElementsByName("btnone_EntityDocumentBO.CountryOfIssue")[0].disabled = true;
                                                 document.getElementsByName("btntwo_EntityDocumentBO.CountryOfIssue")[0].disabled = true;
						
						
						//PlaceOfIssue
											//alert('493:: making placeofissue disabled');

						document.getElementsByName("EntityDocumentBO.PlaceOfIssue")[0].disabled=true;
					       document.getElementsByName("Cat_EntityDocumentBO.PlaceOfIssue")[0].disabled=true;
					       document.getElementsByName("btnone_EntityDocumentBO.PlaceOfIssue")[0].disabled = true;
                                                 document.getElementsByName("btntwo_EntityDocumentBO.PlaceOfIssue")[0].disabled = true;
						
						
						
						
						
						
						}
						catch(e)
						{
						alert(e.message);
						}
						
						
						
						/*For testing*/
					}
					document.getElementsByName("EntityDocumentBO.DocDescr")[0].readOnly = true;
					document.getElementsByName("EntityDocumentBO.DocTypeDescr")[0].readOnly = true;
					document.getElementsByName("EntityDocumentBO.MinDocsReqd")[0].readOnly = true;
//alert("bodyload() finished");
				}
				catch(e) {
				}
			}
			function setMCAttModifyFlag(){
				document.frm2.isMCEditedDoc.value="Y";
			}
			function enableClose(){
				try{
					document.getElementsByName("Close")[0].disabled = false;
				}catch(e){
				}
			}

			//            Array populate for caching
				var DescripionCache = new Array();
				var DescripionIDCache = new Array();

				function CheckRecvDate()
				{
					var status = document.getElementsByName("EntityDocumentBO.Status")[0].value;
					var DateVal =document.getElementsByName("3_EntityDocumentBO.DocReceivedDate")[0].value;
							date		= getCurrentDate();
							var temp 	= Validate_toDateString(DateVal,date, true, false);
							
							if(!temp) {
						showMessage(MSGX50027);
						document.getElementsByName("3_EntityDocumentBO.DocReceivedDate")[0].focus();
								return;
							}
//					alert(DateVal);
					if(status.toUpperCase() == "RECEIVED")
					{
						if(DateVal == "")
						{
							return "false";
						}
						else
						{
							return "true";
						}
					}
					else
					{
						return "true";
					}
				}
			   function CheckWaivedOrDefered()
			   {
					var status = document.getElementsByName("EntityDocumentBO.Status")[0].value;
					var DateVal =document.getElementsByName("3_EntityDocumentBO.WaivedOrDeferedDate")[0].value;
					var DocRemarks =document.getElementsByName("EntityDocumentBO.DocRemarks")[0].value;
					if(status.toUpperCase() == "WAIVED" || status.toUpperCase() == "DEFERRED") {
						if(DateVal == "") {
							showMessage(MSGX0008);
							document.getElementsByName("3_EntityDocumentBO.WaivedOrDeferedDate")[0].focus();
							return "false";
						}
						else if(DocRemarks =="") {
							showMessage(MSGX0009);
							document.getElementsByName("EntityDocumentBO.DocRemarks")[0].focus();
							return "false";
						}
						else {
							return "true";
						}
					}
					else {
						return "true";
					}
			   }
				function populateDocCode() {
				   document.getElementsByName ('EntityDocumentBO.DocCode')[0].value =
							'<xsl:value-of select="$customfields[@n='EntityDocumentBO.DocCode']"/>';
								  
				   document.getElementsByName ('EntityDocumentBO.DocTypeCode')[0].value =
						   '<xsl:value-of select="$customfields[@n='EntityDocumentBO.DocTypeCode']"/>';
				
				<!--ticket id 209960 tracker id 125299 starts-->
				   if(dualflag==0){
				   	 <!--Tracker 113227 Changes starts-->
				   	<!--Tracker 359180 Changes starts-->
				      document.getElementsByName ('EntityDocumentBO.DocDescr')[0].value =
						   '<xsl:value-of select="$docCode_docDesc_alt1"/>';
						   
					<!-- Changes for the ticketid:365866 Starts-->
					if( document.getElementsByName ('EntityDocumentBO.DocDescr')[0].value==""){
					 document.getElementsByName ('EntityDocumentBO.DocDescr')[0].value =
						  decodeSpecialCharsXML('<xsl:value-of select="$Entity_docCode_docDesc"/>');


					}

				   <!--Tracker 113227 Changes End-->
			            document.getElementsByName ('EntityDocumentBO.DocTypeDescr')[0].value =
						   '<xsl:value-of select="$doc_TypeDesc_alt1"/>';
					   if( document.getElementsByName ('EntityDocumentBO.DocTypeDescr')[0].value==""){
						 document.getElementsByName ('EntityDocumentBO.DocTypeDescr')[0].value =
							   decodeSpecialCharsXML('<xsl:value-of select="$Entity_doc_TypeDesc"/>');

					}

				   }
				   else{

				    document.getElementsByName ('EntityDocumentBO.DocDescr')[0].value =
						  decodeSpecialCharsXML('<xsl:value-of select="$Entity_docCode_docDesc"/>');
				   document.getElementsByName ('EntityDocumentBO.DocTypeDescr')[0].value =
						  decodeSpecialCharsXML('<xsl:value-of select="$Entity_doc_TypeDesc"/>');
				   }
				   <!-- Changes for the ticketid:365866 Ends -->
				 <!--ticket id 209960 tracker id 125299 ends-->  
				  <!--Tracker 359180 Changes ends-->
				
//alert("populateDocCode(): finished");
				}
			</script>
		</head>
		<body class="popup">
		<xsl:choose>
			<xsl:when test="normalize-space($readMode)='Y'">
					<!--Changes begin for ticket 436240-->
					<xsl:attribute name="onload">populateDocTypeOnLoad();loadCodeforType('<xsl:value-of select="$customfields[@n='EntityDocumentBO.DocTypeCode']"/>');populateDocCode();showInReadOnlyMode('<xsl:value-of select="$readMode"/>');enableClose();bodyload();</xsl:attribute>
					<!--Changes end for ticket 436240-->
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
				<xsl:when test="normalize-space($mode)='add'">
					<!-- Tracker Id: 136907 Changes Begin -->
					<xsl:attribute name="onload">makeFieldsMandatory();populateDocTypeOnLoad();enableFields()</xsl:attribute>
					<!-- Tracker Id: 136907 Changes end -->
				</xsl:when>
				<xsl:otherwise>
				<!-- changes for tracker id 260265 starts  -->
				<xsl:attribute name="onload">makeFieldsMandatory();populateDocTypeOnLoad();loadCodeforType('<xsl:value-of select="$customfields[@n='EntityDocumentBO.DocTypeCode']"/>');populateDocCode();bodyload();</xsl:attribute>
				<!-- changes for tracker id 260265 ends  -->
				</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
		<table class="background" width="100%" cellpadding="0" cellspacing="0" border="0"  align="center">
			 <xsl:apply-templates select="SRM"/>
		</table>
		
		<table class="background" cellpadding="2" cellspacing="2" width ="100%" border="0"  align="left">
		 <xsl:choose>
			<xsl:when test="normalize-space($readMode)='Y'">
				<xsl:call-template name="user_button_withText">
					<xsl:with-param name="button_name">Close</xsl:with-param>
					<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='CLOSE']/@configLabel"/></xsl:with-param>
					<xsl:with-param name="button_fnc">cancel()</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="user_button_withText">
					<xsl:with-param name="button_name">SAVE</xsl:with-param>
				<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='SAVE']/@configLabel"/></xsl:with-param>
					<xsl:with-param name="button_fnc">saveDet()</xsl:with-param>
				</xsl:call-template>&#160;
			
				<xsl:call-template name="user_button_withText">
				      <!--Tracker:108387:Button name change from cancel to close-->
					<xsl:with-param name="button_name">Close</xsl:with-param>
					<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='CLOSE']/@configLabel"/></xsl:with-param>
				      <!--Tracker:108387:End of Changes-->	
					<xsl:with-param name="button_fnc">cancel()</xsl:with-param>
				</xsl:call-template>
			
			</xsl:otherwise>
		 </xsl:choose>
		</table>
		</body>
	   </html>
	</xsl:template>

	<!-- changes for tracker id 260265 starts  -->
	<xsl:template name="EntityDocumentBO.DocCode">
	  <xsl:choose>
		<xsl:when test="normalize-space($mode)='add' or 'edit'">
			<xsl:call-template name="mdrpdown">
				<xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.DocCode']"/>
				<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
				<xsl:with-param name="selectname">EntityDocumentBO.DocCode</xsl:with-param>
				<xsl:with-param name="selectdisp">EntityDocumentBO.DocCode</xsl:with-param>
				<xsl:with-param name="onchangefn">loadDocDesc(this)</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="label">
				<xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.DocCode']"/>
				<xsl:with-param name="ele_name">EntityDocumentBO.DocCode</xsl:with-param>
				<xsl:with-param name="read_val">true</xsl:with-param>
				<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			</xsl:call-template>
		</xsl:otherwise>
	  </xsl:choose>
	</xsl:template>
       <!-- changes for tracker id 260265 ends  -->

	<xsl:template name="EntityDocumentBO.DocDescr">
		<xsl:call-template name="mtextarea">
			<xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.DocDescr']"/>
			<xsl:with-param name="mname">EntityDocumentBO.DocDescr</xsl:with-param>
			<xsl:with-param name="mwrap">on</xsl:with-param>
			<xsl:with-param name="mrows">2</xsl:with-param>
			<xsl:with-param name="mcols">20</xsl:with-param>
			<xsl:with-param name="mcolspan">2</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!-- changes for tracker id 260265 starts  -->
	<xsl:template name="EntityDocumentBO.DocTypeCode">
		<xsl:choose>
				<xsl:when test="normalize-space($mode)='add' or 'edit'">
				<xsl:call-template name="mdrpdown">
					<xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.DocTypeCode']"/>
					<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
					<xsl:with-param name="selectname">EntityDocumentBO.DocTypeCode</xsl:with-param>
					<xsl:with-param name="selectdisp">EntityDocumentBO.DocTypeCode</xsl:with-param>
					<xsl:with-param name="onchangefn">loadTypeData(this)</xsl:with-param>
					<xsl:with-param name="starshow">true</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="label">
				<xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.DocTypeCode']"/>
				<xsl:with-param name="ele_name">EntityDocumentBO.DocTypeCode</xsl:with-param>
				<xsl:with-param name="read_val">true</xsl:with-param>
				<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- changes for tracker id 260265 ends  -->
	
	<xsl:template name="EntityDocumentBO.DocTypeDescr">
		<xsl:call-template name="mtextarea">
			<xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.DocTypeDescr']"/>
			<xsl:with-param name="mname">EntityDocumentBO.DocTypeDescr</xsl:with-param>
			<xsl:with-param name="mwrap">on</xsl:with-param>
			<xsl:with-param name="mrows">2</xsl:with-param>
			<xsl:with-param name="mcols">20</xsl:with-param>
			<xsl:with-param name="mcolspan">2</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="EntityDocumentBO.IsMandatory">
		<xsl:call-template name="mdrpdown">
			<xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.IsMandatory']"/>
			<xsl:with-param name="selectdisp">EntityDocumentBO.IsMandatory</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			<xsl:with-param name="ele_val">EntityDocumentBO.IsMandatory</xsl:with-param>
			<xsl:with-param name="selectname">EntityDocumentBO.IsMandatory</xsl:with-param>
			<xsl:with-param name="presdata" select="$PresData"/>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="EntityDocumentBO.IsDocumentVerified">
		<xsl:call-template name="mdrpdown">
			<xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.IsDocumentVerified']"/>
			<xsl:with-param name="selectdisp">EntityDocumentBO.IsDocumentVerified</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			<xsl:with-param name="ele_val">EntityDocumentBO.IsDocumentVerified</xsl:with-param>
			<xsl:with-param name="selectname">EntityDocumentBO.IsDocumentVerified</xsl:with-param>
			<xsl:with-param name="presdata" select="$PresData"/>
		</xsl:call-template>
	</xsl:template>	
<!-- Tracker# 97236 ID Issued Organization : Start -->
	  <xsl:template name="EntityDocumentBO.IDIssuedOrganisation">
	         <xsl:call-template name="mdrpdown">
	         <xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.IDIssuedOrganisation']"/>
	         <xsl:with-param name="selectname">EntityDocumentBO.IDIssuedOrganisation</xsl:with-param>
	         <xsl:with-param name="selectdisp">EntityDocumentBO.IDIssuedOrganisation</xsl:with-param>
	         <xsl:with-param name="ele_name">EntityDocumentBO.IDIssuedOrganisation</xsl:with-param>
	         <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
	         <xsl:with-param name="choice_name">EntityDocumentBO.IDIssuedOrganisation</xsl:with-param>
	          <xsl:with-param name="presdata" select="$PresData"/>
	         </xsl:call-template>
	 </xsl:template>
<!-- Tracker# 97236 ID Issued Organization : End-->
	<xsl:template name="EntityDocumentBO.ScanRequired">
		<xsl:call-template name="mdrpdown">
			<xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.ScanRequired']"/>
			<xsl:with-param name="selectdisp">EntityDocumentBO.ScanRequired</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			<xsl:with-param name="ele_val">EntityDocumentBO.ScanRequired</xsl:with-param>
			<xsl:with-param name="selectname">EntityDocumentBO.ScanRequired</xsl:with-param>
			<xsl:with-param name="presdata" select="$PresData"/>
		</xsl:call-template>
	</xsl:template>

	 <xsl:template name="EntityDocumentBO.ReferenceNumber">
		 <xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.ReferenceNumber']"/>
			<xsl:with-param name="ele_name">EntityDocumentBO.ReferenceNumber</xsl:with-param>
			<xsl:with-param name="ele_val">EntityDocumentBO.ReferenceNumber</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="EntityDocumentBO.DocRemarks">
		<xsl:call-template name="mtextarea">
			<xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.DocRemarks']"/>
			<xsl:with-param name="mname">EntityDocumentBO.DocRemarks</xsl:with-param>
			<xsl:with-param name="mvalue">EntityDocumentBO.DocRemarks</xsl:with-param>
			<xsl:with-param name="mwrap">on</xsl:with-param>
			<xsl:with-param name="mrows">2</xsl:with-param>
			<xsl:with-param name="mcols">20</xsl:with-param>
			<xsl:with-param name="mcolspan">0</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			<xsl:with-param name="fn_onblur">txtLimit(this,256,"EntityDocumentBO.DocRemarks","Remarks")</xsl:with-param>
			<xsl:with-param name="checkASCII">false</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
			</xsl:call-template>
	</xsl:template>
	<xsl:template name="EntityDocumentBO.MinDocsReqd">
		 <xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.MinDocsReqd']"/>
			<xsl:with-param name="ele_name">EntityDocumentBO.MinDocsReqd</xsl:with-param>
			<xsl:with-param name="ele_val">EntityDocumentBO.MinDocsReqd</xsl:with-param>
			<xsl:with-param name="read_val">true</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		 </xsl:call-template>
	</xsl:template>

	<xsl:template name="EntityDocumentBO.IdentificationType">
		<xsl:call-template name="mdrpdown">
			<xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.IdentificationType']"/>
<!--			<xsl:with-param name="selectDesc">Cat_EntityDocumentBO.IdentificationType</xsl:with-param>	-->
			<xsl:with-param name="selectname">EntityDocumentBO.IdentificationType</xsl:with-param>
			<xsl:with-param name="selectdisp">EntityDocumentBO.IdentificationType</xsl:with-param>
			<xsl:with-param name="max_length">255</xsl:with-param>
			<xsl:with-param name="choice_name"><xsl:value-of select="$choice_nameIDType"/></xsl:with-param>
			<xsl:with-param name="disable_val">false</xsl:with-param>
			<xsl:with-param name="search_type">url</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			<xsl:with-param name="presdata" select="$PresData"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="EntityDocumentBO.PlaceOfIssue">
		<xsl:call-template name="lookup">
			<xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.PlaceOfIssue']"/>
			<xsl:with-param name="elename">EntityDocumentBO.PlaceOfIssue</xsl:with-param>
			<xsl:with-param name="eleval">EntityDocumentBO.PlaceOfIssue_cat</xsl:with-param>
			<xsl:with-param name="max_length">255</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
			<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
			<!--Fix for 130244-->
			<!-- <xsl:with-param name="buttonone_fnc">categoryLookupCode('CITY', 'EntityDocumentBO.PlaceOfIssue','corp_id_city_code')</xsl:with-param>-->
<!-- Fix for TrackerId: 275751 ticketId:455462 Start -->
			<!-- Change for Callid:240355  Start -->
			<xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('CITY', 'EntityDocumentBO.PlaceOfIssue','corp_id_city_code','NULL','EntityDocumentBO.CountryOfIssue')</xsl:with-param>
			<!-- Change for Callid:240355  End -->
<!-- Fix for TrackerId: 275751 ticketId:455462 End -->
			<!--Fix for 130244-->
			<xsl:with-param name="buttontwo_fnc">clearCategoryValue('EntityDocumentBO.PlaceOfIssue')</xsl:with-param>
			<xsl:with-param name="checkASCII">false</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
<!-- changes for recon -->
			<xsl:with-param name="code_req">true</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="EntityDocumentBO.CountryOfIssue">
		<xsl:call-template name="lookup">
			<xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.CountryOfIssue']"/>
			<xsl:with-param name="elename">EntityDocumentBO.CountryOfIssue</xsl:with-param>
			<xsl:with-param name="eleval">EntityDocumentBO.CountryOfIssue</xsl:with-param>
			<xsl:with-param name="max_length">255</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			<!-- Field Rationalization starts -->
			<xsl:with-param name="code_req">true</xsl:with-param>
			<!-- Field Rationalization ends -->
			<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
			<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
			<!--Fix for 130244-->
			<!--<xsl:with-param name="buttonone_fnc">categoryLookupCode('COUNTRY', 'EntityDocumentBO.CountryOfIssue','corp_id_cntry_code')</xsl:with-param>-->
<!-- Fix for TrackerId: 275751 ticketId:455462 Start -->
			<!-- Change for Callid:240355  Start -->
			<xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('COUNTRY', 'EntityDocumentBO.CountryOfIssue','corp_id_cntry_code','NULL','EntityDocumentBO.PlaceOfIssue')</xsl:with-param>
			<!-- Change for Callid:240355  End -->
<!-- Fix for TrackerId: 275751 ticketId:455462 End -->
			<!--Fix for 130244-->
			<xsl:with-param name="buttontwo_fnc">clearCategoryValue('EntityDocumentBO.CountryOfIssue')</xsl:with-param>
			<xsl:with-param name="checkASCII">false</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="EntityDocumentBO.DocIssueDate">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.DocIssueDate']"/>
			<xsl:with-param name="ele_name">EntityDocumentBO.DocIssueDate</xsl:with-param>
			<xsl:with-param name="ele_val">EntityDocumentBO.DocIssueDate</xsl:with-param>
			<xsl:with-param name="fn_onBlur">validateIssueDate();</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="EntityDocumentBO.DocExpiryDate">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.DocExpiryDate']"/>
			<xsl:with-param name="ele_name">EntityDocumentBO.DocExpiryDate</xsl:with-param>
			<xsl:with-param name="ele_val">EntityDocumentBO.DocExpiryDate</xsl:with-param>
			<xsl:with-param name="fn_onBlur">checkWithIssueDate();</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="EntityDocumentBO.DocDueDate">
		<xsl:choose>
			<xsl:when test="(normalize-space($fromProcess)='Y')">
				<xsl:call-template name="label">
					<xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.DocDueDate']"/>
					<xsl:with-param name="ele_name">EntityDocumentBO.DocDueDate</xsl:with-param>
					<xsl:with-param name="ele_val">EntityDocumentBO.DocDueDate</xsl:with-param>
					<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
					<!-- change for callid 392983 begins -->
					<xsl:with-param name="starshow">true</xsl:with-param>
					<!-- change for callid 392983 ends -->
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="EntityDocumentBO.Status">
		<xsl:choose>
			<xsl:when test="(normalize-space($fromProcess)='Y')">
				<xsl:call-template name="mdrpdown">
					<xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.Status']"/>
					<xsl:with-param name="selectdisp">EntityDocumentBO.Status</xsl:with-param>
					<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
					<xsl:with-param name="ele_val">EntityDocumentBO.Status</xsl:with-param>
					<xsl:with-param name="selectname">EntityDocumentBO.Status</xsl:with-param>
					<xsl:with-param name="search_type">url</xsl:with-param>
					<xsl:with-param name="onchangefn">ChangeStatusDate(this.value)</xsl:with-param>
					<xsl:with-param name="presdata" select="$PresData"/>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="EntityDocumentBO.DocReceivedDate">
		<xsl:choose>
			<xsl:when test="(normalize-space($fromProcess)='Y')">
				<xsl:call-template name="label">
					<xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.DocReceivedDate']"/>
					<xsl:with-param name="ele_name">EntityDocumentBO.DocReceivedDate</xsl:with-param>
					<xsl:with-param name="ele_val">EntityDocumentBO.DocReceivedDate</xsl:with-param>
					<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
					<xsl:with-param name="fn_onBlur">CheckRecvDate(this);</xsl:with-param>
					<xsl:with-param name="starshow">true</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="EntityDocumentBO.WaivedOrDeferedDate">
		<xsl:choose>
			<xsl:when test="(normalize-space($fromProcess)='Y')">
				 <xsl:call-template name="label">
					<xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.WaivedOrDeferedDate']"/>
					<xsl:with-param name="ele_name">EntityDocumentBO.WaivedOrDeferedDate</xsl:with-param>
					<xsl:with-param name="ele_val">EntityDocumentBO.WaivedOrDeferedDate</xsl:with-param>
					<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
					<xsl:with-param name="starshow">true</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="EntityDocumentBO.Scanned">
		<xsl:choose>
			<xsl:when test="(normalize-space($fromProcess)='Y')">
				<xsl:call-template name="mdrpdown">
					<xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.Scanned']"/>
					<xsl:with-param name="selectdisp">EntityDocumentBO.Scanned</xsl:with-param>
					<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
					<xsl:with-param name="ele_val">EntityDocumentBO.Scanned</xsl:with-param>
					<xsl:with-param name="selectname">EntityDocumentBO.Scanned</xsl:with-param>
					<xsl:with-param name="presdata" select="$PresData"/>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="EntityDocumentBO.DocDelFlg">
		<xsl:choose>
			<xsl:when test="(normalize-space($fromProcess)='Y')">
				<xsl:call-template name="mdrpdown">
					<xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.DocDelFlg']"/>
					<xsl:with-param name="selectdisp">EntityDocumentBO.DocDelFlg</xsl:with-param>
					<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
					<xsl:with-param name="ele_val">EntityDocumentBO.DocDelFlg</xsl:with-param>
					<xsl:with-param name="selectname">EntityDocumentBO.DocDelFlg</xsl:with-param>
					<xsl:with-param name="presdata" select="$PresData"/>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="*" mode="mode1">
	
		<xsl:call-template name="Begin"/>
			<td>
				<table>
				<form name="frm2"  method="post" action="">
					<input type="hidden" name="corp_id_city_code" value=""/>
					<input type="hidden" name="corp_id_cntry_code" value=""/>
					<input type="hidden" value="{$CustomerURL}" name="customerURL"/>
					<input type="hidden" name="InputTypeFromLookup" />
					<input type="hidden" name="hid_todDate" />
					<input type="hidden" name="rcvdDate" />
					<input type="hidden" name="rcvdDate1" />
					<input type="hidden" name="waivedOrDeferedDate" />
					<input type="hidden" name="waivedOrDeferedDate1" />
					<input type="hidden" name="expDate" />
					<input type="hidden" name="hidIdentificationType" value="{$identification_Type}"/>
					<input type="hidden" name="isMCEditedDoc" value="N"/>
					
					<xsl:call-template name="Begin"/>
						<xsl:call-template name="EntityDocumentBO.DocTypeCode"/>
						<xsl:call-template name="EntityDocumentBO.DocTypeDescr"/>
					<xsl:call-template name="End"/>
					<xsl:call-template name="Begin"/>
						<xsl:call-template name="EntityDocumentBO.DocCode"/>
						<xsl:call-template name="EntityDocumentBO.DocDescr"/>
					<xsl:call-template name="End"/>
					<xsl:call-template name="Begin"/>
						<xsl:call-template name="EntityDocumentBO.DocRemarks"/>
						<xsl:call-template name="EntityDocumentBO.ScanRequired"/>
					<xsl:call-template name="End"/>
					<xsl:call-template name="Begin"/>
						<xsl:call-template name="EntityDocumentBO.IsMandatory"/>
						<xsl:call-template name="EntityDocumentBO.ReferenceNumber"/>
					<xsl:call-template name="End"/>
					<xsl:call-template name="Begin"/>
						<xsl:call-template name="EntityDocumentBO.PlaceOfIssue"/>
						<xsl:call-template name="EntityDocumentBO.CountryOfIssue"/>
					<xsl:call-template name="End"/>
					<xsl:call-template name="Begin"/>
						<xsl:call-template name="EntityDocumentBO.DocIssueDate"/>
						<xsl:call-template name="EntityDocumentBO.DocExpiryDate"/>
					<xsl:call-template name="End"/>
					<xsl:call-template name="Begin"/>
						<xsl:call-template name="EntityDocumentBO.Status"/>
						<xsl:call-template name="EntityDocumentBO.DocDueDate"/>
					<xsl:call-template name="End"/>
					<xsl:call-template name="Begin"/>
						<xsl:call-template name="EntityDocumentBO.DocReceivedDate"/>
						<xsl:call-template name="EntityDocumentBO.WaivedOrDeferedDate"/>
					<xsl:call-template name="End"/>
					<xsl:call-template name="Begin"/>
						<xsl:call-template name="EntityDocumentBO.Scanned"/>
						<xsl:call-template name="EntityDocumentBO.DocDelFlg"/>
					<xsl:call-template name="End"/>
					<xsl:call-template name="Begin"/>
						<xsl:call-template name="EntityDocumentBO.IsDocumentVerified"/>
						<xsl:call-template name="EntityDocumentBO.IDIssuedOrganisation"/>
					<xsl:call-template name="End"/>
 					
					
					
					
					
					<tr></tr>
					
					
					

					
					
				</form>
				</table>
			</td>
		<xsl:call-template name="End"/>
	</xsl:template>

	<xsl:template match="SRM">
		<xsl:for-each select=".">
			 <table border="0" cellspacing="0" cellpadding="0" width="100%" class="tableborder" vspace="0" hspace="0">
				<tr>
					<td>
				    		<table border="0" cellspacing="0" cellpadding="0" class="innertable" width="100%" vspace="0" hspace="0">
							<tr>
								<td>
									<table bgcolor='ffffff' border="0" cellspacing="0" cellpadding="2" width="100%" vspace="0" hspace="0">
										<tr>
											<xsl:call-template name="apply">
												<xsl:with-param name="apply_head">
													<b><xsl:value-of select="$configLabels[@name='Header']/@configLabel"/></b>
												</xsl:with-param>
											</xsl:call-template>
										</tr>
									</table>
									<table bgcolor='ffffff' width="100%" border="0" cellspacing="0" cellpadding="2">
										<xsl:apply-templates select="." mode="mode1"/>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			 </table>

		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>























