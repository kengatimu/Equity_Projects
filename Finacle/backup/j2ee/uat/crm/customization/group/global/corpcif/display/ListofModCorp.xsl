<?xml version='1.0'?>
  <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="../Renderer/common/display/SRMListTemplate.xsl"/>
        <xsl:param name="locale"/>
  <!-- tracker ID: 161033 START OF CHANGES-->       
  <xsl:variable name="file1">../Renderer/corpcif/resource/ListofModCorp_<xsl:value-of select="$locale"/>.xml</xsl:variable>
  <xsl:variable name="configFile_1" select="document(concat($file1, ''))"/>
  <xsl:variable name="configLabels" select="$configFile_1/SRMBO/*"/>
<!-- tracker ID: 161033 END OF CHANGES--> 
  <xsl:variable name="CORPORATE_NAME" select="/SRM/SRMData[@SRMDataSpace='CustomData']//Z[@n='CORPORATE_NAME']"/>
  <xsl:variable name="CORP_KEY" select="/SRM/SRMData[@SRMDataSpace='CustomData']//Z[@n='CORP_KEY']"/>
  <xsl:variable name="EntityType" select="/SRM/SRMData[@SRMDataSpace='CustomData']//Z[@n='EntityType']"/>
  <xsl:variable name="modDiffFlag" select="/SRM/SRMData[@SRMDataSpace='CustomData']//Z[@n='modDiffFlag']"/>
  <xsl:variable name="RepID" select="/SRM/SRMData[@SRMDataSpace='CustomData']//Z[@n='REPID']"/>
  <xsl:variable name="Type" select="/SRM/SRMData[@SRMDataSpace='CustomData']//Z[@n='Type']"/>
  <xsl:variable name="secondHeader" select="/SRM/SRMData[@SRMDataSpace='CustomData']//Z[@n='secondHeader']"/>
  <xsl:variable name="Graphics" select="/SRM/SRMData[@SRMDataSpace='CustomData']//Z[@n='Graphics']"/>
  <xsl:variable name="SavedSubmitted" select="/SRM/SRMData[@SRMDataSpace='CustomData']//Z[@n='SavedSubmitted']"/>
  <xsl:variable name="bank_ID" select="/SRM/SRMData[@SRMDataSpace='CustomData']//Z[@n='bank_ID']"/>
  <!-- Changes for TOL 669275 starts -->
  <xsl:variable name="cifType" select="/SRM/SRMData[@SRMDataSpace='CustomData']//Z[@n='cifType']"/>
  <!-- Changes for TOL 669275 ends -->
  
  <!-- CRM70T-ST TRACKER:80385:BEGINOFCHANGES --> 
  <xsl:variable name="repTemp" select="/SRM/SRMData[@SRMDataSpace='CustomData']//Z[@n='repTemp']"/>
  <xsl:variable name="groupTemp" select="/SRM/SRMData[@SRMDataSpace='CustomData']//Z[@n='groupTemp']"/>
  <xsl:variable name="groupIdTemp" select="/SRM/SRMData[@SRMDataSpace='CustomData']//Z[@n='groupIdTemp']"/>
  <xsl:variable name="GRPID" select="/SRM/SRMData[@SRMDataSpace='CustomData']//Z[@n='GRPID']"/>
  <!-- CRM70T-ST TRACKER:80385:ENDOFCHANGES --> 
  
  <xsl:param name="resfilename"/>
  <xsl:param name="pageIndex" select="0"/>
  <xsl:param name="NumPages"/>
<xsl:template match="/">
	<xsl:if test="$pageIndex &lt;=1">
	<xsl:call-template name="htmlstart"/>
