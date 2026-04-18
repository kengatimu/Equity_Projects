<?xml version="1.0"?>
    <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"/>
    <xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"/>
    <xsl:import href="../Renderer/common/display/getJVMProperties.xsl"/>
    <xsl:import href="../Renderer/common/display/SRMListTemplate.xsl"/>
    <xsl:param name="locale"/>

<!-- QED Changes: START -->
    <xsl:param name="AddressFileName"/>
    <xsl:variable name="file1" select="$AddressFileName"/>
     <!-- Tracker ID :756914 - Chrome Porting Changes -->
    <xsl:variable name="file1XML" select="substring-before(substring-after($file1,'resource/'),'.xml')"/>
    <xsl:variable name="configFile_1" select="SRM"/>
    <xsl:variable name="configLabels" select="$configFile_1/SRMBO/ResourceFile[@filename=$file1XML]/*"/>
<!-- QED Changes: END -->

    <xsl:variable name="readMode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsReadOnly']"/>
    <xsl:variable name="allfields" select="//SRMData//Z"/>
    <xsl:variable name="mainAccId" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='mainAccId']"></xsl:variable>
    <xsl:param name = "boName"/>
    <xsl:variable name="boDet" select="/SRM/SRMData[@SRMDataSpace='Main']/SRMComposite [@n=$boName]/Z"/>
    <xsl:variable name="accountID" select="$boDet[@n=concat($boName,'.accountID')]"/>
    <xsl:variable name="entityURL" select="//SRMData//Z[@n=concat($boName,'.url_')]"></xsl:variable>
    <xsl:variable name="isNRE" select="//SRMData//Z[@n=concat($boName,'.CustomerNREFlg')]"></xsl:variable>
	<!-- Changes for ticket 346170 : BEGIN -->
    <!--<xsl:variable name="defAddress" select="//SRMData//Z[@n=concat($boName,'.defAddress')]"></xsl:variable>-->
    <xsl:variable name="defAddress" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='defAddress']"/>
    <!-- Changes for ticket 346170 : END -->
    <xsl:variable name="apprFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='apprFlag']"></xsl:variable>
    <xsl:variable name="entityID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='entityID']"></xsl:variable>
    <xsl:variable name="preferredAddressType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='preferredAddressType']"></xsl:variable>	
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
	<!-- Tracker ID :756914 - Chrome Porting Changes -->
    <xsl:variable name="PresData" select="SRM/SRMPresentation"/> 
    

    <xsl:template match="/">
    <html>
        <title><xsl:value-of select="//SRMPresentation/SRMSystem[@n='Strings']/SRMString[@n='Title']/@value"/></title>
    <head>
    <script>
    var locale = '<xsl:value-of select="$locale"/>';
    </script>
    <LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
    <LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/MultiTabs_{$locale}.css"/>
    <link rel="stylesheet" type="text/css" href="../Branding/css/common/SRMListTemplate_{$locale}.css"/>
    <script type="text/javascript" src="../common/js/SRMTableRowColor.js" language="javascript"></script>
		<!-- Equity bank DRC CGCR19 changes start -->        

    <script type="text/javascript" src="../Customization/43/cif/js/QuickEdit_Address.js" language="javascript"></script>
			<!-- Equity bank DRC CGCR19 changes end -->        

    <script type="text/javascript" src="../cif/js/Message_cif_{$locale}.js" language="javascript"></script>
    <script type="text/javascript" src="../cif/js/CheckBSNFlags.js" language="javascript"></script>

    <script type="text/javascript" src="../Customization/cif/js/EquityProcessCustom.js" language="javascript"></script>
    <script type="text/javascript" language="javascript">
	var AddressID = "";
	var isEntityNRE = '<xsl:value-of select="$isNRE"/>';
	var defAddressType = '<xsl:value-of select="$defAddress"/>';
	var boName = '<xsl:value-of select="$boName"/>';
	var apprFlag = '<xsl:value-of select="$apprFlag"/>';
	/* changes for ticket 305918 end */
	var BlackListed = '<xsl:value-of select="$BlackListed"/>';
	var Suspended = '<xsl:value-of select="$Suspended"/>';
	var chkBSNFlg = '<xsl:value-of select="$chkBSN"/>';
	var Negated =  '<xsl:value-of select="$Negated"/>';
	/* changes for ticket 305918 end */
	<!-- Tracker ID :756914 - Chrome Porting Changes -->
	var readMode= '<xsl:value-of select="$readMode"/>';
	function functionBodyOnload(){
		if(readMode=='Y'){
			showInReadOnlyMode('<xsl:value-of select="$readMode"/>');
			enableClose();
			load();
		}else{
			chkBSN();
			load();
		}
	}
	function load()
	{
		try{
		     customLoad();
		}catch(e)
		{ }
		try
		{
		
			var obj = parent.parent.parent.parent.frames(3);
			obj.enableButton_Ub(); 		
		
			sortList('RecordSet');
			deleteList('RecordSet');
			addAddressList('RecordSet');
			document.getElementsByName("Address.preferredAddress")[0].value = '<xsl:value-of select = "$preferredAddressType"/>';
		}
		catch(e){
			 // Changes for Call id: 577798 starts 
                           //alert("error in Rachit function"+e.getMessage); 
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
	
    function closebtn(){
    			
             
    			top.window.close();
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
        <table width="100%" cellpadding="0" cellspacing="0" border="0"  align="left">
            <xsl:apply-templates select="SRM"/>
        </table>
    </body>
    </html>
    </xsl:template>
        <xsl:template name="Address.preferredAddress">
		<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='PreferredAddress']"/>
		<xsl:with-param name="selectname">Address.preferredAddress</xsl:with-param>
		<xsl:with-param name="selectdisp">Address.preferredAddress</xsl:with-param>
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="presdata" select="$PresData"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="Address.AddAddress">
		<xsl:call-template name="user_button_withText">
		<xsl:with-param name="button_name">ADD_ADDRESS</xsl:with-param>
		<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='ADD_ADDRESS']/@configLabel"/></xsl:with-param>
		<xsl:with-param name="button_fnc">addAddress('<xsl:value-of select="$boName"/>')</xsl:with-param>
		</xsl:call-template>
	</xsl:template>	       
	<xsl:template name="Address.CopyAddress">
		<xsl:call-template name="user_button_withText">
		<xsl:with-param name="button_name">COPY_ADDRESS</xsl:with-param>
		<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='COPY_ADDRESS']/@configLabel"/></xsl:with-param>
		<xsl:with-param name="button_fnc">copyAddress()</xsl:with-param>
		</xsl:call-template>
	</xsl:template>	       
	<xsl:template name="Address.RemoveAddress">
		<xsl:call-template name="user_button_withText">
		<xsl:with-param name="button_name">REMOVE_ADDRESS</xsl:with-param>
		<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='DELETE_ADDRESS']/@configLabel"/></xsl:with-param>
		<xsl:with-param name="button_fnc">removeAddress()</xsl:with-param>
		</xsl:call-template>
	</xsl:template>	       
	<xsl:template name="Address.SwiftAddress">
		<xsl:call-template name="user_button_withText">
		<xsl:with-param name="button_name">SWIFT_ADDRESS_DETAILS</xsl:with-param>
		<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='SWIFT_ADDRESS_DETAILS']/@configLabel"/></xsl:with-param>
		<xsl:with-param name="button_fnc">editSwiftAddress()</xsl:with-param>
		</xsl:call-template>
	</xsl:template>	       
    <xsl:template match="*" mode="mode1">
        <form name="frm2"  method="post" action="">
            <table bgcolor="" align="center" cellpadding="2" width="100%">
       		<tr align="right">
		<td>
				<xsl:call-template name="Address.preferredAddress"/>&#160;
		</td>
			<td>
				<xsl:call-template name="Address.AddAddress"/>&#160;
      				<xsl:call-template name="Address.RemoveAddress"/>&#160;
      				<xsl:call-template name="Address.CopyAddress"/>&#160;
      				<xsl:call-template name="Address.SwiftAddress"/>&#160;
			</td>
		</tr>
		</table>
		    <xsl:call-template name="mainbody">
		    <xsl:with-param name="tablename">RecordSet</xsl:with-param>
		    <xsl:with-param name="tableHeader"><xsl:value-of select="$configLabels[@name='ADD_ADDRESS']/@configLabel"/></xsl:with-param>
		    <xsl:with-param name="align">center</xsl:with-param>
		    <xsl:with-param name="button">true</xsl:with-param>
		    <xsl:with-param name="width">100%</xsl:with-param>
		    <xsl:with-param name="name">...</xsl:with-param>
		    <xsl:with-param name="UsrDataSpace">Address</xsl:with-param>
		    <xsl:with-param name="rowhighlight">true</xsl:with-param>
			  <xsl:with-param name="rsfilenm" select="$file1"/>
		    <xsl:with-param name="jscriptfnc">,call()</xsl:with-param>
		    <xsl:with-param name="extra_colheader">Select</xsl:with-param>
		    <xsl:with-param name="onClick">editQuickAddressDetails()</xsl:with-param>
		    <xsl:with-param name="IsEnabledInReadMode">true</xsl:with-param>
		    <xsl:with-param name="IsPrefixrowhighlight">true</xsl:with-param>
		    <xsl:with-param name="PrefixVal">2</xsl:with-param>
		    </xsl:call-template>

			<input type="hidden" name="mainAccId" value="{$mainAccId}"/>
				 <!-- Hidden variables for address tab begin-->
			<input type="hidden" name="address_type" value=""/>
			<input type="hidden" name="screenname" value="CIF"/>
			<input type="hidden" name="houseno" value=""/>
			<input type="hidden" name="premiseno" value=""/>
			<input type="hidden" name="building" value=""/>
			<!-- Equity bank DRC CGCR19 changes end -->        
			<input type="hidden" name="ADDR_USERFIELD1" value=""/>

			<!-- Equity bank DRC CGCR19 changes end -->        

			<!-- Tracker 105266 -->
			<input type="hidden" name="premisename" value=""/>
			<input type="hidden" name="buildinglevel" value=""/>
			<input type="hidden" name="country" value=""/>
			<input type="hidden" name="city" value=""/>
			<input type="hidden" name="state" value=""/>
			<input type="hidden" name="start_date" value=""/>
			<input type="hidden" name="zip" value=""/>
			<input type="hidden" name="end_date" value=""/>
			<input type="hidden" name="addrID" value=""/>
			<input type="hidden" name="streetno" value=""/>
			<input type="hidden" name="town" value=""/>
			<input type="hidden" name="locality" value=""/>
			<input type="hidden" name="localityName" value=""/>
			<input type="hidden" name="domicile" value=""/>
			<!--<input type="hidden" name="website" value=""/>-->
			<input type="hidden" name="url" value=""/>
			<input type="hidden" name="mailstop" value=""/> 
			<input type="hidden" name="streetname" value=""/>
			<input type="hidden" name="suburb" value=""/>
			<input type="hidden" name="AdrRemoved" value=""/>
                        <input type="hidden" name="IsAddressProofRcvd" value=""/>
			<!-- Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin -->
                        <input type="hidden" name="IsAddressVerified" value=""/>
			 <!-- Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end -->
			<input type="hidden" name="extension" value=""/>
			<input type="hidden" name="eduURL" value=""/>
			<input type="hidden" name="EduRemoved" value=""/>
			<input type="hidden" name="accountID" value="{$accountID}"/>
			<input type="hidden" name="hid_entityURL" value="{$entityURL}"/>

			<input type="hidden" name="country_code" value=""/>
			<input type="hidden" name="state_code" value=""/>
			<input type="hidden" name="city_code" value=""/>
			<input type="hidden" name="core_cust_id" value=""/>
			<input type="hidden" name="salutation_code" value=""/>
			<input type="hidden" name="name" value=""/>
			<input type="hidden" name="MLUSERFIELD1" value=""/>
			<input type="hidden" name="MLUSERFIELD2" value=""/>
			<input type="hidden" name="MLUSERFIELD3" value=""/>
			<input type="hidden" name="MLUSERFIELD4" value=""/>
			<input type="hidden" name="MLUSERFIELD5" value=""/>
			<input type="hidden" name="MLUSERFIELD6" value=""/>
			<input type="hidden" name="MLUSERFIELD7" value=""/>
			<input type="hidden" name="MLUSERFIELD8" value=""/>
			<input type="hidden" name="MLUSERFIELD9" value=""/>
			<input type="hidden" name="MLUSERFIELD10" value=""/>
			<input type="hidden" name="MLUSERFIELD11" value=""/>
			<input type="hidden" name="MLUSERFIELD12" value=""/>
			<input type="hidden" name="MLUSERFIELD13" value=""/>
			<input type="hidden" name="MLUSERFIELD14" value=""/>
			<input type="hidden" name="MLUSERFIELD15" value=""/>
			<input type="hidden" name="MLUSERFIELD16" value=""/>
			<input type="hidden" name="MLUSERFIELD17" value=""/>
			<input type="hidden" name="MLUSERFIELD18" value=""/>
			<input type="hidden" name="MLUSERFIELD19" value=""/>
			<input type="hidden" name="MLUSERFIELD20" value=""/>
			<input type="hidden" name="MLUSERFIELD21" value=""/>
			<input type="hidden" name="MLUSERFIELD22" value=""/>
			<input type="hidden" name="MLUSERFIELD23" value=""/>
			<input type="hidden" name="MLUSERFIELD24" value=""/>
			<input type="hidden" name="MLUSERFIELD25" value=""/>
			<input type="hidden" name="MLUSERFIELD26" value=""/>
			<input type="hidden" name="MLUSERFIELD27" value=""/>
			<input type="hidden" name="MLUSERFIELD28" value=""/>
			<input type="hidden" name="MLUSERFIELD29" value=""/>
			<input type="hidden" name="MLUSERFIELD30" value=""/>

			<input type="hidden" name="PreferredFormat" value=""/>
			<input type="hidden" name="HoldMailReason" value=""/>
			<input type="hidden" name="BusinessCenter" value=""/>
			<input type="hidden" name="HoldMailInitiatedBy" value=""/>
			<input type="hidden" name="HoldMailFlag" value=""/>
                        <input type="hidden" name="LastUpdate_Date" value=""/>
