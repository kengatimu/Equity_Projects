<?xml version='1.0'?>
 <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"/>
  <xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"/>
        <xsl:param name="locale"/>
        
        <!--ERPBOCF1:TRACKER113259:STORAGE OF DATES :STARTOFCHANGES-->
	       	<xsl:param name="ALTCALENDAR_TYPE"/>
       <!--ERPBOCF1:TRACKER113259: STORAGE OF DATES :ENDOFCHANGES-->
<!--Changes by Niharika for CR356016-->
    <xsl:variable name="file1">../Renderer/Customization/cif/resource/Ret_Blacklist_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<!--End of changes by Niharika for CR356016-->
<xsl:variable name="configFile_1" select="document(concat($file1, ''))"/>
  <xsl:variable name="configLabels" select="$configFile_1/SRMBO/*"/>
   <!--CRA10MSC : TRACKER# 90015: BEGIN OF CHANGES--> 
    <xsl:variable name="RejectReasons" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='RejectReasons']"/> 
    <xsl:variable name="availableReasons" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AvailableReasons']"/> 
    <xsl:variable name="Delimiter_Word" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Delimiter_Word']"/> 
    <xsl:variable name="Delimiter_Sentence" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Delimiter_Sentence']"/> 
    <!--CRA10MSC : TRACKER# 90015: END OF CHANGES--> 

  <xsl:variable name="entityID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='entityId']"/>
  <xsl:variable name="entityType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='entityType']"/>
 <xsl:variable name="expDate" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='expDate']" />
  <xsl:variable name="operation" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='operation']"/>
  <xsl:variable name="NoteString" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='NoteString']"/> 
  <xsl:variable name="AttachNotes" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AttachNotes']"/> 
  <!--Changes for Approval: start-->
  <xsl:variable name="apprFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='apprFlag']"/>
  <!--Changes for Approval: end-->
  <xsl:template match="/">
	<html>
			<head>
<!--Performance-->
			<!--<script type="text/javascript" src="../common/js/ClientResourceBundle_{$locale}.js" language="javascript"></script>
