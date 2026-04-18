<?xml version='1.0'?>
 <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"/>
  <xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"/>
        <xsl:param name="locale"/>
        <!--Changes by Niharika for CR356016-->
    <xsl:variable name="file1">../Renderer/Customization/cif/resource/Ret_UnSuspend_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<!--End of changes by Niharika for CR356016-->
<xsl:variable name="configFile_1" select="document(concat($file1, ''))"/>
  <xsl:variable name="configLabels" select="$configFile_1/SRMBO/*"/>
  <!-- CRA10MSC : TRACKER # 90015 : BEGIN OF CHANGES  --> 
  <xsl:variable name="availableReasons" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AvailableReasons']"/> 
  <xsl:variable name="Delimiter_Word" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Delimiter_Word']"/> 
  <xsl:variable name="Delimiter_Sentence" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Delimiter_Sentence']"/> 
  <xsl:variable name="entityId" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='entityId']"/> 
  <xsl:variable name="operation" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='operation']"/> 
  <xsl:variable name="AttachNotes" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AttachNotes']"/>
  <xsl:variable name="NoteString" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='NoteString']"/> 
  <!-- CRA10MSC : TRACKER # 90015 : END OF CHANGES  --> 
  <xsl:variable name="accountID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='accountID']"/>
<!--Recon for Security Audit Changes from CRM10301BSUPP-->
<xsl:variable name="strSecureHKey" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='SecureHKey']" />
<xsl:variable name="strFldHashKey" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='FldHashKey']" />
<!--Recon for Security Audit Changes from CRM10301BSUPP-->
  
  <!--Changes for Approval: start-->
  <xsl:variable name="apprFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='apprFlag']"/>
  <!--Changes for Approval: end-->
  <!-- Changes for CallID 213271 begin (To accept special characters in UnSuspend remarks) -->
  <xsl:variable name="noteString" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='noteString']"/> 
  <!-- Changes for CallID 213271 End (To accept special characters in UnSuspend remarks) -->
  <xsl:template match="/">
	<html>
			<head>
<!--Performance-->			
<!--<script type="text/javascript" src="../common/js/ClientResourceBundle_{$locale}.js" language="javascript"></script>
<script type="text/javascript" src="../common/html/validate.js" language="javascript"></script>-->
<!--Performance-->
<!--Changes by Niharika for CR356016-->
<script type="text/javascript" src="../Customization/cif/js/EquityProcessCustom.js" language="javascript"></script>
<!--End of changes by Niharika for CR356016-->
<script type="text/javascript" src="../customization/js/FileCloseCustom.js" language="javascript"></script>
<script type="text/javascript" src="../common/js/ListBoxFunctions.js"></script>
  <!-- CRA10MSC : TRACKER # 90015 : BEGIN OF CHANGES  --> 
  <script type="text/javascript" src="../cif/js/StringTokenizer.js"></script> 
  <!-- CRA10MSC : TRACKER # 90015 : END OF CHANGES  --> 
<script>
var locale = '<xsl:value-of select="$locale"/>';
var accountID = '<xsl:value-of select="$accountID"/>';
var apprFlag='<xsl:value-of select="$apprFlag"/>';//CIF Changes for Approval
var entityId = '<xsl:value-of select="$entityId"/>';	
	      var AttachNotes = '<xsl:value-of select="$AttachNotes"/>';
