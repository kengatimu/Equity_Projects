<?xml version='1.0'?>
  <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="../Renderer/common/display/SRMListTemplate.xsl"/>
        <xsl:param name="locale"/>
  <xsl:variable name="userArea" select="/SRM/SRMData[@SRMDataSpace='UserData']"/>
   <!-- CIF changes for EntitySearch, starts -->
   <xsl:variable name="searchFrom" select="/SRM/SRMData[@SRMDataSpace='UserData']/Z[@n='SearchFrom']"></xsl:variable>
  <!-- CIF changes for EntitySearch, ends -->
  <xsl:variable name="searchType" select="$userArea//Z[@n='SearchType']"/>
  <xsl:variable name="query" select="$userArea//Z[@n='options']"/>
  <xsl:variable name="ViewName" select="$userArea//Z[@n='ViewName']"/>
  <xsl:variable name="loggedusersol" select="$userArea//Z[@n='loggedusersol']"/>
  <xsl:variable name="primarygroupid" select="$userArea//Z[@n='primarygroupid']"/>
  <xsl:variable name="primarygroupname" select="$userArea//Z[@n='primarygroupname']"/>
  <xsl:variable name="queryText" select="$userArea//Z[@n='QueryText']"/>
  <!-- CIF changes - Search FrameWork -->
  <xsl:variable name="ScreenName" select="$userArea//Z[@n='ScreenName']"/>
  <!-- CIF changes - Search FrameWork -->
   <!-- Fix for Ticket 229371 Begins -->
    <xsl:variable name="sType" select="$userArea//Z[@n='sType']"/>
 <!-- Fix for Ticket 229371 ENDS -->
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
   <!-- 
    *** BEGIN OF CHANGES Fix for 264329
    *** Commenting custom data as it is not required to check for criteria
   
    <xsl:variable name="BlackCriteriaFlag" select="$userArea//Z[@n='BlackCriteriaFlag']"/>
    <xsl:variable name="DedupCriteriaFlag" select="$userArea//Z[@n='DedupCriteriaFlag']"/>
     <xsl:variable name="NegCriteriaFlag" select="$userArea//Z[@n='NegCriteriaFlag']"/>
    -->
    <!-- END OF CHANGES FIX for 264329 -->
  <!-- 113066 - End of changes for LCIF Copy by Amit malhotra -->

  <xsl:param name="resfilename"/>
    <xsl:variable name="configFile_1" select="document(concat($resfilename,''))"/>
  <xsl:variable name="configLabels" select="$configFile_1/SRMBO/*"/>
  <xsl:param name="pageIndex" select="0"/>
  <xsl:param name="NumPages"/>
  
  <xsl:template match="/">
  <xsl:if test="$pageIndex &lt;=1">
  <xsl:call-template name="htmlstart"/>
  <head>
    <script type="text/javascript" src="../common/js/ClientResourceBundle_{$locale}.js" language="javascript"></script>
     <script type="text/javascript" src="../cif/js/Message_cif_{$locale}.js" language="javascript"></script>
     
    <!--Begin of changes for tracker 131243 by sumeet gandhok - BANKID - -->       
     <script language="javascript" src="../cif/js/CrossEntityCopyValidation.js"></script>
    <!--End of changes for tracker 131243 by sumeet gandhok - BANKID - -->       
     
    <script type="text/javascript" src="../common/js/SSOUtils.js" language="javascript"></script>
    <script language="javascript" src="../BaseCustomization/js/TelephonyCustom.js"></script>
    <script>
    var locale = '<xsl:value-of select="$locale"/>';
    var NumPages = '<xsl:value-of select="$NumPages"/>';<!-- TRACKER# 92380-->
    var loggedusersol = '<xsl:value-of select="$loggedusersol"/>';
    var primarygroupid = '<xsl:value-of select="$primarygroupid"/>';
    var primarygroupname = '<xsl:value-of select="$primarygroupname"/>';
    
    /*Begin of changes for ticket 219040 by sumeet gandhok - BANKID -*/
    var StrLoggegInBankId1 = '<xsl:value-of select="$strLoggegInBankId"/>';
    var StrSearchedBankId1 = '<xsl:value-of select="$strSearchedBankId"/>';
    	var ScreenName = '<xsl:value-of select="$ScreenName"/>';
    	var viewnameScreenID = '<xsl:value-of select="$userArea//Z[@n='ViewName']"/>';
    /*End of changes for ticket 219040 by sumeet gandhok - BANKID -*/
    </script>


        <link rel="stylesheet" type="text/css" href="../Branding/css/common/SRMTableDisplay_{$locale}.css"/>
        <link rel="stylesheet" Type="text/css" href="../Branding/css/common/PopupMenu_{$locale}.css"/>
         <!-- CIF changes - Search FrameWork -->
         <LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/SRMListTemplate_{$locale}.css"/>
        <object id="factory" style='display:none'></object>

        <script type="text/javascript" src="../common/js/PopupMenu.js"></script>
        <!-- CIF Chages - depending on the screen name, respective RCL options are populated-->
        <xsl:choose>
        	    <xsl:when test="normalize-space($ScreenName)='Screen'">
		   		<script type="text/javascript" src="../cif/js/CIFCustomerRCLOptions_{$locale}.js"></script>
	    	    </xsl:when>

	   	    <xsl:when test="normalize-space($ScreenName)='Screen1'">
	   		 <script type="text/javascript" src="../cif/js/CIFCustomerRCLOptions1_{$locale}.js"></script>
	   	    </xsl:when>

	   	     <xsl:when test="normalize-space($ScreenName)='Screen2'">
		    	 <script type="text/javascript" src="../cif/js/CIFCustomerRCLOptions2_{$locale}.js"></script>
	   	    </xsl:when>

	   	     <xsl:when test="normalize-space($ScreenName)='Screen3'">
		    	   <script type="text/javascript" src="../cif/js/CIFCustomerRCLOptions3_{$locale}.js"></script>
	   	    </xsl:when>

	   	     <xsl:when test="normalize-space($ScreenName)='Screen4'">
			<script type="text/javascript" src="../cif/js/CIFCustomerRCLOptions4_{$locale}.js"></script>
	   	    </xsl:when>
	   	     <xsl:when test="normalize-space($ScreenName)='CopyEntityRet'">
		    		        <script type="text/javascript" src="../cif/js/CustSearchCopyRCLOption_{$locale}.js"></script>
		    </xsl:when>
        	     <!-- Fix for Ticket 229371 Begins -->
        	     <!-- Checking screen type instead of screen Name -->
        	    <!-- xsl:when test="normalize-space($ScreenName)='Screen'" -->
        	    <xsl:when test="normalize-space($sType)='Edit Entity'">
		   		<script type="text/javascript" src="../cif/js/CIFCustomerRCLOptions_{$locale}.js"></script>
	    	    </xsl:when>
                     <!-- Checking screen type instead of screen Name -->
	   	    <!-- xsl:when test="normalize-space($ScreenName)='Screen1'" -->
	   	    <xsl:when test="normalize-space($sType)='DeDup'">
	   		 <script type="text/javascript" src="../cif/js/CIFCustomerRCLOptions1_{$locale}.js"></script>
	   	    </xsl:when>
                     <!-- Checking screen type instead of screen Name -->
	   	     <!-- xsl:when test="normalize-space($ScreenName)='Screen2'" -->
	   	     <xsl:when test="normalize-space($sType)='BlackList'">
		    	 <script type="text/javascript" src="../cif/js/CIFCustomerRCLOptions2_{$locale}.js"></script>
	   	    </xsl:when>
                     <!-- Checking screen type instead of screen Name -->
	   	     <!-- xsl:when test="normalize-space($ScreenName)='Screen3'" -->
	   	     <xsl:when test="normalize-space($sType)='Negative'">
		    	   <script type="text/javascript" src="../cif/js/CIFCustomerRCLOptions3_{$locale}.js"></script>
	   	    </xsl:when>
                     <!-- Checking screen type instead of screen Name -->
	   	     <!-- xsl:when test="normalize-space($ScreenName)='Screen4'" -->
		    <xsl:when test="normalize-space($sType)='Suspend'">			
			<script type="text/javascript" src="../cif/js/CIFCustomerRCLOptions4_{$locale}.js"></script>
	   	    </xsl:when>
	   	     <!-- Fix for Ticket 229371 Begins -->
	   	   <!--<xsl:when test="normalize-space($ScreenName)='Screen'">-->
	   	    	<xsl:when test="normalize-space($searchFrom)='CIF'">
			<script type="text/javascript" src="../cif/js/CIFCustomerRCLOptions_{$locale}.js"></script>
	   	    </xsl:when>

   	</xsl:choose>
        <!-- CIF changes - Search FrameWork -->
        <script type="text/javascript" id="TableRowColor" src="../common/js/SRMTableRowColor.js"></script>
        <!-- CIF changes - Search FrameWork -->
        <script type="text/javascript" src="../Customization/cif/js/CIFCustomerRightClick.js"></script>

     <!-- vasanth's changes start -->     
     <script type="text/javascript" src="../cif/js/CheckBSNFlags.js" language="javascript"></script>
	<!-- vasanth's changes end -->
	
        <script language="javascript" src="../common/js/ExportToExcel.js" type="text/javascript">
       <!-- CIF changes - Search FrameWork -->
       </script>
        <script>
          var escChars = new Array();
	  var salutation = "";
	  var middleName = "";
	  var DOB = "";
	  var maidenName = "";
	  var gender = "";
	  var workPhone = "";
	  var extension = "";
	  var workEmail = "";
 	  var addLine1 = "";
   	  var addLine2 = "";
   	  var addLine3 = "";
	  var city     = "";
	  var SSN      = "";
	  var passportNo = "";
          var lastName = "";
          var firstName = "";
          var region = "";
          var AccountID = "";
          var entityID = "";
          var prevsaId = "-1";
          var expirationdate = new Date ();
          var mode = "";
          //Fix for ticket 252985,252986 begins
          //var Suspended="";
          //var BlackListed="";
          //var Negated="";
          var Suspended="Y";
	  var BlackListed="Y";
          var Negated="Y";
          //Fix for ticket 252985,252986 ends
          var RecordStatus="";
          var address="";  
          var hLinkWindow="";
