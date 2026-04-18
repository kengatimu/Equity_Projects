<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"/>
<xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"/>
        <xsl:param name="locale"/>
<xsl:variable name="readMode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='isReadOnly']"/>
    <xsl:variable name="file1">../Renderer/Customization/corpcif/resource/CorpConcessionSelection_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<xsl:variable name="configFile_1" select="document(concat($file1, ''))"/>
<xsl:variable name="configLabels" select="$configFile_1/SRMBO/*"/>
<xsl:variable name="PsychographicURL" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='ConcessionPsychoURL.URL_']"></xsl:variable>
<xsl:variable name="allfields" select="/SRM/SRMData//Z"/>
<xsl:variable name="BaseCurrency" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='BaseCurrency']"/>
<xsl:variable name="corpid" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='corpid']"/>
<xsl:variable name="dtValid" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='dtValid']"/>
<xsl:variable name="CurrencyAccList" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CurrencyAccList']"></xsl:variable>
		<!--changes for tracker id 349409 BEGIN-->
<xsl:variable name="curren1" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='PreferencesBO.CorpMiscellaneousInfo.str1']"></xsl:variable>
		<!--changes for tracker id 349409 END-->
<!-- caching changes start -->
<xsl:param name="viewname"/>
<xsl:variable name="PresFileName">../servlet/com.infy.cis.ui.corpcif.CorpCIF_DetPresCacheServlet?ViewName=<xsl:value-of select="$viewname"/>&amp;Locale=<xsl:value-of select="$locale"/></xsl:variable>
<xsl:variable name="PresFile" select="document(concat($PresFileName, ''))"/>
<xsl:variable name="PresData" select="$PresFile/SRM/SRMPresentation"/>
<!-- caching changes end -->
<xsl:template match="/">
<html>
	<head>
		<script type="text/javascript" src="../common/js/ClientResourceBundle_{$locale}.js" language="javascript"></script>
