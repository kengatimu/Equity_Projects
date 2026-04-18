<?xml version="1.0"?>
    <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"/>
    <xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"/>
        <xsl:param name="locale"/>
    <xsl:variable name="file1">../Renderer/cif/resource/RetCustPhoneEmail_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<xsl:variable name="configFile_1" select="document(concat($file1,''))"/>
    <xsl:variable name="configLabels" select="$configFile_1/SRMBO/*"/>
    <xsl:variable name="readMode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsReadOnly']"/>
    <!--Chanses By Suman for Approval:Start-->
    <xsl:variable name="apprFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='apprFlag']"/>
    <!--Chanses By Suman for Approval:End-->
    <xsl:variable name="allfields" select="//SRMData//Z"/>
<!-- CIF Changes for Caching Views : Start -->
    <xsl:param name="viewname"/>
<!--     CIF PhoneEmail Changes : Start -->
    <xsl:param name="phoneOrEmail"/>
    <xsl:variable name="isEdit" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsEdit']"/>
    <!-- Changes for Tracker 174169 starts -->
	<xsl:variable name="isCopy" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsCopy']"/>
    <!-- Changes for Tracker 174169 ends -->
       <!--  Change for TicketID: 469253 Tracker ID:285727 Start -->
       <!--  changes for 247853 start -->
	<xsl:variable name="getMCRequired" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='MCRequired']"/>
	<!-- changes for 247853 end -->
	 <!--  Change for TicketID: 469253 Tracker ID:285727 End -->
<!--     CIF PhoneEmail Changes : End -->
    <xsl:variable name="PresFileName">../servlet/com.infy.cis.ui.cif.CIF_DetPresCacheServlet?ViewName=<xsl:value-of select="$viewname"/>&amp;Locale=<xsl:value-of select="$locale"/></xsl:variable>
    <xsl:variable name="PresFile" select="document(concat($PresFileName,''))"/>
    <xsl:variable name="PresData" select="$PresFile/SRM/SRMPresentation"/>
<!-- CIF Changes for Caching Views : End -->

    <xsl:template match="/">
    <html>
        <title><xsl:value-of select="//SRMPresentation/SRMSystem[@n='Strings']/SRMString[@n='Title']/@value"/></title>
    <head>
    <!--Performance-->
	<!--<script type="text/javascript" src="../common/js/ClientResourceBundle_{$locale}.js" language="javascript"></script>-->
<!--Performance-->
	<script type="text/javascript" src="../cif/js/Message_cif_{$locale}.js" language="javascript"></script>
<script type="text/javascript" src="../common/js/Message_common_{$locale}.js" language="javascript"></script>
    <script>
    var locale = '<xsl:value-of select="$locale"/>';
    </script>
    <LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
    <LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/MultiTabs_{$locale}.css"/>
