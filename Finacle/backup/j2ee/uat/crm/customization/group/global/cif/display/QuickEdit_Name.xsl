<?xml version="1.0"?>
    <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"/>
    <xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"/>
    <xsl:import href="../Renderer/common/display/getJVMProperties.xsl"/>
    <xsl:import href="../Renderer/common/display/SRMListTemplate.xsl"/>
    <xsl:param name="locale"/>
    <!--tracker id 113227 starts-->	 
    <xsl:param name="altLocaleActv"/>        
    <!--tracker id 113227 ends-->
    <xsl:variable name="file1">../Renderer/Customization/cif/resource/QuickEdit_Name_<xsl:value-of select="$locale"/>.xml</xsl:variable>
    <xsl:variable name="configFile_1" select="document(concat($file1,''))"/>
    <xsl:variable name="configLabels" select="$configFile_1/SRMBO/*"/>
    <xsl:variable name="readMode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsReadOnly']"/>
    <xsl:variable name="allfields" select="//SRMData//Z"/>
    <xsl:variable name="mainAccId" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='mainAccId']"></xsl:variable>
    <xsl:param name = "boName"/>
    <xsl:variable name="boDet" select="/SRM/SRMData[@SRMDataSpace='Main']/SRMComposite [@n=$boName]/Z"/>
    <xsl:variable name="accountID" select="$boDet[@n=concat($boName,'.accountID')]"/>
    <xsl:variable name="entityURL" select="//SRMData//Z[@n=concat($boName,'.url_')]"></xsl:variable>
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
	<!-- Changes for call id 451066 starts here -->
	<xsl:variable name="Cust_community" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Cust_community']"></xsl:variable>
	<xsl:variable name="Constitution_Code" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Constitution_Code']"></xsl:variable>
	<!-- Changes for call id 451066 ends here -->
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
    <link rel="stylesheet" type="text/css" href="../Branding/css/common/SRMTableDisplay_{$locale}.css"/>
<!--Performance-->
<!--    <script type="text/javascript" src="../common/html/utils.js" language="javascript"></script>
    <script type="text/javascript" src="../common/js/MLValidate.js" language="javascript"></script>
    <script type="text/javascript" src="../common/html/validate.js" language="javascript"></script>-->
   <!--Performance--> 
	<script type="text/javascript" src="../common/js/SRMTableRowColor.js" language="javascript"></script>
 <!--Performance-->