<html>	
      <head>
      <script type="text/javascript" language="javascript" src="../corpcif/js/Message_corpcif_{$locale}.js"></script>
      <script type="text/javascript" src="../common/js/ClientResourceBundle_{$locale}.js" language="javascript"></script>
      <script type="text/javascript" src="../common/js/Message_common_{$locale}.js" language="javascript"></script>
	<script type="text/javascript" language="javascript" src="../common/js/Rendcommon.js"></script>
      <script type="text/javascript" language="javascript" src="../corpcif/js/ListofModCorp.js"></script>
      
      <script>
      var SavedSubmitted = '<xsl:value-of select="$SavedSubmitted"/>';
      var grpid = '<xsl:value-of select="$GRPID"/>';
	  // Changes for TOL 669275 starts
	  var cifType = '<xsl:value-of select="$cifType"/>';
	  // Changes for TOL 669275 ends
      </script>
        <xsl:if test="$modDiffFlag ='Y'">
      	      <script type="text/javascript" language="javascript" src="../Customization/corpcif/js/RendSRMCorpModRightClick.js"></script>
      	</xsl:if>
	
      	<xsl:if test="$SavedSubmitted ='Saved'">
	<script>
      	      </script>
	<script type="text/javascript" language="javascript" src="../Customization/corpcif/js/RendSRMCorpModRightClick.js"></script>
      	</xsl:if>
      	<xsl:if test="$modDiffFlag ='N'">
      	      <script>
      	      </script>
      	    	<xsl:if test="$SavedSubmitted !='Saved'">
	         <script>
      	      </script>
	      <script type="text/javascript" language="javascript" src="../corpcif/js/RendSRMCorpRightClick.js"></script>
	</xsl:if>		
	</xsl:if>
