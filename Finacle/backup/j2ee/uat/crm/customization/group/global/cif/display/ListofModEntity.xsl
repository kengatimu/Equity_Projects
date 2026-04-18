<?xml version='1.0'?>
  <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="../Renderer/common/display/SRMListTemplate.xsl"/>
        <xsl:param name="locale"/>
        
<!-- Tracker id: 161033. START OF CHANGES. -->         
<xsl:variable name="file1">../Renderer/Customization/cif/resource/ListofModEntity_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<xsl:variable name="configFile_1" select="document(concat($file1, ''))"/>
<xsl:variable name="configLabels" select="$configFile_1/SRMBO/*"/>
<!-- Tracker id: 161033. END OF CHANGES. --> 

  <xsl:variable name="Cust_Last_Name" select="/SRM/SRMData[@SRMDataSpace='CustomData']//Z[@n='Cust_Last_Name']"/>
  <xsl:variable name="accountKey" select="/SRM/SRMData[@SRMDataSpace='CustomData']//Z[@n='accountKey']"/>
  <xsl:variable name="RepID" select="/SRM/SRMData[@SRMDataSpace='CustomData']//Z[@n='REPID']"/>
  <xsl:variable name="Type" select="/SRM/SRMData[@SRMDataSpace='CustomData']//Z[@n='Type']"/>
  <!--srini changes for Entity queue search Starts-->
  <xsl:variable name="secondHeader" select="/SRM/SRMData[@SRMDataSpace='CustomData']//Z[@n='secondHeader']"/>
  <xsl:variable name="Graphics" select="/SRM/SRMData[@SRMDataSpace='CustomData']//Z[@n='Graphics']"/>
  <!--srini changes for Entity queue search Ends-->
<!-- Changes for Audit Enquiry CRMBAR02 Starts-->
    <xsl:variable name="ViewName" select="$userArea//Z[@n='ViewName']"/>
    <xsl:variable name="ScreenName" select="$userArea//Z[@n='ScreenName']"/>
<!-- Changes for Audit Enquiry CRMBAR02 Ends-->
  <xsl:variable name="GRPID" select="/SRM/SRMData[@SRMDataSpace='CustomData']//Z[@n='GRPID']"/>
  <xsl:param name="resfilename"/>
  <xsl:param name="pageIndex" select="0"/>
  <xsl:param name="NumPages"/>
<xsl:template match="/">
	<xsl:if test="$pageIndex &lt;=1">
	<xsl:call-template name="htmlstart"/>
<html>	
      <head>
<script type="text/javascript" language="javascript" src="../Customization/cif/js/SRMEntityRightClick.js"></script>
<script type="text/javascript" src="../cif/js/Message_cif_{$locale}.js" language="javascript"></script>
<script type="text/javascript" src="../common/js/Message_common_{$locale}.js" language="javascript"></script>
  <!--srini changes for Entity queue search Starts-->
<script type="text/javascript" language="javascript" src="../cif/js/ListofModEntity.js"></script>
  <!--srini changes for Entity queue search Ends-->
<!-- Tracker id 148647 -->
<script type="text/javascript" language="javascript" src="../cif/js/CrossEntityCopyValidation.js"></script>
<!-- Tracker id 148647 -->
<script>
var locale = '<xsl:value-of select="$locale"/>';
var NumPages = '<xsl:value-of select="$NumPages"/>';<!-- TRACKER# 92380-->
var grpid = '<xsl:value-of select="$GRPID"/>';
var accKey = '<xsl:value-of select="$accountKey"/>';


    	/* Changes for Audit Enquiry CRMBAR02 Starts*/
    
    	/* ScreenName and viewname has been obtained */
    
    	var ScreenName = '<xsl:value-of select="$ScreenName"/>';
    

    	var viewnameScreenID = '<xsl:value-of select="$userArea//Z[@n='ViewName']"/>';