<script type="text/javascript" src="../common/html/validate.js" language="javascript"></script>
<script type="text/javascript" src="../common/html/validateL2.js" language="javascript"></script> -->
<!--Changes by Niharika for CR356016-->
<script type="text/javascript" src="../Customization/cif/js/EquityProcessCustom.js" language="javascript"></script>
<!--End of changes by Niharika for CR356016-->
<!--Performance-->
<!--<script type="text/javascript" src="../common/js/ListBoxFunctions.js"></script>--> 
<!--CRA10MSC : TRACKER# 90015: BEGIN OF CHANGES--> 
<script type="text/javascript" src="../cif/js/StringTokenizer.js"></script> 
<!--CRA10MSC : TRACKER# 90015: END OF CHANGES--> 
<script>
var locale = '<xsl:value-of select="$locale"/>';
var apprFlag='<xsl:value-of select="$apprFlag"/>';//CIF Changes for Approval
var AttachNotes = '<xsl:value-of select="$AttachNotes"/>';
</script>
	     <title><xsl:value-of select="//SRMPresentation/SRMSystem[@n='Strings']/SRMString[@n='Title']/@value"/></title>
	      <LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
	      <STYLE>.listBox  {  width=200px}</STYLE>
	      <SCRIPT>
	      
	      
	  <!--CRA10MSC : TRACKER# 90015: BEGIN OF CHANGES--> 
	var no_errors; 
    //366332 changes
	var aReasons=escape("<xsl:value-of select="$availableReasons"/>");
	aReasons=unescape(aReasons);
	var rReasons='<xsl:value-of select="$RejectReasons"/>'; 
	var wordLimiter= '<xsl:value-of select="$Delimiter_Word"/>' 
	var sentLimiter='<xsl:value-of select="$Delimiter_Sentence"/>'; 
	var expDate='<xsl:value-of select="$expDate"/>';
 
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
		document.frm2.RejectReasonList.IsMandatory='true'; 
		document.frm2.RejectReasonList.isListView='true'; 
		document.frm2.ValidTill.value = expDate;
	    document.frm2.RejectReasonList.Display='Selected Blacklisted Reasons'; 
 
		<!-- function tokens converts a group of data in a string 
			     to an array                                          --> 
		//alert('aReasons::'+aReasons); 
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
		        	break; 
		        } 
			} 
 
			<!-- to add the available reasons to the AvailableReasonsList --> 
			if(j==rejectReasons.length) 
			{ 
			   addToTheList(availReasons[i],availReasons[i],document.frm2.AvailableReasons,'ADD'); 
			} 
		} 
 
		<!-- to add the reject reasons to the RejectReasonsList --> 
	    for(var i=0;i<rejectReasons.length;i++) 
	    { 
	    	addToTheList(rejectReasons[i],rejectReasons[i],document.frm2.RejectReasonList,'ADD'); 
	   	} 
 
		]]> 
	} 
 
	<!-- function to change the valid till Date field on click 
	           of an item in the listbox with or without dates     --> 
	function updateDate(reason) 
	{ 
		/*
		 * Fix for ticket 242674
		 * This code was not letting the value get saved
		 */
		//document.frm2.ValidTill.value=extractDate(reason.value,wordLimiter); 
		/* END OF CHANGES */
	} 
 
    <!-- function to Attach an item from Available Blacklist lists 
	           to Rejected Blacklist lists with the date(ValidTill) 
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
		/*
		 * Fix for ticket 242674
		 * This code was causing the value to go blank
		 */
		//document.frm2.ValidTill.value='';
		/* END OF CHANGES */
    } 
 
    <!-- function to Detach an item from Rejected Blacklist lists 
	      	           to Available Blacklist lists with the date(ValidTill) 
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
	          from Available lists if the entity is blacklisted --> 
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
		var z=document.frm2.RejectReasonList; 
		<![CDATA[ 
		for(var i=0;i<z.length;i++) 
		{ 
			ReasonString+=z.options[i].value+sentLimiter; 
		} 
		]]> 
 
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
							//Changes for Approval
			                                    // document.frm2.action = "../servlet/com.infy.cis.ui.cif.BlackListWriter?apprFlag="+apprFlag+"&amp;ReasonString=" + ReasonString + "&amp;NoteString=" + NoteString;
			                                     document.frm2.action = "../servlet/com.infy.cis.ui.cif.BlackListWriter?apprFlag="+apprFlag+"&amp;ReasonString=" + ReasonString;
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
							document.getElementsByName("RejectReasonList")[0].Display = "BlackListed Reasons";
							for (i=0; i &lt; document.frm2.RejectReasonList.length - 1; i++) {
							rejectReason += document.frm2.RejectReasonList.options[i].value + sentLimiter;
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
										
					  //Recon of Security Audit Changes From CRM10301BSUPP
					var secureHKey = document.getElementsByName("SECUREHKEY")[0].value;	
					var keyField = document.getElementsByName("FLDHASHKEY")[0].value;
					/*Changes by Niharika for CR356016*/
					//window.open('../../../servlet/com.infy.cis.ui.cif.CIFProcessSelectionDetWizard?entityId='+entId+'&amp;entityType='+sentityType+'&amp;isPopup=Yes&amp;SECUREHKEY='+secureHKey+'&amp;FLDHASHKEY='+keyField,'save','directories=No, height=436, left=210, top=120, width=575, location=no, menubar=no, resizable=no, status=no, toolbar=no, scrollbars=yes');
					var strProcessURL = '../servlet/com.infy.cis.custom.EquityRetailProcessSelection?entityId='+entId+'&amp;entityType='+sentityType;
					var strBOURL = 'abc';
					//alert('strBOURL    '+strBOURL);
					//alert('strProcessURL     '+strProcessURL);
					fnProcessSelection(strProcessURL, strBOURL);
       				/*End of changes by Niharika for CR356016*/
					  //Recon of Security Audit Changes From CRM10301BSUPP	
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
     <xsl:template name="AvailableReasons">
	    <xsl:call-template name="listview">
            <xsl:with-param name="ele_name">AvailableReasons</xsl:with-param>
            <xsl:with-param name="size">4</xsl:with-param>
            <xsl:with-param name="multiple">false</xsl:with-param>
            <xsl:with-param name="class">listBox</xsl:with-param>
            <!--  CRM10.0ST Start TrackerID:109059  -->
            <xsl:with-param name="ondblclick">AddDate(AvailableReasons, RejectReasonList,false)</xsl:with-param>
            <!--  CRM10.0ST End -->
            <xsl:with-param name="onclick">updateDate(AvailableReasons);</xsl:with-param> 
          
            <xsl:with-param name="selectname">AvailableReasons</xsl:with-param>
            <xsl:with-param name="selectdisp">AvailableReasons</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    <xsl:template name="RejectReasonList">
	    <xsl:call-template name="listview">
            <xsl:with-param name="ele_name">RejectReasonList</xsl:with-param>
            <xsl:with-param name="size">4</xsl:with-param>
            <xsl:with-param name="width">218</xsl:with-param>
			<xsl:with-param name="IsMandatory">false</xsl:with-param>
            <xsl:with-param name="multiple">false</xsl:with-param>
            <xsl:with-param name="class">listBox</xsl:with-param>
            <!--  CRM10.0ST Start TrackerID:109059  -->
            <xsl:with-param name="ondblclick">RemoveDate(RejectReasonList,AvailableReasons,true)</xsl:with-param>
            <!--  CRM10.0ST End -->
            <xsl:with-param name="onclick">updateDate(RejectReasonList);</xsl:with-param> 
          
            <xsl:with-param name="selectname">RejectReasonList</xsl:with-param>
	    <xsl:with-param name="selectdisp">RejectReasonList</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
  
	<!--CRA10MSC : TRACKER# 90015: BEGIN OF CHANGES--> 
 
	<xsl:template name="IsBlackListed"> 
	<xsl:call-template name="label"> 
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param> 
			<xsl:with-param name="res_name" select="$configLabels[@name='IsBlackListed']"/> 
			<xsl:with-param name="ele_name">IsBlackListed</xsl:with-param> 
			<xsl:with-param name="ele_val">IsBlackListed</xsl:with-param> 
			<xsl:with-param name="is_date">false</xsl:with-param> 
			<xsl:with-param name="read_val">true</xsl:with-param> 
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
			<!-- fix for ticket 201980 start-->
			<!-- Changes for tracker 456097 start-->
			<xsl:with-param name="fn_onBlur">isGregDate("ValidTill");validateTillDate();</xsl:with-param>
			<!-- Changes for tracker 456097 end-->
			<!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
	</xsl:call-template> 
	</xsl:template> 
 
	<!--CRA10MSC : TRACKER# 90015: END OF CHANGES--> 
 
	<xsl:template match="*" mode="mode1">
	
	<form name="frm2"  method="post">
	<input type="hidden" name="entityID" value="{$entityID}"/>
	<input type="hidden" name="entityType" value="{$entityType}"/>
	<input type="hidden" name="operation" value="{$operation}"/>
	<input type="hidden" name="rejectReasonvalues" value=""/>
	 <input type="hidden" name="NoteString" value=""/>
	<input type="hidden" name="CurrentDate" value=""/> 
	 <!--ERPBOCF1:TRACKER:113259:STORAGE OF DATES :STARTOFCHANGES-->	
		   <input type="hidden" name="validTillDate" value=""/>  
		   <input type="hidden" value="{$ALTCALENDAR_TYPE}" name="ALTCALENDAR_TYPE"/>
	 <!--ERPBOCF1:TRACKER:113259:STORAGE OF DATES :ENDOFCHANGES-->
 
	
	<xsl:call-template name="Begin"/>
		<xsl:call-template name="IsBlackListed"/>
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
				<xsl:call-template name="AvailableReasons"/>
			</TD>	
			<TD width="5%" align="center">
				<input class='frmBttnsAddRmv' Type='button' value='&gt;&gt;'
				onclick="AddDate(AvailableReasons, RejectReasonList,false)"/><BR/>
				<input class='frmBttnsAddRmv' Type='button' value='&lt;&lt;'
				onclick="RemoveDate(RejectReasonList,AvailableReasons,true)"/>
				</TD>
			<TD  valign ="top" class="d1" style="width:22%"><xsl:value-of select="$configLabels[@name='REJECT_REASON']/@configLabel"/>&#160;<STRONG class="mandatory_indicator">*</STRONG></TD>
			<TD>
				<xsl:call-template name="RejectReasonList"/>
			</TD>

		</TR>   
	                 
	<xsl:call-template name="End"/> 
	 
	 
	 
	 
	 
	 <!--<xsl:call-template name="Begin"/>
		<td  class='Labels' align='middle'><xsl:value-of select="$configLabels[@name='AvailableReasons']/@configLabel"/></td>
		<td  class='Labels'>&#160;</td>
		<td  class='Labels' align='middle'><xsl:value-of select="$configLabels[@name='RejectReasonList']/@configLabel"/></td>
	 <xsl:call-template name="End"/>
	 <xsl:call-template name="Begin"/>
	  	<td rowSpan='4' align='middle'  class="d3">
         	   <xsl:call-template name="AvailableReasons"/>
                </td>
		<td style='padding-top=10px' align='middle' class="AddRemove">
  	        <b><xsl:value-of select="$configLabels[@name='ADD']/@configLabel"/></b><br/>
		    <input class="sbttn" Type='button' value=' &gt; ' onclick="AddDate(AvailableReasons, RejectReasonList,false)"/><br/><br/>
		</td>  
		<td rowSpan='4' align='middle'  class="d3">
                   <xsl:call-template name="RejectReasonList"/>
                </td>
            	<xsl:call-template name="End"/>
	  <xsl:call-template name="Begin"/>
        	<td align='middle' class="AddRemove">
                <b><xsl:value-of select="$configLabels[@name='REMOVE']/@configLabel"/></b><br/>
		    <input class="sbttn" Type='button' value=' &lt; ' onclick="RemoveDate(RejectReasonList,AvailableReasons,true)"/>
		</td>       
	  <xsl:call-template name="End"/>	-->		  
	  
 
 
 
	
	
	</form>
  
	</xsl:template>
<xsl:template match="SRM">
       <xsl:for-each select=".">
          <tr>
             <td>
                <table border="0" width="100%" cellspacing="0" cellpadding="0">
                   <tr>
                         <xsl:call-template name="apply">
                          <xsl:with-param name="apply_head">
                          <b><xsl:value-of select="$configLabels[@name=$entityType]/@configLabel"/></b>
                          </xsl:with-param>
                          </xsl:call-template>
                   </tr>
               </table>
               <table width="100%" border="0" cellspacing="0" cellpadding="0" align="left">
                     <xsl:apply-templates select="." mode="mode1"/>
               </table>
             </td>
          </tr>
       </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>