<script>
var locale = '<xsl:value-of select="$locale"/>';
var NumPages = '<xsl:value-of select="$NumPages"/>';<!-- TRACKER# 92380-->
var Type = '<xsl:value-of select="$Type"/>';
/*  CRM70T-ST:TRACKER:80385:BEGINOFCHANGES */
var repTemp = '<xsl:value-of select="$repTemp"/>';
var groupTemp = '<xsl:value-of select="$groupTemp"/>';
var groupIdTemp = '<xsl:value-of select="$groupIdTemp"/>';
/*  CRM70T-ST:TRACKER:80385:ENDOFCHANGES */
var RepID = '<xsl:value-of select="$RepID"/>';
var CORP_KEY = '<xsl:value-of select="$CORP_KEY"/>';
var EntityType = '<xsl:value-of select="$EntityType"/>';
var modDiffFlag = '<xsl:value-of select="$modDiffFlag"/>';
var CORPORATE_NAME = '<xsl:value-of select="$CORPORATE_NAME"/>';
var bank_ID='<xsl:value-of select="$bank_ID"/>';
</script>
        <link rel="stylesheet" type="text/css" href="../Branding/css/common/SRMTableDisplay_{$locale}.css"/>
        <link rel="stylesheet" Type="text/css" href="../Branding/css/common/PopupMenu_{$locale}.css"/>
        <link rel="stylesheet" Type="text/css" href="../Branding/css/common/SRMListTemplate_{$locale}.css"/>
        <script type="text/javascript" id="TableRowColor" src="../common/js/SRMTableRowColor.js"></script>        
        <script type="text/javascript" src="../common/js/PopupMenu.js"></script>        
    
	
	
      <xsl:if test="$Type ='Rep'">
		<xsl:choose>
			<xsl:when test="$modDiffFlag ='N' and $SavedSubmitted='SubmittedProc'">
			<xsl:choose>
			<xsl:when test="normalize-space($EntityType)='Non Customer'">
				<script type="text/javascript" src="../corpcif/js/CorpNonCustomerRCLForSub_{$locale}.js"></script>	
			</xsl:when>
			<xsl:otherwise>
				<script type="text/javascript" src="../corpcif/js/CorpRCLOptionsForSubmit_{$locale}.js"></script>
			</xsl:otherwise>
			</xsl:choose>			
			</xsl:when>
			<xsl:otherwise>
			<xsl:choose>
			<xsl:when test="normalize-space($EntityType)='Non Customer'">
				<script type="text/javascript" src="../corpcif/js/CorpNonCustomerRCL_{$locale}.js"></script>	
			</xsl:when>
			<xsl:otherwise>
				<script type="text/javascript" src="../Customization/corpcif/js/CorpRCLOptions_{$locale}.js"></script>
			</xsl:otherwise>
		</xsl:choose>	
			</xsl:otherwise>
		</xsl:choose>	
			
	</xsl:if>
	
	<xsl:if test="$Type ='Group'">
		<script type="text/javascript" src="../corpcif/js/CorpGroupRCLOptions_{$locale}.js"></script>
	</xsl:if>		
	
        <script>
         
          var corporateURL = "";
          var corMod_ID = "";
          var groupId = "";
          var prevCorpId = "";	      
          var mode = "";
          var local_prefix="CifCustomer";
          var expirationdate = new Date ();
          var repId = '<xsl:value-of select="$RepID"/>';
           var makerID = "";
          var assignedBy = "";
       
          var corp_ID='';
          var  corporateKey;
          var ownerID='';
          var record='';
          var doi = "";
	  var tfFlag ="";
          var isMCEdited=""; //Tracker 98769 Change
  		  /* Changes for ticket 308849 starts */
		  var status = "";
  		  /* Changes for ticket 308849 ends */

                   
          
		
		
		
       function selectLastSelected()
       {	
       		
       		try {
       		if(modDiffFlag=='Y') {
       		
       		
	       	corpMod_ID=getCookie("corpMod_ID"); 	
	       	
	    		if((corpMod_ID != null) &amp;&amp; (corpMod_ID != 'null')&amp;&amp;(corpMod_ID != "")&amp;&amp;(corpMod_ID != "undefined")) {
	    	
		
		       showDefTabs();   
			prevCorpId=corMod_ID;	       	       
		
           	
	       		} 
	       		
	       	} else {
	       	
	       	corp_ID=getCookie("corp_ID"); 
	       	  
		if((corp_ID != null) &amp;&amp; (corp_ID != 'null')&amp;&amp;(corp_ID != "")&amp;&amp;(corp_ID != "undefined")) {
	       showDefTabs();   
           	prevCorpId=corp_ID;	       	       
	       	  }
	       	}
	       }
	       catch(e){
	       DebugMessage(e.message);
	       }
       
       }
       
       function Dispatch_getCookie ()
	 {	
		var id = TableRowColor ;
     		if (id.readyState == "complete") 
     		{
			id.onreadystatechange = null;
			mode = getCookie("Mode");
			deleteall() ;
	     	}
	     	
	 }
	function  call_getCookie ()
	  {	
	      	var id = TableRowColor ;
		if (id.readyState == "complete") {
		     mode = getCookie("Mode");
			 deleteall() ;
          } else {
		    id.onreadystatechange = Dispatch_getCookie;
		}
	   }
	   
	   
          function deleteall()
          {		
          	setCookie('CorporateURL', "", expirationdate);  	  	
  	  	setCookie('corpMod_ID', "", expirationdate);
  	  	setCookie('GroupID', "", expirationdate);
		setCookie('makerID', "", expirationdate);
		setCookie('RepID',"",expirationdate);
		setCookie('assignedBy',"",expirationdate);	
		setCookie('corp_Key',"",expirationdate);
		setCookie('AssignedTo',"",expirationdate);
		setCookie('EntityType',"",expirationdate);
		setCookie('LastEditedPage',"",expirationdate);
		
          }
         function setMode () 
         {           
            	
            	call_getCookie ();
            	
            	
             if(document.all.RecordSet &amp;&amp;
             	document.all.RecordSet.rows &amp;&amp;
             	document.all.RecordSet.rows != null &amp;&amp;
                document.all.RecordSet.rows.length == 3) {
             	corMod_ID=document.all.RecordSet.rows(2).getAttribute('CorporateModBO.corp_Mod_ID');
             	
             	
             }
          }
          
       
       
	function identifyme()  
	{	
		var coreCustID='';
		//changes made for corporate
		loadPersistData();
		var item = event.srcElement.parentElement;
		
		if(item.id == null || item.id == '') {
		    item = item.parentElement;
		    if (item.id == null || item.id == '') item = item.parentElement;
		}
		
		if((modDiffFlag=='Y')||(SavedSubmitted=="Saved")) {

			corporateURL		=item.getAttribute('CorporateModBO.url_');				
			corpMod_ID		=item.getAttribute('CorporateModBO.corp_Mod_ID');
			groupId			=item.getAttribute('CorporateModBO.assigned_Group_ID');
			makerID			=item.getAttribute('CorporateModBO.bOCreatedBy');
			assignedBy		=item.getAttribute('CorporateModBO.assigned_By_User_ID');		
			corporateKey		=item.getAttribute('CorporateModBO.corp_Key');
			AssignedTo		=item.getAttribute('CorporateModBO.assigned_User_ID');
			ownerID			=item.getAttribute('CorporateModBO.owner_User_ID');
			record			=item.getAttribute('CorporateModBO.record_Status');
			processId		=item.getAttribute('CorporateModBO.processID');
			status			=item.getAttribute('CorporateModBO.processStatus');	
			corpName		=item.getAttribute('CorporateModBO.corporate_Name');	
			coreCustID		=item.getAttribute('CorporateModBO.core_Cust_ID');	
			AccessOwnerGroup	=item.getAttribute('CorporateModBO.accessOwnerGroup');
			doi			=item.getAttribute('CorporateModBO.date_Of_Incorporation');	
			LastEditedPage		=item.getAttribute('CorporateModBO.LastEditedPage');
			tfFlag 			=item.getAttribute('CorporateModBO.trade_Services_Availed');
			blacklisted		=item.getAttribute('CorporateModBO.blacklist_flag');	
			negated			=item.getAttribute('CorporateModBO.negative_flag');	
			suspended		=item.getAttribute('CorporateModBO.suspend_flag');
			currStep		=item.getAttribute('CorporateModBO.currentStep');
       	   		isMCEdited		=item.getAttribute('CorporateModBO.IsMCEdited');			
	   		IsTampered		=item.getAttribute('CorporateModBO.IsTampered');
	   		<!--Recon for Security Audit Changes from CRM10301BSUPP-->
			 secureKey=item.getAttribute('hashkey');  
			 secureField=item.getAttribute('fieldHashkey1');			 
			<!--Recon for Security Audit Changes from CRM10301BSUPP-->
	   		
	   		if(null != corpMod_ID) {

				deleteCookie('corpMod_ID');
				setCookie('AccessOwnerGroup', AccessOwnerGroup, expirationdate);
				setCookie('tfFlag', tfFlag, expirationdate);
				setCookie('CorporateURL', corporateURL, expirationdate);
				setCookie('corpMod_ID', corpMod_ID, expirationdate);
				setCookie('GroupID', groupId, expirationdate);
				setCookie('makerID', makerID, expirationdate);
				setCookie('RepID',repId,expirationdate);
				setCookie('assignedBy',assignedBy,expirationdate);	
				setCookie('corp_Key',corporateKey,expirationdate);
				setCookie('AssignedTo',AssignedTo,expirationdate);
				setCookie('EntityType',EntityType,expirationdate);
				setCookie('OwnerID',ownerID,expirationdate);
				setCookie('Record',record,expirationdate);
				setCookie('processID',processId,expirationdate);
				setCookie('status',status,expirationdate);
				setCookie('corpName',corpName,expirationdate);
				setCookie('coreCustID',coreCustID,expirationdate);
				setCookie('doi',doi,expirationdate);
				setCookie('LastEditedPage',LastEditedPage,expirationdate);
				setCookie('BlackListed',blacklisted,expirationdate);
				setCookie('Negated',negated,expirationdate);
				setCookie('Suspended',suspended,expirationdate);
				setCookie('currStep',currStep,expirationdate);
				setCookie('isMCEdited',isMCEdited,expirationdate);
				setCookie('IsTampered',IsTampered,expirationdate);
				<!--Recon for Security Audit Changes from CRM10301BSUPP-->
				deleteCookie('HASHKEY');							
				deleteCookie('FLDHASHKEY');
				setCookie('HASHKEY', secureKey, expirationdate);			
			        setCookie('FLDHASHKEY', secureField, expirationdate);
				<!--Recon for Security Audit Changes from CRM10301BSUPP-->
				savePersistData();
				showDefTabs(); 
				prevCorpId=corpMod_ID;
			}
		
       	      }else if((modDiffFlag=='N') &amp;&amp; (SavedSubmitted != "Saved")) { 
       	      	
       	     		corporateURL		=item.getAttribute('CorporateBO.url_');				
			corp_ID			=item.getAttribute('CorporateBO.corp_ID');
			groupId			=item.getAttribute('CorporateBO.assigned_Group_ID');
			makerID			=item.getAttribute('CorporateBO.bOCreatedBy');
			assignedBy		=item.getAttribute('CorporateBO.assigned_By_User_ID');					
			corporateKey		=item.getAttribute('CorporateBO.corp_Key');
			AssignedTo		=item.getAttribute('CorporateBO.assigned_User_ID');
			ownerID			=item.getAttribute('CorporateBO.owner_User_ID');
			record			=item.getAttribute('CorporateBO.record_Status');
			processId		=item.getAttribute('CorporateBO.processID');
			status			=item.getAttribute('CorporateBO.processStatus');	
			corpName		=item.getAttribute('CorporateBO.corporate_Name');	
			coreCustID		=item.getAttribute('CorporateBO.Core_Cust_ID');	
			AccessOwnerGroup	=item.getAttribute('CorporateBO.accessOwnerGroup');
			LastEditedPage		=item.getAttribute('CorporateBO.LastEditedPage');
			tfFlag			=item.getAttribute('CorporateBO.trade_Services_Availed');
			currStep		=item.getAttribute('CorporateBO.CurrentStep');
			isMCEdited		=item.getAttribute('CorporateBO.IsMCEdited');	 
			IsTampered		=item.getAttribute('CorporateBO.IsTampered');	 
			doi			=item.getAttribute('CorporateBO.date_Of_Incorporation');	
			blacklisted		=item.getAttribute('CorporateBO.blacklist_flag');	
			negated			=item.getAttribute('CorporateBO.negative_flag');	
			suspended		=item.getAttribute('CorporateBO.suspend_flag');	
			<!--Recon for Security Audit Changes from CRM10301BSUPP-->
			 secureKey=item.getAttribute('hashkey');  
			 secureField=item.getAttribute('fieldHashkey1');			 
			<!--Recon for Security Audit Changes from CRM10301BSUPP-->
			if(null != corp_ID) {

				deleteCookie('corp_ID');
				setCookie('AccessOwnerGroup', AccessOwnerGroup, expirationdate);
				setCookie('tfFlag', tfFlag, expirationdate);
				setCookie('CorporateURL', corporateURL, expirationdate);
				setCookie('corp_ID', corp_ID, expirationdate);
				setCookie('groupId', groupId, expirationdate);
				setCookie('makerID', makerID, expirationdate);
				setCookie('RepID',repId,expirationdate);
				setCookie('assignedBy',assignedBy,expirationdate);	
				setCookie('corp_Key',corporateKey,expirationdate);
				setCookie('AssignedTo',AssignedTo,expirationdate);
				setCookie('EntityType',EntityType,expirationdate);
				setCookie('OwnerID',ownerID,expirationdate);
				setCookie('Record',record,expirationdate);
				setCookie('processID',processId,expirationdate);
				setCookie('status',status,expirationdate);
				setCookie('corpName',corpName,expirationdate);
				setCookie('coreCustID',coreCustID,expirationdate);
				setCookie('doi',doi,expirationdate);
				setCookie('LastEditedPage',LastEditedPage,expirationdate);
				setCookie('currStep',currStep,expirationdate);
				setCookie('isMCEdited',isMCEdited,expirationdate);
				setCookie('IsTampered',IsTampered,expirationdate);
				setCookie('BlackListed',blacklisted,expirationdate);
				setCookie('Negated',negated,expirationdate);
				setCookie('Suspended',suspended,expirationdate);
				<!--Recon for Security Audit Changes from CRM10301BSUPP-->
				deleteCookie('HASHKEY');							
				deleteCookie('FLDHASHKEY');
				setCookie('HASHKEY', secureKey, expirationdate);			
				setCookie('FLDHASHKEY', secureField, expirationdate);
				<!--Recon for Security Audit Changes from CRM10301BSUPP-->
				savePersistData();
				showDefTabs(); 
				prevCorpId=corp_ID;					
			}
       	        }
       	}
	
	
	/*  CRM70T-ST:TRACKER:80385:BEGINOFCHANGES */	
	/*<![CDATA[  
	function sortMe(col, order) {                                    
	
	var expdate = new Date ();  
	expdate.setTime(expdate.getTime() + ( 160 * 60 * 60 * 1000));
	setCookie('SORT_ORDER_ListofModAccounts', order,expdate);
	setCookie('SORT_COLUMN_ListofModAccounts', col,expdate);                           
	    if( Type == "Rep" ){
	    eval("window.location.href='../servlet/com.infy.cis.ui.corpcif.ListofModCorp?SortColumn=" +col+ "&amp;EntityType=" +EntityType+ "&amp;Rep=" +repTemp+ "&amp;SortOrder=" +order+ "' ");
	    }
	    else if( Type == "Group" ){
	    eval("window.location.href='../servlet/com.infy.cis.ui.corpcif.ListofModCorp?SortColumn=" +col+ "&amp;EntityType=" +EntityType+ "&amp;Group=" +groupTemp+ "&amp;GroupID=" +groupIdTemp+ "&amp;SortOrder=" +order+ "' ");
	    }
	    savePersistData();
	   }]]>*/
	/*  CRM70T-ST:TRACKER:80385:ENDOFCHANGES */   
        </script>
        </head>
        
        <!--<body bgcolor="ffffff" onload="setMode()">
        </body>-->