<script type="text/javascript" src="../corpcif/js/Message_corpcif_{$locale}.js" language="javascript"></script>
		<script>
		var locale = '<xsl:value-of select="$locale"/>';
		var baseCurrency = '<xsl:value-of select="$BaseCurrency"/>';		
		var corpid = '<xsl:value-of select="$corpid"/>';
		var readMode = '<xsl:value-of select="$readMode"/>';		
		var locDate = '<xsl:value-of select = "$dtValid"/>';
		var curraccList = '<xsl:value-of select="$CurrencyAccList"/>';
		var psychourl = '<xsl:value-of select="$PsychographicURL"/>';
		<!--changes for tracker id 349409 BEGIN-->
		var curren1 = '<xsl:value-of select="$curren1"/>';
		<!--changes for tracker id 349409 END-->
		</script>
		<title><xsl:value-of select="//SRMPresentation/SRMSystem[@n='Strings']/SRMString[@n='Title']/@value"/></title>
		<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
		<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/SRMTableDisplay_{$locale}.css"/>
		<script type="text/javascript" src="../common/html/utils.js" language="javascript"></script>
		<script type="text/javascript" src="../common/html/validate.js" language="javascript"></script>        
		<script type="text/javascript" src="../common/html/validateL2.js" language="javascript"></script>        	
		<script type="text/javascript" src="../common/html/Rendvalidate.js" language="javascript"></script>
		<SCRIPT LANGUAGE='javascript' SRC='../common/js/FieldValidate.js'></SCRIPT>
        <script type="text/javascript" src="../common/js/Rendcurrency_cif.js" language="javascript"></script>
        
        	

		<script type="text/javascript" language="javascript">
		<![CDATA[
		function save() 
		{  		
			
		//changes by Rozy for CNF
		removePercentFormat('3_PreferencesBO.CorpMiscellaneousInfo.percentage1');
		removePercentFormat('3_PreferencesBO.CorpMiscellaneousInfo.percentage2');
		removePercentFormat('3_PreferencesBO.CorpMiscellaneousInfo.percentage3');
		FormatBeforeSave_Number('3_PreferencesBO.CorpMiscellaneousInfo.amount1');
			try{
				customSave();
			}catch(e)
			{ }
			try{
				retStat = ValidateFormContents(document.frm2,false);
				//var retStat = "true";
				if(retStat == "false") {
					return "interactive";
				}
		
				var URL 			= document.frm2.hid_PsychographicURL.value;								
				 <!--  Tracker ID : 90197 Begin of Changes for attribute masking-->
				//var creditDiscountPercentage	= document.getElementsByName("PreferencesBO.CorpMiscellaneousInfo.percentage1")[0].value;								
				//var debitDiscountPercentage	= document.getElementsByName("PreferencesBO.CorpMiscellaneousInfo.percentage2")[0].value;
				//var withTaxPercentage	        = document.getElementsByName("PreferencesBO.CorpMiscellaneousInfo.percentage3")[0].value;								
				//var withTaxFloorLimit 		= document.getElementsByName("PreferencesBO.CorpMiscellaneousInfo.amount1")[0].value;								
				//var preferentialExpiryDate 	= document.getElementsByName("PreferencesBO.CorpMiscellaneousInfo.date1")[0].value;	
				var creditDiscountPercentage	= document.getElementsByName("3_PreferencesBO.CorpMiscellaneousInfo.percentage1")[0].value;								
				var debitDiscountPercentage	= document.getElementsByName("3_PreferencesBO.CorpMiscellaneousInfo.percentage2")[0].value;
				var withTaxPercentage	        = document.getElementsByName("3_PreferencesBO.CorpMiscellaneousInfo.percentage3")[0].value;								
				var withTaxFloorLimit 		= document.getElementsByName("3_PreferencesBO.CorpMiscellaneousInfo.amount1")[0].value;								
				var preferentialExpiryDate 	= document.getElementsByName("3_PreferencesBO.CorpMiscellaneousInfo.date1")[0].value;				
				  <!-- Tracker ID : 90197 End of Changes -->
				var currency		 	= document.getElementsByName("PreferencesBO.CorpMiscellaneousInfo.str1")[0].value;					
				var ind=0;
			 	var CurrAccList=new Array();
				var flag1=0;
				CurrAccList= curraccList.split(",");
				var len = curraccList.length;
				
				if (psychourl !='')
				
				{
				for(ind=len;ind>0;ind--){
					if(CurrAccList[ind]==currency)
					{
						
					   flag1=1;
					   continue;
					}
					}
					 var chkArray = new Array();  
					 //Tracker 192434- START
					/*if (flag1==1){
					  chkArray[0] = currency;
					  showUserMessage('MSGJ50877',chkArray);
					  return;
					}*/
					//Tracker 192434 - END
				}	
				if ((creditDiscountPercentage=='') && (debitDiscountPercentage=='') &&(withTaxPercentage=='') && (withTaxFloorLimit=='') && (preferentialExpiryDate=='') && (currency=='')){
					showMessage(MSGX0016);
					self.close();
				}
				else{	
					// Calling the Function to put the records in the Multi Rec.
					window.opener.addConcessionInfo(URL,
								 creditDiscountPercentage,
								 debitDiscountPercentage,
								 withTaxPercentage,
								 withTaxFloorLimit,
								 preferentialExpiryDate,
								 currency);   
					if(document.frm2.isMCEditedConcession.value=="Y"){
							top.window.opener.setMCAttModifyFlag();
					}
					self.close();
					window.opener.focus();
				}
			}catch(e){ }
		} 
		
		function cancel() {
			try 
			{
				self.close();
				window.opener.focus();
			}catch(e) {
			}
		}function setMCAttModifyFlag(){
				document.frm2.isMCEditedConcession.value="Y";
		}
		
		
		
		 // Tracker : 79526
		 // The Base Currency value will be loaded only if currency value entered is null.
		 function loadForm() {	
		
		try{
			//Changes for tracker id 334989 starts
			if(readMode=='Y'){
			document.getElementById("dimg1").style.display = 'none';
			}
		<!--changes for tracker id 349409 BEGIN-->
			document.getElementsByName("PreferencesBO.CorpMiscellaneousInfo.str1")[0].value = curren1;
			document.getElementsByName("Cat_PreferencesBO.CorpMiscellaneousInfo.str1")[0].value = curren1;
		<!--changes for tracker id 349409 END-->
			//Changes for tracker id 334989 ends
			var dbFloat1 = document.getElementsByName("3_PreferencesBO.CorpMiscellaneousInfo.percentage1")[0].value;
			var dbFloat2 = document.getElementsByName("3_PreferencesBO.CorpMiscellaneousInfo.percentage2")[0].value;
			var dbFloat3 = document.getElementsByName("3_PreferencesBO.CorpMiscellaneousInfo.percentage3")[0].value;
			var WithholdTaxFloor = document.getElementsByName("3_PreferencesBO.CorpMiscellaneousInfo.amount1")[0].value;
			//changes for call id:387650 and recon of call 385232 starts - 
			var dateExp = document.getElementsByName("3_PreferencesBO.CorpMiscellaneousInfo.date1")[0].value;
			var expiryDate  = getEndDate1();
			//changes for call id:387650 and recon of call 385232 ends
			var CurrencyAccList = '<xsl:value-of select="$CurrencyAccList"/>';
			if(dbFloat1 == ''){
				document.getElementsByName("3_PreferencesBO.CorpMiscellaneousInfo.percentage1")[0].value = 0;
			}
			if(dbFloat2 == ''){
				document.getElementsByName("3_PreferencesBO.CorpMiscellaneousInfo.percentage2")[0].value = 0;
			}
			if(dbFloat3 == ''){
				document.getElementsByName("3_PreferencesBO.CorpMiscellaneousInfo.percentage3")[0].value = 0;
			}
			if(WithholdTaxFloor==''){
			document.getElementsByName("3_PreferencesBO.CorpMiscellaneousInfo.amount1")[0].value='0';
			}
			//changes for call id: 387650 and recon of call 385232 starts
			if(dateExp==''){
			document.getElementsByName("3_PreferencesBO.CorpMiscellaneousInfo.date1")[0].value = expiryDate;
			}
			else{
			document.getElementsByName("3_PreferencesBO.CorpMiscellaneousInfo.date1")[0].value = dateExp;
			}
			//changes for call id: 387650 and recon of call 385232 ends
		}
		catch(e){}
		
		//changes by Rozy for CNF

		formatPercent("3_PreferencesBO.CorpMiscellaneousInfo.percentage1");
		formatPercent("3_PreferencesBO.CorpMiscellaneousInfo.percentage2");
		formatPercent("3_PreferencesBO.CorpMiscellaneousInfo.percentage3");
		formatNumber("3_PreferencesBO.CorpMiscellaneousInfo.amount1");
		 		<!--changes for tracker id 349409 -->
		 	var currency = document.getElementsByName("PreferencesBO.CorpMiscellaneousInfo.str1")[0].value;		 	
			if (currency == '' || currency == null){		 
			//if (corpid=='' ||corpid==null){
				document.getElementsByName("PreferencesBO.CorpMiscellaneousInfo.str1")[0].value = baseCurrency;
				document.getElementsByName("Cat_PreferencesBO.CorpMiscellaneousInfo.str1")[0].value = baseCurrency;
			}
		}
		
		// PRE-ITPT
		function validatePercent(x){
			var perValue = document.getElementsByName(x)[0].value;			
			if (perValue > 100){
				showMessage(MSGX0021);			
				document.getElementsByName(x)[0].focus();
			}
		}			
		
		function validateDate(){
		/* ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)*/
		/* calling the function isGregDate for on blur functionality*/
				
				isGregDate("3_PreferencesBO.CorpMiscellaneousInfo.date1");
				
				/* ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)*/
		
			var todaydate = new String();
			todaydate.value = getTodayDate1(locDate); 
			var expiryDate = document.getElementsByName("3_PreferencesBO.CorpMiscellaneousInfo.date1")[0];	
		/* ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)*/
		
		/* calling the function isGregDate for on blur functionality*/
		if (expiryDate.value != '')
		{
		todaydate.value = convertDate(todaydate.value);
		}
		
		/* ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)*/	
			
					
			var mill1 = changetoMillis(expiryDate.value);
			var mill2 = changetoMillisForToday(todaydate.value);			
			if(expiryDate.value!=''){
				if (mill1 < mill2){
					showMessage(MSGX0022);
					/* Ticket Id 220137 Changes Begin */
					expiryDate.value = "";
					/* Ticket Id 220137 Changes end */
					expiryDate.focus();
			}
			}
		}
		
		
		
		function enableClose(){
			try{
				document.getElementsByName("Close")[0].disabled = false;
			}catch(e){
			}
		}
		
		
		// PRE-ITPT
		]]>
		</script>
	</head>
	
	
	<body class="popup"> 	
	    	 
		 <!-- Base Currency Setting -->
		 <xsl:attribute name="onload">showInReadOnlyMode('<xsl:value-of select="$readMode"/>');enableClose();loadForm()</xsl:attribute>
	    	 <!-- Base Currency Setting -->	    	 
		 
		 
		<table class="table" width="100%" cellpadding="0" cellspacing="0" border="0">
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

				 
		  
		 
		 
		 <!--
		 <center>
		 <xsl:call-template name="user_button_withText">
			<xsl:with-param name="button_name">SAVE</xsl:with-param>
			<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='SAVE']/@configLabel"/></xsl:with-param>
			<xsl:with-param name="button_fnc">save()</xsl:with-param>
		 </xsl:call-template>&#160;&#160;
		 <xsl:call-template name="user_button_withText">
			<xsl:with-param name="button_name">CANCEL</xsl:with-param>
			<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='CANCEL']/@configLabel"/></xsl:with-param>
			<xsl:with-param name="button_fnc">cancel()</xsl:with-param>
		 </xsl:call-template>
		 </center>
		 -->
		 
		 <table class="background" cellpadding="2" cellspacing="2" width ="100%" border="0"  align="left">
		 
			<xsl:choose>
				<xsl:when test="normalize-space($readMode)='Y'">
					<xsl:call-template name="user_button_withText">
						<xsl:with-param name="button_name">Close</xsl:with-param>
						<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='Close']/@configLabel"/></xsl:with-param>
						<xsl:with-param name="button_fnc">cancel()</xsl:with-param>
					</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="user_button_withText">
				    <xsl:with-param name="button_name">SAVE</xsl:with-param>
				    <xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='SAVE']/@configLabel"/></xsl:with-param>
				    <xsl:with-param name="button_fnc">save()</xsl:with-param>
				</xsl:call-template>&#160;
				<xsl:call-template name="user_button_withText">
				<!--Tracker:108387: Changes for button name -->
				    <xsl:with-param name="button_name">Close</xsl:with-param>
				    <xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='Close']/@configLabel"/></xsl:with-param>
				<!--Tracker:108387: End of Changes-->
				    <xsl:with-param name="button_fnc">cancel()</xsl:with-param>
				</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</table>
		 
        </body>
        </html>
 </xsl:template>    
         <xsl:template name="PreferencesBO.CorpMiscellaneousInfo.percentage1">
             <xsl:call-template name="label">
                 <xsl:with-param name="res_name" select="$configLabels[@name='PreferencesBO.CorpMiscellaneousInfo.percentage1']"/>
                 <xsl:with-param name="ele_name">PreferencesBO.CorpMiscellaneousInfo.percentage1</xsl:with-param>
                 <xsl:with-param name="ele_val">PreferencesBO.CorpMiscellaneousInfo.percentage1</xsl:with-param>
                 <!--<xsl:with-param name="fn_onBlur">validatePercent("3_PreferencesBO.CorpMiscellaneousInfo.percentage1");formatInt(document.getElementsByName("3_PreferencesBO.CorpMiscellaneousInfo.percentage1")[0],2);</xsl:with-param>-->
                 <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>     
              	<xsl:with-param name="fn_onBlur">formatPercent("3_PreferencesBO.CorpMiscellaneousInfo.percentage1");</xsl:with-param>

             </xsl:call-template>
         </xsl:template>
         
         <xsl:template name="PreferencesBO.CorpMiscellaneousInfo.percentage2">
             <xsl:call-template name="label">
                 <xsl:with-param name="res_name" select="$configLabels[@name='PreferencesBO.CorpMiscellaneousInfo.percentage2']"/>
                 <xsl:with-param name="ele_name">PreferencesBO.CorpMiscellaneousInfo.percentage2</xsl:with-param>
                 <xsl:with-param name="ele_val">PreferencesBO.CorpMiscellaneousInfo.percentage2</xsl:with-param>
                 <!--<xsl:with-param name="fn_onBlur">validatePercent("3_PreferencesBO.CorpMiscellaneousInfo.percentage2");formatInt(document.getElementsByName("3_PreferencesBO.CorpMiscellaneousInfo.percentage2")[0],2);</xsl:with-param>-->
                 <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>     
                 <xsl:with-param name="fn_onBlur">formatPercent("3_PreferencesBO.CorpMiscellaneousInfo.percentage2");</xsl:with-param>

             </xsl:call-template>
         </xsl:template>
         
         <xsl:template name="PreferencesBO.CorpMiscellaneousInfo.percentage3">
             <xsl:call-template name="label">
                 <xsl:with-param name="res_name" select="$configLabels[@name='PreferencesBO.CorpMiscellaneousInfo.percentage3']"/>
                 <xsl:with-param name="ele_name">PreferencesBO.CorpMiscellaneousInfo.percentage3</xsl:with-param>
                 <xsl:with-param name="ele_val">PreferencesBO.CorpMiscellaneousInfo.percentage3</xsl:with-param>
                 <xsl:with-param name="starshow">true</xsl:with-param>
                 <xsl:with-param name="IsMandatory">true</xsl:with-param>
                 <xsl:with-param name="fn_onBlur">validatePercent("3_PreferencesBO.CorpMiscellaneousInfo.percentage3");</xsl:with-param>
                 <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>     
             </xsl:call-template>
         </xsl:template>
         
         <xsl:template name="PreferencesBO.CorpMiscellaneousInfo.amount1">
             <xsl:call-template name="label">
                 <xsl:with-param name="res_name" select="$configLabels[@name='PreferencesBO.CorpMiscellaneousInfo.amount1']"/>
                 <xsl:with-param name="ele_name">PreferencesBO.CorpMiscellaneousInfo.amount1</xsl:with-param>
                 <xsl:with-param name="ele_val">PreferencesBO.CorpMiscellaneousInfo.amount1</xsl:with-param>
                 <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>     
               	<xsl:with-param name="fn_onBlur">formatNumber("3_PreferencesBO.CorpMiscellaneousInfo.amount1");</xsl:with-param>

             </xsl:call-template>
         </xsl:template>
         
         <xsl:template name="PreferencesBO.CorpMiscellaneousInfo.date1">
             <xsl:call-template name="label">
                 <xsl:with-param name="res_name" select="$configLabels[@name='PreferencesBO.CorpMiscellaneousInfo.date1']"/>
                 <xsl:with-param name="ele_name">PreferencesBO.CorpMiscellaneousInfo.date1</xsl:with-param>
                 <xsl:with-param name="ele_val">PreferencesBO.CorpMiscellaneousInfo.date1</xsl:with-param>
                 <xsl:with-param name="fn_onBlur">validateDate();</xsl:with-param>
                 <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>     
             </xsl:call-template>
         </xsl:template>  
		<!--changes for tracker id 349409 BEGIN-->         
    	<xsl:template name="PreferencesBO.CorpMiscellaneousInfo.str1">
			<xsl:call-template name="lookup">
				<xsl:with-param name="res_name" select="$configLabels[@name='PreferencesBO.CorpMiscellaneousInfo.str1']"/>
				<xsl:with-param name="elename">PreferencesBO.CorpMiscellaneousInfo.str1</xsl:with-param>
				<xsl:with-param name="eleval">PreferencesBO.CorpMiscellaneousInfo.str1</xsl:with-param>
				<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
				<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
				<xsl:with-param name="buttonone_fnc">categoryLookup('CURRENCY', 'PreferencesBO.CorpMiscellaneousInfo.str1')</xsl:with-param>
				<xsl:with-param name="buttontwo_fnc">clearCategoryValue('PreferencesBO.CorpMiscellaneousInfo.str1')</xsl:with-param>
				<xsl:with-param name="checkASCII">false</xsl:with-param>
			</xsl:call-template>
    	</xsl:template>      
         		<!--changes for tracker id 349409 END-->
	<xsl:template match="*" mode="mode1">   
	          <form name="frm2" method="post">
			   <input type="hidden" name="hid_PsychographicURL" value="{$PsychographicURL}"/>
			   <input type="hidden" name="hTodayDate" value=""/>	   
			   <input type="hidden" name="CurrencyAccList" value="{$CurrencyAccList}"/>
			    <input type="hidden" name="isMCEditedConcession" value="N"/>
			   <xsl:call-template name="Begin"/>                           
			  	 <xsl:call-template name="PreferencesBO.CorpMiscellaneousInfo.str1"/>
			   	 <xsl:call-template name="PreferencesBO.CorpMiscellaneousInfo.amount1"/>
			   <xsl:call-template name="End"/> 
			   
			   <xsl:call-template name="Begin"/>                           
			  	 <xsl:call-template name="PreferencesBO.CorpMiscellaneousInfo.percentage1"/>
			   	 <xsl:call-template name="PreferencesBO.CorpMiscellaneousInfo.percentage2"/>
			   <xsl:call-template name="End"/> 
			   
			   <xsl:call-template name="Begin"/>                           
			  	 <xsl:call-template name="PreferencesBO.CorpMiscellaneousInfo.percentage3"/>
			   	 <xsl:call-template name="PreferencesBO.CorpMiscellaneousInfo.date1"/>
			   <xsl:call-template name="End"/> 			   
	           </form>                 
        </xsl:template>
    <xsl:template match="SRM">
        <xsl:for-each select=".">       
                    <tr>
                     <td colspan="5" align="left">
                <table border="0" cellspacing="0" cellpadding="1" width="100%" vspace="0" hspace="0">
                   <tr>
                     <xsl:call-template name="apply">
                     <xsl:with-param name="apply_head">
                     <b><xsl:value-of select="$configLabels[@name='Header']/@configLabel"/></b>
                     </xsl:with-param>
                     </xsl:call-template>
                 </tr>
              </table>                
             </td>
            </tr> 
           <xsl:apply-templates select="." mode="mode1"/>
         </xsl:for-each>
        </xsl:template>
        
</xsl:stylesheet>










