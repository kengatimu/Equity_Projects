<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../Renderer/common/display/getJVMProperties.xsl"/>
<xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"/>
<xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"/>

<xsl:param name="locale"/>

<xsl:variable name="file_ML">../Renderer/Customization/cif/resource/EquityRetCIF_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<!--<xsl:variable name="file1">../Renderer/Customization/cif/resource/RetailCustOnboard_<xsl:value-of select="$locale"/>.xml</xsl:variable>-->
<xsl:variable name="configFile" select="document(concat($file_ML,''))"/>
<!--<xsl:variable name="configFile_1" select="document(concat($file1, ''))"/>-->
<xsl:variable name="configLabels" select="$configFile/SRMBO/*"/>




<xsl:variable name="CustomFields" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z" />
<xsl:variable name="readMode" select="$CustomFields/Z[@n='IsReadOnly']" />
<xsl:variable name="Mode" select="$CustomFields/Z[@n='mode']" />

<xsl:template match="/">
	<html>
		<head>
			<title><xsl:value-of select="//SRMPresentation/SRMSystem[@n='Strings']/SRMString[@n='Title']/@value"/></title>
						<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
						<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/PopupMenu_{$locale}.css"/>
						<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/SRMListTemplate_{$locale}.css" />
						<LINK REL="stylesheet" Type="text/css" href="../Branding/css/reports/Reports_{$locale}.css" />
						
						
			
						<SCRIPT LANGUAGE='javascript' src='js/SSOParameter.js'></SCRIPT>
						<script type='text/javascript' src='FinacleCRM/common/js/ClientResourceBundle_en_US.js' language='javascript'></script>
						<script type='text/javascript' src='js/Message_loans_en_US.js' language='javascript'></script>
					
			              <script type="text/javascript" src="/FinacleCRM/common/js/Rendcommon.js" language="javascript"></script>
		<script type="text/javascript" src="/FinacleCRM/common/html/TLValidate.js" language="javascript"></script>
		</head>

		<script type="text/javascript" src="../common/html/validate.js" language="javascript"></script>
		
		<body class="popup">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" vspace="0" hspace="0">
				<xsl:apply-templates select="SRM"/>
			</table>
		</body>

		<!--**********Common JS method code starts here*********-->

	<script language="javascript">

	

   	function Uploadfn()
   	{
   	//alert("Upload");
   	
   	var strUserid2=document.getElementsByName("AccountBO.AccountKey")[0].value;
   	var strUserid3=document.getElementsByName("AccountBO.StrUserField2")[0].value;
	   	
	   	 if (strUserid2=='')
	       	{
	   	alert("CIF ID is mandatory. Please provide");
	   	}
	   	else if(strUserid3=='')
	   	{
	   	alert("User's Login ID is mandatory. Please provide");
	   	}
	    else {

			if (window.XMLHttpRequest)
				{											

					 s_xmlHttp = new XMLHttpRequest();

				}
				else
				{	

					 s_xmlHttp = new ActiveXObject("Microsoft.XMLHttp");

				 }

				var strURL1 = '../servlet/com.infy.cis.custom.EquityRetCIF_Result?strUserid2='+strUserid2+'&amp;strUserid3='+strUserid3;


				s_xmlHttp.open("POST",strURL1,false);

				s_xmlHttp.send();

				if(s_xmlHttp.status == 200)
					{

						//var node1 = s_xmlHttp.responseXML.selectSingleNode("CRM/VALUE");


						var node2 = s_xmlHttp.responseXML.selectSingleNode("CRM/LOCALETEXT");


						//var status=node1.text;
						//alert('status'+status);
						

						var message=node2.text;
						alert(message);


					 }

	}
   	}	

	</script>

		<!--**********Script Code Ends *********-->
	</html>
</xsl:template>

		<!--*****Template Definitions Begins Here*****-->
<xsl:template name="AccountBO.AccountKey">
	<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.AccountKey']"/>
		<xsl:with-param name="ele_name">AccountBO.AccountKey</xsl:with-param>
		<xsl:with-param name="ele_val">AccountBO.AccountKey</xsl:with-param>
		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="AccountBO.StrUserField2">
	<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='AccountBO.StrUserField2']"/>
		<xsl:with-param name="ele_name">AccountBO.StrUserField2</xsl:with-param>
		<xsl:with-param name="ele_val">AccountBO.StrUserField2</xsl:with-param>
		<xsl:with-param name="starshow">true</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="Upload">
	<xsl:call-template name="user_button_withText">
		<xsl:with-param name="button_text">Submit</xsl:with-param>
		<xsl:with-param name="button_name">Assign</xsl:with-param>
		<xsl:with-param name="button_fnc">Uploadfn();</xsl:with-param>
	</xsl:call-template>
</xsl:template>


		<!--*****Template Definitions END Here********-->

		<!--*****Calling Template Begins Here*********-->

<xsl:template match="*" mode="mode1">
	<xsl:call-template name="Begin"/>
		<!--<td>-->
			<form name="frm2"  method="post" action="">
			
			<table bgcolor="E5E5E5" border="0" cellspacing="0" hspace="0" vspace="0" width="100%">
				
							
						
				<xsl:call-template name="Begin" />
						
				<xsl:call-template name="AccountBO.AccountKey"/>
				<xsl:call-template name="AccountBO.StrUserField2"/>
				
				
																		
				<xsl:call-template name="End" />
				
				<table width="100%"  align="left" cellspacing="0" vspace="20" hspace="0" border="0">
				<tr align="left">
				<td>
				<xsl:call-template name="Upload"/>
				</td></tr>
															
															
															
				</table>
							
			</table></form>
		<!--	</td>  -->
						
				<xsl:call-template name="End"></xsl:call-template>
				</xsl:template><xsl:template match="SRM">
				<xsl:for-each select=".">
				<xsl:call-template name="startTable"></xsl:call-template>
				<table width="100%" vspace="0" hspace="0" cellspacing="0" cellpadding="2" border="0" bgcolor="ffffff">
				<tr>
			<xsl:call-template name="apply">
			<xsl:with-param name="apply_head">
			<b>Retail CIF Custom Menu</b><br/>
			</xsl:with-param>
				</xsl:call-template>
				</tr>
				</table>
				<table width="100%" cellspacing="0" cellpadding="2" border="0" bgcolor="ffffff">
				<xsl:apply-templates select="." mode="mode1"></xsl:apply-templates>
				</table>
				<xsl:call-template name="endTable"></xsl:call-template>
				</xsl:for-each>
				</xsl:template>
			</xsl:stylesheet>