<!--Performance-->
    <!--<script type="text/javascript" src="../common/html/utils.js" language="javascript"></script>
    <script type="text/javascript" src="../common/js/MLValidate.js" language="javascript"></script>
    <script type="text/javascript" src="../common/html/validate.js" language="javascript"></script>-->
    <!--Performance-->
	<SCRIPT LANGUAGE='javascript' SRC='../common/js/FieldValidate.js'></SCRIPT>
    <script type="text/javascript" src="../common/js/SRMTableRowColor.js" language="javascript"></script>
    <!--Performance-->
	<!--<script type="text/javascript" src="../common/html/validateL2.js" language="javascript"></script>-->
    <!--Performance-->
	<script type="text/javascript" src="../cif/js/CIFPhoneEmail.js" language="javascript"></script>
    <script type="text/javascript" language="javascript">
	var PhoneEmailID="";
	function load(){
	try{
		/*TRACKER 182390:BEGIN OF CHANGES*/
		/*Start of Fix for the ticket 243350 - to make all the below mentioned fields mandatory*/
		//document.getElementsByName("AccountBO.PhoneEmail.PhoneNo.cntrycode")[0].IsMandatory = "true";
		//document.getElementsByName("AccountBO.PhoneEmail.PhoneNo.areacode")[0].IsMandatory = "true";
		//document.getElementsByName("AccountBO.PhoneEmail.PhoneNo.localCode")[0].IsMandatory = "true";
		/*end of Fix for the ticket 243350*/
		/*TRACKER 182390:END OF CHANGES*/
		/*changes made for ticket 337631 start*/
/* Changes made for tracker id 336792 :: start */
var PhoneorEmail;
PhoneorEmail=document.getElementsByName('AccountBO.PhoneEmail.PhoneOrEmail')[0].value;
/* Changes made for tracker id 336792 :: end */
		var phonetype;
		//changes for Tracker #303241 starts
		PhoneEmailID = '<xsl:value-of select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccountBO.PhoneEmail.PhoneEmailID']"/>';
		//changes for Tracker #303241 ends
/* Changes made for tracker id 336792 :: start  */
if(PhoneorEmail=='PHONE'){
		phonetype = document.getElementsByName('AccountBO.PhoneEmail.PhoneEmailType')[0].value;
		 if(phonetype=='WORKPH2'||phonetype=='WORKPH1'){
			document.getElementsByName('AccountBO.PhoneEmail.WorkExtension')[0].disabled=false;
		 }else{
			document.getElementsByName('AccountBO.PhoneEmail.WorkExtension')[0].value = "";
			document.getElementsByName('AccountBO.PhoneEmail.WorkExtension')[0].disabled=true;
		} } else if(PhoneorEmail=='EMAIL'){
			phonetype = document.getElementsByName('AccountBO.PhoneEmail.PhoneEmailType');
		}
/* Changes made for tracker id 336792 :: end */
		/*changes made for ticket 337631 end */

/*		if('<xsl:value-of select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccountBO.PhoneEmail.PhoneOrEmail']"/>' == "P")
		{
			document.getElementsByName('AccountBO.PhoneEmail.PhoneOrEmail')[0].value = "PHONE";
		}
		else if('<xsl:value-of select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccountBO.PhoneEmail.PhoneOrEmail']"/>' == "E")
		{
			document.getElementsByName('AccountBO.PhoneEmail.PhoneOrEmail')[0].value = "EMAIL";
		}
		else
		{
			document.getElementsByName('AccountBO.PhoneEmail.PhoneOrEmail')[0].value = "PHONE";
		}*/
		if('<xsl:value-of select="$phoneOrEmail"/>' == '')
		{
			/*TRACKER 182390:BEGIN OF CHANGES*/
			document.getElementsByName('AccountBO.PhoneEmail.PhoneOrEmail')[0].value = "PHONE";
			document.getElementsByName("AccountBO.PhoneEmail.PhoneNo.cntrycode")[0].IsMandatory = "true";
			// commenting for 355347 document.getElementsByName("AccountBO.PhoneEmail.PhoneNo.areacode")[0].IsMandatory = "true";
			document.getElementsByName("AccountBO.PhoneEmail.PhoneNo.localCode")[0].IsMandatory = "true";
			/*TRACKER 182390:END OF CHANGES*/
		}
		if('<xsl:value-of select="$isEdit"/>' == 'Yes')
		{
			document.getElementsByName('AccountBO.PhoneEmail.PhoneOrEmail')[0].disabled = true;
		}
		//Changes for Tracker #303241 starts
		//PhoneEmailID = '<xsl:value-of select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccountBO.PhoneEmail.PhoneEmailID']"/>';
		//changes for Tracker #303241 ends
		var phoneTypeCustom = '<xsl:value-of select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccountBO.PhoneEmail.PhoneEmailType']"/>';
	        var phoneType = document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType")[0];
	        phoneType.value = phoneTypeCustom;


	      /* Change for Tracker 180758 */
	      /* This piece of code was disabled......  uncommented as it sets the mandatory star for extension */
	      if (phoneTypeCustom == "WORKPH1" || phoneTypeCustom == "WORKPH2")
	       {
		      document.getElementsByName("mandStarAccountBO.PhoneEmail.WorkExtension")[0].style.visibility="visible";
		      document.getElementsByName("AccountBO.PhoneEmail.WorkExtension")[0].IsMandatory = "true";
	       }
	       else{
		    document.getElementsByName("mandStarAccountBO.PhoneEmail.WorkExtension")[0].style.visibility="hidden";
		    document.getElementsByName("AccountBO.PhoneEmail.WorkExtension")[0].IsMandatory = "false";
		}
		/* End of change */
	}catch(e)
	{
	}
	}
/* Code Changes Call Recon of Call 205562 Tracker 250136 Start */
PhoneEmailID = '<xsl:value-of select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AccountBO.PhoneEmail.PhoneEmailID']"/>';
/* Code Changes Call Recon of Call 205562 Tracker 250136 Start */
 function enableClose(){
			try{
				document.getElementsByName("Close")[0].disabled = false;
			}catch(e){
			}
    }