</script>
        <link rel="stylesheet" type="text/css" href="../Branding/css/common/SRMTableDisplay_{$locale}.css"/>
        <link rel="stylesheet" Type="text/css" href="../Branding/css/common/PopupMenu_{$locale}.css"/>
        <link rel="stylesheet" Type="text/css" href="../Branding/css/common/SRMListTemplate_{$locale}.css"/>
        
        <script type="text/javascript" src="../common/js/PopupMenu.js"></script>        
        
        <xsl:if test="$Type ='Rep'">
		<script type="text/javascript" src="../Customization/cif/js/EntityRCLOptions_{$locale}.js"></script>
	</xsl:if>
	<xsl:if test="$Type ='Group'">
		<script type="text/javascript" src="../cif/js/EntityGroupRCLOptions_{$locale}.js"></script>
	</xsl:if>		
       	<script type="text/javascript" id="TableRowColor" src="../common/js/SRMTableRowColor.js"></script>        
       	
        <script>
          var prevAccountURL = "";
          var accountURL = "";
          var accountId = "";
          var groupId = "";
          var prevAcctId = "";	      
		  /*Changes for Ticket#349877 begin*/
		  var prevTrayType = "";
		  var trayType = "";
		  /*Changes for Ticket#349877 end*/		  
          var mode = "";
          var local_prefix="CifCustomer";
          var expirationdate = new Date ();
          var repId = '<xsl:value-of select="$RepID"/>';
          var boCreatedById = "";
          var MakerID = "";
          var AccessOwnerGroup = "";
          var EntityType = "Customer";
	// CORE-CIF Approval Changes
          var creFlag = "";
          var mainID = "";
          //CIF Last Edited Page Change start
          var LastEdited = "";
          //CIF Last Edited Page Chanage ends
                   
          var Dob = "";
          var isMCEdited="";
          