<!-- <script type="text/javascript" src="../common/html/validateL2.js" language="javascript"></script>-->
<!--Performance-->
 <script type="text/javascript" src="../cif/js/Message_cif_{$locale}.js" language="javascript"></script>
    <!-- changes for tracker no 113227 start -->
    <script type="text/javascript" src="../common/js/SRMFormToggle.js"></script>  
    <!-- changes for tracker no 113227  end -->
    <script type="text/javascript" src="../cif/js/CheckBSNFlags.js" language="javascript"></script>
    <script type="text/javascript" src="../Customization/cif/js/EquityProcessCustom.js" language="javascript"></script>
    <script type="text/javascript" language="javascript">
	var AddressID = "";
	var boName = '<xsl:value-of select="$boName"/>';
	var apprFlag = '<xsl:value-of select="$apprFlag"/>';
	/* changes for ticket 305918 start */
	var BlackListed = '<xsl:value-of select="$BlackListed"/>';
	var Suspended = '<xsl:value-of select="$Suspended"/>';
	var chkBSNFlg = '<xsl:value-of select="$chkBSN"/>';
	var Negated =  '<xsl:value-of select="$Negated"/>';
	/* changes for ticket 305918 end */
	function load()
	{ 	<!--Tracker id 113227 start here-->  
 		document.frm2.altLocaleActv.value='<xsl:value-of select="$altLocaleActv"/>';
 		<!--Tracker id 113227 end here--> 
		try{
		     customLoad();
		}catch(e)
		{ }
		try
		{
			// sanity Fix : for enabling button
			var obj = parent.parent.parent.parent.frames(3);
			obj.enableButton_Ub(); 	
			
			if(boName == 'AccountBO')
			{
			      document.getElementsByName("mandStarShortName")[0].style.visibility="visible";
      			      document.getElementsByName("mandStarPreferredName")[0].style.visibility="visible";
			}
			else if(boName == 'SuspectBO')
			{
			      document.getElementsByName("mandStarShortName")[0].style.visibility="hidden";
      			      document.getElementsByName("mandStarPreferredName")[0].style.visibility="hidden";
			}
		}
		catch(e){
			/* Tracker 121662 Changes Start */
			//alert("error in Rachit function"+e.getMessage);
			/* Tracker 121662 Changes End */
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

	function save(blFlag)
	{
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
		var chkStat = parent.parent.parent.parent.ValidateFormContents(document.frm2,false);
		if (chkStat != "true")
			  return 'interactive';	
		//Changes for tracker ID 431151 start
<!-- Changes for 451067 starts  -->
	try{
			if(boName=="AccountBO")
			{
				document.frm2.lastName.value = document.getElementsByName(boName+".Cust_Last_Name")[0].value;
				document.frm2.firstName.value = document.getElementsByName(boName+".Cust_First_Name")[0].value;
				document.frm2.shortName.value = document.getElementsByName("ShortName")[0].value;
				if(document.getElementsByName("NativeShortName")[0] != undefined)
				{
					document.frm2.natShortName.value = document.getElementsByName("NativeShortName")[0].value;
					document.frm2.natShortName1.value = document.getElementsByName("NativeShortName1")[0].value;
				}
				document.frm2.additionalName.value = document.getElementsByName("AdditionalName")[0].value;
				document.frm2.nameSuffix.value = document.getElementsByName("NameSuffix")[0].value;
				document.frm2.maidenName.value = document.getElementsByName("MaidenName")[0].value;
				document.frm2.previousName.value = document.getElementsByName("PreviousName")[0].value;
				document.frm2.nickName.value = document.getElementsByName("NickName")[0].value;
				document.frm2.preferredName.value = document.getElementsByName("PreferredName")[0].value;
			}
		/*else{
		document.frm2.lastName.value = document.getElementsByName("LastName")[0].value;
		document.frm2.lastName.value = document.getElementsByName("FirstName")[0].value;
		}*/
		
			if(boName=="SuspectBO")
			{
				document.frm2.lastName.value = document.getElementsByName("LastName")[0].value;
				document.frm2.firstName.value = document.getElementsByName("FirstName")[0].value;
				document.frm2.shortName.value = document.getElementsByName("ShortName")[0].value;
				if(document.getElementsByName("NativeShortName")[0] != undefined)
				{
					document.frm2.natShortName.value = document.getElementsByName("NativeShortName")[0].value;
					document.frm2.natShortName1.value = document.getElementsByName("NativeShortName1")[0].value;
				}
			document.frm2.additionalName.value = document.getElementsByName("AdditionalName")[0].value;
			document.frm2.nameSuffix.value = document.getElementsByName("NameSuffix")[0].value;
			document.frm2.previousName.value = document.getElementsByName("PreviousName")[0].value;
			document.frm2.nickName.value = document.getElementsByName("NickName")[0].value;
			document.frm2.preferredName.value = document.getElementsByName("PreferredName")[0].value;
		}
		if(boName=="ContactBO")
		{
			//Changes for ticket 717261 begin
			document.frm2.lastName.value = document.getElementsByName("LastName")[0].value;
			//Changes for ticket 717261 ends
			document.frm2.firstName.value = document.getElementsByName("FirstName")[0].value;
			document.frm2.additionalName.value = document.getElementsByName("AdditionalName")[0].value;
			document.frm2.nameSuffix.value = document.getElementsByName("NameSuffix")[0].value;
			document.frm2.maidenName.value = document.getElementsByName("MaidenName")[0].value;
			document.frm2.preferredName.value = document.getElementsByName("PreferredName")[0].value;
		}
		if(boName=="NonCustomerBO")
		{
			document.frm2.lastName.value = document.getElementsByName("LastName")[0].value;
			document.frm2.firstName.value  = document.getElementsByName("FirstName")[0].value;
			
		}
		
			document.frm2.middleName.value = document.getElementsByName("MiddleName")[0].value;
			document.frm2.natLastName.value = document.getElementsByName("NativeLastName")[0].value;
			document.frm2.natMiddleName.value = document.getElementsByName("NativeMiddleName")[0].value;
			document.frm2.natFirstName.value = document.getElementsByName("NativeFirstName")[0].value;
			document.frm2.natLastName1.value = document.getElementsByName("NativeLastName1")[0].value;
			document.frm2.natMiddleName1.value = document.getElementsByName("NativeMiddleName1")[0].value;
			document.frm2.natFirstName1.value = document.getElementsByName("NativeFirstName1")[0].value;
		}
		catch(e){
					
		}
		<!-- Changes for 449696 ends  -->
		
		
		//Changes for tracker ID 431151 end
		
		
		

		document.frm2.action="../servlet/com.infy.cis.ui.cif.QuickEntityWriter";
		document.frm2.target="formSaveFrame";
		document.frm2.submit();
		return "true";
	}
	function clear() {
	}
	function resubmit(){
		parent.parent.parent.parent.parent.parent.frames(0).submit();
	}
	function closebtn(){
			top.window.close();
	}
	function selectProcess()
	{
		submit = true;	
		var entityType = "";
		var accountId=0;
		entityId  = parent.formSaveFrame.savedValue;
		entityType  = parent.formSaveFrame.entityType;
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
    function check(Tab,setFlag){
	        if(setFlag == false) {
			noValidationMsg = true;
		}
		else {
			noValidationMsg = false;
		}
	        return parent.parent.parent.parent.ValidateFormContents(document.frm2,true,noValidationMsg,Tab);
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
        <table width="100%" cellpadding="0" cellspacing="0" border="0"  align="center">
            <xsl:apply-templates select="SRM"/>
        </table>
        <BR/>
    </body>
    </html>
    </xsl:template>
	<!--   AccountBO template Definition :Start -->
	    <xsl:template name="AccountBO.LastName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='LastName']"/>
						<!-- Comment corrected for Call id: 660145 starts -->
                           <xsl:with-param name="ele_name">AccountBO.Cust_Last_Name</xsl:with-param> 
                        <!-- Comment corrected for Call id: 660145 ends -->

			
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_Last_Name</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
	   <!--TrackerID: 113227 start of changes -->
	    <xsl:template name="AccountBO.Cust_Last_Name_alt1">
	   		<xsl:call-template name="label_alternate">
	   			<xsl:with-param name="res_name" select="$configLabels[@name='LastName']"/>
	   			<xsl:with-param name="ele_name">AccountBO.Cust_Last_Name_alt1</xsl:with-param>
	   			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_Last_Name_alt1</xsl:with-param>
	   			<xsl:with-param name="max_length">80</xsl:with-param>
	   	        </xsl:call-template>
	   </xsl:template>
	   <!--TrackerID: 113227 end of changes -->
  	   <xsl:template name="AccountBO.MiddleName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='MiddleName']"/>
			<xsl:with-param name="ele_name">MiddleName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_Middle_Name</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
	   <!--TrackerID: 113227 start of changes -->
	   <xsl:template name="AccountBO.Cust_Middle_Name_alt1">
	   		<xsl:call-template name="label_alternate">
	   			<xsl:with-param name="res_name" select="$configLabels[@name='MiddleName']"/>
	   			<xsl:with-param name="ele_name">AccountBO.Cust_Middle_Name_alt1</xsl:with-param>
	   			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_Middle_Name_alt1</xsl:with-param>
	   			<xsl:with-param name="max_length">80</xsl:with-param>
	   	        </xsl:call-template>
	   </xsl:template>
	   <!--TrackerID: 113227 end of changes -->
  	   <xsl:template name="AccountBO.FirstName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='FirstName']"/>
						<!-- Comment corrected for Call id: 660145 starts -->
                           <xsl:with-param name="ele_name">AccountBO.Cust_First_Name</xsl:with-param> 
                        <!-- Comment corrected for Call id: 660145 ends -->

			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_First_Name</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
	   <!--TrackerID: 113227 start of changes -->
	   <xsl:template name="AccountBO.Cust_First_Name_alt1">
	   		<xsl:call-template name="label_alternate">
	   			<xsl:with-param name="res_name" select="$configLabels[@name='FirstName']"/>
	   			<xsl:with-param name="ele_name">AccountBO.Cust_First_Name_alt1</xsl:with-param>
	   			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_First_Name_alt1</xsl:with-param>
	   			<xsl:with-param name="max_length">80</xsl:with-param>
	   	        </xsl:call-template>
	   </xsl:template>
	   <!--TrackerID: 113227 end of changes -->
  	   <xsl:template name="AccountBO.AdditionalName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='AdditionalName']"/>
			<xsl:with-param name="ele_name">AdditionalName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.strField6</xsl:with-param>
			<xsl:with-param name="max_length">50</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="AccountBO.NameSuffix">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NameSuffix']"/>
			<xsl:with-param name="ele_name">NameSuffix</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.NameSuffix</xsl:with-param>
			<xsl:with-param name="max_length">25</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="AccountBO.MaidenName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='MaidenName']"/>
			<xsl:with-param name="ele_name">MaidenName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.maidenName</xsl:with-param>
			<xsl:with-param name="max_length">50</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="AccountBO.PreviousName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='PreviousName']"/>
			<xsl:with-param name="ele_name">PreviousName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.previous_name</xsl:with-param>
			<xsl:with-param name="max_length">20</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="AccountBO.ShortName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='ShortName']"/>
			<xsl:with-param name="ele_name">ShortName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.short_name</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
			<xsl:with-param name="max_length">10</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="AccountBO.NickName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NickName']"/>
			<xsl:with-param name="ele_name">NickName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.nick_name</xsl:with-param>
			<xsl:with-param name="max_length">10</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="AccountBO.PreferredName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='PreferredName']"/>
			<xsl:with-param name="ele_name">PreferredName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.PreferredName</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
			<xsl:with-param name="max_length">50</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="AccountBO.NativeFirstName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NativeFirstName']"/>
			<xsl:with-param name="ele_name">NativeFirstName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_First_Name_Native</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="AccountBO.NativeLastName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NativeLastName']"/>
			<xsl:with-param name="ele_name">NativeLastName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_Last_Name_Native</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="AccountBO.NativeMiddleName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NativeMiddleName']"/>
			<xsl:with-param name="ele_name">NativeMiddleName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_Middle_Name_Native</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="AccountBO.NativeShortName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NativeShortName']"/>
			<xsl:with-param name="ele_name">NativeShortName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Short_Name_Native</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
			<xsl:with-param name="max_length">10</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="AccountBO.NativeLastName1">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NativeLastName1']"/>
			<xsl:with-param name="ele_name">NativeLastName1</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_Last_Name_Native1</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="AccountBO.NativeFirstName1">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NativeFirstName1']"/>
			<xsl:with-param name="ele_name">NativeFirstName1</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_First_Name_Native1</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="AccountBO.NativeMiddleName1">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NativeMiddleName1']"/>
			<xsl:with-param name="ele_name">NativeMiddleName1</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Cust_Middle_Name_Native1</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="AccountBO.NativeShortName1">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NativeShortName1']"/>
			<xsl:with-param name="ele_name">NativeShortName1</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Short_Name_Native1</xsl:with-param>
			<xsl:with-param name="max_length">10</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
	  <!--   AccountBO template Definition : End-->
   	  <!--   ContactBO template Definition :Start -->
	    <xsl:template name="ContactBO.LastName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='LastName']"/>
			<xsl:with-param name="ele_name">LastName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.lastName</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="ContactBO.MiddleName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='MiddleName']"/>
			<xsl:with-param name="ele_name">MiddleName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.middleName</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="ContactBO.FirstName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='FirstName']"/>
			<xsl:with-param name="ele_name">FirstName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.firstName</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
	    <!--TrackerID: 113227 start of changes -->   
	   <xsl:template name="ContactBO.lastName_alt1">
	     		<xsl:call-template name="label_alternate">
	     			<xsl:with-param name="res_name" select="$configLabels[@name='LastName']"/>
	     			<xsl:with-param name="ele_name">ContactBO.lastName_alt1</xsl:with-param>
	     			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.lastName_alt1</xsl:with-param>
	     			<xsl:with-param name="max_length">80</xsl:with-param>
	     	        </xsl:call-template>
	     	   </xsl:template>
	       	   <xsl:template name="ContactBO.middleName_alt1">
	     		<xsl:call-template name="label_alternate">
	     			<xsl:with-param name="res_name" select="$configLabels[@name='MiddleName']"/>
	     			<xsl:with-param name="ele_name">ContactBO.middleName_alt1</xsl:with-param>
	     			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.middleName_alt1</xsl:with-param>
	     			<xsl:with-param name="max_length">80</xsl:with-param>
	     	        </xsl:call-template>
	     	   </xsl:template>
	       	   <xsl:template name="ContactBO.firstName_alt1">
	     		<xsl:call-template name="label_alternate">
	     			<xsl:with-param name="res_name" select="$configLabels[@name='FirstName']"/>
	     			<xsl:with-param name="ele_name">ContactBO.firstName_alt1</xsl:with-param>
	     			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.firstName_alt1</xsl:with-param>
	     			<xsl:with-param name="max_length">80</xsl:with-param>
	     	        </xsl:call-template>
	   </xsl:template>
	   <!--TrackerID: 113227 end of changes -->
  	   <xsl:template name="ContactBO.AdditionalName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='AdditionalName']"/>
			<xsl:with-param name="ele_name">AdditionalName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.strField6</xsl:with-param>
			<xsl:with-param name="max_length">50</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="ContactBO.NameSuffix">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NameSuffix']"/>
			<xsl:with-param name="ele_name">NameSuffix</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.nameSuffix</xsl:with-param>
			<xsl:with-param name="max_length">25</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="ContactBO.MaidenName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='MaidenName']"/>
			<xsl:with-param name="ele_name">MaidenName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.maidenName</xsl:with-param>
			<xsl:with-param name="max_length">50</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="ContactBO.PreferredName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='PreferredName']"/>
			<xsl:with-param name="ele_name">PreferredName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.PreferredName</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
			<xsl:with-param name="max_length">50</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="ContactBO.NativeFirstName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NativeFirstName']"/>
			<xsl:with-param name="ele_name">NativeFirstName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Contact_First_Name_Native</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="ContactBO.NativeLastName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NativeLastName']"/>
			<xsl:with-param name="ele_name">NativeLastName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Contact_Last_Name_Native</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="ContactBO.NativeMiddleName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NativeMiddleName']"/>
			<xsl:with-param name="ele_name">NativeMiddleName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Contact_Middle_Name_Native</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="ContactBO.NativeLastName1">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NativeLastName1']"/>
			<xsl:with-param name="ele_name">NativeLastName1</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Contact_Last_Name_Native1</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="ContactBO.NativeFirstName1">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NativeFirstName1']"/>
			<xsl:with-param name="ele_name">NativeFirstName1</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Contact_First_Name_Native1</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="ContactBO.NativeMiddleName1">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NativeMiddleName1']"/>
			<xsl:with-param name="ele_name">NativeMiddleName1</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Contact_Middle_Name_Native1</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
      	  <!--   ContactBO template Definition :End -->
      	  <!--   SuspectBO template Definition Start -->
	    <xsl:template name="SuspectBO.LastName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='LastName']"/>
			<xsl:with-param name="ele_name">LastName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.lastName</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="SuspectBO.MiddleName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='MiddleName']"/>
			<xsl:with-param name="ele_name">MiddleName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiddleName</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="SuspectBO.FirstName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='FirstName']"/>
			<xsl:with-param name="ele_name">FirstName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.firstName</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="SuspectBO.AdditionalName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='AdditionalName']"/>
			<xsl:with-param name="ele_name">AdditionalName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.strField6</xsl:with-param>
			<xsl:with-param name="max_length">50</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="SuspectBO.NameSuffix">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NameSuffix']"/>
			<xsl:with-param name="ele_name">NameSuffix</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.nameSuffix</xsl:with-param>
			<xsl:with-param name="max_length">25</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="SuspectBO.MaidenName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='MaidenName']"/>
			<xsl:with-param name="ele_name">SuspectBO.MaidenName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.maidenName</xsl:with-param>
			<xsl:with-param name="max_length">50</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="SuspectBO.PreviousName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='PreviousName']"/>
			<xsl:with-param name="ele_name">PreviousName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.previous_name</xsl:with-param>
			<xsl:with-param name="max_length">20</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="SuspectBO.ShortName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='ShortName']"/>
			<xsl:with-param name="ele_name">ShortName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.short_name</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
			<xsl:with-param name="max_length">10</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="SuspectBO.NickName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NickName']"/>
			<xsl:with-param name="ele_name">NickName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.nick_name</xsl:with-param>
			<xsl:with-param name="max_length">10</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="SuspectBO.PreferredName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='PreferredName']"/>
			<xsl:with-param name="ele_name">PreferredName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.PreferredName</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
			<xsl:with-param name="max_length">50</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="SuspectBO.NativeFirstName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NativeFirstName']"/>
			<xsl:with-param name="ele_name">NativeFirstName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.FirstName_Native</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="SuspectBO.NativeLastName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NativeLastName']"/>
			<xsl:with-param name="ele_name">NativeLastName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.LastName_Native</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="SuspectBO.NativeMiddleName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NativeMiddleName']"/>
			<xsl:with-param name="ele_name">NativeMiddleName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiddleName_Native</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="SuspectBO.NativeShortName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NativeShortName']"/>
			<xsl:with-param name="ele_name">NativeShortName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Short_Name_Native</xsl:with-param>
			<xsl:with-param name="max_length">10</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="SuspectBO.NativeLastName1">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NativeLastName1']"/>
			<xsl:with-param name="ele_name">NativeLastName1</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.LastName_Native1</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="SuspectBO.NativeFirstName1">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NativeFirstName1']"/>
			<xsl:with-param name="ele_name">NativeFirstName1</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.FirstName_Native1</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="SuspectBO.NativeMiddleName1">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NativeMiddleName1']"/>
			<xsl:with-param name="ele_name">NativeMiddleName1</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiddleName_Native1</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="SuspectBO.NativeShortName1">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NativeShortName1']"/>
			<xsl:with-param name="ele_name">NativeShortName1</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Short_Name_Native1</xsl:with-param>
			<xsl:with-param name="max_length">10</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
	   <!--TrackerID: 113227 start of changes -->
	   	        
	     <xsl:template name="SuspectBO.MiddleName_alt1">
			<xsl:call-template name="label_alternate">
			 <xsl:with-param name="res_name" select="$configLabels[@name='MiddleName']"/>
			 <xsl:with-param name="ele_name">SuspectBO.MiddleName_alt1</xsl:with-param>               
			 <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiddleName_alt1</xsl:with-param>
			 <xsl:with-param name="max_length">50</xsl:with-param>
			</xsl:call-template>
	    </xsl:template>

	    <xsl:template name="SuspectBO.lastName_alt1">
			  <xsl:call-template name="label_alternate">
				  <xsl:with-param name="res_name" select="$configLabels[@name='LastName']"/>                
				  <xsl:with-param name="ele_name">SuspectBO.lastName_alt1</xsl:with-param>
				  <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.lastName_alt1</xsl:with-param>
				  <xsl:with-param name="max_length">50</xsl:with-param>
			  </xsl:call-template>
	   </xsl:template>

	     

	     <xsl:template name="SuspectBO.firstName_alt1">
		       <xsl:call-template name="label_alternate">
		       <xsl:with-param name="res_name" select="$configLabels[@name='FirstName']"/>
			<xsl:with-param name="ele_name">SuspectBO.firstName_alt1</xsl:with-param>	               
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.firstName_alt1</xsl:with-param>
			<xsl:with-param name="max_length">50</xsl:with-param>
		      </xsl:call-template>
      	 </xsl:template>
      	 <xsl:template name="SuspectBO.short_name_alt1">
      		<xsl:call-template name="label_alternate">
      			<xsl:with-param name="res_name" select="$configLabels[@name='ShortName']"/>
      			<xsl:with-param name="ele_name">SuspectBO.short_name_alt1</xsl:with-param>
      			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.short_name_alt1</xsl:with-param>
      			<xsl:with-param name="starshow">true</xsl:with-param>
      			<xsl:with-param name="max_length">10</xsl:with-param>
      	        </xsl:call-template>
	   </xsl:template>
	   <!--TrackerID: 113227 end of changes -->
	  
      	  <!--   SuspectBO template Definition End -->
      	  <!--   SuspectBO template Definition Start -->
	    <xsl:template name="NonCustomerBO.LastName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='LastName']"/>
			<xsl:with-param name="ele_name">LastName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Last_Name</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="NonCustomerBO.MiddleName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='MiddleName']"/>
			<xsl:with-param name="ele_name">MiddleName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Middle_Name</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="NonCustomerBO.FirstName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='FirstName']"/>
			<xsl:with-param name="ele_name">FirstName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.First_Name</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="NonCustomerBO.NativeFirstName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NativeFirstName']"/>
			<xsl:with-param name="ele_name">NativeFirstName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.First_Name_Native</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="NonCustomerBO.NativeLastName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NativeLastName']"/>
			<xsl:with-param name="ele_name">NativeLastName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Last_Name_Native</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="NonCustomerBO.NativeMiddleName">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NativeMiddleName']"/>
			<xsl:with-param name="ele_name">NativeMiddleName</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Middle_Name_Native</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="NonCustomerBO.NativeLastName1">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NativeLastName1']"/>
			<xsl:with-param name="ele_name">NativeLastName1</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Last_Name_Native1</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="NonCustomerBO.NativeFirstName1">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NativeFirstName1']"/>
			<xsl:with-param name="ele_name">NativeFirstName1</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.First_Name_Native1</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
  	   <xsl:template name="NonCustomerBO.NativeMiddleName1">
		<xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='NativeMiddleName1']"/>
			<xsl:with-param name="ele_name">NativeMiddleName1</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Middle_Name_Native1</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
	        </xsl:call-template>
	   </xsl:template>
	   <!--TrackerID: 113227 start of changes -->
	    <xsl:template name="NonCustomerBO.Last_Name_alt1">
		<xsl:call-template name="label_alternate">
			<xsl:with-param name="res_name" select="$configLabels[@name='LastName']"/>
			<xsl:with-param name="ele_name">NonCustomerBO.Last_Name_alt1</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Last_Name_alt1</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
		</xsl:call-template>
	   </xsl:template>
	   <xsl:template name="NonCustomerBO.Middle_Name_alt1">
		<xsl:call-template name="label_alternate">
			<xsl:with-param name="res_name" select="$configLabels[@name='MiddleName']"/>
			<xsl:with-param name="ele_name">NonCustomerBO.Middle_Name_alt1</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Middle_Name_alt1</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
		</xsl:call-template>
	   </xsl:template>
	   <xsl:template name="NonCustomerBO.First_Name_alt1">
		<xsl:call-template name="label_alternate">
			<xsl:with-param name="res_name" select="$configLabels[@name='FirstName']"/>
			<xsl:with-param name="ele_name">NonCustomerBO.First_Name_alt1</xsl:with-param>
			<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.First_Name_alt1</xsl:with-param>
			<xsl:with-param name="max_length">80</xsl:with-param>
		</xsl:call-template>
	   </xsl:template>	   
	   <!--TrackerID: 113227 end of changes -->
      	  <!--   NonCustomerBO template Definition End -->
    <xsl:template match="*" mode="mode1">
        <form name="frm2"  method="post" action="">
	    <xsl:choose>
		<xsl:when test="$boName='AccountBO'">
			<xsl:call-template name="Begin"/>
			    <xsl:call-template name="AccountBO.LastName"/>
   			    <xsl:call-template name="AccountBO.MiddleName"/>
			<xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
    			    <xsl:call-template name="AccountBO.FirstName"/>
 			    <xsl:call-template name="AccountBO.AdditionalName"/>
		        <xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
    			    <xsl:call-template name="AccountBO.NameSuffix"/>
 			    <xsl:call-template name="AccountBO.MaidenName"/>
		        <xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
    			    <xsl:call-template name="AccountBO.PreviousName"/>
 			    <xsl:call-template name="AccountBO.ShortName"/>
		        <xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
    			    <xsl:call-template name="AccountBO.NickName"/>
 			    <xsl:call-template name="AccountBO.PreferredName"/>
		        <xsl:call-template name="End"/>
			<tr>
			 <td colspan = "5" NOWRAP="true" class="LabelFont">
			<xsl:value-of select="$configLabels[@name='NativeLingualFields']/@configLabel"/>
			</td></tr>
			<xsl:call-template name="Begin"/>
    			    <xsl:call-template name="AccountBO.NativeLastName"/>
 			    <xsl:call-template name="AccountBO.NativeFirstName"/>
		        <xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
    			    <xsl:call-template name="AccountBO.NativeMiddleName"/>
 			    <xsl:call-template name="AccountBO.NativeShortName"/>
		        <xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
    			    <xsl:call-template name="AccountBO.NativeLastName1"/>
 			    <xsl:call-template name="AccountBO.NativeFirstName1"/>
		        <xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
    			    <xsl:call-template name="AccountBO.NativeMiddleName1"/>
 			    <xsl:call-template name="AccountBO.NativeShortName1"/>
		        <xsl:call-template name="End"/>
		        <!-- TrackerID: 113227 start of changes-->
			   <xsl:choose>
				<xsl:when test="normalize-space($altLocaleActv)='true'">
				
				<xsl:variable name="DUAL"><xsl:value-of select="$configLabels[@name='Details in Alternate Language']/@configLabel"/></xsl:variable>
				
					<table  bgcolor='FFFFFF' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
						<tr style="cursor:hand" STYLE="border-bottom: 10px black;" ID="rowdual" name="rowdual">
						<xsl:attribute name="oncontextmenu">setClickedArea();doContextMenu();</xsl:attribute>
						<td onclick="Toggle('dual','all');" colspan = "5" NOWRAP="true" class="LabelFont">
					     	<A HREF="javascript:Toggle('DUAL','all');"><IMG onclick="Toggle('dual','all');" SRC="../reports/images/minus.gif" ID="dualgif"
					      	BORDER="0" ALIGN="absmiddle" HEIGHT="12" WIDTH="12" HSPACE="3" VSPACE="4"/></A>
					     	<label FOR="CPD" class="LabelFont"><xsl:value-of select="$DUAL"/>
					     	</label>
						</td>
						</tr>
					</table>
				
					<DIV ID = 'native' STYLE= 'visibility:visible;'>
			
				 		<table  bgcolor='FFFFFF' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" > 
			
							<TR ID='rowdual' name='rowdual'>
								<xsl:call-template name="AccountBO.Cust_Last_Name_alt1">
								</xsl:call-template>
			
								<xsl:call-template name="AccountBO.Cust_First_Name_alt1">
								</xsl:call-template>
							</TR>
			
							<TR ID='rowdual' name='rowdual'>
								<xsl:call-template name="AccountBO.Cust_Middle_Name_alt1">
								</xsl:call-template>
							</TR>
					
						</table>
				    </DIV>
		</xsl:when>
			
			  </xsl:choose>							
		<!-- TrackerID: 113227 end of changes-->	
		</xsl:when>
		<xsl:when test="$boName='ContactBO'">
			<xsl:call-template name="Begin"/>
			    <xsl:call-template name="ContactBO.LastName"/>
   			    <xsl:call-template name="ContactBO.MiddleName"/>
			<xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
    			    <xsl:call-template name="ContactBO.FirstName"/>
 			    <xsl:call-template name="ContactBO.AdditionalName"/>
		        <xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
    			    <xsl:call-template name="ContactBO.NameSuffix"/>
 			    <xsl:call-template name="ContactBO.MaidenName"/>
		        <xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
 			    <xsl:call-template name="ContactBO.PreferredName"/>
		        <xsl:call-template name="End"/>
			<tr>
			<td colspan = "5" NOWRAP="true" class="LabelFont">
			<xsl:value-of select="$configLabels[@name='NativeLingualFields']/@configLabel"/>
			</td></tr>
			<xsl:call-template name="Begin"/>
    			    <xsl:call-template name="ContactBO.NativeLastName"/>
 			    <xsl:call-template name="ContactBO.NativeFirstName"/>
		        <xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
    			    <xsl:call-template name="ContactBO.NativeMiddleName"/>
		        <xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
    			    <xsl:call-template name="ContactBO.NativeLastName1"/>
 			    <xsl:call-template name="ContactBO.NativeFirstName1"/>
		        <xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
    			    <xsl:call-template name="ContactBO.NativeMiddleName1"/>
		        <xsl:call-template name="End"/>
			 <!-- TrackerID: 113227 start of changes-->
			   <xsl:choose>
				<xsl:when test="normalize-space($altLocaleActv)='true'">

				<xsl:variable name="DUAL"><xsl:value-of select="$configLabels[@name='Details in Alternate Language']/@configLabel"/></xsl:variable>

					<table  bgcolor='FFFFFF' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
						<tr style="cursor:hand" STYLE="border-bottom: 10px black;" ID="rowdual" name="rowdual">
						<xsl:attribute name="oncontextmenu">setClickedArea();doContextMenu();</xsl:attribute>
						<td onclick="Toggle('dual','all');" colspan = "5" NOWRAP="true" class="LabelFont">
						<A HREF="javascript:Toggle('DUAL','all');"><IMG onclick="Toggle('dual','all');" SRC="../reports/images/minus.gif" ID="dualgif"
						BORDER="0" ALIGN="absmiddle" HEIGHT="12" WIDTH="12" HSPACE="3" VSPACE="4"/></A>
						<label FOR="CPD" class="LabelFont"><xsl:value-of select="$DUAL"/>
						</label>
						</td>
						</tr>
					</table>

					<DIV ID = 'native' STYLE= 'visibility:visible;'>

						<table  bgcolor='FFFFFF' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" > 

							<TR ID='rowdual' name='rowdual'>
								<xsl:call-template name="ContactBO.firstName_alt1">
								</xsl:call-template>
								<xsl:call-template name="ContactBO.lastName_alt1">
								</xsl:call-template>
							</TR>
							<TR ID='rowdual' name='rowdual'>
								<xsl:call-template name="ContactBO.middleName_alt1">
								</xsl:call-template>

							</TR>

						</table>
				      </DIV>
		</xsl:when>
			  </xsl:choose>			 						
		    <!-- TrackerID: 113227 end of changes-->	
		 </xsl:when>
		<xsl:when test="$boName='NonCustomerBO'">
			<xsl:call-template name="Begin"/>
			    <xsl:call-template name="NonCustomerBO.LastName"/>
   			    <xsl:call-template name="NonCustomerBO.MiddleName"/>
			<xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
    			    <xsl:call-template name="NonCustomerBO.FirstName"/>
		        <xsl:call-template name="End"/>
			<tr>
			<td colspan = "5" NOWRAP="true" class="LabelFont">
			<xsl:value-of select="$configLabels[@name='NativeLingualFields']/@configLabel"/>
			</td></tr>
			<xsl:call-template name="Begin"/>
    			    <xsl:call-template name="NonCustomerBO.NativeLastName"/>
 			    <xsl:call-template name="NonCustomerBO.NativeFirstName"/>
		        <xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
    			    <xsl:call-template name="NonCustomerBO.NativeMiddleName"/>
		        <xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
    			    <xsl:call-template name="NonCustomerBO.NativeLastName1"/>
 			    <xsl:call-template name="NonCustomerBO.NativeFirstName1"/>
		        <xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
    			    <xsl:call-template name="NonCustomerBO.NativeMiddleName1"/>
		        <xsl:call-template name="End"/>
			<!--TrackerID: 113227  Alternate Fields Call here -->
			
			<xsl:choose>
				<xsl:when test="normalize-space($altLocaleActv)='true'">

					<xsl:variable name="DUAL"><xsl:value-of select="$configLabels[@name='Details in Alternate Language']/@configLabel"/></xsl:variable>
					 <tr style="cursor:hand" STYLE="border-bottom: 10px black;" ID="rowdual" name="rowdual">
						<xsl:attribute name="oncontextmenu">setClickedArea();doContextMenu();</xsl:attribute>
					  <td onclick="Toggle('dual','all');" colspan = "5" NOWRAP="true" class="LabelFont">
					   <A HREF="javascript:Toggle('dual','all');"><IMG onclick="Toggle('dual','all');" SRC="../reports/images/minus.gif" ID="dualgif"
					   BORDER="0" ALIGN="absmiddle" HEIGHT="12" WIDTH="12" HSPACE="3" VSPACE="4"/></A>
					   <label FOR="CPD" class="LabelFont"><xsl:value-of select="$DUAL"/>
					   </label>
					  </td>
					</tr>

					<DIV ID = 'dual' STYLE= 'visibility:visible;'>

					<TR ID='rowdual' name='rowdual'>
						<xsl:call-template name="NonCustomerBO.Last_Name_alt1">
						</xsl:call-template>

						<xsl:call-template name="NonCustomerBO.Middle_Name_alt1">
						</xsl:call-template>
					</TR>
					<TR ID='rowdual' name='rowdual'>
						<xsl:call-template name="NonCustomerBO.First_Name_alt1">
						</xsl:call-template>

					</TR>

					</DIV>
		</xsl:when>
		   </xsl:choose>
		<!--TrackerID: 113227  Alternate Fields call end here-->
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="Begin"/>
			    <xsl:call-template name="SuspectBO.LastName"/>
   			    <xsl:call-template name="SuspectBO.MiddleName"/>
			<xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
    			    <xsl:call-template name="SuspectBO.FirstName"/>
 			    <xsl:call-template name="SuspectBO.AdditionalName"/>
		        <xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
    			    <xsl:call-template name="SuspectBO.NameSuffix"/>
 			    <xsl:call-template name="SuspectBO.MaidenName"/>
		        <xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
    			    <xsl:call-template name="SuspectBO.PreviousName"/>
 			    <xsl:call-template name="SuspectBO.ShortName"/>
		        <xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
    			    <xsl:call-template name="SuspectBO.NickName"/>
 			    <xsl:call-template name="SuspectBO.PreferredName"/>
		        <xsl:call-template name="End"/>
			<tr>
			<td colspan = "5" NOWRAP="true" class="LabelFont">
			<xsl:value-of select="$configLabels[@name='NativeLingualFields']/@configLabel"/>
			</td></tr>
			<xsl:call-template name="Begin"/>
    			    <xsl:call-template name="SuspectBO.NativeLastName"/>
 			    <xsl:call-template name="SuspectBO.NativeFirstName"/>
		        <xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
    			    <xsl:call-template name="SuspectBO.NativeMiddleName"/>
 			    <xsl:call-template name="SuspectBO.NativeShortName"/>
		        <xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
    			    <xsl:call-template name="SuspectBO.NativeLastName1"/>
 			    <xsl:call-template name="SuspectBO.NativeFirstName1"/>
		        <xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
    			    <xsl:call-template name="SuspectBO.NativeMiddleName1"/>
 			    <xsl:call-template name="SuspectBO.NativeShortName1"/>
		        <xsl:call-template name="End"/>
		       <!-- TrackerID: 113227 Begin of Changes-->
			   <xsl:choose>
				<xsl:when test="normalize-space($altLocaleActv)='true'">
				 	
				 	<xsl:variable name="DUAL"><xsl:value-of select="$configLabels[@name='Details in Alternate Language']/@configLabel"/></xsl:variable>
				 		<tr style="cursor:hand" STYLE="border-bottom: 10px black;" ID="rowdual" name="rowdual">
				 		<xsl:attribute name="oncontextmenu">setClickedArea();doContextMenu();</xsl:attribute>
				 		<td onclick="Toggle('dual','all');" colspan = "5" NOWRAP="true" class="LabelFont">
				 		     <A HREF="javascript:Toggle('DUAL','all');"><IMG onclick="Toggle('dual','all');" SRC="../reports/images/minus.gif" ID="dualgif"
				 		      BORDER="0" ALIGN="absmiddle" HEIGHT="12" WIDTH="12" HSPACE="3" VSPACE="4"/></A>
				 		     <label FOR="CPD" class="LabelFont"><xsl:value-of select="$DUAL"/>
				 		     </label>
				 		</td>
				 		</tr>
				 	
				 	<DIV ID = 'native' STYLE= 'visibility:visible;'>	 	 
				 
				 	   <TR ID='rowdual' name='rowdual'>
						<xsl:call-template name="SuspectBO.lastName_alt1">
						</xsl:call-template>
						<xsl:call-template name="SuspectBO.MiddleName_alt1">
						</xsl:call-template>
					 </TR>
					 <TR ID='rowdual' name='rowdual'>
						<xsl:call-template name="SuspectBO.firstName_alt1">
						</xsl:call-template>
						
						
					 </TR>
				 	 <TR ID='rowdual' name='rowdual'>
						<xsl:call-template name="SuspectBO.short_name_alt1">
						</xsl:call-template>
					
					 </TR>
				 	 
				   </DIV>
				</xsl:when>
				 	
			  </xsl:choose>
			 <!-- TrackerID: 113227 End of Changes--> 		       	        
		</xsl:otherwise>
	    </xsl:choose>	

			<input type="hidden" name="accountID" value="{$accountID}"/>
			<input type="hidden" name="hid_entityURL" value="{$entityURL}"/>
			<!-- Hidden variables for Name tab Start-->
			<input type="hidden" name="lastName" value=""/>
			<input type="hidden" name="middleName" value=""/>
			<input type="hidden" name="firstName" value=""/>
			<input type="hidden" name="shortName" value=""/>
			<input type="hidden" name="natLastName" value=""/>
			<input type="hidden" name="natMiddleName" value=""/>
			<input type="hidden" name="natFirstName" value=""/>
			<input type="hidden" name="natShortName" value=""/>
			<input type="hidden" name="natLastName1" value=""/>
			<input type="hidden" name="natMiddleName1" value=""/>
			<input type="hidden" name="natFirstName1" value=""/>
			<input type="hidden" name="natShortName1" value=""/>
			<input type="hidden" name="additionalName" value=""/>
			<input type="hidden" name="nameSuffix" value=""/>
			<input type="hidden" name="maidenName" value=""/>
			<input type="hidden" name="previousName" value=""/>
			<input type="hidden" name="nickName" value=""/>
			<input type="hidden" name="preferredName" value=""/>
			<!-- Hidden variables for Name tab End-->
			<input type="hidden" name="name" value=""/>
			<input type="hidden" name="quickEditFlag" value="true"/>
			<input type="hidden" name="quickEditType" value="QuickNameSave"/>
			
		        <input type="hidden" name="saveFlag" value=""/>
		        <!-- Changes for call id 451066 starts here -->
		        <input type="hidden" name="Cust_community" value="{$Cust_community}"/>
		        <input type="hidden" name="Constitution_Code" value="{$Constitution_Code}"/>
		        <!-- Changes for call id 451066 ends here -->
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
			<!--Tracker id 113227 changes start-->
			<input type="hidden" name="altLocaleActv" />
 			<!--Tracker id 113227 changes end-->
			
		
			
			
			
			
			
        </form>
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










