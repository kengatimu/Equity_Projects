<?xml version="1.0"?>
    <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"/>
    <xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"/>
    <xsl:import href="../Renderer/common/display/getJVMProperties.xsl"/>
    <xsl:import href="../Renderer/common/display/SRMListTemplate.xsl"/>
    <xsl:param name="locale"/>
 
<!-- QED Changes: START -->
    <xsl:param name="PhEmailFileName"/>
    <xsl:variable name="file1" select="$PhEmailFileName"/>
    <xsl:variable name="configFile_1" select="document(concat($file1,''))"/>
    <xsl:variable name="configLabels" select="$configFile_1/SRMBO/*"/>
<!-- QED Changes: END -->

    <xsl:variable name="readMode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsReadOnly']"/>
    <xsl:variable name="allfields" select="//SRMData//Z"/>
    <xsl:param name = "boName"/>
    <xsl:variable name="boDet" select="/SRM/SRMData[@SRMDataSpace='Main']/SRMComposite [@n=$boName]/Z"/>
    <xsl:variable name="accountID" select="$boDet[@n=concat($boName,'.accountID')]"/>
    <xsl:variable name="entityURL" select="//SRMData//Z[@n=concat($boName,'.url_')]"></xsl:variable>
    <xsl:variable name="isNRE" select="//SRMData//Z[@n=concat($boName,'.CustomerNREFlg')]"></xsl:variable>
    <xsl:variable name="apprFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='apprFlag']"></xsl:variable>
    <xsl:variable name="entityID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='entityID']"></xsl:variable>
     <xsl:variable name="preferredPhone" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='preferredPhone']"></xsl:variable>	
    <xsl:variable name="preferredEmail" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='preferredEmail']"></xsl:variable>	
	<!--Field based maker check changes-->
	<xsl:variable name="getRole" select="/SRM/SRMData[@SRMDataSpace='RoleCode']//Z"/>
   	<xsl:variable name="getMCRequired" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='MCRequired']"></xsl:variable>
   	<xsl:variable name="mcJNDIFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='mcJNDIFlag']"></xsl:variable>
   	<xsl:variable name="isMCEdited" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='isMCEdited']"></xsl:variable>
   	<!-- changes for ticket 305918 start -->
   	<xsl:variable name="BlackListed" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='BlackListed']"></xsl:variable>
        <xsl:variable name="Suspended" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Suspended']"></xsl:variable>
        <xsl:variable name="Negated" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Negated']"></xsl:variable>
    	<xsl:variable name="chkBSN" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='chkBSN']"></xsl:variable>
	<!--Field based maker check changes-->
	<!-- changes for ticket 305918 end -->
    <xsl:param name="viewname"/>
    <xsl:variable name="PresFileName">../servlet/com.infy.cis.ui.cif.CIF_DetPresCacheServlet?ViewName=<xsl:value-of select="$viewname"/>&amp;Locale=<xsl:value-of select="$locale"/></xsl:variable>
    <xsl:variable name="PresFile" select="document(concat($PresFileName,''))"/>
    <xsl:variable name="PresData" select="$PresFile/SRM/SRMPresentation"/> 

    <xsl:template match="/">
    <html>
        <title><xsl:value-of select="//SRMPresentation/SRMSystem[@n='Strings']/SRMString[@n='Title']/@value"/></title>
    <head>
<!--Performance-->
    <!--<script type="text/javascript" src="../common/js/ClientResourceBundle_{$locale}.js" language="javascript"></script>-->
<!--Performance-->
    <script>
    var locale = '<xsl:value-of select="$locale"/>';
    </script>
    <LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
    <LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/MultiTabs_{$locale}.css"/>
    <link rel="stylesheet" type="text/css" href="../Branding/css/common/SRMListTemplate_{$locale}.css"/>
<!--Performance-->
    <!--<script type="text/javascript" src="../common/js/ClientResourceBundle_{$locale}.js" language="javascript"></script>
    <script type="text/javascript" src="../common/html/utils.js" language="javascript"></script>
    <script type="text/javascript" src="../common/js/MLValidate.js" language="javascript"></script>
    <script type="text/javascript" src="../common/html/validate.js" language="javascript"></script>-->
<!--Performance-->
    <script type="text/javascript" src="../common/js/SRMTableRowColor.js" language="javascript"></script>
<!--Performance-->
    <!--<script type="text/javascript" src="../common/html/validateL2.js" language="javascript"></script>-->
