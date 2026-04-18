<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--impoting variables wich hold the jvm properties-->
	<xsl:import href="../Renderer/common/display/getJVMProperties.xsl"/>
	<xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"/>
	<xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"/>
	<xsl:import href="../Renderer/common/display/SRMListTemplate.xsl"/>
	<!-- mamta CIF changes for EntitySearch, starts -->
        <xsl:param name="locale"/>
        <!--tracker id 113227 starts-->
        <xsl:param name="altLocaleActv"/>
        <!--tracker id 113227 ends-->
    	<xsl:variable name="currEmpDOJ" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z[@n='CurrEmpDOJ']"></xsl:variable>
  	<!-- CIF changes for EntitySearch, ends -->
	<!--CIF changes:Read Only Mod:Start-->
	<xsl:variable name="readMode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsReadOnly']"/>
	<!--CIF changes:Read Only Mod:End-->
	<!--including file for label names-->
	<xsl:variable name="boName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='boName']"></xsl:variable>
	<xsl:variable name="ProfessionCode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='ProfessionCode']"></xsl:variable>
	<xsl:variable name="Designation" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='DemographicBO.EmploymentHistory.strText8']"></xsl:variable>
	<!-- Fix for Tracker #: SIDDHARTH Begins-->
	    <xsl:variable name="dtValid" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='dtValid']"/>
	<!-- Fix for Tracker #: SIDDHARTH Ends -->
    <xsl:variable name="file1">../Renderer/cif/resource/DemographicEmploymentHistory_<xsl:value-of select="$locale"/>.xml</xsl:variable>
    <!-- Tracker ID :756914 - Chrome Porting Changes -->
    <xsl:variable name="file1XML" select="substring-before(substring-after($file1,'resource/'),'.xml')"/>
	<xsl:variable name="configFile_1" select="SRM"/>
	<xsl:variable name="configLabels" select="$configFile_1/SRMBO/ResourceFile[@filename=$file1XML]/*"/>
<!-- CIF Changes for Caching Views : Start -->
    <xsl:param name="viewname"/>
    <xsl:variable name="PresFileName">../servlet/com.infy.cis.ui.cif.CIF_DetPresCacheServlet?ViewName=<xsl:value-of select="$viewname"/>&amp;Locale=<xsl:value-of select="$locale"/></xsl:variable>
    <!-- Tracker ID :756914 - Chrome Porting Changes -->
    <xsl:variable name="PresFile" select="SRM"/>
    <xsl:variable name="PresData" select="SRM/SRMPresentation"/>