function savePhoneEmailDet(){

/*Start of fix for Ticket 284526*/
// checkForExistingPhoneTypeChk();
/*end of fix for Ticket 284526*/

/* Start of fix for Ticket id: 337801 */
try{
	    retStat = ValidateFormContents(document.frm2,false,false,'',true);
	    if(retStat == "false") {
	    return "interactive";
    }
/* End of fix for Ticket id: 337801 */


if('<xsl:value-of select="$phoneOrEmail"/>' == 'PHONE' || '<xsl:value-of select="$phoneOrEmail"/>'=="")
    {
		/*Start of fix for Ticket 285470*/
		/* Start of fix for Ticket id: 337801 */
		retStat = checkForExistingPhoneTypeChk();
		/*End of fix for Ticket 285470*/
		if(retStat == "false")
		{
			top.window.focus();
		    return;
		}
		/* End of fix for Ticket id: 337801 */
   var Extn = document.frm2.elements("AccountBO.PhoneEmail.WorkExtension").value;

   selectedPhoneType = document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType")[0].value;
//changes for call id: 235865 Ticket: 454943 tracker: 275549  start

if(selectedPhoneType=='CELLPH'){

      var areaCode1 = document.getElementsByName('AccountBO.PhoneEmail.PhoneNo.areacode')[0].value;
      var countryCode1 = document.getElementsByName('AccountBO.PhoneEmail.PhoneNo.cntrycode')[0].value;
      var localcode1=	document.getElementsByName('AccountBO.PhoneEmail.PhoneNo.localCode')[0].value;
       
      var length =areaCode1.length+countryCode1.length+localcode1.length;
         
         if(length > 17){
	        showUserMessage('MSGJ0070','');
	  	return "interactive";
	}

   }
//changes for call id: 235865 Ticket: 454943 tracker: 275549  end
/*Tracker 170380 -START*/
 if ((selectedPhoneType!='CELLPH') || (selectedPhoneType!='PAGER'))
   {
	document.getElementsByName("AccountBO.PhoneEmail.PhoneNo.areacode")[0].IsMandatory = "false";
   }
/*Tracker 170380 -END*/

/* Tracker ID- 150017 Start of changes for Ticket No-249280 Defect Fix
 * Mmoved the code commenting to correct location from outside the if loop to inside,
 * and removed code commenting for Extension text field.
 */
/*Start of Fix for the ticket 243350
 *Commenting the below code

   if ((selectedPhoneType!='CELLPH') &amp;&amp; (selectedPhoneType!='PAGER'))
   {

      var areaCode = document.getElementsByName('AccountBO.PhoneEmail.PhoneNo.areacode')[0].value;
      var countryCode = document.getElementsByName('AccountBO.PhoneEmail.PhoneNo.cntrycode')[0].value;
	  var localCode = document.getElementsByName('AccountBO.PhoneEmail.PhoneNo.localCode')[0].value;
      if(countryCode ==""){
      	showUserMessage('MSGX50076','');
	return "interactive";
	}
	  //Changes for Call Id:344119 Start		
	  if(countryCode.indexOf("+")!= -1 || countryCode.indexOf("-")!= -1 ){
		  showUserMessage('MSGX50076','');
		  document.getElementsByName('AccountBO.PhoneEmail.PhoneNo.cntrycode')[0].value="";
		  return "interactive";
	  }
      //Changes for Call Id:344119 End

       changes for 355347 start
      if(areaCode ==""){
	 showUserMessage('MSGX50077','');
	 return "interactive";
	 }
	  //Changes for Call Id:344119 Start		
	  if(areaCode.indexOf("+")!= -1 || areaCode.indexOf("-")!= -1 ){
		  showUserMessage('MSGX50077','');
		  document.getElementsByName('AccountBO.PhoneEmail.PhoneNo.areacode')[0].value="";
		  return "interactive";
	  }
      //Changes for Call Id:344119 End

	  if(localCode.indexOf("+")!= -1 || localCode.indexOf("-")!= -1 ){
		  showUserMessage('MSGX50078','');
		  document.getElementsByName('AccountBO.PhoneEmail.PhoneNo.localCode')[0].value="";
		  return "interactive";
	  }

 changes for 355347 end
   }
*/
// Tracker ID- 150017 End of changes for Ticket No- 249280 Defect Fix
   	if(isNaN(Extn)) {
	  showUserMessage('MSGX50079','');
	  return "interactive";
         }
    /*Start of fix for Ticket 285470*/
    /* Start of fix for Ticket id: 337801 */
    }else{
    
	/*Start of fix for tracker id 253936*/
	
      // retStat=checkForExistingEmailType1();
      
        /*End of fix for tracker id 253936*/

      /*End of fix for Ticket 285470*/

	  if(retStat == "false")
	    {
	      top.window.focus();
	      return;
		}

	/* End of fix for Ticket id: 337801 */
	}

/*End  of Fix for the ticket 243350 */

PhoneEmailDetails = new Array();

    if('<xsl:value-of select="$phoneOrEmail"/>' == 'PHONE' || '<xsl:value-of select="$phoneOrEmail"/>'=="")
    {
	    PhoneEmailDetails[0] = trim(''+document.getElementsByName('AccountBO.PhoneEmail.PhoneOrEmail')[0].value);
		//Fix for call id: 440761
	    PhoneEmailDetails[1] = trim(''+document.getElementsByName('AccountBO.PhoneEmail.PhoneNo')[0].value).replace(/\s+/g, '');
            PhoneEmailDetails[2] = trim(''+document.getElementsByName('AccountBO.PhoneEmail.PhoneNo.cntrycode')[0].value);
	    PhoneEmailDetails[3] = trim(''+document.getElementsByName('AccountBO.PhoneEmail.PhoneNo.areacode')[0].value);
	    PhoneEmailDetails[4] = trim(''+document.getElementsByName('AccountBO.PhoneEmail.PhoneNo.localCode')[0].value);
            PhoneEmailDetails[5] = trim(''+document.getElementsByName('AccountBO.PhoneEmail.PhoneEmailType')[0].value);
 	    PhoneEmailDetails[6] = trim(''+PhoneEmailID);
	    PhoneEmailDetails[7] = trim(''+document.getElementsByName('AccountBO.PhoneEmail.WorkExtension')[0].value);
	    if (top.window.opener.addPhoneDetails(PhoneEmailDetails) == 'true') {
	                             // Change for TicketID: 469253 Tracker ID:285727 Start
	                               //  changes for 247853 -- start
    					if(document.frm2.isMCEditedGeneralPhoneEmail.value=="Y"){
    					//  changes for 247853 -- end
    				     //  Change for TicketID: 469253 Tracker ID:285727 End	
    						top.window.opener.setMCAttModifyFlag();
    					}
    					top.window.close();
    					top.window.opener.focus();
	    }
	    else{
	     top.window.focus();
	    }
    }
    else if('<xsl:value-of select="$phoneOrEmail"/>' == 'EMAIL')
    {
	chkStat = validate_emailField(document.getElementsByName('AccountBO.PhoneEmail.Email')[0]);
	if(chkStat=='false'){
		return;
	}
	PhoneEmailDetails[0] = trim(''+document.getElementsByName('AccountBO.PhoneEmail.PhoneOrEmail')[0].value);
        PhoneEmailDetails[1] = trim(''+document.getElementsByName('AccountBO.PhoneEmail.Email')[0].value);
//        PhoneEmailDetails[2] = trim(''+document.getElementsByName('AccountBO.PhoneEmail.EmailPalm')[0].value);
        PhoneEmailDetails[2] = trim(''+document.getElementsByName('AccountBO.PhoneEmail.PhoneEmailType1')[0].value);
        PhoneEmailDetails[3] = trim(''+PhoneEmailID);
	if (top.window.opener.addEmailDetails(PhoneEmailDetails) == 'true') {
	                                 //  Change for TicketID: 469253 Tracker ID:285727 Start 
	                                //  changes for 247853 -- start
    					if(document.frm2.isMCEditedGeneralPhoneEmail.value=="Y"){
    					//  changes for 247853 -- end
					// Change for TicketID: 469253 Tracker ID:285727 End	
						top.window.opener.setMCAttModifyFlag();
    					}
    					top.window.close();
    					top.window.opener.focus();
        }
	else{
	     top.window.focus();
	}
    }
} catch(e) {
           top.window.close();
        }
 }//end of function savePhoneEmailDet

    function cancel(){
    	if ( !this.parent.parent.showConfirmMessage(MSG022)) {
    		return;
	}
        try {
            ProdLookupWindow = null;
            window.close();
            window.opener.focus();
        }catch(e) {
        }
    }

    function enableClose(){
		try{
			document.getElementsByName("Close")[0].disabled = false;
		}catch(e){
		}
    }

   /* changes for ticket 220757 and tracker 132940 start*/
   function checkForExistingPhoneTypeChk()
   {
  /* changes for ticket 220757 and tracker 132940 ends*/
	selectedPhoneType = document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType")[0].value;
	//changes for 258717 starts
	  if ((selectedPhoneType.indexOf("WORKPH1")!=-1) || (selectedPhoneType.indexOf("WORKPH2")!=-1))
	{
	//changes for 258717 ends
		document.getElementsByName("mandStarAccountBO.PhoneEmail.WorkExtension")[0].style.visibility="visible";
	        document.getElementsByName("AccountBO.PhoneEmail.WorkExtension")[0].IsMandatory = "true";
	        document.getElementsByName("AccountBO.PhoneEmail.WorkExtension")[0].disabled = false;//Fix for #361783
	}
	else
	{
		document.getElementsByName("mandStarAccountBO.PhoneEmail.WorkExtension")[0].style.visibility="hidden";
		document.getElementsByName("AccountBO.PhoneEmail.WorkExtension")[0].IsMandatory = "false";
		document.getElementsByName("AccountBO.PhoneEmail.WorkExtension")[0].disabled = true;//Fix for #361783
	}
	var flag = top.window.opener.checkForExistingPhoneType(selectedPhoneType);
	/* Changes for Tracker 174169 starts */
	/* Changes for Tracker 177082 starts */
	/* Changes for tracker id :251272  / ticket id : 413803 - Start*/
	/* Fix for Ticket Id: 434061 starts */
	if(!(('<xsl:value-of select="$isEdit"/>' == 'Yes')||('<xsl:value-of select="$isCopy"/>' == 'Y'))){
	/* Fix for Ticket Id: 434061 ends */
	/* Changes for tracker id :251272  / ticket id : 413803 - End*/
	/* Changes for Tracker 177082 ends */
	if(flag != null &amp;&amp; flag == 'false')	//changes for ticket id: 440391
	{
		showMessage(MSGJ50263);
		document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType")[0].value = "";

 		/*Start of fix for Ticket id : 337801*/
			return 'false';
		/*End of fix for Ticket id : 337801 */
	}
	}
	/* Changes for Tracker 174169 ends */
   }

   function checkForExistingEmailType1()
   {
	selectedEmailType = document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType1")[0].value;
	if(selectedEmailType != "")
	{
		/* Changes for Tracker 174169 starts */

		/* Changes for Tracker 177082 starts */
		/* Changes for tracker id :251272  / ticket id : 413803*/
		if((!('<xsl:value-of select="$isEdit"/>' == 'Yes'))||(!('<xsl:value-of select="$isCopy"/>' == 'Y'))){
		/* Changes for Tracker 177082 ends */
		/* Changes for tracker id :251272  / ticket id : 413803 - End*/
		var flag = top.window.opener.checkForExistingEmailType(selectedEmailType);
		if(flag != null &amp;&amp; flag == 'false')	//changes for ticket id:440391
		{
			showMessage(MSGJ50264);
			document.getElementsByName("AccountBO.PhoneEmail.PhoneEmailType1")[0].value = "";

			/*Start of fix for Ticket id : 337801*/
				return 'false';
			/*End of fix for Ticket id : 337801 */
		}
		}
		/* Changes for Tracker 174169 ends */
	}
   }
   function changePageContent()
   {
/*	phoneOrEmail = "";
	if(document.getElementsByName("AccountBO.PhoneEmail.PhoneOrEmail")[0].value == "PHONE")
	{
		phoneOrEmail = "P";
	}
	else
	{
		phoneOrEmail = "E";
	}*/
	document.frm2.PhoneOrEmail.value = document.getElementsByName("AccountBO.PhoneEmail.PhoneOrEmail")[0].value;
	document.frm2.action = "../servlet/com.infy.cis.ui.cif.PhoneEmailForm_Det?boName=AccountBO";
        document.frm2.submit();

   }
 function setMCAttModifyFlag(){
  // Change for TicketID: 469253 Tracker ID:285727 Start 
                //  changes for 247853 -- start
		document.frm2.isMCEditedGeneralPhoneEmail.value="Y";
		//  changes for 247853 -- end
		 // Change for TicketID: 469253 Tracker ID:285727 End
	}
   function validate_emailField(mail){
	var email=mail;
	if(email.value!= ""){
	    var retVal = validate_email(email, true, false);
	    if(!retVal) {
	           showMessage(MSG081);
		   return 'false';
	       }
	 }
	 return 'true';
}
//CIF PhoneEmail Changes: End
    </script>
    </head>
    <body class="popup">
    <xsl:choose>
		<xsl:when test="normalize-space($readMode)='Y'">
			<xsl:attribute name="onload">showInReadOnlyMode('<xsl:value-of select="$readMode"/>');enableClose();load();</xsl:attribute>
		</xsl:when>
		<xsl:otherwise>
		<!-- tracker 213863 changes for ticket 349688 -->
			<!--  changes for ticket 337631 -->
			<xsl:attribute name="onload">load();</xsl:attribute>
		</xsl:otherwise>
    </xsl:choose>
       <table class="tableborder" width="100%" cellpadding="0" cellspacing="0" border="0">
                          <tr>
                          <td>
              		<table border="0" cellspacing="0" cellpadding="0" class="innertable" width="100%" vspace="0" hspace="0">
              			<tr>

              			<xsl:apply-templates select="SRM"/>
                          		</tr>
                          	</table>
                          </td>

                          </tr>
        </table>
        <BR/>
        <left>
		<xsl:choose>
			<xsl:when test="normalize-space($readMode)='Y'">
				<xsl:call-template name="user_button">
					<xsl:with-param name="button_name">Close</xsl:with-param>
					<xsl:with-param name="button_fnc">cancel()</xsl:with-param>
				</xsl:call-template>
	        </xsl:when>
	        <xsl:otherwise>
	        	<td>
		        <xsl:call-template name="user_button">
		        <!-- Tracker-156777   :Changes Begin -->
		            <xsl:with-param name="button_name"><xsl:value-of select="$configLabels[@name='SAVE']/@configLabel"/></xsl:with-param>
		            <!-- Tracker-156777   :Changes End -->
		            <xsl:with-param name="button_fnc">savePhoneEmailDet()</xsl:with-param>
		        </xsl:call-template> </td>&#160;
		        <td>
		        <xsl:call-template name="user_button">