/* CIF Changes for blocking convert of unverified records */
          var ProcessStatus="";
/* CIF Changes for blocking convert of unverified records */

	  var showLastTenTranxTab = "N";

/* CIF Changes for Retaining Row Highlight starts */
	  var local_prefix = "Customer";


// vasanth's chanegs start

	var IsDummy = "";
// vasanth's chanegs end
var cifprimarysol = "";

//Field Rationalization changes start
var tfFlag ="";
//Field Rationalization changes end

function selectLastSelected() {
	prevsaId= getCookie('AccountID');
	
	//Fix for ticket 252985,252986 begins

	BlackListed= getCookie('BlackListed');
	Suspended= getCookie('Suspended')
	Negated= getCookie('Negated');
	//Fix for ticket 252985,252986 ends

}
/* CIF Changes for Retaining Row Highlight ends */

function identifyme() {
	 //113066 Begin of changes for LCIF Copy by Amit Malhotra
	 
		 /*Begin of changes for ticket 219040 by sumeet gandhok - BANKID -
		  *commented the following code and declared the variables globally
		  */ 
		    //var StrLoggegInBankId1 = '<xsl:value-of select="$strLoggegInBankId"/>';
		    //var StrSearchedBankId1 = '<xsl:value-of select="$strSearchedBankId"/>';
		  /*End of changes for ticket 219040 by sumeet gandhok - BANKID -*/
		    var StrCeTarget1 = '<xsl:value-of select="$StrCeTarget"/>';
		    var StrCeCopySusTarget1 = '<xsl:value-of select="$StrCeCopySusTarget"/>';
		    var StrCeCopyBlTarget1 = '<xsl:value-of select="$StrCeCopyBlTarget"/>';
		    var StrCeCopyNlTarget1 = '<xsl:value-of select="$StrCeCopyNlTarget"/>';
		    var StrCeSource1 = '<xsl:value-of select="$StrCeSource"/>';
		    var StrCeCopySusSource1 = '<xsl:value-of select="$StrCeCopySusSource"/>';
		    var StrCeCopyBlSource1 = '<xsl:value-of select="$StrCeCopyBlSource"/>';
		    var StrCeCopyNlSource1 = '<xsl:value-of select="$StrCeCopyNlSource"/>';
		   	        
	         //113066 End of changes for LCIF Copy by Amit Malhotra
	      
        loadPersistData();
        expirationdate.setTime(expirationdate.getTime() + ( 160 * 60 * 1 * 1000));
        var item = null;

        if(event.srcElement.parentElement.id == null || event.srcElement.parentElement.id == '') {
            item = event.srcElement.parentElement.parentElement;
            if (item.id == null || item.id == '') item = item.parentElement;
        } else {
             item = event.srcElement.parentElement;
        }
		
//C.M EMT 17FEB2026 Start
//Any CIF of account in scheme code SB199/CA299 to be blocked for editing until the scheme code has been changed.
	var myBankId = '<xsl:value-of select="$strLoggegInBankId"/>';	
	if(myBankId == "54")
	{
		var myCifId = item.getAttribute('AccountBO.AccountKey');		
		if (myCifId != "")
		{
			try
			{
				var s_xmlHttp;
				if (window.XMLHttpRequest)
				{
					s_xmlHttp = new XMLHttpRequest();
				}
				else
				{
					s_xmlHttp = new ActiveXObject("MSXML2.XMLHTTP");
				}

				s_xmlHttp.abort();
				var strURL = '../servlet/com.infy.cis.custom.CifEditBlocking?orgkey=' + myCifId;
				s_xmlHttp.open("POST", strURL, false);
				s_xmlHttp.send();
			
				if (s_xmlHttp.status == 200)
				{
					var responseText = s_xmlHttp.responseText;

					try
					{
						var xmlDoc = new ActiveXObject('Microsoft.XMLDOM');
						xmlDoc.async = false;
						xmlDoc.loadXML(responseText);

						var statusElement = xmlDoc.getElementsByTagName('STATUS')[0];
						var sbElement = xmlDoc.getElementsByTagName('SB199_COUNT')[0];
						var caElement = xmlDoc.getElementsByTagName('CA299_COUNT')[0];
						var totalElement = xmlDoc.getElementsByTagName('TOTAL_COUNT')[0];

						var statusValue = statusElement.text;
						var sbCount = sbElement.text;
						var caCount = caElement.text;
						var totalCount = totalElement.text;
					}
					catch(e)
					{
						alert("Error reading response." + e);
						return false;
					}

					if (statusValue == "EXISTS")
					{
						var message = "CIF Edit Blocked !!!\n\n";
						message += "CIF ID: " + myCifId + "\n";

						if (sbCount != "0")
						{
							message += "SB199 Accounts: " + sbCount;
						}
						if (caCount != "0")
						{
							message += "CA299 Accounts: " + caCount;
						}
						message += "\nTotal Accounts: " + totalCount;
						alert(message);
						try
						{
							if (document.getElementsByName('ie5menu3')[0])
								document.getElementsByName('ie5menu3')[0].disabled = true;

							if (document.getElementsByName('ie5menu4')[0])
								document.getElementsByName('ie5menu4')[0].disabled = true;
						}
						catch(e)
						{
						}
						
						return false;
					}
					else if (statusValue == "NOMATCH")
					{
						return true;
					}
					else
					{
						alert("An error occurred while validating CIF.");
						return false;
					}
				}
			}
			catch(e)
			{
				alert(e.message);
				return false;
			}
		}
	}
//C.M EMT 17FEB2026 End

        
// vasanth's chanegs start

	IsDummy      = item.getAttribute('AccountBO.IsDummy');
	TabValidator  = item.getAttribute('AccountBO.TabValidator');
	var sName = '<xsl:value-of select="$ScreenName"/>';
	
	if(sName == "Screen"){
    
		var z = document.getElementsByTagName("DIV");
		for (var i=0; i &lt;z.length; i++) {
			
			if((IsDummy == "Y")&amp;&amp; (TabValidator.indexOf('Retail_Customer_GE=Y') == "-1")){
				if(z[i].id == "ie5menu1"){

					
    			    document.getElementsByName('ie5menu' + 3)[0].disabled = false;	  //Edit
					document.getElementsByName('ie5menu' + 4)[0].disabled = true;	  //entity
					document.getElementsByName('ie5menu' + 2)[0].disabled = true;	  //process
    				document.getElementsByName('ie5menu' + 1)[0].disabled = true;
				}
			} else if((IsDummy == "Y" ) &amp;&amp; (TabValidator.indexOf('Retail_Customer_GE=Y') != "-1")){
			
			if(z[i].id == "ie5menu1"){
				document.getElementsByName('ie5menu' + 3)[0].disabled = false;
				document.getElementsByName('ie5menu' + 4)[0].disabled = true;
				document.getElementsByName('ie5menu' + 2)[0].disabled = false;
				document.getElementsByName('ie5menu' + 1)[0].disabled = true;
				}

			}
			else{
    				
    				document.getElementsByName('ie5menu' + 3)[0].disabled = false;
    				document.getElementsByName('ie5menu' + 2)[0].disabled = false;
    				document.getElementsByName('ie5menu' + 4)[0].disabled = false;
    				document.getElementsByName('ie5menu' + 1)[0].disabled = false;
			}
		}
	}

// vasanth's chanegs end        

       var cifprimarysol = item.getAttribute('AccountBO.primary_sol_id');
	lastName      = item.getAttribute('AccountBO.Cust_Last_Name');
        firstName     = item.getAttribute('AccountBO.Cust_First_Name');
        AccountId     = item.getAttribute('AccountBO.accountID');
        entityId      = item.getAttribute('AccountBO.AccountKey');
	DOB	      = item.getAttribute('AccountBO.Cust_DOB');
	Suspended     = item.getAttribute('AccountBO.Suspended');
	BlackListed   = item.getAttribute('AccountBO.BlackListed');
	Negated       = item.getAttribute('AccountBO.Negated');
	workPhone     = item.getAttribute('AccountBO.phone');
	RecordStatus  = item.getAttribute('AccountBO.RecordStatus');
	ProcessStatus  = item.getAttribute('AccountBO.ProcessStatus');
	IsTampered  = item.getAttribute('AccountBO.IsTampered');
	processID = item.getAttribute('AccountBO.ProcessID');
	preferredPhoneType  = item.getAttribute('AccountBO.preferredPhoneType');
	UniqueIdType  = item.getAttribute('AccountBO.UniqueIdType');
	entityType    = "Customer";
	address = MSG_ADDR_MAILING;
	<!-- CIF changes - Tabbing & Saving -->
	//if(prevsaId == AccountID) {
            //return;
        //}
	<!--  Tracker ID : 90197 Begin of Changes for attribute masking-->
	AccessOwnerGroup = item.getAttribute('AccountBO.accessOwnerGroup');
	setCookie('AccessOwnerGroup', AccessOwnerGroup, expirationdate);
	<!-- Tracker ID : 90197 End of Changes -->
	//Field Rationalization changes
	tfFlag	     = item.getAttribute('AccountBO.TFPartyFlag');
	
	setCookie('tfFlag', tfFlag, expirationdate);
	//Field Rationalization changes
	setCookie('cifprimarysol', cifprimarysol, expirationdate);
	setCookie('AccountID', AccountId, expirationdate);
	setCookie('AccountKey', entityId, expirationdate);
	setCookie('entityId', entityId, expirationdate);
	setCookie('entityType', entityType, expirationdate);
	setCookie('BlackListed', BlackListed, expirationdate);
	setCookie('Suspended', Suspended, expirationdate);
	setCookie('Negated', Negated, expirationdate);
	setCookie('RecordStatus', RecordStatus, expirationdate);
	setCookie('ProcessStatus', ProcessStatus, expirationdate);
	setCookie('processID',processID,expirationdate);
	setCookie('IsTampered', IsTampered, expirationdate);
	setCookie('loggedusersol', loggedusersol, expirationdate);
	setCookie('primarygroupid', primarygroupid, expirationdate);
	setCookie('primarygroupname', primarygroupname, expirationdate);
// vasanth's changes start
	setCookie('dob', DOB, expirationdate);
// vasanth's changes end	
	/* Changes done by Kanika for Cif Deceased starts */
	var custStatus    = item.getAttribute('AccountBO.status');
	/* Changes done by Kanika for Cif Deceased ends */
			/* Changes done by Kanika for Cif Deceased starts */
			setCookie('custStatus', custStatus, expirationdate);
		/* Changes done by Kanika for Cif Deceased ends */
	//113066 Amit Malhotra
		setCookie('StrLoggegInBankId1', StrLoggegInBankId1, expirationdate);
		setCookie('StrSearchedBankId1', StrSearchedBankId1, expirationdate);
		setCookie('StrCeTarget1', StrCeTarget1, expirationdate);
		setCookie('StrCeCopySusTarget1', StrCeCopySusTarget1, expirationdate);
		setCookie('StrCeCopyBlTarget1', StrCeCopyBlTarget1, expirationdate);
		setCookie('StrCeCopyNlTarget1', StrCeCopyNlTarget1, expirationdate);
		setCookie('StrCeSource1', StrCeSource1, expirationdate);
		setCookie('StrCeCopySusSource1', StrCeCopySusSource1, expirationdate);
		setCookie('StrCeCopyBlSource1', StrCeCopyBlSource1, expirationdate);
		setCookie('StrCeCopyNlSource1', StrCeCopyNlSource1, expirationdate);
		
//113066 Amit Malhotra	

		/*
		 * BEGIN OF CHANGES Fix for 264329
		 * No need for cookies as it is not used in js
		 *
		setCookie('BlackCriteriaFlag1', BlackCriteriaFlag1, expirationdate);
		setCookie('DedupCriteriaFlag1', DedupCriteriaFlag1, expirationdate);
		setCookie('NegCriteriaFlag1', NegCriteriaFlag1, expirationdate);
		*/
		/* END OF CHANGES 264329 */
	<!-- CIF changes - Tabbing & Saving -->
	
	<!--Recon for Security Audit Changes from CRM10301BSUPP-->
		 secureKey=item.getAttribute('hashkey');  
		 secureField=item.getAttribute('fieldHashkey1');
		 deleteCookie('HASHKEY');							
		 deleteCookie('FLDHASHKEY');
		 setCookie('HASHKEY', secureKey, expirationdate);			
		 setCookie('FLDHASHKEY', secureField, expirationdate);
	<!--Recon for Security Audit Changes from CRM10301BSUPP-->
        savePersistData();

        if(prevsaId != AccountID) {
            prevsaId = AccountID;
        }
      }