<!-- CIF Changes for Caching Views : End -->
	<xsl:template match="/">
		<html>
		<title><xsl:value-of select="//SRMPresentation/SRMSystem[@n='Strings']/SRMString[@n='Title']/@value"/></title>
		<head>

			<script type="text/javascript" language="javascript">
			  <!-- Fix for Tracker #: SIDDHARTH Begins -->
			    var locDate = '<xsl:value-of select = "$dtValid"/>'
			  <!-- Fix for Tracker #: SIDDHARTH Ends -->
			  <!-- Change for ticket 345829 start -->
			  var currEmpDOJ1='<xsl:value-of select="$currEmpDOJ"/>';
			  <!-- Change for ticket 345829 end -->
			  <!-- Change for ticket 344694 start -->
			  var altLocaleActv = '<xsl:value-of select="$altLocaleActv"/>';
			  var ProfessionCode= '<xsl:value-of select="$ProfessionCode"/>';
			  var Designation = '<xsl:value-of select="$Designation"/>';
			  <!-- Change for ticket 344694 end -->
			</script>

			<link rel="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
			<link rel="stylesheet" Type="text/css" href="../Branding/css/common/PopupMenu_{$locale}.css"/>
			<link rel="stylesheet" type="text/css" href="../Branding/css/common/SRMTableDisplay_{$locale}.css"/>
			<link rel="stylesheet" type="text/css" href="../Branding/css/common/SRMListTemplate_{$locale}.css"/>



		   <script type="text/javascript" language="javascript">

		   <![CDATA[
			    function getCurrEmpDOJ() {
			        var currEmpDOJ=]]>"<xsl:value-of select="$currEmpDOJ"/>"<![CDATA[;
				return currEmpDOJ;
			    }]]>

    		<!--CIF changes:Read Only Mod:Start-->
    		function enableClose(){
			try{
				document.getElementsByName("Close")[0].disabled = false;
			}catch(e){
			}
    		 }
    		 function cancel(){
				/* Changes for ticket 341080 : BEGIN */
				if ( !this.parent.parent.showConfirmMessage(MSG022)) {
					return;
				}
				/* Changes for ticket 341080 : END */
			 try {
			     window.close();
			     window.opener.focus();
			 }catch(e) {
			 }
    		}
        	/*tracker id 157295 changes starts*/   
        	/* Changes made for call id 260080: start */
 		function formatDemoEmpIntField(obj){	
 		/* fix for call id: 305429- START*/
 		/* Changes made for Tracker id: 292151 starts here */
 		/* fix for call id: 305429- END*/
	        var period = document.getElementsByName("DemographicBO.MiscellaneousInfo.strText9")[0].value;
			/* Changes for call id 427282-recon for 425158 Starts */
			/*if (period>100)
			{ showMessage(MSGJ51520);
			  document.getElementsByName("DemographicBO.MiscellaneousInfo.strText9")[0].value="";
			  document.getElementsByName("DemographicBO.MiscellaneousInfo.strText9")[0].focus();
			}*/
			/* Changes for call id 427282-recon for 425158 Ends */
		/* Changes made for Tracker id: 292151 ends here*/ 
    			 if (isNaN(obj.value)) {
				showMessage(MSGJ50161);
			 	obj.value="";
				obj.focus();
				}	
		/*tracker id 157295 changes ends*/
    		}
    		/* Changes made for call id 260080: end */
    		function formatDemoEmpIntFieldRead(){
    			formatInt(document.getElementsByName("DemographicBO.MiscellaneousInfo.strText9")[0],gettingDigitGroupNumber());
    		}

    		<!--CIF changes:Read Only Mod:End-->

 	function SetLocCookies(){

 		onLoadSetLocCookies('DemographicBO.MiscellaneousInfo.strText18','DemographicBO.MiscellaneousInfo.strText19','DemographicBO.MiscellaneousInfo.strText20');
	}
	function setMCAttModifyFlag(){
		document.frm2.isMCEditedDemoEmp.value="Y";
	}

	<!--Tracker:1121611:Changes for focus on first editable field-->

	function focusFirstField()
	{
		try
		{
			//Ticket Id 213550 - Begin
			//Removing Hardcoding and using variable boname
			  document.getElementsByName('<xsl:value-of select="$boName"/>'+".MiscellaneousInfo.strText26")[0].focus();
			//Ticket Id 213550 - End
		}
		catch (e)
		{
		}
	}
	<!--Tracker:1121611:End of changes-->
	function setProfessionDesignation()
	{
		if(ProfessionCode!='' &amp;&amp; ProfessionCode!=undefined)
		document.getElementsByName('DemographicBO.EmploymentHistory.strText2')[0].value=ProfessionCode;

		if(Designation!='' &amp;&amp; Designation!=undefined)
		document.getElementsByName('DemographicBO.EmploymentHistory.strText8')[0].value=Designation;
	}
	function functionBodyOnload(){
		var readMode = '<xsl:value-of select="$readMode"/>';
		if(readMode=='Y'){
			showInReadOnlyMode('<xsl:value-of select="$readMode"/>');
			enableClose();
			DisableObjects();
			load();
			setProfessionDesignation();
		}else{
			SetLocCookies();
			DisableObjects();
			focusFirstField();
			setProfessionDesignation();
		}
	}   
    		</script>



		</head>
		<script type="text/javascript" src="../common/js/currency.js" language="javascript"></script>
		<script type="text/javascript" src="../common/js/SRMFormToggle.js" language="javascript"></script>
		<script type="text/javascript" language="javascript" src="../cif/js/DemographicEmploymentHistory.js"></script>
		<SCRIPT LANGUAGE='javascript' SRC='../common/js/FieldValidate.js'></SCRIPT>
		<!--Performance-->
		<!--<script type="text/javascript" language="javascript" src="../common/js/RendValidate.js"></script>-->
		<script type="text/javascript" language="javascript" src="../common/html/Rendvalidate.js"></script>
		<!--Performance-->
		<body class="popup" >
			 <xsl:choose>
				<xsl:when test="normalize-space($readMode)='Y'">
					<xsl:attribute name="onload">showInReadOnlyMode('<xsl:value-of select="$readMode"/>');enableClose();load();DisableObjects();setProfessionDesignation();</xsl:attribute>
				</xsl:when>

			<!-- Employer Details Changes -->
			<!--Tracker:1121611:Changes for focus on first editable field-->
			<xsl:otherwise>
				<xsl:attribute name="onload">SetLocCookies();DisableObjects();focusFirstField();setProfessionDesignation();</xsl:attribute>
			</xsl:otherwise>
			<!--Tracker:1121611:End of Changes-->
			</xsl:choose>
			<table width="100%" border="0" cellpadding="0" cellspacing="0" vspace="0" hspace="0">
				<xsl:apply-templates select="SRM"/>
			
			</table>
							<table class="background" width="100%" cellpadding="0" cellspacing="0" border="0"  align="center">
								
									<!--CIF changes:Read Only Mod:Start-->
									<xsl:choose>
										<xsl:when test="normalize-space($readMode)='Y'">
											<xsl:call-template name="user_button_withText">
												<xsl:with-param name="button_name">Close</xsl:with-param>
												<!--  Changes for ticket 341080 : BEGIN  -->
												<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='CLOSE']/@configLabel"/></xsl:with-param>
												<!--  Changes for ticket 341080 : END  -->
												<xsl:with-param name="button_fnc">cancel()</xsl:with-param>
											</xsl:call-template>
										</xsl:when>
				        				<xsl:otherwise>
										<xsl:call-template name="user_button_withText">
											<xsl:with-param name="button_name">SAVE</xsl:with-param>
											<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='SAVE']/@configLabel"/></xsl:with-param>
											<xsl:with-param name="button_fnc">saveEmpHistDetail();</xsl:with-param>
											<xsl:with-param name="class">sbttn</xsl:with-param>
										</xsl:call-template>&#160;
										<xsl:call-template name="user_button_withText">
											<xsl:with-param name="button_name">CLOSE</xsl:with-param>
											<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='CLOSE']/@configLabel"/></xsl:with-param>
			
											<xsl:with-param name="button_fnc">CloseID();</xsl:with-param>
											<xsl:with-param name="class">sbttn</xsl:with-param>
										</xsl:call-template>
									</xsl:otherwise>
			    						</xsl:choose>
			    						<!--CIF changes:Read Only Mod:End-->
								
							</table>
			
			
		</body>
		</html>
	</xsl:template>
 		<!-- Employer History: Profession :  -->
			    <!--  CODE ADDED BY KAMAL for tracker id 349409 -->
			     <xsl:template name="DemographicBO.MiscellaneousInfo.strText2">
			   <xsl:call-template name="lookup">
				  <xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.MiscellaneousInfo.strText2']"/>
					  <xsl:with-param name="elename">DemographicBO.EmploymentHistory.strText2</xsl:with-param>
					  <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.EmploymentHistory.strText2</xsl:with-param>
					   <!-- Field Rationalization changes start -->
							<!--   <xsl:with-param name="code_req">true</xsl:with-param> -->
									<!-- Field Rationalization changes end -->
							<!--  TRACKER ID:150150  CHANGES BEGIN   -->
									<xsl:with-param name="buttonone_name" select="$configLabels[@name='BTN_LOOKUP']/@configLabel"/>
									<xsl:with-param name="buttontwo_name" select="$configLabels[@name='BTN_CLEAR']/@configLabel"/>
									<xsl:with-param name="buttonone_fnc">categoryLookup('CONTACT_OCCUPATION', 'DemographicBO.EmploymentHistory.strText2')</xsl:with-param>
									<xsl:with-param name="buttontwo_fnc">clearCategoryValue('DemographicBO.EmploymentHistory.strText2')</xsl:with-param>
									<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
									<xsl:with-param name="checkASCII">false</xsl:with-param>
							<!--  TRACKER ID:150150  CHANGES END  -->
						<!-- CIF Changes for Caching Views : Start -->
					<xsl:with-param name="presdata" select="$PresData"/>
					<!-- CIF Changes for Caching Views : End -->
					       </xsl:call-template>
					    </xsl:template>
			        
  <!-- CODE ADDED BY KAMAL for tracker id 349409 -->

       <!-- Field Rationalization changes start -->
                      <xsl:template name="DemographicBO.MiscellaneousInfo.strText3">
                         <xsl:call-template name="lookup">
                            <xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.MiscellaneousInfo.strText3']"/>
                                 <!-- tol id 700121 changes start -->
		     <xsl:with-param name="elename">DemographicBO.MiscellaneousInfo.strText3</xsl:with-param>
		     <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText3</xsl:with-param>
		      <!-- Field Rationalization changes start -->
		      <xsl:with-param name="code_req">true</xsl:with-param>
		      <!-- Field Rationalization changes end -->
		     <xsl:with-param name="buttonone_name" select="$configLabels[@name='BTN_LOOKUP']/@configLabel"/>
		     <xsl:with-param name="buttontwo_name" select="$configLabels[@name='BTN_CLEAR']/@configLabel"/>
		     <xsl:with-param name="buttonone_fnc">categoryLookup('INDUSTRY_TYPE', 'DemographicBO.MiscellaneousInfo.strText3')</xsl:with-param>
		     <xsl:with-param name="buttontwo_fnc">clearCategoryValue('DemographicBO.MiscellaneousInfo.strText3')</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		     <xsl:with-param name="checkASCII">false</xsl:with-param>
                        </xsl:call-template>
                    </xsl:template>
                         <!-- tol id 700121 changes end -->
        <!-- Field Rationalization changes end -->

                    <!-- Employer History: Employer Name :  -->
         <!--           <xsl:template name="DemographicBO.MiscellaneousInfo.strText4">
                                 <xsl:call-template name="label">
                                      <xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.MiscellaneousInfo.strText4']"/>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
                                      <xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.strText4</xsl:with-param>
                                      <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText4</xsl:with-param>
				      <xsl:with-param name="checkASCII">false</xsl:with-param>
                               </xsl:call-template>
                    </xsl:template>
             -->
 <xsl:template name="DemographicBO.MiscellaneousInfo.strText4">
     <xsl:call-template name="lookup">
          <xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.MiscellaneousInfo.strText4']"/>

          <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
          <xsl:with-param name="elename">DemographicBO.MiscellaneousInfo.strText4</xsl:with-param>
          <xsl:with-param name="eleval">DemographicBO.MiscellaneousInfo.strText4</xsl:with-param>
             <xsl:with-param name="buttonone_name" select="$configLabels[@name='BTN_LOOKUP']/@configLabel"/>
             <xsl:with-param name="buttontwo_name" select="$configLabels[@name='BTN_CLEAR']/@configLabel"/>
          <xsl:with-param name="buttonone_fnc">empLookup()</xsl:with-param>
          <xsl:with-param name="buttontwo_fnc">clearAll()</xsl:with-param>
     </xsl:call-template>
