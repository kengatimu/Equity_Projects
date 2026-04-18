<?xml version='1.0'?>
 <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"/>
  <xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"/>
        <xsl:param name="locale"/>
        <!--Changes by Niharika for CR356016-->
    <xsl:variable name="file1">../Renderer/Customization/corpcif/resource/Corp_UnSuspend_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<!--End of changes by Niharika for CR356016-->
<xsl:variable name="configFile_1" select="document(concat($file1, ''))"/>
  <xsl:variable name="configLabels" select="$configFile_1/SRMBO/*"/>
  <xsl:variable name="entityID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='entityId']"/>
  <xsl:variable name="entityType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='entityType']"/>
  <!--CRA10MSC : TRACKER #90015 : BEGIN OF CHANGES -->
  <xsl:variable name="availableReasons" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AvailableReasons']"/>
  <xsl:variable name="Delimiter_Word" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Delimiter_Word']"/>
  <xsl:variable name="Delimiter_Sentence" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Delimiter_Sentence']"/>
  <xsl:variable name="entityId" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='entityId']"/>

  <xsl:variable name="operation" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='operation']"/>
    <xsl:variable name="accountID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='accountID']"/>
  <!--CRA10MSC : TRACKER #90015 : END OF CHANGES -->

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
<script type="text/javascript" src="../common/js/ListBoxFunctions.js"></script>
  <!--CRA10MSC : TRACKER #90015 : BEGIN OF CHANGES -->
  <script type="text/javascript" src="../cif/js/StringTokenizer.js"></script>
  <!--CRA10MSC : TRACKER #90015 : END OF CHANGES -->
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
var entityId = '<xsl:value-of select="$entityId"/>';
var operation = '<xsl:value-of select="$operation"/>';

