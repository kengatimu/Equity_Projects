<?xml version='1.0'?>
 <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"/>
  <xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"/>
        <xsl:param name="locale"/>
        <!--ERPBOCF1:TRACKER113259:STORAGE OF DATES :STARTOFCHANGES-->
		       	<xsl:param name="ALTCALENDAR_TYPE"/>
        <!--ERPBOCF1:TRACKER113259: STORAGE OF DATES :ENDOFCHANGES-->
<!--Changes by Niharika for CR356016-->
    <xsl:variable name="file1">../Renderer/Customization/cif/resource/Ret_Suspend_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<!--End of changes by Niharika for CR356016-->
<xsl:variable name="configFile_1" select="document(concat($file1, ''))"/>
  <xsl:variable name="configLabels" select="$configFile_1/SRMBO/*"/>
  <xsl:variable name="accountID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='accountID']"/>
  <!--Changes for Approval: start-->
  <xsl:variable name="apprFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='apprFlag']"/>
  <!--Changes for Approval: end-->
    <!-- CRA10MSC : TRACKER # 90015 : BEGIN OF CHANGES  -->
    <xsl:variable name="RejectReasons" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='RejectReasons']"/>
    <xsl:variable name="availableReasons" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AvailableReasons']"/>
    <xsl:variable name="Delimiter_Word" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Delimiter_Word']"/>
    <xsl:variable name="Delimiter_Sentence" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Delimiter_Sentence']"/>
    <xsl:variable name="entityId" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='entityId']"/>
    <xsl:variable name="entityType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='entityType']"/>
    <!--Recon For Call ID 189974 Ticket ID 383223:start-->
    <xsl:variable name="AttachNotes" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AttachNotes']"/>
    <!--Recon For Call ID 189974 Ticket ID 383223:End-->
    <!-- Changes for CallID 213271 begin (To accept special characters in UnSuspend remarks) -->
    <xsl:variable name="NoteString" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='NoteString']"/> 
    <!-- Changes for CallID 213271 End (To accept special characters in UnSuspend remarks) -->
	 <!--Recon for Security Audit Changes from CRM10301BSUPP-->
    <xsl:variable name="strSecureHKey" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='SecureHKey']" />
    <xsl:variable name="strFldHashKey" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='FldHashKey']" />
    <xsl:variable name="ExpiryDate" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='ExpiryDate']" />
    <!--Recon for Security Audit Changes from CRM10301BSUPP-->
    <!--<xsl:variable name="operation" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='operation']"/>-->
    <!-- CRA10MSC : TRACKER # 90015 : END OF CHANGES  -->
  <xsl:template match="/">
	<html>
			<head>
<!--Performance-->
<!--<script type="text/javascript" src="../common/js/ClientResourceBundle_{$locale}.js" language="javascript"></script>
<script type="text/javascript" src="../common/html/validate.js" language="javascript"></script>
 <script type="text/javascript" src="../common/html/validateL2.js" language="javascript"></script>-->
 <!--Performance-->
 <!--Changes by Niharika for CR356016-->
 <script type="text/javascript" src="../Customization/cif/js/EquityProcessCustom.js" language="javascript"></script>
<!--End of changes by Niharika for CR356016-->
 <!-- Recon For Call ID 189974 Ticket ID 383223:Start-->
  <script type="text/javascript" src="../admin/js/Message_admin_{$locale}.js" language="javascript"></script>
  <!--Recon For Call ID 189974 Ticket ID 383223:End-->
<script type="text/javascript" src="../common/js/ListBoxFunctions.js"></script>
  <!-- CRA10MSC : TRACKER # 90015 : BEGIN OF CHANGES  -->
  <script type="text/javascript" src="../cif/js/StringTokenizer.js"></script>
  <!-- CRA10MSC : TRACKER # 90015 : END OF CHANGES  -->
<script>
var locale = '<xsl:value-of select="$locale"/>';
var apprFlag='<xsl:value-of select="$apprFlag"/>';//CIF Changes for Approval
var entityId = '<xsl:value-of select="$entityId"/>';
<!-- Recon For Call ID 189974 Ticket ID 383223:Start-->
var AttachNotes = '<xsl:value-of select="$AttachNotes"/>';
<!-- Recon For Call ID 189974 Ticket ID 383223:End-->
</script>
	     <title><xsl:value-of select="//SRMPresentation/SRMSystem[@n='Strings']/SRMString[@n='Title']/@value"/></title>
	      <LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
	      <STYLE>.listBox  {  width=200px}</STYLE>
	      <SCRIPT>