<IFRAME name="hidfrm_emphist" width="0" height="0" src="../common/html/SSOblank.html"/>
 </xsl:template>
 
 <!--TrackerID: 113227  Start of changes-->
 
 
  <xsl:template name="DemographicBO.MiscellaneousInfo.strText4_alt1">
      <xsl:call-template name="label_alternate">
           <xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.MiscellaneousInfo.strText4']"/>
           <!--changes for Tracker 120416 start-->
           <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
           <!--changes for Tracker 120416 end-->
		<xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.strText4_alt1</xsl:with-param>    
		<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText4_alt1</xsl:with-param>
		<xsl:with-param name="checkASCII">false</xsl:with-param>
		<xsl:with-param name="starshow">false</xsl:with-param>
		<xsl:with-param name="fn_onBlur">set_isName(this,true);</xsl:with-param>
      </xsl:call-template>
 <IFRAME name="hidfrm_emphist" width="0" height="0" src="../common/html/SSOblank.html"/>
 </xsl:template>
 
 
 <!--TrackerID: 113227  End of changes -->
 
                    <!-- Employer History: Address :  -->
                    <xsl:template name="DemographicBO.MiscellaneousInfo.strText5">
                                 <xsl:call-template name="label">
                                  <xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.MiscellaneousInfo.strText5']"/>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
                                  <xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.strText5</xsl:with-param>
                              <xsl:with-param name="concat">true</xsl:with-param>
                                <xsl:with-param name="ele1_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText5</xsl:with-param>
                                  <xsl:with-param name="ele2_val">Premise</xsl:with-param>

				  <xsl:with-param name="checkASCII">false</xsl:with-param>
                               </xsl:call-template>
                    </xsl:template>
 		<!-- Employer History: Phone :  -->
              <xsl:template name="DemographicBO.MiscellaneousInfo.strText6">
			<xsl:call-template name="label">
				<xsl:with-param name="is_phone">true</xsl:with-param>
				<xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.MiscellaneousInfo.strText6']"/>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
				<xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.strText6</xsl:with-param>
				<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText6</xsl:with-param>
			</xsl:call-template>
        </xsl:template>
		 <!-- Employer History: Fax :  -->
              <xsl:template name="DemographicBO.MiscellaneousInfo.strText7">
			<xsl:call-template name="label">
				<xsl:with-param name="is_phone">true</xsl:with-param>
				<xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.MiscellaneousInfo.strText7']"/>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
				<xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.strText7</xsl:with-param>
				<xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText7</xsl:with-param>
			</xsl:call-template>
        </xsl:template>
                    <!-- Employer History: Designation :  -->
	                                     <!-- CODE ADDED BY KAMAL for tracker id 349409 -->
	     <xsl:template name="DemographicBO.MiscellaneousInfo.strText8">
			   <xsl:call-template name="lookup">
				  <xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.MiscellaneousInfo.strText8']"/>
					  <xsl:with-param name="elename">DemographicBO.EmploymentHistory.strText8</xsl:with-param>
					  <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.EmploymentHistory.strText8</xsl:with-param>
					   <!-- Field Rationalization changes start -->
							<!--   <xsl:with-param name="code_req">true</xsl:with-param> -->
									<!-- Field Rationalization changes end -->
							<!--  TRACKER ID:150150  CHANGES BEGIN   -->
									<xsl:with-param name="buttonone_name" select="$configLabels[@name='BTN_LOOKUP']/@configLabel"/>
									<xsl:with-param name="buttontwo_name" select="$configLabels[@name='BTN_CLEAR']/@configLabel"/>
									<xsl:with-param name="buttonone_fnc">categoryLookup('DESIGNATION', 'DemographicBO.EmploymentHistory.strText8')</xsl:with-param>
									<xsl:with-param name="buttontwo_fnc">clearCategoryValue('DemographicBO.EmploymentHistory.strText8')</xsl:with-param>
									<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
									<xsl:with-param name="checkASCII">false</xsl:with-param>
							<!--  TRACKER ID:150150  CHANGES END  -->
									<!-- CIF Changes for Caching Views : Start -->
					<xsl:with-param name="presdata" select="$PresData"/>
					<!-- CIF Changes for Caching Views : End -->
					       </xsl:call-template>
	    </xsl:template>
	        
  <!-- CODE ADDED BY KAMAL for tracker id 349409 -->
                    <!-- Employer History: DOJ :  -->
                      <xsl:template name="DemographicBO.MiscellaneousInfo.dtDate1">
                         <xsl:call-template name="label">
                              <xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.MiscellaneousInfo.dtDate1']"/>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
                              <xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.dtDate1</xsl:with-param>
                              <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.dtDate1</xsl:with-param>
                              <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
			      <!-- calling the function isGregDate for on blur functionality-->
                        <xsl:with-param name="fn_onBlur">isGregDate("3_DemographicBO.MiscellaneousInfo.dtDate1");</xsl:with-param>
                        <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
                       </xsl:call-template>
                    </xsl:template>
                    <!-- Employer History: DOL :  -->
                      <xsl:template name="DemographicBO.MiscellaneousInfo.dtDate2">
                         <xsl:call-template name="label">
                              <xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.MiscellaneousInfo.dtDate2']"/>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
                              <xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.dtDate2</xsl:with-param>
                              <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.dtDate2</xsl:with-param>
                              <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
			      <!-- calling the function isGregDate for on blur functionality-->
                         <xsl:with-param name="fn_onBlur">isGregDate("3_DemographicBO.MiscellaneousInfo.dtDate2");</xsl:with-param>
                         <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
                       </xsl:call-template>
                    </xsl:template>
                    <!-- Employer History: Period :  -->
                    <xsl:template name="DemographicBO.MiscellaneousInfo.strText9">
                         <xsl:call-template name="label">
                              <xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.MiscellaneousInfo.strText9']"/>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
                              <xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.strText9</xsl:with-param>
                              <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText9</xsl:with-param>
                              <!--tracker id 157295 changes starts-->
                              <xsl:with-param name="fn_onBlur">formatDemoEmpIntField(document.getElementsByName("DemographicBO.MiscellaneousInfo.strText9")[0]);</xsl:with-param>
                       	      <!--tracker id 157295 changes ends-->
                       </xsl:call-template>
                    </xsl:template>
        <!-- Employer History Zip Code -->
              <xsl:template name="DemographicBO.MiscellaneousInfo.strText17">
                     <xsl:call-template name="label">
                     <xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.MiscellaneousInfo.strText17']"/>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
                       <xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.strText17</xsl:with-param>
                       <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText17</xsl:with-param>
                     </xsl:call-template>
              </xsl:template>
        <!-- Employer History Address - City -->
             <xsl:template name="DemographicBO.MiscellaneousInfo.strText18">
             <xsl:call-template name="lookup">
             <xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.MiscellaneousInfo.strText18']"/>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
             <xsl:with-param name="elename">DemographicBO.MiscellaneousInfo.strText18</xsl:with-param>
             <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText18</xsl:with-param>
             <xsl:with-param name="buttonone_name" select="$configLabels[@name='BTN_LOOKUP']/@configLabel"/>
             <xsl:with-param name="buttontwo_name" select="$configLabels[@name='BTN_CLEAR']/@configLabel"/>

				<!-- vasanth's changes start -->

				<xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('CITY', 'DemographicBO.MiscellaneousInfo.strText18','','DemographicBO.MiscellaneousInfo.strText19','DemographicBO.MiscellaneousInfo.strText20')</xsl:with-param>
				<xsl:with-param name="buttontwo_fnc">clearLocValue('DemographicBO.MiscellaneousInfo.strText18','CITY')</xsl:with-param>

			 <!--<xsl:with-param name="buttonone_fnc">categoryLookup('CITY', 'DemographicBO.MiscellaneousInfo.strText18')</xsl:with-param>
			 <xsl:with-param name="buttontwo_fnc">clearCategoryValue('DemographicBO.MiscellaneousInfo.strText18')</xsl:with-param>-->

				<!-- vasanth's changes end   -->

	     <xsl:with-param name="checkASCII">false</xsl:with-param>
             </xsl:call-template>
             </xsl:template>
        <!-- Employer History Address - State -->
             <xsl:template name="DemographicBO.MiscellaneousInfo.strText19">
             <xsl:call-template name="lookup">
             <xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.MiscellaneousInfo.strText19']"/>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
             <xsl:with-param name="elename">DemographicBO.MiscellaneousInfo.strText19</xsl:with-param>
             <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText19</xsl:with-param>
             <xsl:with-param name="buttonone_name" select="$configLabels[@name='BTN_LOOKUP']/@configLabel"/>
             <xsl:with-param name="buttontwo_name" select="$configLabels[@name='BTN_CLEAR']/@configLabel"/>

				<!-- vasanth's changes start -->

				<xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('STATE', 'DemographicBO.MiscellaneousInfo.strText19','','DemographicBO.MiscellaneousInfo.strText18','DemographicBO.MiscellaneousInfo.strText20')</xsl:with-param>
				<xsl:with-param name="buttontwo_fnc">clearLocValue('DemographicBO.MiscellaneousInfo.strText19','STATE','DemographicBO.MiscellaneousInfo.strText18')</xsl:with-param>

			 <!--<xsl:with-param name="buttonone_fnc">categoryLookup('STATE', 'DemographicBO.MiscellaneousInfo.strText19')</xsl:with-param>
			 <xsl:with-param name="buttontwo_fnc">clearCategoryValue('DemographicBO.MiscellaneousInfo.strText19')</xsl:with-param>-->

				<!-- vasanth's changes end   -->

	     <xsl:with-param name="checkASCII">false</xsl:with-param>
             </xsl:call-template>
             </xsl:template>
        <!-- Employer History Address - Country -->
             <xsl:template name="DemographicBO.MiscellaneousInfo.strText20">
             <xsl:call-template name="lookup">
             <xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.MiscellaneousInfo.strText20']"/>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
             <xsl:with-param name="elename">DemographicBO.MiscellaneousInfo.strText20</xsl:with-param>
             <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText20</xsl:with-param>
		<!-- Field Rationalization changes start-->
		<xsl:with-param name="code_req">true</xsl:with-param>
		<!-- Field Rationalization changes end-->
             <xsl:with-param name="buttonone_name" select="$configLabels[@name='BTN_LOOKUP']/@configLabel"/>
             <xsl:with-param name="buttontwo_name" select="$configLabels[@name='BTN_CLEAR']/@configLabel"/>

						<!-- vasanth's changes start -->

						<xsl:with-param name="buttonone_fnc">categoryLookupCode_Location('COUNTRY', 'DemographicBO.MiscellaneousInfo.strText20','','DemographicBO.MiscellaneousInfo.strText19','DemographicBO.MiscellaneousInfo.strText18')</xsl:with-param>
						<xsl:with-param name="buttontwo_fnc">clearLocValue('DemographicBO.MiscellaneousInfo.strText20','COUNTRY','DemographicBO.MiscellaneousInfo.strText19','DemographicBO.MiscellaneousInfo.strText18')</xsl:with-param>

					 <!--<xsl:with-param name="buttonone_fnc">categoryLookup('COUNTRY', 'DemographicBO.MiscellaneousInfo.strText20')</xsl:with-param>
					 <xsl:with-param name="buttontwo_fnc">clearCategoryValue('DemographicBO.MiscellaneousInfo.strText20')</xsl:with-param>-->

						<!-- vasanth's changes end   -->

	     <xsl:with-param name="checkASCII">false</xsl:with-param>
             </xsl:call-template>
             </xsl:template>
        <!-- Employment History User Field1 -->
                    <xsl:template name="DemographicBO.MiscellaneousInfo.strText21">
                        <xsl:call-template name="label">
                            <xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.MiscellaneousInfo.strText21']"/>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
                            <xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.strText21</xsl:with-param>
                            <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText21</xsl:with-param>
			<xsl:with-param name="checkASCII">false</xsl:with-param>
                    </xsl:call-template>
              </xsl:template>
        <!-- Employment History User Field2 -->
                    <xsl:template name="DemographicBO.MiscellaneousInfo.strText22">
                        <xsl:call-template name="label">
                            <xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.MiscellaneousInfo.strText22']"/>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
                            <xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.strText22</xsl:with-param>
                            <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText22</xsl:with-param>
                    </xsl:call-template>
              </xsl:template>
        <!-- Employment History User Field3 -->
                    <xsl:template name="DemographicBO.MiscellaneousInfo.strText23">
                        <xsl:call-template name="label">
                            <xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.MiscellaneousInfo.strText23']"/>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
                            <xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.strText23</xsl:with-param>
                            <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText23</xsl:with-param>
                    </xsl:call-template>
              </xsl:template>
        <!-- Employment History User Field4 -->
                    <xsl:template name="DemographicBO.MiscellaneousInfo.strText24">
                        <xsl:call-template name="label">
                            <xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.MiscellaneousInfo.strText24']"/>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
                            <xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.strText24</xsl:with-param>
                            <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText24</xsl:with-param>
                    </xsl:call-template>
              </xsl:template>
        <!-- Employment History User Field5 -->
                    <xsl:template name="DemographicBO.MiscellaneousInfo.strText25">
                        <xsl:call-template name="label">
                            <xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.MiscellaneousInfo.strText25']"/>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
                            <xsl:with-param name="ele_name">DemographicBO.MiscellaneousInfo.strText25</xsl:with-param>
                            <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText25</xsl:with-param>
                    </xsl:call-template>
              </xsl:template>


                       <xsl:template name="DemographicBO.MiscellaneousInfo.strText26">
                          <xsl:call-template name="mdrpdown">
                             <xsl:with-param name="res_name" select="$configLabels[@name='DemographicBO.MiscellaneousInfo.strText26']"/>
 			    <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
                             <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText26</xsl:with-param>
                             <xsl:with-param name="selectdisp">DemographicBO.MiscellaneousInfo.strText26</xsl:with-param>
                 <xsl:with-param name="choice_name">DemographicBO.MiscellaneousInfo.strText26</xsl:with-param>
                 <xsl:with-param name="onchangefn">DisableObjects();clearAll();</xsl:with-param>
 	<!-- CIF Changes for Caching Views : Start -->
          	<xsl:with-param name="presdata" select="$PresData"/>
 	<!-- CIF Changes for Caching Views : End -->
                             <xsl:with-param name="search_type">value</xsl:with-param>
                         </xsl:call-template>
                     </xsl:template>

	<xsl:template name="mode1">
		


		<input type="hidden" name="boName" value="{$boName}"/>
		<input type="hidden" name="isMCEditedDemoEmp" value="N"/>


		<table class="background" bgcolor="FFFFFF" align="center" cellpadding="0" width="100%">
			<xsl:call-template name="Begin"/>
				<xsl:call-template name="DemographicBO.MiscellaneousInfo.strText26"/>
				<xsl:call-template name="DemographicBO.MiscellaneousInfo.strText4"/>

			<xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
				<xsl:call-template name="DemographicBO.MiscellaneousInfo.strText8"/>
				<xsl:call-template name="DemographicBO.MiscellaneousInfo.strText2"/>

			<xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
				<xsl:call-template name="DemographicBO.MiscellaneousInfo.strText3"/>
				<xsl:call-template name="DemographicBO.MiscellaneousInfo.strText5"/>
			<xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
				<xsl:call-template name="DemographicBO.MiscellaneousInfo.strText18"/>
				<xsl:call-template name="DemographicBO.MiscellaneousInfo.strText19"/>
			<xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
				<xsl:call-template name="DemographicBO.MiscellaneousInfo.strText20"/>
				<xsl:call-template name="DemographicBO.MiscellaneousInfo.strText17"/>
			<xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
				<xsl:call-template name="DemographicBO.MiscellaneousInfo.strText6"/>
				<xsl:call-template name="DemographicBO.MiscellaneousInfo.strText7"/>
			<xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
				<xsl:call-template name="DemographicBO.MiscellaneousInfo.strText9"/>
				<xsl:call-template name="DemographicBO.MiscellaneousInfo.dtDate1"/>
			<xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
				
				<xsl:call-template name="DemographicBO.MiscellaneousInfo.dtDate2"/>
				<xsl:call-template name="DemographicBO.MiscellaneousInfo.strText21"/>
			<xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
				
				<xsl:call-template name="DemographicBO.MiscellaneousInfo.strText22"/>
				<xsl:call-template name="DemographicBO.MiscellaneousInfo.strText23"/>
			<xsl:call-template name="End"/>
			<xsl:call-template name="Begin"/>
				
				<xsl:call-template name="DemographicBO.MiscellaneousInfo.strText24"/>
				<xsl:call-template name="DemographicBO.MiscellaneousInfo.strText25"/>
			<xsl:call-template name="End"/>
			
			