<!--Performance-->
    <script type="text/javascript" src="../cif/js/CIFPhoneEmail.js" language="javascript"></script>
    <script type="text/javascript" src="../cif/js/Message_cif_{$locale}.js" language="javascript"></script>
    <script type="text/javascript" src="../cif/js/CheckBSNFlags.js" language="javascript"></script>
    <script type="text/javascript" src="../Customization/cif/js/EquityProcessCustom.js" language="javascript"></script>
    <script type="text/javascript" language="javascript">
	var PhoneEmailID = "";
	var escChars = new Array(',');
	var isEntityNRE = '<xsl:value-of select="$isNRE"/>';
	var boName = '<xsl:value-of select="$boName"/>';
	var apprFlag = '<xsl:value-of select="$apprFlag"/>';
	/*changes for ticket 305918 start*/
	var BlackListed = '<xsl:value-of select="$BlackListed"/>';
	var Suspended = '<xsl:value-of select="$Suspended"/>';
	var chkBSNFlg = '<xsl:value-of select="$chkBSN"/>';
	var Negated =  '<xsl:value-of select="$Negated"/>';
	/* changes for ticket 305918 end */
	function load()
	{
		try{
		
			var obj = parent.parent.parent.parent.frames(3);
			obj.enableButton_Ub(); 		
		
		     customLoad();
		}catch(e)
		{ }
		try
		{
		/* Changes for call id 425161 Starts */
		 document.getElementsByName("PhoneEmail.preferredPhone")[0].value = '<xsl:value-of select = "$preferredPhone"/>';
		 document.getElementsByName("PhoneEmail.preferredEmail")[0].value = '<xsl:value-of select = "$preferredEmail"/>';
		/* Changes for call id 425161 Ends */
//xml encoding changes --start		
			if(boName=='AccountBO'){

	  	  for (i=0; i &lt; document.all.PhoneEmailRecordSet.rows.length; i++) {
			var phoneEmailId ='';
				phoneEmailId = document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountBO.PhoneEmail.PhoneEmailID");
			if ((phoneEmailId != null) &amp;&amp; (phoneEmailId != 'undefined') &amp;&amp; phoneEmailId != "") {

					email  = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountBO.PhoneEmail.Email"));
					phoneNo = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountBO.PhoneEmail.PhoneNo"));
					phoneOrEmail = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountBO.PhoneEmail.PhoneOrEmail"));
					extension = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountBO.PhoneEmail.WorkExtension"));
				if(phoneOrEmail == "PHONE")
				{
						phoneEmailType = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountBO.PhoneEmail.PhoneEmailType"));
					phoneEmail_URL[phoneEmail_URL.length] = phoneNo + phoneEmailType;
						document.all.PhoneEmailRecordSet.rows(i).setAttribute("AccountBO.PhoneEmail.url_", phoneNo + phoneEmailType);
						document.all.PhoneEmailRecordSet.rows(i).setAttribute("AccountBO.PhoneEmail.PhoneEmailType",phoneEmailType);
						/* Changes for Ticket 717398 Starts */
						/* Changes for call id 425161 Starts */
						<![CDATA[
						var temp = document.getElementsByName("PhoneEmail.preferredPhone")[0].value;
						document.getElementsByName("PhoneEmail.preferredPhone")[0].value = phoneEmailType;
						var localetext = document.getElementsByName("PhoneEmail.preferredPhone")[0].options[document.getElementsByName("PhoneEmail.preferredPhone")[0].selectedIndex].text;
						document.all.PhoneEmailRecordSet.rows(i).childNodes(1).innerHTML="<font class='fntColData'>"+localetext+"</font>";
						document.getElementsByName("PhoneEmail.preferredPhone")[0].value=temp;
						]]>
						/* Changes for call id 425161 Ends */
						/* Changes for Ticket 717398 Ends */
				}
				else
				{
						phoneEmailType = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountBO.PhoneEmail.PhoneEmailType"));
					phoneEmail_URL[phoneEmail_URL.length] = email + phoneEmailType;
						document.all.PhoneEmailRecordSet.rows(i).setAttribute("AccountBO.PhoneEmail.url_", email + phoneEmailType);
						document.all.PhoneEmailRecordSet.rows(i).setAttribute("AccountBO.PhoneEmail.PhoneEmailType1",phoneEmailType);
						/* Changes for Ticket 717398 Starts */
						/* Changes for call id 425161 Starts */
						<![CDATA[
						var temp = document.getElementsByName("PhoneEmail.preferredEmail")[0].value;
						document.getElementsByName("PhoneEmail.preferredEmail")[0].value = phoneEmailType;
						var localetext = document.getElementsByName("PhoneEmail.preferredEmail")[0].options[document.getElementsByName("PhoneEmail.preferredEmail")[0].selectedIndex].text;
						document.all.PhoneEmailRecordSet.rows(i).childNodes(1).innerHTML="<font class='fntColData'>"+localetext+"</font>";
						document.getElementsByName("PhoneEmail.preferredEmail")[0].value=temp;
						]]>
						/* Changes for call id 425161 Ends */
						/* Changes for Ticket 717398 Ends */

					}
					phoneNoCountryCode = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountBO.PhoneEmail.PhoneNoCountryCode"));
					phoneNoCityCode = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountBO.PhoneEmail.PhoneNoCityCode"));
					phoneNoLocalCode = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountBO.PhoneEmail.PhoneNoLocalCode"));
					extension = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("AccountBO.PhoneEmail.WorkExtension"));
				phoneEmailId = trim(phoneEmailId);
				ad_PhoneOrEmail[ad_PhoneOrEmail.length] = phoneOrEmail
				ad_PhoneEmailType[ad_PhoneEmailType.length] = phoneEmailType	
				ad_PhoneEmailID[ad_PhoneEmailID.length] = phoneEmailId
				/* Ticket 273733 changes start*/
				//ad_extension[ad_extension.length] = extension;
				/* Ticket 273733 changes end*/
				ad_Email[ad_Email.length] = email;                  
				ad_PhoneNo[ad_PhoneNo.length] = phoneNo;            
				ad_PhoneNoCountryCode[ad_PhoneNoCountryCode.length] = phoneNoCountryCode;
				ad_PhoneNoCityCode[ad_PhoneNoCityCode.length] = phoneNoCityCode;
				ad_PhoneNoLocalCode[ad_PhoneNoLocalCode.length] = phoneNoLocalCode;
				ad_extension[ad_extension.length] = extension;
				phoneEmail_Status[phoneEmail_Status.length] = "Add";

			}
		  }//end  of for

			}else if(boName=='ContactBO'){
			  for (i=0; i &lt; document.all.PhoneEmailRecordSet.rows.length; i++) {
				var phoneEmailId ='';
				phoneEmailId = document.all.PhoneEmailRecordSet.rows(i).getAttribute("ContactBO.PhoneEmail.PhoneEmailID");
				if ((phoneEmailId != null) &amp;&amp; (phoneEmailId != 'undefined') &amp;&amp; phoneEmailId != "") {

					email  = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("ContactBO.PhoneEmail.Email"));
					phoneNo = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("ContactBO.PhoneEmail.PhoneNo"));
					phoneOrEmail = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("ContactBO.PhoneEmail.PhoneOrEmail"));
					extension = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("ContactBO.PhoneEmail.WorkExtension"));
					if(phoneOrEmail == "PHONE")
					{
						phoneEmailType = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("ContactBO.PhoneEmail.PhoneEmailType"));
						phoneEmail_URL[phoneEmail_URL.length] = phoneNo + phoneEmailType;
						document.all.PhoneEmailRecordSet.rows(i).setAttribute("ContactBO.PhoneEmail.url_", phoneNo + phoneEmailType);
						document.all.PhoneEmailRecordSet.rows(i).setAttribute("ContactBO.PhoneEmail.PhoneEmailType",phoneEmailType);
						/* Changes for Ticket 717398 Starts */
						/* Changes for call id 425161 Starts */
						<![CDATA[
						var temp = document.getElementsByName("PhoneEmail.preferredPhone")[0].value;
						document.getElementsByName("PhoneEmail.preferredPhone")[0].value = phoneEmailType;
						var localetext = document.getElementsByName("PhoneEmail.preferredPhone")[0].options[document.getElementsByName("PhoneEmail.preferredPhone")[0].selectedIndex].text;
						document.all.PhoneEmailRecordSet.rows(i).childNodes(1).innerHTML="<font class='fntColData'>"+localetext+"</font>";
						document.getElementsByName("PhoneEmail.preferredPhone")[0].value=temp;						
						]]>
						/* Changes for call id 425161 Ends */
						/* Changes for Ticket 717398 Ends */
					}
					else
					{
						phoneEmailType = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("ContactBO.PhoneEmail.PhoneEmailType"));
						phoneEmail_URL[phoneEmail_URL.length] = email + phoneEmailType;
						document.all.PhoneEmailRecordSet.rows(i).setAttribute("ContactBO.PhoneEmail.url_", email + phoneEmailType);
						document.all.PhoneEmailRecordSet.rows(i).setAttribute("ContactBO.PhoneEmail.PhoneEmailType1",phoneEmailType);
						/* Changes for Ticket 717398 Starts */
						/* Changes for call id 425161 Starts */
						<![CDATA[
						var temp = document.getElementsByName("PhoneEmail.preferredEmail")[0].value;
						document.getElementsByName("PhoneEmail.preferredEmail")[0].value = phoneEmailType;
						var localetext = document.getElementsByName("PhoneEmail.preferredEmail")[0].options[document.getElementsByName("PhoneEmail.preferredEmail")[0].selectedIndex].text;
						document.all.PhoneEmailRecordSet.rows(i).childNodes(1).innerHTML="<font class='fntColData'>"+localetext+"</font>";
						document.getElementsByName("PhoneEmail.preferredEmail")[0].value=temp;
						]]>
						/* Changes for call id 425161 Ends */
						/* Changes for Ticket 717398 Ends */

					}
					phoneNoCountryCode = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("ContactBO.PhoneEmail.PhoneNoCountryCode"));
					phoneNoCityCode = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("ContactBO.PhoneEmail.PhoneNoCityCode"));
					phoneNoLocalCode = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("ContactBO.PhoneEmail.PhoneNoLocalCode"));
					extension = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("ContactBO.PhoneEmail.WorkExtension"));
					phoneEmailId = trim(phoneEmailId);
					ad_PhoneOrEmail[ad_PhoneOrEmail.length] = phoneOrEmail
					ad_PhoneEmailType[ad_PhoneEmailType.length] = phoneEmailType	
					ad_PhoneEmailID[ad_PhoneEmailID.length] = phoneEmailId
					ad_extension[ad_extension.length] = extension;
					ad_Email[ad_Email.length] = email;                  
					ad_PhoneNo[ad_PhoneNo.length] = phoneNo;            
					ad_PhoneNoCountryCode[ad_PhoneNoCountryCode.length] = phoneNoCountryCode;
					ad_PhoneNoCityCode[ad_PhoneNoCityCode.length] = phoneNoCityCode;
					ad_PhoneNoLocalCode[ad_PhoneNoLocalCode.length] = phoneNoLocalCode;
					ad_extension[ad_extension.length] = extension;
					phoneEmail_Status[phoneEmail_Status.length] = "Add";

				}
			  }//end  of for

			}else if(boName=='SuspectBO'){
			  for (i=0; i &lt; document.all.PhoneEmailRecordSet.rows.length; i++) {
				var phoneEmailId ='';
				phoneEmailId = document.all.PhoneEmailRecordSet.rows(i).getAttribute("SuspectBO.PhoneEmail.PhoneEmailID");
				if ((phoneEmailId != null) &amp;&amp; (phoneEmailId != 'undefined') &amp;&amp; phoneEmailId != "") {

					email  = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("SuspectBO.PhoneEmail.Email"));
					phoneNo = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("SuspectBO.PhoneEmail.PhoneNo"));
					phoneOrEmail = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("SuspectBO.PhoneEmail.PhoneOrEmail"));
					extension = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("SuspectBO.PhoneEmail.WorkExtension"));
					if(phoneOrEmail == "PHONE")
					{
						phoneEmailType = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("SuspectBO.PhoneEmail.PhoneEmailType"));
						phoneEmail_URL[phoneEmail_URL.length] = phoneNo + phoneEmailType;
						document.all.PhoneEmailRecordSet.rows(i).setAttribute("SuspectBO.PhoneEmail.url_", phoneNo + phoneEmailType);
						document.all.PhoneEmailRecordSet.rows(i).setAttribute("SuspectBO.PhoneEmail.PhoneEmailType",phoneEmailType);
						/* Changes for Ticket 717398 Starts */
						/* Changes for call id 425161 Starts */
						<![CDATA[
						var temp = document.getElementsByName("PhoneEmail.preferredPhone")[0].value;
						document.getElementsByName("PhoneEmail.preferredPhone")[0].value = phoneEmailType;
						var localetext = document.getElementsByName("PhoneEmail.preferredPhone")[0].options[document.getElementsByName("PhoneEmail.preferredPhone")[0].selectedIndex].text;
						document.all.PhoneEmailRecordSet.rows(i).childNodes(1).innerHTML="<font class='fntColData'>"+localetext+"</font>";
						document.getElementsByName("PhoneEmail.preferredPhone")[0].value=temp;
						]]>
						/* Changes for call id 425161 Ends */
						/* Changes for Ticket 717398 Ends */
					}
					else
					{
						phoneEmailType = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("SuspectBO.PhoneEmail.PhoneEmailType"));
						phoneEmail_URL[phoneEmail_URL.length] = email + phoneEmailType;
						document.all.PhoneEmailRecordSet.rows(i).setAttribute("SuspectBO.PhoneEmail.url_", email + phoneEmailType);
						document.all.PhoneEmailRecordSet.rows(i).setAttribute("SuspectBO.PhoneEmail.PhoneEmailType1",phoneEmailType);
						/* Changes for Ticket 717398 Starts */
						/* Changes for call id 425161 Starts */
						<![CDATA[
						var temp = document.getElementsByName("PhoneEmail.preferredEmail")[0].value;
						document.getElementsByName("PhoneEmail.preferredEmail")[0].value = phoneEmailType;
						var localetext = document.getElementsByName("PhoneEmail.preferredEmail")[0].options[document.getElementsByName("PhoneEmail.preferredEmail")[0].selectedIndex].text;
						document.all.PhoneEmailRecordSet.rows(i).childNodes(1).innerHTML="<font class='fntColData'>"+localetext+"</font>";
						document.getElementsByName("PhoneEmail.preferredEmail")[0].value=temp;
						]]>
						/* Changes for call id 425161 Ends */
						/* Changes for Ticket 717398 Ends */

					}
					phoneNoCountryCode = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("SuspectBO.PhoneEmail.PhoneNoCountryCode"));
					phoneNoCityCode = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("SuspectBO.PhoneEmail.PhoneNoCityCode"));
					phoneNoLocalCode = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("SuspectBO.PhoneEmail.PhoneNoLocalCode"));
					extension = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("SuspectBO.PhoneEmail.WorkExtension"));
					phoneEmailId = trim(phoneEmailId);
					ad_PhoneOrEmail[ad_PhoneOrEmail.length] = phoneOrEmail
					ad_PhoneEmailType[ad_PhoneEmailType.length] = phoneEmailType	
					ad_PhoneEmailID[ad_PhoneEmailID.length] = phoneEmailId
					ad_extension[ad_extension.length] = extension;
					ad_Email[ad_Email.length] = email;                  
					ad_PhoneNo[ad_PhoneNo.length] = phoneNo;            
					ad_PhoneNoCountryCode[ad_PhoneNoCountryCode.length] = phoneNoCountryCode;
					ad_PhoneNoCityCode[ad_PhoneNoCityCode.length] = phoneNoCityCode;
					ad_PhoneNoLocalCode[ad_PhoneNoLocalCode.length] = phoneNoLocalCode;
					ad_extension[ad_extension.length] = extension;
					phoneEmail_Status[phoneEmail_Status.length] = "Add";

				}
			  }//end  of for

			}else if(boName=='NonCustomerBO'){
			  for (i=0; i &lt; document.all.PhoneEmailRecordSet.rows.length; i++) {
				var phoneEmailId ='';
				phoneEmailId = document.all.PhoneEmailRecordSet.rows(i).getAttribute("NonCustomerBO.PhoneEmail.PhoneEmailID");
				if ((phoneEmailId != null) &amp;&amp; (phoneEmailId != 'undefined') &amp;&amp; phoneEmailId != "") {

					email  = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("NonCustomerBO.PhoneEmail.Email"));
					phoneNo = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("NonCustomerBO.PhoneEmail.PhoneNo"));
					phoneOrEmail = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("NonCustomerBO.PhoneEmail.PhoneOrEmail"));
					extension = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("NonCustomerBO.PhoneEmail.WorkExtension"));
					if(phoneOrEmail == "PHONE")
					{
						phoneEmailType = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("NonCustomerBO.PhoneEmail.PhoneEmailType"));
						phoneEmail_URL[phoneEmail_URL.length] = phoneNo + phoneEmailType;
						document.all.PhoneEmailRecordSet.rows(i).setAttribute("NonCustomerBO.PhoneEmail.url_", phoneNo + phoneEmailType);
						document.all.PhoneEmailRecordSet.rows(i).setAttribute("NonCustomerBO.PhoneEmail.PhoneEmailType",phoneEmailType);
						/* Changes for Ticket 717398 Starts */
						/* Changes for call id 425161 Starts */
						<![CDATA[
						var temp = document.getElementsByName("PhoneEmail.preferredPhone")[0].value;
						document.getElementsByName("PhoneEmail.preferredPhone")[0].value = phoneEmailType;
						var localetext = document.getElementsByName("PhoneEmail.preferredPhone")[0].options[document.getElementsByName("PhoneEmail.preferredPhone")[0].selectedIndex].text;
						document.all.PhoneEmailRecordSet.rows(i).childNodes(1).innerHTML="<font class='fntColData'>"+localetext+"</font>";
						document.getElementsByName("PhoneEmail.preferredPhone")[0].value=temp;
						]]>
						/* Changes for call id 425161 Ends */
						/* Changes for Ticket 717398 Ends */
					}
					else
					{
						phoneEmailType = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("NonCustomerBO.PhoneEmail.PhoneEmailType"));
						phoneEmail_URL[phoneEmail_URL.length] = email + phoneEmailType;
						document.all.PhoneEmailRecordSet.rows(i).setAttribute("NonCustomerBO.PhoneEmail.url_", email + phoneEmailType);
						document.all.PhoneEmailRecordSet.rows(i).setAttribute("NonCustomerBO.PhoneEmail.PhoneEmailType1",phoneEmailType);
						/* Changes for Ticket 717398 Starts */
						/* Changes for call id 425161 Starts */
						<![CDATA[
						var temp = document.getElementsByName("PhoneEmail.preferredEmail")[0].value;
						document.getElementsByName("PhoneEmail.preferredEmail")[0].value = phoneEmailType;
						var localetext = document.getElementsByName("PhoneEmail.preferredEmail")[0].options[document.getElementsByName("PhoneEmail.preferredEmail")[0].selectedIndex].text;
						document.all.PhoneEmailRecordSet.rows(i).childNodes(1).innerHTML="<font class='fntColData'>"+localetext+"</font>";
						document.getElementsByName("PhoneEmail.preferredEmail")[0].value=temp;
						]]>
						/* Changes for call id 425161 Ends */
						/* Changes for Ticket 717398 Ends */

					}
					phoneNoCountryCode = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("NonCustomerBO.PhoneEmail.PhoneNoCountryCode"));
					phoneNoCityCode = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("NonCustomerBO.PhoneEmail.PhoneNoCityCode"));
					phoneNoLocalCode = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("NonCustomerBO.PhoneEmail.PhoneNoLocalCode"));
					extension = trim(document.all.PhoneEmailRecordSet.rows(i).getAttribute("NonCustomerBO.PhoneEmail.WorkExtension"));
					phoneEmailId = trim(phoneEmailId);
					ad_PhoneOrEmail[ad_PhoneOrEmail.length] = phoneOrEmail
					ad_PhoneEmailType[ad_PhoneEmailType.length] = phoneEmailType	
					ad_PhoneEmailID[ad_PhoneEmailID.length] = phoneEmailId
					ad_extension[ad_extension.length] = extension;
					ad_Email[ad_Email.length] = email;                  
					ad_PhoneNo[ad_PhoneNo.length] = phoneNo;            
					ad_PhoneNoCountryCode[ad_PhoneNoCountryCode.length] = phoneNoCountryCode;
					ad_PhoneNoCityCode[ad_PhoneNoCityCode.length] = phoneNoCityCode;
					ad_PhoneNoLocalCode[ad_PhoneNoLocalCode.length] = phoneNoLocalCode;
					ad_extension[ad_extension.length] = extension;
					phoneEmail_Status[phoneEmail_Status.length] = "Add";

				}
			  }//end  of for

			}