<!-- TRACKER ID 108387 BEGIN CHANGES  FOR CLOSE BUTTON -->
		            <xsl:with-param name="button_name">Close<xsl:value-of select="$configLabels[@name='CLOSE']/@configLabel"/></xsl:with-param>
		            <xsl:with-param name="button_fnc">cancel()</xsl:with-param>
<!-- TRACKER ID 108387 END CHANGES FOR CLOSE BUTTON -->
		        </xsl:call-template>
		        </td>
			</xsl:otherwise>
    	</xsl:choose>
        </left>
    </body>
    </html>
    </xsl:template>
                       <!-- cif -->

		       <xsl:template name="AccountBO.PhoneEmail.PhoneOrEmail">
		                   <xsl:call-template name="mdrpdown">
		                       <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.PhoneEmail.PhoneOrEmail']"/>
		                       <xsl:with-param name="selectname">AccountBO.PhoneEmail.PhoneOrEmail</xsl:with-param>
		                       <xsl:with-param name="selectdisp">AccountBO.PhoneEmail.PhoneOrEmail</xsl:with-param>
		                       <xsl:with-param name="search_type">value</xsl:with-param>
       				       <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		                       <xsl:with-param name="onchangefn">changePageContent()</xsl:with-param>
		                       <xsl:with-param name="dispNone">false</xsl:with-param>
					<!-- CIF Changes for Caching Views : Start -->
			         	<xsl:with-param name="presdata" select="$PresData"/>
					<!-- CIF Changes for Caching Views : End -->
		                   </xsl:call-template>
		               </xsl:template>