</script>
	     <title><xsl:value-of select="//SRMPresentation/SRMSystem[@n='Strings']/SRMString[@n='Title']/@value"/></title>
	      <LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
	      <STYLE>.listBox  {  width=200px}</STYLE>
	      <SCRIPT>
	      //366332 changes
		  	var aReasons=escape("<xsl:value-of select="$availableReasons"/>");
		  	aReasons=unescape(aReasons);
	      var wordLimiter= '<xsl:value-of select="$Delimiter_Word"/>' 
	      var sentLimiter='<xsl:value-of select="$Delimiter_Sentence"/>'; 

 
    <!-- CRA10MSC : TRACKER # 90015 : BEGIN OF CHANGES  --> 
 
	<!-- CRM10.1 Sanity Start TrackerID:112090 -->
	function enableButton()
	{
		try
		{
			var obj = parent.parent.parent.parent.frames(3);
			obj.enableButton_Ub();
		}
		catch(e)
		{

		}
	}
	<!-- CRM10.1 Sanity End-->
	<!-- function to perform some operations onload of the screen --> 
	function load() 
	{ 

		var availReasons=tokens(aReasons,sentLimiter); 
						
		 document.frm2.AttachNotes.value = AttachNotes;
		 
		<![CDATA[ 
		for(var i=0;i<availReasons.length;i++) 
		{ 
			<!-- to add the available reasons to the AvailableReasonsList --> 
			addToTheList(availReasons[i],availReasons[i],document.frm2.AVAILABLE_REJECT_REASON,'ADD'); 
		} 
		]]> 
	} 
 
	<!-- function to add list items to Rejected lists and subtract items 
	from Available lists if the entity is Suspended --> 
	function addToTheList(x, y, z, flag) 
	{ 
		<![CDATA[ 
		var a = z.length; 
		if(flag == "ADD") 
		{ 
			for(var i=0; i < a; i++) 
			{ 
				if(z.options[i].text == x) 
				{ 
					return; 
				} 
			} 
			z.length = a + 1; 
			z.options[a].text = getText(x,wordLimiter); 
			z.options[a].value = y; 
		} 
		else if(flag == "REMOVE") 
		{ 
			for(var i=0; i < a; i++) 
			{ 
				if(z.options[i] != null) 
				{ 
					if(z.options[i].text==x) 
					{ 
						z.options[i] = null; 
					} 
				} 
			} 
		} 
		return; 
		]]> 
	} 
 
	function save() 
	{ 
		document.frm2.REJECT_REASON.IsMandatory='true'; 
		document.frm2.REJECT_REASON.isListView='true'; 
		document.frm2.REJECT_REASON.Display='Selected UnSuspended Reasons'; 
 
		var chkStat = parent.parent.parent.parent.ValidateFormContents(document.frm2,true); 
		//Changes for CallID 213271 begin (To accept special characters in UnSuspend remarks)
		var noteString = document.frm2.AttachNotes.value;
		document.frm2.NoteString.value = noteString;
		//Changes for CallID 213271 End
		var ReasonString=''; 
		var z=document.frm2.REJECT_REASON; 
		var oprn='UnSuspend'; 
 
		<![CDATA[ 
		for(var i=0;i<z.length;i++) 
		{ 
			ReasonString+=z.options[i].value+sentLimiter; 
		} 
		]]> 
		if(chkStat == "true") 
                   {
							
							
							//Recon from CRM10301BSUPP starts
							var SECUREHKEY = document.frm2.hid_HASHKEY.value;
							var FLDHASHKEY = document.frm2.hid_KEYFIELD.value;
							//Recon from CRM10301BSUPP ends
							
							//CIF Changes for Approval
							//Changes for CallID 213271 begin (To accept special characters in UnSuspend remarks)
							//document.frm2.action = "../servlet/com.infy.cis.ui.cif.SuspendWriter?apprFlag="+apprFlag+"&amp;ReasonString=" + ReasonString + "&amp;NoteString=" + NoteString + "&amp;entityId=" + accountID + "&amp;operation=" + oprn;	   
							//Checksum recon from 10.3 SUPP begin
							document.frm2.action = "../servlet/com.infy.cis.ui.cif.SuspendWriter?apprFlag="+apprFlag+"&amp;ReasonString=" + ReasonString + "&amp;entityId=" + accountID + "&amp;operation=" + oprn+"&amp;FLDHASHKEY="+FLDHASHKEY+"&amp;SECUREHKEY="+SECUREHKEY;
                            //Checksum recon from 10.3 SUPP End
							//Changes for CallID 213271 End
							document.frm2.target='formSaveFrame';
							document.frm2.submit();
							return "true";
						}
						else {
						
							return chkStat;
						}
						
					}
					
					<!-- CRA10MSC : TRACKER # 90015 : END OF CHANGES  -->
					
					function rejectReasonValue() 
					{
						try 
						{
							var rejectReason = "";
							document.getElementsByName("REJECT_REASON")[0].isListView = "true";
							document.getElementsByName("REJECT_REASON")[0].IsMandatory = "true";
							document.getElementsByName("REJECT_REASON")[0].Display = "UnSuspended Reasons";
							for (i=0; i &lt; document.frm2.REJECT_REASON.length - 1; i++) {
							rejectReason += document.frm2.REJECT_REASON.options[i].text + ","; 
							}
							if (document.frm2.REJECT_REASON.length > 0) {
								rejectReason += document.frm2.REJECT_REASON.options[document.all.REJECT_REASON.length-1].text; 
							} 		
							document.frm2.rejectReasonvalues.value = rejectReason
						} catch (e) {}
					}
					
					function refreshParent()
					{															
						parent.parent.parent.parent.parent.parent.window.opener.parent.parent.parent.parent.frames(0).frames(0).frames(1).location.reload(true);
					}
					function clear()
					{
						/*Changes for Approval: start*/
						if(apprFlag=='true')
						{
							selectProcess();
						}
						/*Changes for Approval: end*/
						
						parent.parent.parent.parent.setButtonsVisible(false);
						self.location.href="../../common/html/blank.html";
						parent.frames(0).location.href = parent.frames(0).location.href;
                                                         top.window.close();
					}
					/*Changes for Approval: start*/
					function selectProcess()
					{					
						var sentityType=parent.formSaveFrame.savedEntityType;
						var entId=parent.formSaveFrame.savedValue;
						
						// Recon from CRM10301BSUPP starts 

						var secureHKey = document.getElementsByName("SECUREHKEY")[0].value;
						var keyField = document.getElementsByName("FLDHASHKEY")[0].value;
						/*Changes by Niharika for CR356016*/
						//window.open('../../../servlet/com.infy.cis.ui.cif.CIFProcessSelectionDetWizard?entityId='+entId+'&amp;entityType='+sentityType+'&amp;SECUREHKEY='+secureHKey+'&amp;FLDHASHKEY='+keyField+'&amp;isPopup=Yes','save','directories=No, height=436, left=210, top=120, width=575, location=no, menubar=no, resizable=no, status=no, toolbar=no, scrollbars=yes');
						var strProcessURL = '../servlet/com.infy.cis.custom.EquityRetailProcessSelection?entityId='+entId+'&amp;entityType='+sentityType;
						var strBOURL = 'abc';
						//alert('strBOURL    '+strBOURL);
						//alert('strProcessURL     '+strProcessURL);
						fnProcessSelection(strProcessURL, strBOURL);
       				/*End of changes by Niharika for CR356016*/
						// Recon from CRM10301BSUPP starts						
					}
					/*Changes for Approval: end*/
					
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
				
			</SCRIPT>
			</head>
			<link REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
			<body class="popup">
                            <xsl:attribute name="onload">load();enableButton()</xsl:attribute>
			<table width="100%" cellpadding="0" cellspacing="0" border="0"  align="left">
			<xsl:apply-templates select="SRM"/>
			</table>
               </body>
		</html>