var tfFlag ="";
       function selectLastSelected()
       {
       		try{	       
	       accountId=getCookie("accountId"); 	       
		   /*Changes for Ticket#349877 begin*/
		   trayType=getCookie("ModEntityType");
		   /*Changes for Ticket#349877 end*/
	       if((accountId != null) &amp;&amp; (accountId != 'null')&amp;&amp;(accountId != "")&amp;&amp;(accountId != "undefined")) {
	       showDefTabs();       
	       prevAcctId=accountId;	       	       
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
          	setCookie('AccountURL', "", expirationdate);  	  	
  	  	setCookie('accountId', "", expirationdate);
  	  	setCookie('GroupID', "", expirationdate);
		setCookie('BOCreatedByID', "", expirationdate);
		setCookie('RepID',"",expirationdate);
		setCookie('MakerID',"",expirationdate);	
		setCookie('accountKey',"",expirationdate);
		setCookie('AssignedTo',"",expirationdate);
		setCookie('EntityType',"",expirationdate);
		setCookie('creFlag',"",expirationdate);
		setCookie('mainID',"",expirationdate);
		setCookie('dob',"",expirationdate);
		setCookie('isMCEdited',"",expirationdate);

	}
         function setMode () 
         {           
            	
            	call_getCookie ()
             if(document.all.RecordSet &amp;&amp;
             	document.all.RecordSet.rows &amp;&amp;
                document.all.RecordSet.rows.length == 3) {
             	accountId=document.all.RecordSet.rows(2).getAttribute('AccountModBO.accountID');
             	//accountDetails();
             }
          }
          
          
          function setMode2() 
	  {	  
	  	selectLastSelected();
          }
          
         function accountDetails() 
         {
         	if (accountId== null || accountId=="" || accountId== 'null') 
         	{
		     return;
            	}
		window.open('../servlet/com.infy.cis.ui.admin.AccountDetWizard?accountId=' + accountId + '&amp;isPopup=Yes','','height=436, left=70, top=120, width=860, location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=yes');
         }
       
	function identifyme()  
	{	
	
		loadPersistData();
		var item = event.srcElement.parentElement;

		/* Changes for ticket 345935 starts here*/
		if(item.id == null || item.id == '') {
			item = item.parentElement;
			if (item.id == null || item.id == '') item = item.parentElement;
		}
		/* Changes for ticket 345935 ends here*/
		
			/*changes for ticket 630723 begin*/
					
		/*if(event.srcElement.parentElement.id == null || event.srcElement.parentElement.id == ''|| event.srcElement.parentElement.id == "") 
		{	*/	
		
			/*changes for ticket 630723 end*/
						
// parentElement added		
			//CIF Changes for bug fixing
			/* Change for ticket 345247 start */
			/* Changes for ticket 345935 starts here*/
			accountURL			=item.getAttribute('AccountModBO.url_');
			accountId			=item.getAttribute('AccountModBO.accountID');
			groupId				=item.getAttribute('AccountModBO.GroupID');
			boCreatedById		=item.getAttribute('AccountModBO.createdUserID');
			MakerID				=item.getAttribute('AccountModBO.MakerID');
			accountKey			=item.getAttribute('AccountModBO.accountKey');
			AssignedTo			=item.getAttribute('AccountModBO.AssignedTo');
			assignedBy			=item.getAttribute('AccountModBO.AssignedByUserID');
			custModStepID		=item.getAttribute('AccountModBO.CurrentStep');
			ProcessGroupID		=item.getAttribute('AccountModBO.ProcessID');
			ProcessStatus		=item.getAttribute('AccountModBO.ProcessStatus');
			OwnerID				=item.getAttribute('AccountModBO.ownedUserID');
			RecordStatus		=item.getAttribute('AccountModBO.RecordStatus');
			creFlag				=item.getAttribute('AccountModBO.Entity_cre_flag');
			mainID				=item.getAttribute('AccountModBO.MainTableID');
			AssignedToGroup		=item.getAttribute('AccountModBO.AssignedToGroup');
			OwnerGroup=item.getAttribute('AccountModBO.OwnerGroup');
			 //  Tracker ID : 90197 Begin of Changes for attribute masking
			// Security changes
				secureKey=event.srcElement.parentElement.getAttribute('hashkey');
				secureField=event.srcElement.parentElement.getAttribute('fieldHashkey1');

			// Security changes
			// CIF Last Edited Page start
			LastEdited  		=item.getAttribute('AccountModBO.LastEditedPage');
			// CIF Last Edited Page End
	        Dob  				=item.getAttribute('AccountModBO.Cust_DOB');
			AccessOwnerGroup = item.getAttribute('AccountModBO.accessOwnerGroup');
			 <!-- Tracker ID : 90197 End of Changes -->
			IsTampered			=item.getAttribute('AccountModBO.IsTampered');
			isMCEdited			=item.getAttribute('AccountModBO.IsMCEdited');
			tfFlag	     		=item.getAttribute('AccountModBO.TFPartyFlag');
			//Changes for BSN:Start
			blacklisted			=item.getAttribute('AccountModBO.blacklisted');
			negated				=item.getAttribute('AccountModBO.negated');
			suspended			=item.getAttribute('AccountModBO.suspended');
			/* Change for ticket 345247 end */
		//Changes for BSN:End
			// Security changes
				secureKey=event.srcElement.parentElement.parentElement.getAttribute('hashkey');
				secureField=event.srcElement.parentElement.parentElement.getAttribute('fieldHashkey1');

			// Security changes
			
		/*changes for ticket 630723 begin*/
		/*
		} 
		
		 else 
		{		
			accountURL			=item.getAttribute('AccountModBO.url_');
			accountId			=item.getAttribute('AccountModBO.accountID');
			groupId				=item.getAttribute('AccountModBO.GroupID');
			MakerID				=item.getAttribute('AccountModBO.MakerID');
			boCreatedById		=item.getAttribute('AccountModBO.createdUserID');
			accountKey			=item.getAttribute('AccountModBO.accountKey');
			AssignedTo			=item.getAttribute('AccountModBO.AssignedTo');
			assignedBy			=item.getAttribute('AccountModBO.AssignedByUserID');
			ProcessGroupID		=item.getAttribute('AccountModBO.ProcessID');
			ProcessStatus		=item.getAttribute('AccountModBO.ProcessStatus');
			OwnerID				=item.getAttribute('AccountModBO.ownedUserID');
			RecordStatus		=item.getAttribute('AccountModBO.RecordStatus');
			creFlag				=item.getAttribute('AccountModBO.Entity_cre_flag');
			mainID				=item.getAttribute('AccountModBO.MainTableID');
			AssignedToGroup		=item.getAttribute('AccountModBO.AssignedToGroup');
			custModStepID		=item.getAttribute('AccountModBO.CurrentStep');
			OwnerGroup			=item.getAttribute('AccountModBO.OwnerGroup');*/
           // CIF Last Edited Page start
		/*	LastEdited  		=item.getAttribute('AccountModBO.LastEditedPage');*/
			// CIF Last Edited Page End
         /*  	Dob  				=item.getAttribute('AccountModBO.Cust_DOB');*/
			 <!--  Tracker ID : 90197 Begin of Changes for attribute masking-->
			/*AccessOwnerGroup 	=item.getAttribute('AccountModBO.accessOwnerGroup');*/
			<!-- Tracker ID : 90197 End of Changes -->
		 /* IsTampered			=item.getAttribute('AccountModBO.IsTampered');
			isMCEdited			=item.getAttribute('AccountModBO.IsMCEdited');

			tfFlag	     		=item.getAttribute('AccountModBO.TFPartyFlag');*/
       			//Changes for BSN:Start
			/*blacklisted			=item.getAttribute('AccountModBO.blacklisted');
			negated				=item.getAttribute('AccountModBO.negated');
			suspended			=item.getAttribute('AccountModBO.suspended');*/
			/* Changes for ticket 345935 ends here*/
			//Changes for BSN:End
			// Security changes
				/*secureKey=event.srcElement.parentElement.parentElement.parentElement.getAttribute('hashkey');
				secureField=event.srcElement.parentElement.parentElement.parentElement.getAttribute('fieldHashkey1');*/

			// Security changes
      /* 	}*/
       	/*changes for ticket 630723 end*/
       	
		setCookie('tfFlag', tfFlag, expirationdate);
		<!-- Begin of Change -->
		<!-- Setting all the id cookies to null as the same may be already assigned -->
		setCookie('accountId', '', expirationdate);
		setCookie('contId', '', expirationdate);
		setCookie('prosId', '', expirationdate);
		setCookie('noncustId', '', expirationdate);
		<!-- End of Change -->
       	        
       	        if(null != accountId) {				
            			deleteCookie('accountId');
						/*Changes for ticket#349877 begin*/
						deleteCookie('ModEntityType'); 
setCookie('ModEntityType', trayType, expirationdate);
						/*Changes for ticket#349877 end*/
            	 <!--  Tracker ID : 90197 Begin of Changes for attribute masking-->
				setCookie('AccessOwnerGroup', AccessOwnerGroup, expirationdate);
		 <!-- Tracker ID : 90197 End of Changes -->			
       	        setCookie('AccountURL', accountURL, expirationdate);
		setCookie('accountId', accountId, expirationdate);
		setCookie('GroupID', groupId, expirationdate);
		setCookie('BOCreatedByID', boCreatedById, expirationdate);
		setCookie('RepID',repId,expirationdate);
		setCookie('MakerID',MakerID,expirationdate);	
		setCookie('accountKey',accountKey,expirationdate);
		setCookie('AssignedTo',AssignedTo,expirationdate);
		setCookie('assignedBy',assignedBy,expirationdate);
		setCookie('ProcessGroupID',ProcessGroupID,expirationdate);
		setCookie('ProcessStatus', ProcessStatus, expirationdate);
		setCookie('custModStepID', custModStepID, expirationdate);
		setCookie('OwnerID',OwnerID,expirationdate);
		setCookie('RecordStatus',RecordStatus,expirationdate);
		setCookie('EntityType',EntityType,expirationdate);
		setCookie('creFlag',creFlag,expirationdate);
		setCookie('mainID',mainID,expirationdate);
		setCookie('LastEdited',LastEdited,expirationdate);
		setCookie('dob',Dob,expirationdate);
		//Changes for BSN:Start
			setCookie('BlackListed',blacklisted,expirationdate);
			setCookie('Negated',negated,expirationdate);
	        setCookie('Suspended',suspended,expirationdate);
		//Changes for BSN:End
		setCookie('IsTampered',IsTampered,expirationdate);
		setCookie('AssignedToGroup',AssignedToGroup,expirationdate);		
		setCookie('OwnerGroup',OwnerGroup,expirationdate);
		setCookie('isMCEdited',isMCEdited,expirationdate);
		// Security changes
			setCookie('HASHKEY', secureKey, expirationdate);
			setCookie('FLDHASHKEY', secureField, expirationdate);
	   	// Security changes
				
		savePersistData();		
		/*Changes for ticket#349877 begin*/
		if	((prevAcctId != accountId)||(prevTrayType != trayType)){
		showDefTabs();
		prevAcctId=accountId;
		prevTrayType=trayType;
		}
		/*Changes for ticket#349877 end*/		
		}
		//Tracker:109227:95 SPE Changes:End
	}
	
	
	<![CDATA[
	function sortMe(col,order) {
				var expirationdate = new Date ();
				expirationdate.setTime(expirationdate.getTime() + ( 160 * 60 * 60 * 1000));
				setCookie('SORT_ORDER_ListofModAccounts', order,expirationdate);
				setCookie('SORT_COLUMN_ListofModAccounts', col,expirationdate);
				savePersistData();
				
				// CRM70t-ST :TRACKER# 78678 - BEGIN OF CHANGES
				var Type= parent.frames(0).document.getElementsByName("TypeFilter")[0].value;			
				var GrType= parent.frames(0).document.getElementsByName("GpFilter")[0].value;			
				if (Type=='Group' && GrType =="")
				{
				showMessage(MSGX0045);
				return;
				}
				if(Type=='Group')
				{				
				eval("window.location.href='../servlet/com.infy.cis.ui.cif.ListofModEntity?"
				+ "SortColumn=" + col
				+ "&amp;SortOrder=" + order 	
				+ "&amp;Group=Group&amp;GroupID="+ GrType
				+ "'");
				}
				else
				{				
				eval("window.location.href='../servlet/com.infy.cis.ui.cif.ListofModEntity?"
				+ "SortColumn=" + col
				+ "&amp;SortOrder=" + order
				+ "'");
				}
				// CRM70t-ST :TRACKER# 78678 - END OF CHANGES
				
				/*var doc = parent.frames(0).document;
				doc.all.SortColumn.value = col;
				doc.all.SortOrder.value = order;
				doc.FindForm.submit();*/
								
                   }]]>
        </script>
        </head>
        
        <body onload="setMode2()">
        </body>
        
        </html>
        <xsl:call-template name="bodystart"/>
	
	<form name="frm2" action="" ENCTYPE="multipart/form-data">
			
			<input type="hidden" name="RepID" value="{$RepID}"/>
			  <!--srini changes for Entity queue search Starts-->
			<input type="hidden" name="SortColumn" value= ""/>
			<input type="hidden" name="SortOrder" value= ""/>
			<input type="hidden" name="LastName" value= ""/>
			<input type="hidden" name="CifDate" value= ""/>		
			<input type="hidden" name="CifKey" value= ""/>
			<input type="hidden" name="AccountKey" value= ""/>
			<input type="hidden" name="HouseholdID" value= ""/>
			<input type="hidden" name="HouseholdName" value= ""/>
			<input type="hidden" name="SuspendedFlag" value=""/>
			<input type="hidden" name="BlacklistFlag" value=""/>
		        <input type="hidden" name="NagativeFlag" value=""/>
			<input type="hidden" name="QueryText" value=""/>
		        <input type="hidden" name="Query" value=""/>
		        <input type="hidden" name="Advanced" value=""/>
		        <input type="hidden" name="Graphics" value=""/> 
		        <input type="hidden" name="Group" value=""/>
			<input type="hidden" name="Rep" value=""/>
			<input type="hidden" name="GroupID" value=""/>
		        <input type="hidden" name="savedSubmitted" value=""/>
		        <input type="hidden" name="BCFlag" value=""/>
                          <!--srini changes for Entity queue search Ends-->
	</form>
      </xsl:if>
	       <xsl:call-template name="mainbody">
	         <xsl:with-param name="tablename">RecordSet</xsl:with-param>
	           <!--srini changes for Entity queue search Starts-->
	         <xsl:with-param name="graphics"><xsl:value-of select="$Graphics"/></xsl:with-param>
	         <xsl:with-param name="extra_tableHeader"><xsl:value-of select="$secondHeader"/></xsl:with-param>
                   <!--srini changes for Entity queue search Ends-->
	         <xsl:with-param name="pageIndex"><xsl:value-of select="$pageIndex"/></xsl:with-param>	         
	         <xsl:with-param name="NumPages"><xsl:value-of select="$NumPages"/></xsl:with-param><!--TRACKER# 92380-->
	         <xsl:with-param name="callcalme">1</xsl:with-param>
		 <xsl:with-param name="callselectLastSelected">1</xsl:with-param>
		 <xsl:with-param name="rclickshow">true</xsl:with-param>
                 <xsl:with-param name="rowhighlight">true</xsl:with-param>
                 <xsl:with-param name="showNext">true</xsl:with-param>
	         <xsl:with-param name="rsfilenm"><xsl:value-of select="$resfilename"/></xsl:with-param>
	         <!--<xsl:with-param name="jscriptfnc">,identifyme();doContextMenu1();</xsl:with-param>--><!--TRACKER# 204548-->
	         <xsl:with-param name="jscriptfnc">,identifyme();</xsl:with-param><!--TRACKER# 204548-->
		<xsl:with-param name="usabilityChange">true</xsl:with-param>
		<xsl:with-param name="imgFieldName">AccountModBO.AccountKey,</xsl:with-param>
		<xsl:with-param name="imgFieldNameLink_one">AccountModBO.AccountKey</xsl:with-param>
		<xsl:with-param name="imgFieldNameFunc_one">populateCifEntityDetails('Mod','Account',accountId,ScreenName,viewnameScreenID)</xsl:with-param>
		 
	         <xsl:with-param name="colhrefname">ASSIGNENAME</xsl:with-param>
		 <xsl:with-param name="colhref_function">userDetails('AssignedTo',AssignedTo)</xsl:with-param>
	         <xsl:with-param name="colhref_one">ASSIGNBYNAME</xsl:with-param>
		 <xsl:with-param name="colhrefone_function">userDetails('AssignedBy',assignedBy)</xsl:with-param>
	         <xsl:with-param name="colhref_two">OWNERNAME</xsl:with-param>
		 <xsl:with-param name="colhreftwo_function">userDetails('Owner',OwnerID)</xsl:with-param>		 
	         <xsl:with-param name="colhref_three">MAKERNAME</xsl:with-param>
		 <xsl:with-param name="colhrefthree_function">userDetails('Maker',MakerID)</xsl:with-param>
	 
		 <xsl:with-param name="checkbox">true</xsl:with-param>
		 <xsl:with-param name="checkboxOnClick">AddSelectedRowToList(this.value)</xsl:with-param>
		    
		<!-- START - TRACKER -92380-->
		
		    <!-- Tracker id: 161033. START OF CHANGES. -->  
		    <xsl:with-param name="extra_colheader8"><xsl:value-of select="$configLabels[@name='SelectAll']/@configLabel"/></xsl:with-param>
		    <!-- Tracker id: 161033. END OF CHANGES. -->  
		    
		    <xsl:with-param name="extra_colheadercheckbox">Y</xsl:with-param>
		    <xsl:with-param name="extra_colheaderfn8">javascript:return selectAll();</xsl:with-param>
		    <!--END - TRACKER -92380-->
	       </xsl:call-template>
</xsl:template>
 </xsl:stylesheet>