<!--Changes for ticket id: 684995 starts-->
        <body onload="selectLastSelected()">
        </body>
<!--Changes for ticket id: 684995 ends-->        
        </html>
        <xsl:call-template name="bodystart"/>
	
	<form name="frm2" action="" ENCTYPE="multipart/form-data">
			
			<input type="hidden" name="RepID" value="{$RepID}"/>
			<input type="hidden" name="ie5menu" value=""/>
			<input type="hidden" name="SortColumn" value=""/>
			<input type="hidden" name="SortOrder" value=""/>
			<input type="hidden" name="CorpType" value= ""/>
			<input type="hidden" name="CorporateName" value= ""/>		
			<input type="hidden" name="CorporateDate" value= ""/>
			<input type="hidden" name="CorporateKey" value=""/>
			<input type="hidden" name="SuspendedFlag" value=""/>
			<input type="hidden" name="BlacklistFlag" value=""/>
			<input type="hidden" name="NagativeFlag" value=""/>
			<input type="hidden" name="Designation" value=""/>
			<input type="hidden" name="EntityType" value=""/>
			<input type="hidden" name="entityID" value=""/>
			<input type="hidden" name="QueryText" value=""/>
			<input type="hidden" name="Query" value=""/>
			<input type="hidden" name="Advanced" value=""/>
		        <input type="hidden" name="Graphics" value=""/>
		        <input type="hidden" name="Group" value=""/>
			<input type="hidden" name="Rep" value=""/>
			<input type="hidden" name="GroupID" value=""/>
		        <input type="hidden" name="savedSubmitted" value=""/>
		        <input type="hidden" name="BCFlag" value=""/>
		        <input type="hidden" name="BCID" value=""/>
		        <input type="hidden" name="bank_ID" value="{$bank_ID}"/>
		        
	</form>
      </xsl:if>