var no_errors;
var checkOldReasons="";
    //366332 changes
	var aReasons=escape("<xsl:value-of select="$availableReasons"/>");
	aReasons=unescape(aReasons);
  var rReasons='<xsl:value-of select="$RejectReasons"/>';
  var wordLimiter= '<xsl:value-of select="$Delimiter_Word"/>'
  var sentLimiter='<xsl:value-of select="$Delimiter_Sentence"/>';
  var ExpiryDate='<xsl:value-of select="$ExpiryDate"/>';
  <!--var operation ='<xsl:value-of select="$operation"/>';-->
  var accountID = '<xsl:value-of select="$accountID"/>';

   <!-- CRA10MSC : TRACKER # 90015 : BEGIN OF CHANGES  -->

	function verifyDate (field)
	{
		<![CDATA[
		if (no_errors && field.value != '' && validate_date(field, true, false) == false)
		{
			showMessage (getUserErrorMessage ('MSG241'));
			field.select();
			no_errors = false;
		}
		]]>
	}

	function verify_toDate (from, to)
	{
		<![CDATA[
		if (no_errors && Validate_toDate1(from, to, true, false) == false)
		{
			showMessage (getUserErrorMessage ("MSG017",[ to.Display, from.Display ]));
			from.select();
			no_errors = false;
		}
		]]>
	}
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

		document.frm2.REJECT_REASON.IsMandatory='true';
	    document.frm2.REJECT_REASON.isListView='true';
	    document.frm2.ValidTill.value = ExpiryDate;
		document.frm2.REJECT_REASON.Display='Selected Suspend Reasons';
		<!-- function tokens converts a group of data in a string
		 to an array                                          -->
		var availReasons=tokens(aReasons, sentLimiter);
		var rejectReasons=tokens(rReasons, sentLimiter);
				//alert('AttachNotes'+AttachNotes);
		 document.frm2.AttachNotes.value = AttachNotes;
		<![CDATA[
		for(var i=0;i<availReasons.length;i++)
		{
			for(var j=0;j<rejectReasons.length;j++)
			{
				if(trimReason(availReasons[i],wordLimiter)==trimReason(rejectReasons[j],wordLimiter))
		  		{	
		  		//Recon For Call ID 189974 Ticket ID 383223:Start
		  			checkOldReasons=checkOldReasons+rejectReasons[j]+";;";
		  		//Recon For Call ID 189974 Ticket ID 383223:End
					break;
				}
			}

			<!-- to add the available reasons to the AvailableReasonsList -->
			if(j==rejectReasons.length)
			{
			   addToTheList(availReasons[i],availReasons[i],document.frm2.AVAILABLE_REJECT_REASON,'ADD');
			}
		}
		<!-- to add the reject reasons to the RejectReasonsList -->
		for(var i=0;i<rejectReasons.length;i++)
		{
			addToTheList(rejectReasons[i],rejectReasons[i],document.frm2.REJECT_REASON,'ADD');
		}
		]]>
	}

	<!-- function to change the valid till Date field on click
	of an item in the listbox with or without dates     -->
	function updateDate(reason)
	{
		/* START OF CHANGES */
						/*
						 * Fix for tracker 152578
						 * This code was not letting the value get saved
						 */
						//document.frm2.ValidTill.value=extractDate(reason.value,wordLimiter);
		/* END OF CHANGES */

	}

	<!-- function to Attach an item from Available Suspension lists
	to Rejected Suspension lists with the date(ValidTill)
	appended to the item string                              -->

	function AddDate(x, y, flag)
	{
		var dt=document.frm2.ValidTill.value;
	/* ERPBOCF1:113259 STORAGE OF DATES BEGIN OF CHANGES */
		 document.all.validTillDate.value = dt;
	/* ERPBOCF1:113259 STORAGE OF DATES END OF CHANGES */
		no_errors=true;
		if(dt.length!=0)
		{
			verifyDate(document.frm2.ValidTill);
			if(no_errors)
			{
				var currDt = document.frm2.CurrentDate;
				currDt.value = getCurrentDate();
				currDt.Display = MSG_CURR_DATE;
				verify_toDate(currDt,document.frm2.ValidTill);
			}
		}
		if(no_errors)
		{
			var ALTCALENDAR_TYPE = document.all.ALTCALENDAR_TYPE.value;
			if(ALTCALENDAR_TYPE == 'true')
			{
			   if(dt != '')
			   {

				var strFlag = isGregDateWithoutConv(dt);
				if(strFlag != 'true')
				{
					dt=convertHijToGreg(dt);

				}

			   }

			}
			var selected=false;
			<![CDATA[
			var elem = new Array();
			var a=0;
			var nxt=0;
			for (i=0; i < x.length; i++)
			{
				if (x.options[i].selected)
				{
					selected=true;
					var z = y.length;
					y.length = z + 1;
					if(dt.length!=0)
					{
						y.options[z].text = x.options[i].text+' ('+dt+')';
						y.options[z].value = x.options[i].value+dt+wordLimiter;

					}
					else

					{
						y.options[z].text = x.options[i].text;
						y.options[z].value = x.options[i].value;
					}
					x.options[i] = null;
					i--;
				}
			}
			if(!selected)
			{
				showUserMessage("MSGJ50187");
			}
		}
		]]>
		//Fix for tracker 152578
		//document.frm2.ValidTill.value='';
		//End of fix
	}

	<!-- function to Detach an item from Rejected Suspension lists
	to Available Suspension lists with the date(ValidTill)
	removed from the item string                              -->
	function RemoveDate(x, y, flag)
	{
		var selected=false;
		<![CDATA[
		var elem = new Array();
		var a=0;
		var nxt=0;
		for (i=0; i < x.length; i++)
		{
			if (x.options[i].selected)
			{
				selected=true;
				var z = y.length;
				y.length = z + 1;
				y.options[z].text = trimDate(x.options[i].value,wordLimiter);
				y.options[z].value = trimValueDate(x.options[i].value,wordLimiter);
				x.options[i] = null;
				i--;
			}
		}
		if(!selected)
		{
			showUserMessage("MSGJ50188");
		}
		]]>
document.frm2.ValidTill.value='';
	}

	<!-- function to add list items to Rejected lists and subtract items
	from Available lists if the entity is Suspension -->
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
		var chkStat = parent.parent.parent.parent.ValidateFormContents(document.frm2,true);
		var NoteString = document.frm2.AttachNotes.value;

		//Changes for CallID 213271 begin (To accept special characters in UnSuspend remarks)
		document.frm2.NoteString.value = NoteString;
		//Changes for CallID 213271 End
			
		var ReasonString='';
		var operation='Suspend';
		var z=document.frm2.REJECT_REASON;
		<![CDATA[
		for(var i=0;i<z.length;i++)
	 	{
			ReasonString+=z.options[i].value+sentLimiter;
		}
		]]>
		
		//Recon For Call ID 189974 Ticket ID 383223:Start
		if(checkOldReasons==ReasonString){
			if(AttachNotes==NoteString){
			showUserMessage("MSGJ0438"); 
			return "false";
			}
		}
		//Recon For Call ID 189974 Ticket ID 383223:End
	      	/********ERPBOCF1:TRACKER:113259:STORAGE OF DATES :STARTOFCHANGES***********/
	var ALTCALENDAR_TYPE = document.all.ALTCALENDAR_TYPE.value;
	var strValidTillDt = document.all.validTillDate.value;

	if(ALTCALENDAR_TYPE = 'true')
	{
			   if(strValidTillDt != '')
			   {

				  var strFlag = isGregDateWithoutConv(strValidTillDt);

				if(strFlag != 'true')
				{
					strValidTillDt=convertHijToGreg(strValidTillDt);

				}

			   }

		document.all.validTillDate.value = strValidTillDt;
	}
		/***ERPBOCF1:TRACKER:113259:STORAGE OF DATES :ENDOFCHANGES***********/

						if(chkStat == "true") {
							//Recon from CRM10301BSUPP starts
							var SECUREHKEY = document.frm2.hid_HASHKEY.value;
							var FLDHASHKEY = document.frm2.hid_KEYFIELD.value;
							//Recon from CRM10301BSUPP ends
							//CIF Changes for Approval

							//Changes for CallID 213271 begin
							//document.frm2.action = "../servlet/com.infy.cis.ui.cif.SuspendWriter?apprFlag="+apprFlag+"&amp;ReasonString=" + ReasonString + "&amp;NoteString=" + NoteString + "&amp;entityId="+accountID + "&amp;operation=" + operation;	
                           //Checksum recon from 10.3 SUPP begin
							document.frm2.action = "../servlet/com.infy.cis.ui.cif.SuspendWriter?apprFlag="+apprFlag+"&amp;ReasonString=" + ReasonString + "&amp;entityId="+accountID + "&amp;operation=" + operation + "&amp;FLDHASHKEY=" + FLDHASHKEY + "&amp;SECUREHKEY=" + SECUREHKEY;
							 //Checksum recon from 10.3 SUPP End
                             //Changes for CallID 213271 end
							
							document.frm2.target='formSaveFrame';
							document.frm2.submit();
							return "true";
						}
						else {

							return chkStat;
						}

					}
					function rejectReasonValue()
					{
						try
						{
							var rejectReason = "";
							document.getElementsByName("RejectReasonList")[0].isListView = "true";
							document.getElementsByName("RejectReasonList")[0].IsMandatory = "true";
							document.getElementsByName("RejectReasonList")[0].Display = "Suspended Reasons";
							for (i=0; i &lt; document.frm2.RejectReasonList.length - 1; i++) {
							rejectReason += document.frm2.RejectReasonList.options[i].text + sentLimiter;
							}
							if (document.frm2.RejectReasonList.length > 0) {
								rejectReason += document.frm2.RejectReasonList.options[document.all.RejectReasonList.length-1].text;
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
						
						//Recon from CRM10301BSUPP starts

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
						//Recon from CRM10301BSUPP ends
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
			<body class="popup" bgcolor="blue">
			<xsl:attribute name="onload">load();enableButton()</xsl:attribute>
			<table width="100%" cellpadding="0" cellspacing="0" border="0"  align="left">
			<xsl:apply-templates select="SRM"/>
			</table>
               </body>
		</html>
</xsl:template>
<xsl:template name="IsSuspended">
	<xsl:call-template name="label">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='IsSuspended']"/>
		<xsl:with-param name="ele_name">IsSuspended</xsl:with-param>
		<xsl:with-param name="ele_val">IsSuspended</xsl:with-param>
		<xsl:with-param name="is_date">false</xsl:with-param>
		<xsl:with-param name="read_val">true</xsl:with-param>
		<xsl:with-param name="toUpperCase">false</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template name="ValidTill">
	<xsl:call-template name="label">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='ValidTill']"/>
		<xsl:with-param name="ele_name">ValidTill</xsl:with-param>
		<xsl:with-param name="ele_val">ValidTill</xsl:with-param>
		<xsl:with-param name="is_date">true</xsl:with-param>
		<!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
		<!-- calling the function isGregOprDate for on blur functionality-->
		<!-- fix for ticket 201985 start-->
		<!-- Changes for tracker 456097 start-->
		<xsl:with-param name="fn_onBlur">isGregDate("ValidTill");validateTillDate();</xsl:with-param>
		<!-- Changes for tracker 456097 end-->
		<!-- fix for ticket 201985 ends-->
			<!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
	</xsl:call-template>
</xsl:template>

<!--template for Note  here-->
<xsl:template name="AttachNotes">
	<xsl:call-template name="mtextarea">
		<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="res_name" select="$configLabels[@name='AttachNotes']"/>
		<xsl:with-param name="mvalue">AttachNotes</xsl:with-param>
		<xsl:with-param name="mcols">50</xsl:with-param>
		<xsl:with-param name="mrows">2</xsl:with-param>
		<xsl:with-param name="mcolspan">2</xsl:with-param>
		<!--  TRACKER:78504:BEGINOFCHANGES -->
		<!--Changes for TOL ID 581262 starts--> 
                   <xsl:with-param name="fn_onblur">txtLimit(this,500,"AttachNotes","Attach BlackList Notes");checkForEnterKey(this,"AttachNotes")</xsl:with-param> 
   <!--Changes for TOL ID 581262 ends--> 

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
            <xsl:with-param name="ondblclick">AddDate(AVAILABLE_REJECT_REASON, REJECT_REASON,false)</xsl:with-param>
            <!--  CRM10.0ST End -->
            <xsl:with-param name="onclick">updateDate(AVAILABLE_REJECT_REASON);</xsl:with-param>
            <xsl:with-param name="selectname">AVAILABLE_REJECT_REASON</xsl:with-param>
            <xsl:with-param name="selectdisp">AVAILABLE_REJECT_REASON</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    <xsl:template name="REJECT_REASON">
	    <xsl:call-template name="listview">
            <xsl:with-param name="ele_name">REJECT_REASON</xsl:with-param>
            <xsl:with-param name="size">4</xsl:with-param>
            <xsl:with-param name="width">218</xsl:with-param>
            <xsl:with-param name="multiple">false</xsl:with-param>
			<xsl:with-param name="IsMandatory">false</xsl:with-param>
            <xsl:with-param name="class">listBox</xsl:with-param>
           <!--  CRM10.0ST Start TrackerID:109059  -->
           <xsl:with-param name="ondblclick">RemoveDate(REJECT_REASON,AVAILABLE_REJECT_REASON,true)</xsl:with-param>
           <!--  CRM10.0ST End -->
           <xsl:with-param name="onclick">updateDate(REJECT_REASON);</xsl:with-param>
            <xsl:with-param name="selectname">REJECT_REASON</xsl:with-param>
	    <xsl:with-param name="selectdisp">REJECT_REASON</xsl:with-param>
        </xsl:call-template>
    </xsl:template>

	<xsl:template match="*" mode="mode1">

	<form name="frm2"  method="post">

	<input type="hidden" name="accountID" value="{$accountID}"/>
	<input type="hidden" name="rejectReasonvalues" value=""/>
        <input type="hidden" name="CurrentDate" value=""/>
        
        <!-- Changes for CallID 213271 begin -->
        <input type="hidden" name="NoteString" value=""/>
        <!-- Changes for CallID 213271 end -->
        
   <!--ERPBOCF1:TRACKER:113259:STORAGE OF DATES :STARTOFCHANGES-->
	 <input type="hidden" name="validTillDate" value=""/>
	 <input type="hidden" value="{$ALTCALENDAR_TYPE}" name="ALTCALENDAR_TYPE"/>
  <!--ERPBOCF1:TRACKER:113259:STORAGE OF DATES :ENDOFCHANGES-->
  	<!--Recon for Security Audit Changes from CRM10301BSUPP-->
  	<input type="hidden" name="hid_HASHKEY" value="{$strSecureHKey}"/>
  	<input type="hidden" name="hid_KEYFIELD" value="{$strFldHashKey}"/>
  	<!--Recon for Security Audit Changes from CRM10301BSUPP-->


	<xsl:call-template name="Begin"/>
		<xsl:call-template name="IsSuspended"/>
		<td></td>
		<xsl:call-template name="ValidTill"/>
	<xsl:call-template name="End"/>
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
							onclick="AddDate(AVAILABLE_REJECT_REASON, REJECT_REASON,false)"/><BR/>
							<input class='frmBttnsAddRmv' Type='button' value='&lt;&lt;'
							onclick="RemoveDate(REJECT_REASON,AVAILABLE_REJECT_REASON,true)"/>
							</TD>
						<TD  valign ="top" class="d1" style="width:22%"><xsl:value-of select="$configLabels[@name='REJECT_REASON']/@configLabel"/>&#160;<STRONG class="mandatory_indicator">*</STRONG></TD>
						<TD>
							<xsl:call-template name="REJECT_REASON"/>
						</TD>

	</TR>

	<xsl:call-template name="End"/>










	<!-- <xsl:call-template name="Begin"/>
		<td  class='Labels' align='middle'><xsl:value-of select="$configLabels[@name='AVAILABLE_REJECT_REASON']/@configLabel"/></td>
		<td  class='Labels'>&#160;</td>
		<td  class='Labels' align='middle'><xsl:value-of select="$configLabels[@name='REJECT_REASON']/@configLabel"/></td>
	<xsl:call-template name="End"/>
	<xsl:call-template name="Begin"/>
	  	<td rowSpan='4' align='middle'  class="d3">
         	   <xsl:call-template name="AVAILABLE_REJECT_REASON"/>
                </td>
		<td style='padding-top=10px' align='middle' class="AddRemove">
  	        <b><xsl:value-of select="$configLabels[@name='ADD']/@configLabel"/></b><br/>
		  <input class="sbttn" Type='button' value=' &gt; ' onclick="AddDate(AVAILABLE_REJECT_REASON, REJECT_REASON,false)"/><br/><br/>
		</td>
		<td rowSpan='4' align='middle'  class="d3">
                   <xsl:call-template name="REJECT_REASON"/>
                </td>
            	<xsl:call-template name="End"/>
	<xsl:call-template name="Begin"/>
        	<td align='middle' class="AddRemove">
                <b><xsl:value-of select="$configLabels[@name='REMOVE']/@configLabel"/></b><br/>
		   <input class="sbttn" Type='button' value=' &lt; ' onclick="RemoveDate(REJECT_REASON,AVAILABLE_REJECT_REASON,true)"/>
		</td>
	<xsl:call-template name="End"/>	 -->







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








