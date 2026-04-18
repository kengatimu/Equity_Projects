<?xml version='1.0'?>
 <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"/>
  <xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"/>
        <xsl:param name="locale"/>
        <!--ERPBOCF1:TRACKER113259:STORAGE OF DATES :STARTOFCHANGES-->
	       	<xsl:param name="ALTCALENDAR_TYPE"/>
	<!--ERPBOCF1:TRACKER113259: STORAGE OF DATES :ENDOFCHANGES-->
<!--Changes by Niharika for CR356016-->
    <xsl:variable name="file1">../Renderer/Customization/corpcif/resource/Corp_Suspend_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<!--End of hanges by Niharika for CR356016-->
<xsl:variable name="configFile_1" select="document(concat($file1, ''))"/>
  <xsl:variable name="configLabels" select="$configFile_1/SRMBO/*"/>
  <!-- CRA10MSC : TRACKER #90015 : BEGIN OF CHANGES -->
  <xsl:variable name="RejectReasons" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='RejectReasons']"/>
  <xsl:variable name="availableReasons" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AvailableReasons']"/>
  <xsl:variable name="Delimiter_Word" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Delimiter_Word']"/>
  <xsl:variable name="Delimiter_Sentence" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Delimiter_Sentence']"/>
  <!-- CRA10MSC : TRACKER #90015 : END OF CHANGES -->
  <xsl:variable name="entityID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='entityId']"/>
  <xsl:variable name="entityType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='entityType']"/>
  <xsl:variable name="operation" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='operation']"/>
    <!--Tracker 96275 Changes for Approval by Ramsurendar start-->
    <xsl:variable name="apprFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='apprFlag']"/>
   <!--Recon for Security Audit Changes from CRM10301BSUPP-->
    <xsl:variable name="hashkey" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='hashkey']"/>
    <xsl:variable name="fldhashkey" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='fldhashkey']"/>
   <!--Recon for Security Audit Changes from CRM10301BSUPP-->
  <!--Tracker 96275 Changes for Approval by Ramsurendar end-->
  <xsl:template match="/">
	<html>
			<head>
<script type="text/javascript" src="../common/js/ClientResourceBundle_{$locale}.js" language="javascript"></script>
<script type="text/javascript" src="../corpcif/js/Message_corpcif_{$locale}.js" language="javascript"></script>
<script type="text/javascript" src="../common/html/validate.js" language="javascript"></script>

<script type="text/javascript" src="../common/html/validateL2.js" language="javascript"></script>
  <!--<script type="text/javascript" src="../common/js/ListBoxFunctions.js"></script>-->

  <!--CRA10MSC : TRACKER #90015 : BEGIN OF CHANGES -->
  <script type="text/javascript" src="../cif/js/StringTokenizer.js"></script>
  <!-- CRA10MSC : TRACKER #90015 : END OF CHANGES -->
  <!--Changes by Niharika for CR356016-->
  <script type="text/javascript" src="../Customization/cif/js/EquityProcessCustom.js" language="javascript"></script>
	<!--End of changes by Niharika for CR356016-->
<script>
/* Checksum changes made by Rajneet Singh */
var hashkey =  '<xsl:value-of select="$hashkey"/>';
        var fldhashkey = '<xsl:value-of select="$fldhashkey"/>';
        var expirationdate = new Date ();
        expirationdate.setTime(expirationdate.getTime() + ( 160 * 60 * 60 * 1000));
        setCookie('HASHKEY', hashkey,expirationdate);
        setCookie('FLDHASHKEY', fldhashkey,expirationdate);
  /* Checksum changes made by Rajneet Singh */