<xsl:choose>      
      <xsl:when test="$modDiffFlag ='Y' or $SavedSubmitted='Saved'">      
	       <xsl:call-template name="mainbody">
	         <xsl:with-param name="tablename">RecordSet</xsl:with-param>
	         <xsl:with-param name="graphics"><xsl:value-of select="$Graphics"/></xsl:with-param>
	         <xsl:with-param name="extra_tableHeader"><xsl:value-of select="$secondHeader"/></xsl:with-param>
	         <xsl:with-param name="pageIndex"><xsl:value-of select="$pageIndex"/></xsl:with-param>	         
	         <xsl:with-param name="NumPages"><xsl:value-of select="$NumPages"/></xsl:with-param><!--TRACKER# 92380-->
	         <xsl:with-param name="callcalme">1</xsl:with-param>
		 <xsl:with-param name="callselectLastSelected">1</xsl:with-param>
		 <xsl:with-param name="rclickshow">true</xsl:with-param>
                 <xsl:with-param name="rowhighlight">true</xsl:with-param>
                 <xsl:with-param name="showNext">true</xsl:with-param>
	         <xsl:with-param name="rsfilenm"><xsl:value-of select="$resfilename"/></xsl:with-param>
	         <xsl:with-param name="jscriptfnc">,identifyme()</xsl:with-param>
	        <!-- Changes For Tracker ID- 153169, Ticket- 253480 Fix start --> 	
			<xsl:with-param name="usabilityChange">false</xsl:with-param>
	         
			<xsl:with-param name="usabilityChange">true</xsl:with-param>
			<xsl:with-param name="imgFieldName">CorporateModBO.corp_Key,</xsl:with-param>
			<xsl:with-param name="imgFieldNameLink_one">CorporateModBO.corp_Key</xsl:with-param>
			<xsl:with-param name="imgFieldNameFunc_one">copyRec('../servlet/com.infy.cis.ui.corpcif.CorpCreateDetWizard?IsReadOnly=Y&amp;fetchFrom=Mod')</xsl:with-param>

		    <xsl:with-param name="colhref_four">CorporateModBO.corp_Key</xsl:with-param>
		       <!-- Changes For Tracker ID- 163250 --> 
		    <xsl:with-param name="colhreffour_function">copyRec('../servlet/com.infy.cis.ui.corpcif.CorpCreateDetWizard?IsReadOnly=Y&amp;fetchFrom=Mod')</xsl:with-param>
		    <!-- Changes For Tracker ID- 153169, Ticket- 253480 Fix end --> 
			<xsl:with-param name="colhrefname">ASSIGNTONAME</xsl:with-param>
		 <xsl:with-param name="colhref_function">userDetails('AssignedTo',AssignedTo)</xsl:with-param>
			<xsl:with-param name="colhref_one">ASSIGNBYNAME</xsl:with-param>
		 <xsl:with-param name="colhrefone_function">userDetails('AssignedBy',assignedBy)</xsl:with-param>
			<xsl:with-param name="colhref_two">OWNERNAME</xsl:with-param>
		 <xsl:with-param name="colhreftwo_function">userDetails('Owner',ownerID)</xsl:with-param>		 
			<xsl:with-param name="colhref_three">MAKERNAME</xsl:with-param>
		 <xsl:with-param name="colhrefthree_function">userDetails('Maker',makerID)</xsl:with-param>
	 
		 <xsl:with-param name="checkbox">true</xsl:with-param>
		 <xsl:with-param name="checkboxOnClick">AddSelectedRowToList(this.value)</xsl:with-param>
		    
		    <!-- tracker ID: 161033 START OF CHANGES--> 
		    <xsl:with-param name="extra_colheader8"><xsl:value-of select="$configLabels[@name='SelectAll']/@configLabel"/></xsl:with-param>
		    <!-- tracker ID: 161033 END OF CHANGES--> 
		    <xsl:with-param name="extra_colheadercheckbox">Y</xsl:with-param>
		    <xsl:with-param name="extra_colheaderfn8">javascript:return selectAll();</xsl:with-param>
	       </xsl:call-template>
	</xsl:when>
	<xsl:otherwise>
	
	       <xsl:call-template name="mainbody">
	         <xsl:with-param name="tablename">RecordSet</xsl:with-param>
	         <xsl:with-param name="graphics"><xsl:value-of select="$Graphics"/></xsl:with-param>
	         <xsl:with-param name="extra_tableHeader"><xsl:value-of select="$secondHeader"/></xsl:with-param>
	         <!--CRM102ST: TrackerID:176681 Being of Change -->
	         <xsl:with-param name="NumPages"><xsl:value-of select="$NumPages"/></xsl:with-param>
	         <!--CRM102ST: TrackerID:176681 End of Change -->
	         <xsl:with-param name="pageIndex"><xsl:value-of select="$pageIndex"/></xsl:with-param>	         
	         <xsl:with-param name="callcalme">1</xsl:with-param>
		 <xsl:with-param name="callselectLastSelected">1</xsl:with-param>
		 <xsl:with-param name="rclickshow">true</xsl:with-param>
                 <xsl:with-param name="rowhighlight">true</xsl:with-param>
                 <xsl:with-param name="showNext">true</xsl:with-param>
	         <xsl:with-param name="rsfilenm"><xsl:value-of select="$resfilename"/></xsl:with-param>
		 <xsl:with-param name="jscriptfnc">,identifyme();doContextMenu1();</xsl:with-param>	
			
			<xsl:with-param name="usabilityChange">true</xsl:with-param>
			<xsl:with-param name="imgFieldName">CorporateBO.corp_Key,</xsl:with-param>
			<xsl:with-param name="imgFieldNameLink_one">CorporateBO.corp_Key</xsl:with-param>
			<xsl:with-param name="imgFieldNameFunc_one">copyRec('../servlet/com.infy.cis.ui.corpcif.CorpCreateDetWizard?IsReadOnly=Y')</xsl:with-param>
                <xsl:with-param name="colhref_four">CorporateBO.corp_Key</xsl:with-param>
		  <!-- Changes For Tracker ID- 163250 --> 
		<xsl:with-param name="colhreffour_function">copyRec('../servlet/com.infy.cis.ui.corpcif.CorpCreateDetWizard?IsReadOnly=Y')</xsl:with-param>
			<xsl:with-param name="colhrefname">ASSIGNTONAME</xsl:with-param>
		 <xsl:with-param name="colhref_function">userDetails('AssignedTo',AssignedTo)</xsl:with-param>
			<xsl:with-param name="colhref_one">ASSIGNBYNAME</xsl:with-param>
		 <xsl:with-param name="colhrefone_function">userDetails('AssignedBy',assignedBy)</xsl:with-param>
			<xsl:with-param name="colhref_two">OWNERNAME</xsl:with-param>
		 <xsl:with-param name="colhreftwo_function">userDetails('Owner',ownerID)</xsl:with-param>		 
			<xsl:with-param name="colhref_three">MAKERNAME</xsl:with-param>
		 <xsl:with-param name="colhrefthree_function">userDetails('Maker',makerID)</xsl:with-param>		 
 
		 <xsl:with-param name="checkbox">true</xsl:with-param>
		 <xsl:with-param name="checkboxOnClick">AddSelectedRowToList(this.value)</xsl:with-param>
		    
		 <!-- START - TRACKER -92380-->
		 <!-- tracker ID: 161033 START OF CHANGES--> 
		    <xsl:with-param name="extra_colheader8"><xsl:value-of select="$configLabels[@name='SelectAll']/@configLabel"/></xsl:with-param>
		    <!-- tracker ID: 161033 END OF CHANGES--> 
		    <xsl:with-param name="extra_colheadercheckbox">Y</xsl:with-param>
		    <xsl:with-param name="extra_colheaderfn8">javascript:return selectAll();</xsl:with-param>
		    <!--END - TRACKER -92380-->
	       </xsl:call-template>
	       
	</xsl:otherwise>
	</xsl:choose>

  </xsl:template>
 </xsl:stylesheet>