//xml encoding changes --end		  
		  /* Changes for call id 425161 Starts */
		  //document.getElementsByName("PhoneEmail.preferredPhone")[0].value = '<xsl:value-of select = "$preferredPhone"/>';
		  //document.getElementsByName("PhoneEmail.preferredEmail")[0].value = '<xsl:value-of select = "$preferredEmail"/>';
			/* Changes for call id 425161 Ends */

		}
		catch(e){
			// Changes for Call id: 577798 starts 
                           // alert("error in Rachit function"+e.getMessage); 
                           // Changes for Call id: 577798 ends 

		}
	}
	/* CIF PhoneEmail Changes : End*/
     
 function enableClose(){
			try{
				document.getElementsByName("Close")[0].disabled = false;
			}catch(e){
			}
   	 }
   	 
   	 //Field based Maker checker changes-322009
	 		function setMCAttModifyFlag(){
	 			document.frm2.isMCEditedGeneral.value="Y";
	 	
	} 	 
	     			

	
    function cancel(){
	if ( !this.parent.parent.showConfirmMessage("Are you sure you want to cancel this operation?")) {
		return;
	}
        try {
            ProdLookupWindow = null;
            window.close();
            window.opener.focus();
        }catch(e) {
        }
    }
    function save(blFlag) {

	
	if(document.frm2.isMCEdited.value=="Y"){
		document.frm2.isMCEditedGeneral.value="Y";
	}
	if(blFlag == false)
	{
		document.frm2.saveFlag.value=1;
	}
	else
	{
		document.frm2.saveFlag.value=0;
	}
	var noOfPhoneEmail = phoneEmail_URL.length;
	
	var chkStat = parent.parent.parent.parent.ValidateFormContents(document.frm2,false);
	     
	
	if (chkStat != "true")
		  return 'interactive';
        
	preferredPhone = document.getElementsByName('PhoneEmail.preferredPhone')[0];
	preferredEmail = document.getElementsByName('PhoneEmail.preferredEmail')[0];
	var preferredPhoneFlag = false;
	var preferredEmailFlag = false;
	
	//Tracker 184709 Starts
		var phoneCheck = phoneEmailCheck();
		if(phoneCheck == "false" || phoneCheck == false) {
			return "interactive";
		}		

	//Tracker 184709 Ends
	
	if((preferredPhone.value != null &amp;&amp; preferredPhone.value != 'undefined') || (preferredEmail.value != null &amp;&amp; preferredEmail.value != 'undefined') )
	{
//xml encoding changes --start
		if(boName=='AccountBO'){
		for(var r=0 ; r &lt; document.all.PhoneEmailRecordSet.rows.length ; r++)
		{
				recordSetPhone = document.all.PhoneEmailRecordSet.rows(r).getAttribute("AccountBO.PhoneEmail.PhoneEmailType");
			if(preferredPhone.value == recordSetPhone &amp;&amp; preferredPhone.value != null){
				preferredPhoneFlag = true;
			}
				recordSetPhone1 = document.all.PhoneEmailRecordSet.rows(r).getAttribute("AccountBO.PhoneEmail.PhoneEmailType1");
			if(preferredEmail.value == recordSetPhone1 &amp;&amp; preferredEmail.value != null){
				preferredEmailFlag = true;
			}
		}
		
		}else if(boName=='ContactBO'){
			for(var r=0 ; r &lt; document.all.PhoneEmailRecordSet.rows.length ; r++)
			{
				recordSetPhone = document.all.PhoneEmailRecordSet.rows(r).getAttribute("ContactBO.PhoneEmail.PhoneEmailType");
				if(preferredPhone.value == recordSetPhone &amp;&amp; preferredPhone.value != null){
					preferredPhoneFlag = true;
				}
				recordSetPhone1 = document.all.PhoneEmailRecordSet.rows(r).getAttribute("ContactBO.PhoneEmail.PhoneEmailType1");
				if(preferredEmail.value == recordSetPhone1 &amp;&amp; preferredEmail.value != null){
					preferredEmailFlag = true;
				}
			}
		
		}else if(boName=='SuspectBO'){
			for(var r=0 ; r &lt; document.all.PhoneEmailRecordSet.rows.length ; r++)
			{
				recordSetPhone = document.all.PhoneEmailRecordSet.rows(r).getAttribute("SuspectBO.PhoneEmail.PhoneEmailType");
				if(preferredPhone.value == recordSetPhone &amp;&amp; preferredPhone.value != null){
					preferredPhoneFlag = true;
				}
				recordSetPhone1 = document.all.PhoneEmailRecordSet.rows(r).getAttribute("SuspectBO.PhoneEmail.PhoneEmailType1");
				if(preferredEmail.value == recordSetPhone1 &amp;&amp; preferredEmail.value != null){
					preferredEmailFlag = true;
				}
			}
		
		}else if(boName=='NonCustomerBO'){
			for(var r=0 ; r &lt; document.all.PhoneEmailRecordSet.rows.length ; r++)
			{
				recordSetPhone = document.all.PhoneEmailRecordSet.rows(r).getAttribute("NonCustomerBO.PhoneEmail.PhoneEmailType");
				if(preferredPhone.value == recordSetPhone &amp;&amp; preferredPhone.value != null){
					preferredPhoneFlag = true;
				}
				recordSetPhone1 = document.all.PhoneEmailRecordSet.rows(r).getAttribute("NonCustomerBO.PhoneEmail.PhoneEmailType1");
				if(preferredEmail.value == recordSetPhone1 &amp;&amp; preferredEmail.value != null){
					preferredEmailFlag = true;
				}
			}
		
		}
//xml encoding changes --end		
		if(!preferredPhoneFlag &amp;&amp; preferredPhone.value != null &amp;&amp; preferredPhone.value != '')
		{
			selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
			parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("Preferred Phone Does not exist in the Listing",""), preferredPhone.name, 'NO_HYPER_LINK');
			parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			return "interactive";
		}
		if(!preferredEmailFlag &amp;&amp; preferredEmail.value != null &amp;&amp; preferredEmail.value != '')
		{
			selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
			parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("Preferred Email Does not exist in the Listing",""), preferredEmail.name, 'NO_HYPER_LINK');
			parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			return "interactive";
		}
	}
	addPhoneEmailCounter = 0;
	for(var i = 0; i &lt; noOfPhoneEmail; i++){
		if((phoneEmail_URL[i] != null) &amp;&amp; !(phoneEmail_Status[i] == "Remove")) {
			if(addPhoneEmailCounter == 0) {
				document.frm2.PhoneNo.value = srmEscape(ad_PhoneNo[i], '^', escChars);
				document.frm2.PhoneOrEmail.value = srmEscape(ad_PhoneOrEmail[i], '^', escChars);
				document.frm2.PhoneEmailType.value = srmEscape(ad_PhoneEmailType[i], '^', escChars);
				document.frm2.PhoneEmailID.value = srmEscape(ad_PhoneEmailID[i], '^', escChars);
				document.frm2.Email.value = srmEscape(ad_Email[i], '^', escChars);
				document.frm2.PhoneNoCountryCode.value = srmEscape(ad_PhoneNoCountryCode[i], '^', escChars);
				document.frm2.PhoneNoCityCode.value = srmEscape(ad_PhoneNoCityCode[i], '^', escChars);
				document.frm2.PhoneNoLocalCode.value = srmEscape(ad_PhoneNoLocalCode[i], '^', escChars);
				document.frm2.extension.value = srmEscape(ad_extension[i], '^', escChars);
				document.frm2.PreferredPhone.value = document.getElementsByName('PhoneEmail.preferredPhone')[0].value;
				document.frm2.PreferredEmail.value = document.getElementsByName('PhoneEmail.preferredEmail')[0].value;

				addPhoneEmailCounter = 1;
			}
			else
			{
				/*Modified For Recon Id : 440199 Starts */
				document.frm2.PhoneEmailID.value = document.frm2.PhoneEmailID.value + "," + srmEscape(ad_PhoneEmailID[i], '^', escChars);
				document.frm2.PhoneOrEmail.value = document.frm2.PhoneOrEmail.value + "," + srmEscape(ad_PhoneOrEmail[i], '^', escChars);
				document.frm2.PhoneNo.value = document.frm2.PhoneNo.value + "," + srmEscape(ad_PhoneNo[i], '^', escChars);
				document.frm2.PhoneEmailType.value = document.frm2.PhoneEmailType.value + "," + srmEscape(ad_PhoneEmailType[i], '^', escChars);
				document.frm2.Email.value = document.frm2.Email.value + "," + srmEscape(ad_Email[i], '^', escChars);
				document.frm2.PhoneNoCountryCode.value = document.frm2.PhoneNoCountryCode.value + "," + srmEscape(ad_PhoneNoCountryCode[i], '^', escChars);
				document.frm2.PhoneNoCityCode.value = document.frm2.PhoneNoCityCode.value + "," + srmEscape(ad_PhoneNoCityCode[i], '^', escChars);
				document.frm2.PhoneNoLocalCode.value = document.frm2.PhoneNoLocalCode.value + "," + srmEscape(ad_PhoneNoLocalCode[i], '^', escChars);
				document.frm2.extension.value = document.frm2.extension.value + "," +srmEscape(ad_extension[i], '^', escChars);
				/*Modified For Recon Id : 440199 Ends */
				document.frm2.PreferredEmail.value = document.getElementsByName('PhoneEmail.preferredEmail')[0].value;
				document.frm2.PreferredPhone.value = document.getElementsByName('PhoneEmail.preferredPhone')[0].value;
			}
		}
	}//end of for
	document.frm2.PhoneEmailRemoved.value = getCSVforArray(phone_detachedURLs);
	document.frm2.action="../servlet/com.infy.cis.ui.cif.QuickEntityWriter";
	document.frm2.target="formSaveFrame";
        document.frm2.submit();
	return "true";
    }
    
    function check(Tab,setFlag){
	        if(setFlag == false) {
			noValidationMsg = true;
		}
		else {
			noValidationMsg = false;
		}
	        return parent.parent.parent.parent.ValidateFormContents(document.frm2,true,noValidationMsg,Tab);
	}
    function getCSVforArray(arr){

            retVal = "";
            tmpCnt = 0;
            noOfElems = arr.length;
            for(var i = 0; i &lt; noOfElems; i++) {
                if(arr[i] != null) {
                    if(tmpCnt == 0) {
                        tmpCnt  = 1;
                        retVal = arr[i];
                    } else {
                        retVal = retVal + "," + arr[i];
                    }
                }
            }
            return retVal;
    }

    function closebtn()
     	{
     	 top.window.close();
     	} 
    function selectProcess()
    {
		submit = true;	
		var entityType = "";
		entityId  = parent.formSaveFrame.savedValue;
		entityType = parent.formSaveFrame.entityType;
//Checksum recon from 10.3 SUPP
		var secureHKey = document.getElementsByName("SECUREHKEY")[0].value;	
		var keyField = document.getElementsByName("FLDHASHKEY")[0].value;						
//Checksum recon from 10.3 SUPP

		//window.open('../../../servlet/com.infy.cis.ui.cif.CIFProcessSelectionDetWizard?entityId='+entityId+'&amp;entityType='+entityType+'&amp;SECUREHKEY='+secureHKey+'&amp;FLDHASHKEY='+keyField+'&amp;isPopup=Yes','save','directories=No, height=250, left=100, top=100, width=550, location=no, menubar=no, resizable=no, status=no, toolbar=no');
   var strProcessURL = '../servlet/com.infy.cis.custom.EquityRetailProcessSelection?entityId='+entityId+'&amp;entityType='+entityType;
   					var strBOURL = "";
   					//alert('strBOURL    '+strBOURL);
   					//alert('strProcessURL     '+strProcessURL);
			fnProcessSelection(strProcessURL, strBOURL);
    }
    function clear() {
	//alert("in clear values in PhoneEmail");
    }
    function resubmit(){
	parent.parent.parent.parent.parent.parent.frames(0).submit();
    }
    </script>
    </head>
    <body class="popup">
    
   
    <xsl:choose>
		<xsl:when test="normalize-space($readMode)='Y'">
			<xsl:attribute name="onload">showInReadOnlyMode('<xsl:value-of select="$readMode"/>');enableClose();load();</xsl:attribute>
		</xsl:when>
		<xsl:otherwise>
		<!-- changes for ticket 305918 start -->
			<xsl:attribute name="onload">chkBSN();load();</xsl:attribute>
			<!-- changes for ticket 305918 end -->
		</xsl:otherwise>
    </xsl:choose>
        
            <xsl:apply-templates select="SRM"/>
        
        </body>
    </html>
    </xsl:template>
        <xsl:template name="PhoneEmail.preferredPhone">
		<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='PreferredPhone']"/>
		<xsl:with-param name="selectname">PhoneEmail.preferredPhone</xsl:with-param>
		<xsl:with-param name="selectdisp">PhoneEmail.preferredPhone</xsl:with-param>
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="presdata" select="$PresData"/>
		</xsl:call-template>
	</xsl:template>

        <xsl:template name="PhoneEmail.preferredEmail">
		<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='PreferredEmail']"/>
		<xsl:with-param name="selectname">PhoneEmail.preferredEmail</xsl:with-param>
		<xsl:with-param name="selectdisp">PhoneEmail.preferredEmail</xsl:with-param>
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="presdata" select="$PresData"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="PhoneEmail.AddPhoneEmail">
		<xsl:call-template name="user_button_withText">
		<xsl:with-param name="button_name">ADD_PHONEEMAIL</xsl:with-param>
		<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='Add Phone/Email']/@configLabel"/></xsl:with-param>
		<xsl:with-param name="button_fnc">addPhoneEmail()</xsl:with-param>
		</xsl:call-template>
	</xsl:template>	       
	<xsl:template name="PhoneEmail.CopyPhoneEmail">
		<xsl:call-template name="user_button_withText">
		<xsl:with-param name="button_name">COPY_PHONEEMAIL</xsl:with-param>
		<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='Copy Phone/Email']/@configLabel"/></xsl:with-param>
		<xsl:with-param name="button_fnc">copyPhoneEmail()</xsl:with-param>
		</xsl:call-template>
	</xsl:template>	       
	<xsl:template name="PhoneEmail.RemovePhoneEmail">
		<xsl:call-template name="user_button_withText">
		<xsl:with-param name="button_name">REMOVE_PHONEEMAIL</xsl:with-param>
		<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='Delete Phone/Email']/@configLabel"/></xsl:with-param>
		<xsl:with-param name="button_fnc">removePhoneEmail()</xsl:with-param>
		</xsl:call-template>
	</xsl:template>	       
    <xsl:template match="*" mode="mode1">
        <form name="frm2"  method="post" action="">
	    <table bgcolor="ffffff" cellpadding="0" cellspacing="0" width="100%">
       		      		
				<xsl:call-template name="PhoneEmail.preferredPhone"/>
				<xsl:call-template name="PhoneEmail.preferredEmail"/>
                 				
	</table>
	<table bgcolor="ffffff" cellpadding="0" width="100%">
		
			<td>
				<xsl:call-template name="PhoneEmail.AddPhoneEmail"/>&#160;
      				<xsl:call-template name="PhoneEmail.RemovePhoneEmail"/>&#160;
      				<xsl:call-template name="PhoneEmail.CopyPhoneEmail"/>&#160;
			</td>
		
		</table>
		    <xsl:call-template name="mainbody">
		    <xsl:with-param name="tablename">PhoneEmailRecordSet</xsl:with-param>
		    <xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels[@name='Header']/@configLabel"/></xsl:with-param>
		    <xsl:with-param name="align">center</xsl:with-param>
		    <xsl:with-param name="button">true</xsl:with-param>
		    <xsl:with-param name="width">100%</xsl:with-param>
		    <xsl:with-param name="name">...</xsl:with-param>
		    <xsl:with-param name="UsrDataSpace">PhoneEmail</xsl:with-param>
		    <xsl:with-param name="rowhighlight">true</xsl:with-param>
			  <xsl:with-param name="rsfilenm" select="$file1"/>
		    <xsl:with-param name="jscriptfnc">,callPhoneEmail()</xsl:with-param>
		    <xsl:with-param name="extra_colheader">Select</xsl:with-param>
		    <xsl:with-param name="onClick">editPhoneEmailDetails()</xsl:with-param>
		    <xsl:with-param name="IsEnabledInReadMode">true</xsl:with-param>
		    <xsl:with-param name="IsPrefixrowhighlight">true</xsl:with-param>
		    <xsl:with-param name="PrefixVal">2</xsl:with-param>
		    </xsl:call-template>

			<input type="hidden" name="hid_entityURL" value="{$entityURL}"/>
			<input type="hidden" name="PhoneOrEmail" value=""/>
			<input type="hidden" name="PhoneNoCountryCode" value=""/>
			<input type="hidden" name="PhoneNoCityCode" value=""/>
			<input type="hidden" name="PhoneNoLocalCode" value=""/>
			<input type="hidden" name="PhoneNo" value=""/>
			<input type="hidden" name="PhoneEmailID" value=""/>
			<input type="hidden" name="PhoneEmailType" value=""/>
			<input type="hidden" name="Email" value=""/>
			<input type="hidden" name="extension" value=""/>
			<input type="hidden" name="PhoneEmailRemoved" value=""/>
			<input type="hidden" name="PreferredPhone" value=""/>
			<input type="hidden" name="PreferredEmail" value=""/>
			<input type="hidden" name="quickEditFlag" value="true"/>
			<input type="hidden" name="quickEditType" value="QuickPhoneEmailSave"/>
		        <input type="hidden" name="saveFlag" value=""/>
	                <input type="hidden" name="apprFlag" value="{$apprFlag}"/>
	                <input type="hidden" name="boName" value="{$boName}"/>
	                <input type="hidden" name="entityID" value="{$entityID}"/>
			<!--Field based maker checker changes-->
			<input type="hidden" name="isMCEditedGeneral" value="N"/>
			<input type="hidden" name="isMCEdited" value="{$isMCEdited}"/>
			<input type="hidden" name="mcJNDIFlag" value="{$mcJNDIFlag}"/>
			<input type="hidden" name="getMCRequired" value="{$getMCRequired}"/>
			<input type="hidden" name="getRole" value="{$getRole}"/>
			<!--Field based maker checker changes-->
        </form>
        </xsl:template>
        <xsl:template match="SRM">
            <xsl:for-each select=".">
                <xsl:call-template name="startTable"/>
                    <table bgcolor='ffffff' border="0" cellspacing="0" cellpadding="0" width="100%" vspace="0" hspace="0">
                        <tr>
                            <xsl:call-template name="apply">
                                <xsl:with-param name="apply_head">
                                <b><xsl:value-of select="$configLabels[@name='Header']/@configLabel"/></b>
                                </xsl:with-param>
                            </xsl:call-template>
                        </tr>
                    </table>
                    <table bgcolor='ffffff' width="100%" border="0" cellspacing="0" cellpadding="0">
                        <xsl:apply-templates select="." mode="mode1"/>
                    </table>
                <xsl:call-template name="endTable"/>
            </xsl:for-each>
        </xsl:template>
    </xsl:stylesheet>