</script>
	     <title><xsl:value-of select="//SRMPresentation/SRMSystem[@n='Strings']/SRMString[@n='Title']/@value"/></title>
	      <LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
	      <STYLE>.listBox  {  width=200px}</STYLE>
	      <SCRIPT>


          //366332 changes
		  	var aReasons=escape("<xsl:value-of select="$availableReasons"/>");
		  	aReasons=unescape(aReasons);
	      var wordLimiter= '<xsl:value-of select="$Delimiter_Word"/>';
	      var sentLimiter='<xsl:value-of select="$Delimiter_Sentence"/>';

	      var ENTITYID='<xsl:value-of select="$entityId"/>';
	      var ENTITYTYPE='<xsl:value-of select="$entityType"/>';

  function enableButton()
  {
  	try
  	{
  		var obj = parent.parent.parent.parent.frames(3);
   		obj.enableButton_Ub();
   	}
   	catch (e)
   	{
   	}

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
    <!--CRA10MSC : TRACKER #90015 : BEGIN OF CHANGES -->

	<!-- function to perform some operations onload of the screen -->
	function load()
	{

		/*Changes for Tracker 174903 starts */
		var availReasons=tokens_Reason(aReasons,sentLimiter);
		/*Changes for Tracker 174903 ends */
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

 		// Changes starts for trackerID:235579
		//document.frm2.REJECT_REASON.Display='Selected UnBlacklisted Reasons';
		document.frm2.REJECT_REASON.Display='Selected UnSuspended Reasons';
       // Changes starts for trackerID:235579
		var chkStat = parent.parent.parent.parent.ValidateFormContents(document.frm2,true);
		var NoteString = document.frm2.UnSuspendNotes.value;

		var ReasonString='';
		var z=document.frm2.REJECT_REASON;

		<![CDATA[
		for(var i=0;i<z.length;i++)
		{
			ReasonString+=z.options[i].value+sentLimiter;
		}
		]]>

		if(chkStat == "true")
		{

							//document.frm2.Notes.value=document.getElementsByName("CorporateBO.Suspend_Notes")[0].value;
                            //Recon from CRM10301BSUPP
							document.frm2.action = "../servlet/com.infy.cis.ui.corpcif.CorpSuspendWriter?apprFlag="+apprFlag+"&amp;ReasonString=" + ReasonString + "&amp;NoteString=" + NoteString + "&amp;operation=" + operation + "&amp;entityID="+ entityId+"&amp;SECUREHKEY="+hashkey+"&amp;FLDHASHKEY="+fldhashkey;
							document.frm2.target='formSaveFrame';
							document.frm2.submit();
							return "true";
						}
						else {

							return chkStat;
						}

					}
                                               <!-- CRA10MSC : TRACKER #90015 : END OF CHANGES -->
					function txtLimit1() {
						var x = document.getElementsByName("CorporateBO.Suspend_Notes")[0];
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
				document.getElementsByName("REJECT_REASON")[0].Display = "UnSuspend Reasons";
				for (i=0; i &lt; document.frm2.REJECT_REASON.length - 1; i++) {
				rejectReason += document.frm2.REJECT_REASON.options[i].text + sentLimiter;
				}
				if (document.frm2.RejectReasonList.length > 0) {
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
						//alert("Inside clear");
						execStatus = parent.formSaveFrame.executionStatus;
						//alert("execStatus"+execStatus);
						if(execStatus == 'SUCCESS'){

							fetchFrom = parent.formSaveFrame.fetchFrom;
							//alert("fetchFrom"+fetchFrom);
							CorpID = parent.formSaveFrame.CorpID;
							//alert("CorpID"+CorpID);
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
							// Tracker 96275 BEGIN
							/*Changes by Niharika for CR356016*/
							/*if(apprFlag=='Y')
							{
							docTypeNew = window.open(servletURL, '','height=436, left=70, top=120, width=860, location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=yes');
							}*/
							/*End of changes by Niharika for CR356016*/
							// Tracker 96275 END
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

			</SCRIPT>
			</head>
			<link REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
			<body class="popup">
			<xsl:attribute name="onload">load();enableButton();</xsl:attribute>
			<table width="100%" cellpadding="0" cellspacing="0" border="0"  align="left">
			<xsl:apply-templates select="SRM"/>
			</table>
               </body>
		</html>
</xsl:template>
<!--template for Note  here-->
   <xsl:template name="CorporateBO.suspend_Notes">
  		   <xsl:call-template name="mtextarea">
  			    <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.suspend_Notes']"/>
  			    <xsl:with-param name="mvalue">UnSuspendNotes</xsl:with-param>
  			    <xsl:with-param name="mcols">30</xsl:with-param>
  			    <xsl:with-param name="mrows">2</xsl:with-param>
  			    <xsl:with-param name="mcolspan">3</xsl:with-param>
				<!--  Fix for Tracker#79889: Starts -->
				<xsl:with-param name="fn_onblur">txtLimit(this,500,"UnSuspendNotes","Undo Suspend Notes")</xsl:with-param>
				<!--  Fix for Tracker#79889: Ends -->
  			    <xsl:with-param name="mname">UnSuspendNotes</xsl:with-param>
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
            <xsl:with-param name="ondblclick">selfield(AVAILABLE_REJECT_REASON,REJECT_REASON, false)</xsl:with-param>
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
            <!--  CRM10.0ST Start TrackerID:109059  -->
            <xsl:with-param name="ondblclick">selfield(REJECT_REASON, AVAILABLE_REJECT_REASON, true)</xsl:with-param>
            <!--  CRM10.0ST End -->
            <xsl:with-param name="selectname">REJECT_REASON</xsl:with-param>
	    <xsl:with-param name="selectdisp">REJECT_REASON</xsl:with-param>
        </xsl:call-template>
    </xsl:template>


	<xsl:template match="*" mode="mode1">
	<xsl:call-template name="Begin"/>
	<td>
	<form name="frm2"  method="post">
	<input type="hidden" name="accountID" value="{$accountID}"/>
	<input type="hidden" name="entityType" value="{$entityType}"/>
	<input type="hidden" name="operation" value="{$operation}"/>
	<input type="hidden" name="rejectReasonvalues" value=""/>
	<input type="hidden" name="Notes" value=""/>
	<xsl:call-template name="Begin"/>
			<xsl:call-template name="CorporateBO.suspend_Notes"/>
	 <xsl:call-template name="End"/>
	<xsl:call-template name="Begin"/>
		<TR >

			  		<TD nowrap="true" align="left" valign ="top" class="d1" style="width:22%"><xsl:value-of select="$configLabels[@name='AVAILABLE_REJECT_REASON']/@configLabel"/></TD>
			  		<TD style="width:22%">
			  			<xsl:call-template name="AVAILABLE_REJECT_REASON"/>
			  		</TD>
			  		<TD width="5%" align="center">
			  			<input class='frmBttnsAddRmv' Type='button' value='&gt;&gt;'
			  			onclick="selfield(AVAILABLE_REJECT_REASON,REJECT_REASON, false)"/><BR/>
			  			<input class='frmBttnsAddRmv' Type='button' value='&lt;&lt;'
			  			onclick="selfield(REJECT_REASON, AVAILABLE_REJECT_REASON, true)"/>
			  			</TD>
			  		<TD  nowrap="true" valign ="top" class="d1" style="width:22%"><xsl:value-of select="$configLabels[@name='REJECT_REASON']/@configLabel"/>&#160;<STRONG class="mandatory_indicator">*</STRONG></TD>
			  		<TD>
			  			<xsl:call-template name="REJECT_REASON"/>
			  		</TD>

	 </TR>
	<xsl:call-template name="End"/>

	</form>
  </td>
<xsl:call-template name="End"/>
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