if(!showDefTabs){
  function showDefTabs() {
  }
}

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
            var options=]]>"<xsl:value-of select="$query"/>"
            <![CDATA[;var queryText=]]>"<xsl:value-of select="$queryText"/>"
            <![CDATA[;
                 eval("window.location.href='../servlet/com.infy.cis.ui.common.AdvancedContactSearchResults?SortColumn=" +sortColumn+ "&amp;SortOrder=" +sortOrder+ "&amp;Query=" +escape(options)+ "&amp;QueryText=" +escape(queryText)+ "&amp;BOName=AccountBO&amp;ViewName="+vName+"&amp;ScreenName="+ScreenName+"&amp;SearchFrom=" +searchFrom+"'");
        } else {
        try {
            <!-- CIF changes - Search FrameWork -->
            var doc = parent.frames(0).frames(0).document;
            <!-- CIF changes - Search FrameWork -->
            <!-- changes for TOL 557453 -->
            label = doc.form_filters.FilterParam10.value;
	    
	                                                    if (doc.form_filters.FilterParam10.value == "Blacklisted") {                                                           
	                                                                    doc.form_filters.FilterParam10.value = "*";         
	                                                    }
	                                                    else if (doc.form_filters.FilterParam10.value == "Negated") {                                                     
	                                                                    doc.form_filters.FilterParam10.value = "*";                         
	                                                    }
	                                                    else if (doc.form_filters.FilterParam10.value == "Suspended") {                                                                
	                                                                    doc.form_filters.FilterParam10.value = "*";                         
	                                    
                                                } 
            
            
            <!-- changes for TOL 557453 -->
            <!--doc.all.SortColumn.value = sortColumn;-->
            <!--doc.all.SortOrder.value = sortOrder;-->
            <!--Changes for call id 581736 begin-->
		var arrValue = new Array();
		arrValue[0] = doc.form_filters.FilterParam1.value;
		arrValue[1] = doc.form_filters.FilterParam3.value;
		arrValue[2] = doc.form_filters.FilterParam2.value;
		arrValue[3] = doc.form_filters.FilterParam17.value;
		arrValue[4] = doc.form_filters.DispFilterParam23.value;
		arrValue[5] = doc.form_filters.DispFilterParam24.value;
		var strValue = fnCheckMandatory(arrValue,ScreenName,'',vName);
		if(strValue==false){
			showMessage(MSGJ61729);
			doc.form_filters.FilterParam1.value="";
			doc.form_filters.FilterParam3.value="";
			doc.form_filters.FilterParam2.value="";
			doc.form_filters.FilterParam17.value="";
			doc.form_filters.FilterParam11.value="";
			//Made the following change due to incompatibilty of JS method focus() and IE8 
			//document.form_filters.FilterParam1.focus();
			setTimeout(function() { doc.form_filters.FilterParam1.focus(); }, 0);
			return false;
		}

            <!--Changes for call id 581736 ends-->
            doc.form_filters.SortColumn.value = sortColumn;
	    doc.form_filters.SortOrder.value = sortOrder;
            doc.form_filters.submit();
            <!-- changes for TOL 557453 -->
            doc.form_filters.FilterParam10.value = label;
            <!-- changes for TOL 557453 -->
        }
            catch(e)
	    		{
	    		var doc1 = parent.parent.frames(0).frames(0).document;
	    		<!-- changes for TOL 557453 -->
	    		
	    		label = doc1.form_filters.FilterParam10.value;
			                                                if (doc1.form_filters.FilterParam10.value == "Blacklisted") {                                                         
			                                                                doc1.form_filters.FilterParam10.value = "*";      
			                                                }
			                                                else if (doc1.form_filters.FilterParam10.value == "Negated") {                                                   
			                                                                doc1.form_filters.FilterParam10.value = "*";                      
			                                                }
			                                                else if (doc1.form_filters.FilterParam10.value == "Suspended") {                                                              
			                                                                doc1.form_filters.FilterParam10.value = "*";                      
			                                                                                
                                                }
	    		
	    		
	    		<!-- changes for TOL 557453 -->
	    		doc1.form_filters.SortColumn.value = sortColumn;
	    		doc1.form_filters.SortOrder.value = sortOrder;
	    		doc1.form_filters.submit();
	    		<!-- changes for TOL 557453 -->
	    		doc1.form_filters.FilterParam10.value = label;
	    		
	    		<!-- changes for TOL 557453 -->
		}
        }
           }]]>
       /*This function displays Entity details*/
       function onClickLastName(){
        var currURL = null;
	if (AccountId== null || AccountId=="" || AccountId== 'null') {
             return;
        }
        // Tracker ID - 90197 Begin of Changes for attribute masking
	AccessOwnerGroup = getCookie('AccessOwnerGroup');
        //  Tracker ID - 90197 End of Changes
	var str = "";
	var hashkey=getBrowserCookie('HASHKEY');
	var fldhashkey=getBrowserCookie('FLDHASHKEY');
	
	str = "../servlet/com.infy.cis.ui.admin.ScreenPop_GetEntityDetails?EntityID=" + entityId + "&amp;EntityType=" + entityType+ "&amp;AccessOwnerGroup=" + AccessOwnerGroup+"&amp;AddressType=" + address+"&amp;SECUREHKEY="+hashkey+"&amp;FLDHASHKEY="+fldhashkey;

	var retVal = fnAuthenticateCustom(entityType, entityID)  /*Call to the customisation function for authentication*/
	if(!retVal)
	{
	    /* Tracker:108381:Centering of pop-up */
		
		// hardcoded values
		
		var wh = 460;
		
		var ww = 900;
		
		// end hardcoded values
		
		 
		
		var left_x = (screen.width - ww) / 2 ;
		
		var left_y = (screen.height - wh) / 2 ;
		

		var newWin = window.open(str, 'EntityInfo','height='+wh+',left='+left_x+',top='+left_y+',width='+ww+',resizable=no,menubar=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
	    
	    /* Tracker:108381:End of changes */	
	}
      }

// CIF Grouphoushold Change starts
     function onClickHouseHold() {
		if (AccountId== null || AccountId=="" || AccountId== 'null') {
		             return;
        }
                //Security Changes  Start
			            try{
			            	var hashkey=getCookie('HASHKEY');
			            	var fldhashkey=getCookie('FLDHASHKEY');
		    	}catch(e){}
        
    <!--Tracker:108382:Modal Window change-->
        var str = "";
	//Changes for tracker ID 449744 start
		str = "../servlet/com.infy.cis.ui.corpcif.ListofGroupHshldLinked?EntityID=" + AccountId +"&amp;SECUREHKEY="+hashkey+"&amp;FLDHASHKEY="+fldhashkey+"&amp;EntityType=" + entityType+"&amp;AccountId=" + AccountId;
	//Changes for tracker ID 449744 end
       var newWin = window.open(str, 'ListofHouseHoldLinked','height=436, left=70, top=120, width=860,resizable=no,menubar=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
 	//Change for tracker ID 452108
 	//var newWin = window.showModalDialog(str, 'ListofHouseHoldLinked','dialogHeight:460px; dialogWidth:900px;directories=No,location=no, menubar=no, resizable=yes, status=no, toolbar=no, scrollbars');
	hLinkWindow=newWin;
 	
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

// CIF GroupHousehold Change ends
    </script>
        </head>
	<body class="popup" onfocus="setFocust()" onmouseover="setFocust()" onclick="setFocust()">
	
	 </body>
	<form name="frmOD" target='Omnidoc' method="post" action="">
	</form>

      <xsl:call-template name="bodystart"/>
      </xsl:if>
      <!-- CIF changes for EntitySearch, starts -->
	<xsl:choose>
	<xsl:when test="normalize-space($searchFrom)='CIF'">
	<xsl:call-template name="mainbody">
                 <xsl:with-param name="tablename">RecordSet</xsl:with-param>
                 <xsl:with-param name="extra_tableHeader"><xsl:value-of select='$queryText' /></xsl:with-param>
                 <xsl:with-param name="pageIndex"><xsl:value-of select="$pageIndex"/></xsl:with-param>
                 <xsl:with-param name="NumPages"><xsl:value-of select="$NumPages"/></xsl:with-param><!--TRACKER# 92380-->
                 <xsl:with-param name="callcalme">1</xsl:with-param>
                 <xsl:with-param name="showNext">true</xsl:with-param>
                 <xsl:with-param name="callselectLastSelected">1</xsl:with-param>
                 <!-- CIF Changes- framework search -->
                 <xsl:with-param name="rclickshow">true</xsl:with-param>
                 <!-- CIF Changes- framework search -->
                 <xsl:with-param name="rowhighlight">true</xsl:with-param>
                 <xsl:with-param name="rsfilenm"><xsl:value-of select="$resfilename"/></xsl:with-param>
                 <xsl:with-param name="jscriptfnc">,identifyme()</xsl:with-param>
<!-- CRM101UB changes start-->                 
		 <xsl:with-param name="usabilityChange">true</xsl:with-param>
		 <xsl:with-param name="hyphonereq">false</xsl:with-param>
		 <xsl:with-param name="imgValueName">AccountBO.Suspended,AccountBO.Negated,AccountBO.BlackListed,AccountBO.Segmentation_Class,AccountBO.preferredPhoneType,AccountBO.UniqueIdType,AccountBO.RecordStatus,</xsl:with-param>
		<xsl:with-param name="imgValueNameLink_one">AccountBO.Suspended</xsl:with-param>
		<xsl:with-param name="imgValueNameLink_two">AccountBO.Negated</xsl:with-param>
		 <xsl:with-param name="imgValueNameLink_three">AccountBO.BlackListed</xsl:with-param>
		 <xsl:with-param name="imgValueNameFunc_one">ShowReasonCodes('suspend','Retail','entityId','Customer')</xsl:with-param>
		 <xsl:with-param name="imgValueNameFunc_two">ShowReasonCodes('negative','Retail','entityId','Customer')</xsl:with-param>
		 <xsl:with-param name="imgValueNameFunc_three">ShowReasonCodes('blacklist','Retail','entityId','Customer')</xsl:with-param>
		 <xsl:with-param name="phone_elements">AccountBO.preferredPhoneType,</xsl:with-param>
		 <!-- Tracker # 152449 Changes BEGIN -->
		 <xsl:with-param name="colhrefname">AccountBO.Cust_Last_Name</xsl:with-param>
                 <xsl:with-param name="colhref_function">composeHTMLEmail('Account',AccountId)</xsl:with-param>
                 <!-- Tracker # 152449 Changes END -->
		<!--219916 Changes start-->
                 <xsl:with-param name="colhref_three">AccountBO.UniqueId</xsl:with-param>
		 <xsl:with-param name="colhrefthree_function">populateUniqueIDs(AccountId,'Account')</xsl:with-param>
		<!--219916 Changes end-->
		<xsl:with-param name="imgFieldName">AccountBO.AccountKey,</xsl:with-param>
		<xsl:with-param name="imgFieldNameLink_one">AccountBO.AccountKey</xsl:with-param>
		<xsl:with-param name="imgFieldNameFunc_one">populateCifEntityDetails('Main','Account',AccountId,ScreenName,viewnameScreenID)</xsl:with-param>		 
<!-- CRM101UB changes end-->

		<!--*************CR changes for tracker 113227 begin***********-->
		<xsl:with-param name="nameListingFlag">true</xsl:with-param>
		<!--*************CR changes for tracker 113227 end***********-->
                 </xsl:call-template>
		</xsl:when>
	<xsl:otherwise>
		<xsl:call-template name="mainbody">
			 <xsl:with-param name="tablename">RecordSet</xsl:with-param>
			 <xsl:with-param name="extra_tableHeader"><xsl:value-of select='$queryText' /></xsl:with-param>
			 <xsl:with-param name="pageIndex"><xsl:value-of select="$pageIndex"/></xsl:with-param>
			 <xsl:with-param name="NumPages"><xsl:value-of select="$NumPages"/></xsl:with-param><!--TRACKER# 92380-->
			 <xsl:with-param name="callcalme">1</xsl:with-param>
			 <xsl:with-param name="showNext">true</xsl:with-param>
			 <xsl:with-param name="callselectLastSelected">1</xsl:with-param>
			 <!-- CIF Changes- framework search -->
			 <xsl:with-param name="rclickshow">false</xsl:with-param>
			 <!-- CIF Changes- framework search -->
			 <xsl:with-param name="rowhighlight">true</xsl:with-param>
			 <xsl:with-param name="rsfilenm"><xsl:value-of select="$resfilename"/></xsl:with-param>
			 <xsl:with-param name="jscriptfnc">,identifyme()</xsl:with-param>
			 <xsl:with-param name="colhrefname">AccountBO.Cust_Last_Name</xsl:with-param>
			 <xsl:with-param name="colhref_function">onClickLastName()</xsl:with-param>
		     <xsl:with-param name="name"><xsl:value-of select="$configLabels[@name='HouseHold']/@configLabel"/></xsl:with-param>
		     <xsl:with-param name="hardcoded_string">true</xsl:with-param>
  	  		 <xsl:with-param name="extra_colheader2"><xsl:value-of select="$configLabels[@name='HouseHold']/@configLabel"/></xsl:with-param>
		     <xsl:with-param name="colhrefone_function">onClickHouseHold()</xsl:with-param>

			<!--vasanth's changes start-->
			
	         <!--<xsl:with-param name="colhref_four">AccountBO.Suspended</xsl:with-param>
	         <xsl:with-param name="colhref_three">AccountBO.Negated</xsl:with-param>
	         <xsl:with-param name="colhref_two">AccountBO.BlackListed</xsl:with-param>
			 <xsl:with-param name="colhreffour_function">ShowReasonCodes('suspend','Retail','entityId','Customer')</xsl:with-param>
			 <xsl:with-param name="colhrefthree_function">ShowReasonCodes('negative','Retail','entityId','Customer')</xsl:with-param>
			 <xsl:with-param name="colhreftwo_function">ShowReasonCodes('blacklist','Retail','entityId','Customer')</xsl:with-param>-->
			 
			
			<!--vasanth's changes end-->
			<!--Sanity fixes Start-->
			<xsl:with-param name="usabilityChange">true</xsl:with-param>
			<xsl:with-param name="hyphonereq">false</xsl:with-param>
			<xsl:with-param name="imgValueName">AccountBO.Suspended,AccountBO.Negated,AccountBO.BlackListed,AccountBO.Segmentation_Class,AccountBO.preferredPhoneType,AccountBO.UniqueIdType,AccountBO.RecordStatus,</xsl:with-param>
			<xsl:with-param name="imgValueNameLink_one">AccountBO.Suspended</xsl:with-param>
			<xsl:with-param name="imgValueNameLink_two">AccountBO.Negated</xsl:with-param>
			<xsl:with-param name="imgValueNameLink_three">AccountBO.BlackListed</xsl:with-param>
			<xsl:with-param name="imgValueNameFunc_one">ShowReasonCodes('suspend','Retail','entityId','Customer')</xsl:with-param>
			<xsl:with-param name="imgValueNameFunc_two">ShowReasonCodes('negative','Retail','entityId','Customer')</xsl:with-param>
			<xsl:with-param name="imgValueNameFunc_three">ShowReasonCodes('blacklist','Retail','entityId','Customer')</xsl:with-param>
			<xsl:with-param name="phone_elements">AccountBO.preferredPhoneType,</xsl:with-param>
			<xsl:with-param name="colhref_two">AccountBO.Cust_Last_Name</xsl:with-param>
			<xsl:with-param name="colhreftwo_function">composeHTMLEmail('Account',AccountId)</xsl:with-param>
			<xsl:with-param name="imgFieldName">AccountBO.AccountKey,</xsl:with-param>
			<xsl:with-param name="imgFieldNameLink_one">AccountBO.AccountKey</xsl:with-param>
			<xsl:with-param name="imgFieldNameFunc_one">populateCifEntityDetails('Main','Account',AccountId,ScreenName,viewnameScreenID)</xsl:with-param>		
		 	<!--Sanity Fixes End-->
		 	
		 	<!--*************CR changes for tracker 113227 begin***********-->
		 	<xsl:with-param name="nameListingFlag">true</xsl:with-param>
		 	<!--*************CR changes for tracker 113227 end***********-->

			</xsl:call-template>
		</xsl:otherwise>
		</xsl:choose>
		<!-- CIF changes for EntitySearch, ends -->
  	</xsl:template>
 </xsl:stylesheet>




