<!-- AdressLine changes: START -->
			<input type="hidden" name="AddressLine1" value=""/>
			<input type="hidden" name="AddressLine2" value=""/>
			<input type="hidden" name="AddressLine3" value=""/>
<!-- AdressLine changes: END -->
			<!--Field based maker checker changes-->
			<input type="hidden" name="isMCEditedGeneral" value="N"/>
			<input type="hidden" name="isMCEdited" value="{$isMCEdited}"/>
			<input type="hidden" name="mcJNDIFlag" value="{$mcJNDIFlag}"/>
			<input type="hidden" name="getMCRequired" value="{$getMCRequired}"/>
			<input type="hidden" name="getRole" value="{$getRole}"/>
			<!--Field based maker checker changes-->
			<input type="hidden" name="FreeTextLabel" value=""/>
			<input type="hidden" name="PreferredAddress" value=""/>
			<input type="hidden" name="quickEditFlag" value="true"/>
			<input type="hidden" name="quickEditType" value="QuickAddressSave"/>
			<!-- Hidden variables for address tab end-->
		        <input type="hidden" name="saveFlag" value=""/>
	                <input type="hidden" name="apprFlag" value="{$apprFlag}"/>
	                <input type="hidden" name="boName" value="{$boName}"/>
	                <input type="hidden" name="entityID" value="{$entityID}"/>
	                <input type="hidden" name="SwiftAddressDetails" value=""/>
			<!-- Changes for call id: 401260 and recon for TOL 397571 -->
			<input name="LastUpdate_Date_Flag" type="hidden" value=""/>
        </form>
        </xsl:template>
        <xsl:template match="SRM">
            <xsl:for-each select=".">
                <xsl:call-template name="startTable"/>

                    <table bgcolor='FFFFFF' width="100%" border="0" cellspacing="0" cellpadding="2">
                        <xsl:apply-templates select="." mode="mode1"/>
                    </table>
                <xsl:call-template name="endTable"/>
            </xsl:for-each>
        </xsl:template>
    </xsl:stylesheet>