<!-- 		       <xsl:template name="AccountBO.PhoneEmail.PhoneNoCountryCode">
		                   <xsl:call-template name="label">
		                       <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.PhoneEmail.PhoneNoCountryCode']"/>
		                       <xsl:with-param name="ele_name">AccountBO.PhoneEmail.PhoneNoCountryCode</xsl:with-param>
		                       <xsl:with-param name="ele_val">AccountBO.PhoneEmail.PhoneNoCountryCode</xsl:with-param>
				       <xsl:with-param name="showphonelabels">true</xsl:with-param>
		                       <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		                   </xsl:call-template>
		               </xsl:template>

		               <xsl:template name="AccountBO.PhoneEmail.PhoneNoCityCode">
		       	            <xsl:call-template name="label">
		       	                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.PhoneEmail.PhoneNoCityCode']"/>
		       	                <xsl:with-param name="ele_name">AccountBO.PhoneEmail.PhoneNoCityCode</xsl:with-param>
		       	                <xsl:with-param name="ele_val">AccountBO.PhoneEmail.PhoneNoCityCode</xsl:with-param>
				        <xsl:with-param name="showphonelabels">false</xsl:with-param>
		       	                <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		       	            </xsl:call-template>
		               </xsl:template>
 -->

		               <xsl:template name="AccountBO.PhoneEmail.PhoneNo">
		       		            <xsl:call-template name="label">
		       		                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.PhoneEmail.PhoneNo']"/>
		       		                <xsl:with-param name="ele_name">AccountBO.PhoneEmail.PhoneNo</xsl:with-param>
		       		                <xsl:with-param name="ele_val">AccountBO.PhoneEmail.PhoneNo</xsl:with-param>
					        <xsl:with-param name="showphonelabels">false</xsl:with-param>
		       		                <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		       		            </xsl:call-template>
		               </xsl:template>

		               <xsl:template name="AccountBO.PhoneEmail.PhoneEmailType">
     			            <xsl:call-template name="mdrpdown">
	       			                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.PhoneEmail.PhoneEmailType']"/>
	       			                <xsl:with-param name="selectname">AccountBO.PhoneEmail.PhoneEmailType</xsl:with-param>
	       			                <xsl:with-param name="selectdisp">AccountBO.PhoneEmail.PhoneEmailType</xsl:with-param>
			                        <xsl:with-param name="search_type">value</xsl:with-param>
	       			                <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
	       			                <!--changes for ticket 220757 and tracker 132940 start-->
			                        <xsl:with-param name="onchangefn">populateLocationCode('Customer');checkForExistingPhoneTypeChk();</xsl:with-param>
			                        <!--changes for ticket 220757 and tracker 132940 ends-->
				         	<xsl:with-param name="presdata" select="$PresData"/>
       			            </xsl:call-template>
		               </xsl:template>

				<xsl:template name="AccountBO.PhoneEmail.Email">
     			            <xsl:call-template name="label">
	       			                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.PhoneEmail.Email']"/>
	       			                <xsl:with-param name="ele_name">AccountBO.PhoneEmail.Email</xsl:with-param>
	       			                <xsl:with-param name="ele_val">AccountBO.PhoneEmail.Email</xsl:with-param>
					        <xsl:with-param name="showphonelabels">false</xsl:with-param>
					        <xsl:with-param name="max_length">50</xsl:with-param>
						<xsl:with-param name="isPhoneTemplateFlag">false</xsl:with-param>
	       			                <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
	       			                <xsl:with-param name="fn_onBlur">validateEmail(document.getElementsByName('AccountBO.PhoneEmail.Email')[0])</xsl:with-param>
       			            </xsl:call-template>
		               </xsl:template>

			       <!-- <xsl:template name="AccountBO.PhoneEmail.EmailPalm">
     			            <xsl:call-template name="label">
	       			                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.PhoneEmail.EmailPalm']"/>
	       			                <xsl:with-param name="ele_name">AccountBO.PhoneEmail.EmailPalm</xsl:with-param>
	       			                <xsl:with-param name="ele_val">AccountBO.PhoneEmail.EmailPalm</xsl:with-param>
						<xsl:with-param name="isPhoneTemplateFlag">false</xsl:with-param>
	       			                <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
       			            </xsl:call-template>
		               </xsl:template> -->

			       <xsl:template name="AccountBO.PhoneEmail.PhoneEmailType1">
     			            <xsl:call-template name="mdrpdown">
	       			                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.PhoneEmail.PhoneEmailType']"/>
	       			                <xsl:with-param name="selectname">AccountBO.PhoneEmail.PhoneEmailType1</xsl:with-param>
	       			                <xsl:with-param name="selectdisp">AccountBO.PhoneEmail.PhoneEmailType1</xsl:with-param>
			                        <xsl:with-param name="search_type">value</xsl:with-param>
			                        <xsl:with-param name="onchangefn">checkForExistingEmailType1()</xsl:with-param>
	       			                <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
				         	<xsl:with-param name="presdata" select="$PresData"/>
       			            </xsl:call-template>
		               </xsl:template>

			       <xsl:template name="AccountBO.PhoneEmail.WorkExtension">
     			            <xsl:call-template name="label">
	       			                <xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.PhoneEmail.WorkExtension']"/>
	       			                <xsl:with-param name="ele_name">AccountBO.PhoneEmail.WorkExtension</xsl:with-param>
	       			                <xsl:with-param name="ele_val">AccountBO.PhoneEmail.WorkExtension</xsl:with-param>
						<xsl:with-param name="isPhoneTemplateFlag">false</xsl:with-param>
						<xsl:with-param name="starshow">true</xsl:with-param>
	       					<xsl:with-param name="mcols">10</xsl:with-param>
	       			                <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
       			            </xsl:call-template>
		               </xsl:template>


    <xsl:template match="*" mode="mode1">
        <xsl:call-template name="Begin"/>
        <form name="frm2"  method="post" action="">
        	<input type="hidden" name="apprFlag" value="{$apprFlag}"/>
		<input type="hidden" name="PhoneOrEmail" value=""/>
		<input type="hidden" name="isMCEditedGeneralPhoneEmail" value="N"/>



			<!-- Tracker Id 92380 -->
			<td align="left">
			    <xsl:call-template name="Begin"/>
				<xsl:call-template name="AccountBO.PhoneEmail.PhoneOrEmail"/>
				<xsl:choose>
				<xsl:when test="$phoneOrEmail='EMAIL'">
					<xsl:call-template name="AccountBO.PhoneEmail.PhoneEmailType1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="AccountBO.PhoneEmail.PhoneEmailType"/>
				</xsl:otherwise>
			    </xsl:choose>
			    <xsl:call-template name="End"/>

			    <xsl:call-template name="Begin"/>
			    <xsl:choose>
				<xsl:when test="$phoneOrEmail='EMAIL'">
					<xsl:call-template name="Begin"/>
					    <xsl:call-template name="AccountBO.PhoneEmail.Email"/>
					<xsl:call-template name="End"/>
				</xsl:when>
				<xsl:otherwise>

					<xsl:call-template name="Begin"/>
					    <xsl:call-template name="AccountBO.PhoneEmail.PhoneNo"/>
					    <xsl:call-template name="AccountBO.PhoneEmail.WorkExtension"/>


					<xsl:call-template name="End"/>

				</xsl:otherwise>
			    </xsl:choose>
				 <xsl:call-template name="Begin"/>
							    <xsl:call-template name="addemptycell"/>
							    <xsl:call-template name="addemptycell"/>
			    <xsl:call-template name="End"/>

			 </td>


		            <!-- <xsl:call-template name="Begin"/>
			    <xsl:call-template name="AccountBO.PhoneEmail.PhoneNoCountryCode"/>
			    <xsl:call-template name="AccountBO.PhoneEmail.PhoneNoCityCode"/>
			    <xsl:call-template name="End"/>


			    <xsl:call-template name="Begin"/>
			    <xsl:call-template name="AccountBO.PhoneEmail.PhoneNo"/>
			    <xsl:call-template name="AccountBO.PhoneEmail.PhoneEmailType"/>
		            <xsl:call-template name="End"/> -->

        </form>
        <xsl:call-template name="End"/>
        </xsl:template>
        <xsl:template match="SRM">
            <xsl:for-each select=".">
                <xsl:call-template name="startTable"/>
                    <table bgcolor='FFFFFF' border="0" cellspacing="0" cellpadding="2" width="100%" vspace="0" hspace="0">
                        <tr>
                            <xsl:call-template name="apply">
                                <xsl:with-param name="apply_head">
                                <b><xsl:value-of select="$configLabels[@name='Header']/@configLabel"/></b>
                                </xsl:with-param>
                            </xsl:call-template>
                        </tr>
                    </table>
                    <table bgcolor='FFFFFF' width="100%" border="0" cellspacing="0" cellpadding="2">
                        <xsl:apply-templates select="." mode="mode1"/>
                    </table>
                <xsl:call-template name="endTable"/>
            </xsl:for-each>
        </xsl:template>
    </xsl:stylesheet>