<!-- TrackerID: 113227  Begin of Changes-->
  <xsl:choose>
	<xsl:when test="normalize-space($altLocaleActv)='true'">
  	 	<!--DUAL Language Changes:start-->
  	 	<xsl:variable name="DUAL"><xsl:value-of select="$configLabels[@name='Details in Alternate Language']/@configLabel"/></xsl:variable>
  	 		<tr style="cursor:pointer

" STYLE="border-bottom: 10px black;" ID="rowdual" name="rowdual">
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
  	 		
  			<xsl:call-template name="DemographicBO.MiscellaneousInfo.strText4_alt1">
  			</xsl:call-template>
  			
  		</TR>
  		
  	 	</DIV>
  	 	
  	 <tr></tr>
  </xsl:when>
  	 
  </xsl:choose> 	 
  	 
 <!-- TrackerID: 113227  End of Changes-->

			</table>
		
	</xsl:template>
	<xsl:template match="SRM">
		<xsl:for-each select=".">
			<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tableborder" vspace="0" hspace="0">
									<tr>
										<td>
									    		<table border="0" cellspacing="0" cellpadding="0" class="innertable" width="100%" vspace="0" hspace="0">
												<tr>
													<td>
														<table bgcolor='ffffff' border="0" cellspacing="0" cellpadding="2" width="100%" vspace="0" hspace="0">
															<tr>
																<xsl:call-template name="apply">
																	<xsl:with-param name="apply_head">
																		<b><xsl:value-of select="$configLabels[@name='Header']/@configLabel"/></b>
																	</xsl:with-param>
																</xsl:call-template>
															</tr>
														</table>
														<form name="frm2"  method="post" >
														<table bgcolor='ffffff' width="100%" border="0" cellspacing="0" cellpadding="2">
															<xsl:call-template name="mode1"/>
														</table>
														</form>
													</td>
												</tr>
											</table>
										</td>
									</tr>
			 </table>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>

