var locale = '<xsl:value-of select="$locale"/>';
var entityID = '<xsl:value-of select="$entityID"/>';
var apprFlag='<xsl:value-of select="$apprFlag"/>';//Tracker 96275 Changes for Approval by Ramsurendar
</script>
	     <title><xsl:value-of select="//SRMPresentation/SRMSystem[@n='Strings']/SRMString[@n='Title']/@value"/></title>
	      <LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
	      <STYLE>.listBox  {  width=200px}</STYLE>
	      <SCRIPT>


    var no_errors;
    //366332 changes
	var aReasons=escape("<xsl:value-of select="$availableReasons"/>");
	aReasons=unescape(aReasons);
  var rReasons='<xsl:value-of select="$RejectReasons"/>';
  var wordLimiter= '<xsl:value-of select="$Delimiter_Word"/>'
  var sentLimiter='<xsl:value-of select="$Delimiter_Sentence"/>';

  var ENTITYID='<xsl:value-of select="$entityID"/>';
  var ENTITYTYPE='<xsl:value-of select="$entityType"/>';




   <!--CRA10MSC : TRACKER #90015 : BEGIN OF CHANGES -->
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
/*Changes for Tracker 174903 starts */
 function tokens_Reason(str,delim)
{
	var arr=new Array();
	var j=0;
	var start=0;
	var ret;
	while(true)
	{
		ret=str.indexOf(delim,start);
		if(ret== -1)
		{
			break;
		}
		arr[j++]=str.substring(start,ret);
		start=ret+2;
	}
	return arr;
}
/*Changes for Tracker 174903 ends */
   <!-- function to perform some operations onload of the screen -->
   function load()
   {
     		//For enabling save button
     		var obj = parent.parent.parent.parent.frames(3);
		obj.enableButton_Ub();
   		document.frm2.REJECT_REASON.IsMandatory='true';
	    document.frm2.REJECT_REASON.isListView='true';
	    document.frm2.REJECT_REASON.Display='Selected Suspend Reasons';

		<!-- function tokens converts a group of data in a string
		     to an array                                          -->
		/*Changes for Tracker 174903 starts */
		var availReasons=tokens_Reason(aReasons, sentLimiter);
		var rejectReasons=tokens_Reason(rReasons, sentLimiter);
		/*Changes for Tracker 174903 ends */
	    <![CDATA[
	    for(var i=0;i<availReasons.length;i++)
	    {
			for(var j=0;j<rejectReasons.length;j++)
			{
 	      		if(trimReason(availReasons[i],wordLimiter)==trimReason(rejectReasons[j],wordLimiter))
		      	{
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
    /*Changes for trackerid:-187643 Changes Begin
    This piece of code was commented because when it was calling Extractdate
    method it was making it null without reason as a result valid till date was getting blank
    Since we are not using this method at all we are commenting the method*/
    <!--function updateDate(reason)
    {

	    document.frm2.ValidTill.value=extractDate(reason.value,wordLimiter);

    } -->
    /*Changes for trackerid:-187643 Changes End	*/
    <!-- function to Attach an item from Available Suspend lists
	   to Rejected Suspend lists with the date(ValidTill)
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
/*Changes for trackerid:-187643 Changes Begin
While adding valid Till date along with reason code it is making the value of ValidTill as null in UI*/
<!--document.frm2.ValidTill.value='';-->
/*Changes for trackerid:-187643 Changes End*/
      }



    <!-- function to Detach an item from Rejected Suspend lists
		   to Available Suspend lists with the date(ValidTill)
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
	  from Available lists if the entity is Suspend -->
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
		var ReasonString='';
		var z=document.frm2.REJECT_REASON;
      	<![CDATA[

		for(var i=0;i<z.length;i++)
        {
        	ReasonString+=z.options[i].value+sentLimiter;
        }
       	]]>


                /********ERPBOCF1:TRACKER:113259:STORAGE OF DATES :STARTOFCHANGES***********/
	       				var strAltCalType = document.all.ALTCALENDAR_TYPE.value;
	       				var strValidTillDt = document.all.validTillDate.value;

	       				if(strAltCalType = 'true')
	       				{
	       						   if(strValidTillDt == '')
	       						   {
	       						   }
	       						   else
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

	  	if(chkStat == "true")
      	         {

							//document.frm2.Notes.value=document.getElementsByName("CorporateBO.suspend_Notes")[0].value;
							//Recon from CRM10301BSUPP
							document.frm2.action = "../servlet/com.infy.cis.ui.corpcif.CorpSuspendWriter?apprFlag="+apprFlag+"&amp;ReasonString=" + ReasonString + "&amp;NoteString=" + NoteString+"&amp;SECUREHKEY="+hashkey+"&amp;FLDHASHKEY="+fldhashkey;
							document.frm2.target='formSaveFrame';

							document.frm2.submit();

							return "true";
						}
						else {

							return chkStat;
						}

					}

					function txtLimit1() {
						var x = document.getElementsByName("AttachNotes")[0];
						if (x.value.length > 2000){
							showMessage(MSGX0061);
							x.focus();

						}
					}
					function rejectReasonValue()
					{
						try
						{
							var rejectReason = "";
                                             document.getElementsByName("REJECT_REASON")[0].isListView = "true";
					document.getElementsByName("REJECT_REASON")[0].IsMandatory = "true";
					document.getElementsByName("REJECT_REASON")[0].Display = "Negated Reasons";
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
						//alert('value of Entyity id -- >'+entityID);

						execStatus = parent.formSaveFrame.executionStatus;

						if(execStatus == 'SUCCESS'){

							fetchFrom = parent.formSaveFrame.fetchFrom;

							CorpID = parent.formSaveFrame.CorpID;

							copyValue ='';

			//Recon from CRM10301BSUPP
			/*Changes by Niharika for CR356016*/
		  /*<![CDATA[
 var servletURL ="../../../servlet/com.infy.cis.ui.corpcif.CorpProcessSelectionDetWizard?entityId="
	+CorpID+"&amp;entityType="+fetchFrom+"&amp;SECUREHKEY="+hashkey+"&amp;FLDHASHKEY="+fldhashkey;
			]]>*/
			 var strProcessURL ="/FinacleCRM/servlet/com.infy.cis.custom.EquityCorporateProcessSelection?entityId="+CorpID+"&amp;entityType="+fetchFrom;
			            var strBOURL = 'abc';
						//alert('strBOURL    '+strBOURL);
						//alert('strProcessURL     '+strProcessURL);
						fnProcessSelection(strProcessURL, strBOURL);
       		/*End of changes by Niharika for CR356016*/
							// Tracker 96275 Changes BEGIN
							/*Changes by Niharika for CR356016*/
							/*if(apprFlag=='Y')
							{
							docTypeNew = window.open(servletURL, '','height=436, left=50, top=120, width=900, location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=yes');

							}*/
							/*End of changes by Niharika for CR356016*/
							// Tracker 96275 Changes END
						}
						//parent.parent.parent.parent.setButtonsVisible(false);
						//self.location.href="../../common/html/blank.html";
						//parent.frames(0).location.href = parent.frames(0).location.href;
                                                         top.window.close();
					}
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

                     <!-- CRA10MSC : TRACKER #90015 : END OF CHANGES -->
			</SCRIPT>
			</head>
			<link REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
			<body class="popup">
			<xsl:attribute name="onload">load()</xsl:attribute>
			<table  width="100%" cellpadding="0" cellspacing="0" border="0"  align="center">
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
	<xsl:with-param name="fn_onBlur">validateTillDate();</xsl:with-param>
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
				<xsl:with-param name="fn_onblur">txtLimit(this,500,"AttachNotes","Attach Suspend Notes")</xsl:with-param>
				<!--  TRACKER:78504:ENDOFCHANGES -->

  			    <xsl:with-param name="mname">AttachNotes</xsl:with-param>
  			</xsl:call-template>
       </xsl:template>


   	<!--
   	<xsl:template name="CorporateBO.suspend_Notes">
  		   <xsl:call-template name="mtextarea">
  			    <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.suspend_Notes']"/>
  			    <xsl:with-param name="mvalue">CorporateBO.suspend_Notes</xsl:with-param>
  			     <xsl:with-param name="fn_onblur">txtLimit1()</xsl:with-param>
		 	    <xsl:with-param name="mwrap">on</xsl:with-param>
		 	    <xsl:with-param name="mcols">30</xsl:with-param>
  			    <xsl:with-param name="mrows">5</xsl:with-param>
  			    <xsl:with-param name="mcolspan">3</xsl:with-param>
  			    <xsl:with-param name="mname">CorporateBO.suspend_Notes</xsl:with-param>
  		   </xsl:call-template>
       </xsl:template>
-->
   <!-- Tracker ID : 78943 BEGIN OF CHANGES -->
   <!-- Tracker ID : 59466 BEGIN OF CHANGES -->
     <xsl:template name="AVAILABLE_REJECT_REASON">
	    <xsl:call-template name="listview">
            <xsl:with-param name="ele_name">AVAILABLE_REJECT_REASON</xsl:with-param>
            <xsl:with-param name="size">4</xsl:with-param>
            <xsl:with-param name="width">218</xsl:with-param>
            <xsl:with-param name="multiple">false</xsl:with-param>
            <xsl:with-param name="class">listBox</xsl:with-param>
  	    <!--  CRM10.0ST Start TrackerID:109059  -->
            <xsl:with-param name="ondblclick">AddDate(AVAILABLE_REJECT_REASON,REJECT_REASON, false)</xsl:with-param>
 	    <!--  CRM10.0ST End -->
                      <!--Changes for trackerid:-187643 Changes Begin-->
                      <!--<xsl:with-param name="onclick">updateDate(AVAILABLE_REJECT_REASON)</xsl:with-param> -->
 		      <!--Changes for trackerid:-187643 Changes End -->

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
 	    <!--  CRM10.0ST Start TrackerID:109059  -->
            <xsl:with-param name="ondblclick">AddDate(REJECT_REASON, AVAILABLE_REJECT_REASON, true);</xsl:with-param>
 	    <!--  CRM10.0ST End -->
 	    <!--Changes for trackerid:-187643 Changes Begin -->
            <!--<xsl:with-param name="onclick">updateDate(REJECT_REASON)</xsl:with-param> -->
            <!--Changes for trackerid:-187643 Changes End -->

            <xsl:with-param name="selectname">REJECT_REASON</xsl:with-param>
	    <xsl:with-param name="selectdisp">REJECT_REASON</xsl:with-param>
        </xsl:call-template>
    </xsl:template>


	<xsl:template match="*" mode="mode1">
	<xsl:call-template name="Begin"/>
	<td>
	<form name="frm2"  method="post">
	<input type="hidden" name="entityID" value="{$entityID}"/>
	<input type="hidden" name="entityType" value="{$entityType}"/>
	<input type="hidden" name="operation" value="{$operation}"/>
	<input type="hidden" name="rejectReasonvalues" value=""/>
	<input type="hidden" name="Notes" value=""/>
	<input type="hidden" name="CurrentDate" value=""/>
	 <!--ERPBOCF1:TRACKER:113259:STORAGE OF DATES :STARTOFCHANGES-->
		   <input type="hidden" name="validTillDate" value=""/>
		   <input type="hidden" value="{$ALTCALENDAR_TYPE}" name="ALTCALENDAR_TYPE"/>
	 <!--ERPBOCF1:TRACKER:113259:STORAGE OF DATES :ENDOFCHANGES-->

	<xsl:call-template name="Begin"/>
	<xsl:call-template name="IsSuspended"/>
	<td></td>
	<xsl:call-template name="ValidTill"/>
	<xsl:call-template name="End"/>
	<TR >

		  		<TD nowrap="true" align="left" valign ="top" class="d1" style="width:22%"><xsl:value-of select="$configLabels[@name='AVAILABLE_REJECT_REASON']/@configLabel"/></TD>
		  		<TD style="width:22%">
		  			<xsl:call-template name="AVAILABLE_REJECT_REASON"/>
		  		</TD>
		  		<TD width="5%" align="center">
		  			<input class='frmBttnsAddRmv' Type='button' value='&gt;&gt;'
		  			onclick="AddDate(AVAILABLE_REJECT_REASON,REJECT_REASON, false)"/><BR/>
		  			<input class='frmBttnsAddRmv' Type='button' value='&lt;&lt;'
		  			onclick="AddDate(REJECT_REASON, AVAILABLE_REJECT_REASON, true)"/>
		  			</TD>
		  		<TD  nowrap="true" valign ="top" class="d1" style="width:22%"><xsl:value-of select="$configLabels[@name='REJECT_REASON']/@configLabel"/>&#160;<STRONG class="mandatory_indicator">*</STRONG></TD>
		  		<TD>
		  			<xsl:call-template name="REJECT_REASON"/>
		  		</TD>

	 </TR>
	 <!-- <td align="left" valign ="top" class="d1" style='width:29%'><xsl:value-of select="$configLabels[@name='AVAILABLE_REJECT_REASON']/@configLabel"/></td>
	 		<td>
	 		<xsl:call-template name="AVAILABLE_REJECT_REASON"/></td><td></td>
	 		 <TD align='center' width="1%">
	 	 			<TABLE align="center" >
	 	 			<TR>
	 	 			<TD align='center'>
	 	 			<input class="frmBttnsAddRmv" Type='button' value='&gt;&gt;' onclick="AddDate(AVAILABLE_REJECT_REASON, REJECT_REASON,false)"/>
	 	 			</TD>
	 	 			</TR>
	 	 			<TR>
	 	 			<TD align='center'>
	 	 			<input class="frmBttnsAddRmv" Type='button' value='&lt;&lt;' onclick="RemoveDate(REJECT_REASON,AVAILABLE_REJECT_REASON,true)"/>
	 	 			</TD>
	 	 			</TR>
	 	 			</TABLE>

	 		</TD>

	 	 <td nowrap="true" align="left" valign ="top" class="d1" style='width:29%'><xsl:value-of select="$configLabels[@name='REJECT_REASON']/@configLabel"/></td>
	 	 <TD>
	 	 			<xsl:call-template name="REJECT_REASON"/>
	 </TD> -->

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
	  <xsl:call-template name="End"/>
	  <tr><td colspan="4"><table><tr><td/></tr></table></td></tr>
	  <tr><td colspan="4"><table><tr><td/></tr></table></td></tr>
	  <tr><td colspan="4"><table><tr><td/></tr></table></td></tr>
	  <tr><td colspan="4"><table><tr><td/></tr></table></td></tr>
	  <tr><td colspan="4"><table><tr><td/></tr></table></td></tr>
	  <tr><td colspan="4"><table><tr><td/></tr></table></td></tr>





	 <tr><td colspan="4"><table><tr><td/></tr></table></td></tr>
	  <tr><td colspan="4"><table><tr><td/></tr></table></td></tr>
	  <tr><td colspan="4"><table><tr><td/></tr></table></td></tr>
	 <tr><td colspan="4"><table><tr><td/></tr></table></td></tr>
 -->

	 <xsl:call-template name="Begin"/>
	<xsl:call-template name="AttachNotes"/>
	 <xsl:call-template name="End"/>



	</form>
  </td>
<xsl:call-template name="End"/>
	</xsl:template>
<xsl:template match="SRM">
       <xsl:for-each select=".">
          <tr>
             <td>
                <table border="0" width="100%" cellspacing="1" cellpadding="0">
                   <tr>
                         <xsl:call-template name="apply">
                          <xsl:with-param name="apply_head">
                          <b><xsl:value-of select="$configLabels[@name='Header']/@configLabel"/></b>
                          </xsl:with-param>
                          </xsl:call-template>
                   </tr>
               </table>
               <table width="100%" border="0" cellspacing="1" cellpadding="0" align="left">
                     <xsl:apply-templates select="." mode="mode1"/>
               </table>
             </td>
          </tr>
       </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>