</xsl:template>
<!--template for Note  here-->
   <xsl:template name="AccountBO.Suspend_Notes">
  		   <xsl:call-template name="mtextarea">
  			    <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.Suspend_Notes']"/>
  			    <xsl:with-param name="mvalue">WorkNotes</xsl:with-param>
  			    <xsl:with-param name="mcols">30</xsl:with-param>
  			    <xsl:with-param name="mrows">2</xsl:with-param>
  			    <xsl:with-param name="mcolspan">3</xsl:with-param>
				<!--  Fix for Tracker#79889: Starts -->
				<!--Changes for TOL ID 581262 starts--> 
                                   <xsl:with-param name="fn_onblur">txtLimit(this,500,"WorkNotes","Suspend Notes");checkForEnterKey(this,"AttachNotesUnSuspend")</xsl:with-param> 
   <!--Changes for TOL ID 581262 ends--> 

				<!--  Fix for Tracker#79889: Ends -->
  			   <xsl:with-param name="mname">WorkNotes</xsl:with-param>
  			</xsl:call-template>
       </xsl:template>
              <xsl:template name="AttachNotes">
                		   <xsl:call-template name="mtextarea">
                		   	<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
              
                			    <xsl:with-param name="res_name" select="$configLabels[@name='AttachNotes']"/>
                			    <xsl:with-param name="mvalue">AttachNotes</xsl:with-param>
                			    <xsl:with-param name="mcols">50</xsl:with-param>
                			    <xsl:with-param name="mrows">2</xsl:with-param>
                			    <xsl:with-param name="mcolspan">2</xsl:with-param>
              				<!--  TRACKER:78504:BEGINOFCHANGES -->
              				<xsl:with-param name="fn_onblur">txtLimit(this,500,"AttachNotes","Attach BlackList Notes")</xsl:with-param>
              				<!--  TRACKER:78504:ENDOFCHANGES -->
              
                			    <xsl:with-param name="mname">AttachNotes</xsl:with-param>
                			</xsl:call-template>
       </xsl:template>
   <!-- Tracker ID : 59466 BEGIN OF CHANGES -->
     <xsl:template name="AVAILABLE_REJECT_REASON">
	    <xsl:call-template name="listview">
            <xsl:with-param name="ele_name">AVAILABLE_REJECT_REASON</xsl:with-param>
            <xsl:with-param name="size">4</xsl:with-param>
            <xsl:with-param name="width">218</xsl:with-param>
            <xsl:with-param name="multiple">false</xsl:with-param>
            <xsl:with-param name="class">listBox</xsl:with-param>
            <!--  CRM10.0ST Start TrackerID:109059  -->
            <xsl:with-param name="ondblclick">selfield(AVAILABLE_REJECT_REASON, REJECT_REASON,false)</xsl:with-param>
            <!--  CRM10.0ST End -->
            <xsl:with-param name="selectname">AVAILABLE_REJECT_REASON</xsl:with-param>
            <xsl:with-param name="selectdisp">AVAILABLE_REJECT_REASON</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    <xsl:template name="REJECT_REASON">
	    <xsl:call-template name="listview">
            <xsl:with-param name="ele_name">REJECT_REASON</xsl:with-param>
            <xsl:with-param name="size">4</xsl:with-param>
           <xsl:with-param name="width">218</xsl:with-param>
	 <xsl:with-param name="IsMandatory">false</xsl:with-param>
            <xsl:with-param name="multiple">false</xsl:with-param>
            <xsl:with-param name="class">listBox</xsl:with-param>
            <xsl:with-param name="ondblclick">selfield(REJECT_REASON,AVAILABLE_REJECT_REASON,true)</xsl:with-param>
            <xsl:with-param name="selectname">REJECT_REASON</xsl:with-param>
	    <xsl:with-param name="selectdisp">REJECT_REASON</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
  
	<xsl:template match="*" mode="mode1">
	<form name="frm2"  method="post">
	<input type="hidden" name="accountID" value="{$accountID}"/>
	<!-- Changes for CallID 213271 begin (To accept special characters in UnSuspend remarks) -->
	<input type="hidden" name="NoteString" value=""/>
	<!-- Changes for CallID 213271 End -->
	<input type="hidden" name="rejectReasonvalues" value=""/>
  	<!--Recon for Security Audit Changes from CRM10301BSUPP-->
  	<input type="hidden" name="hid_HASHKEY" value="{$strSecureHKey}"/>
  	<input type="hidden" name="hid_KEYFIELD" value="{$strFldHashKey}"/>
  	<!--Recon for Security Audit Changes from CRM10301BSUPP-->
	<xsl:call-template name="Begin"/>
			<xsl:call-template name="AttachNotes"/>
	 <xsl:call-template name="End"/>
	 
	 <xsl:call-template name="Begin"/>
	 <TR >

	
	
				<TD align="left" valign ="top" class="d1" style="width:22%"><xsl:value-of select="$configLabels[@name='AVAILABLE_REJECT_REASON']/@configLabel"/></TD>
				<TD style="width:22%">
					<xsl:call-template name="AVAILABLE_REJECT_REASON"/>
				</TD>	
				<TD width="5%" align="center">
					<input class='frmBttnsAddRmv' Type='button' value='&gt;&gt;'
					onclick="selfield(AVAILABLE_REJECT_REASON, REJECT_REASON,false)"/><BR/>
					<input class='frmBttnsAddRmv' Type='button' value='&lt;&lt;'
					onclick="selfield(REJECT_REASON,AVAILABLE_REJECT_REASON,true)"/>
					</TD>
				<TD  valign ="top" class="d1" style="width:22%"><xsl:value-of select="$configLabels[@name='REJECT_REASON']/@configLabel"/>&#160;<STRONG class="mandatory_indicator">*</STRONG></TD>
				<TD>
					<xsl:call-template name="REJECT_REASON"/>
				</TD>
	
		  
	
	
	
	
	<!--<TD align="left" valign ="top" class="d1" style="width:22%"><xsl:value-of select="$configLabels[@name='AVAILABLE_REJECT_REASON']/@configLabel"/></TD>
	<TD style="width:22%">
		<xsl:call-template name="AVAILABLE_REJECT_REASON"/>
	</TD>	
	<TD width="5%" align="center">
		<input class='frmBttnsAddRmv' Type='button' value='&gt;&gt;'
		onclick="selfield(AVAILABLE_REJECT_REASON, REJECT_REASON,false)"/><BR/>
		<input class='frmBttnsAddRmv' Type='button' value='&lt;&lt;'
		onclick="selfield(REJECT_REASON,AVAILABLE_REJECT_REASON,true)"/>
		</TD>
	<TD  valign ="top" class="d1" style="width:22%"><xsl:value-of select="$configLabels[@name='REJECT_REASON']/@configLabel"/>&#160;<STRONG class="mandatory_indicator">*</STRONG></TD>
	<TD>
		<xsl:call-template name="REJECT_REASON"/>
	</TD>-->

	</TR>   
	 <xsl:call-template name="End"/>			  
	
	</form>
	</xsl:template>
<xsl:template match="SRM">
       <xsl:for-each select=".">
          <tr>
             <td>
                <table border="0" width="100%" cellspacing="1" cellpadding="2">
                   <tr>
                         <xsl:call-template name="apply">
                          <xsl:with-param name="apply_head">
                          <b><xsl:value-of select="$configLabels[@name='Header']/@configLabel"/></b>
                          </xsl:with-param>
                          </xsl:call-template>
                   </tr>
               </table>
               <table width="100%" border="0" cellspacing="1" cellpadding="2" align="left">
                     <xsl:apply-templates select="." mode="mode1"/>
               </table>
             </td>
          </tr>
       </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>







