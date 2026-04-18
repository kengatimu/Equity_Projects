<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"/>
<xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"/>
        <xsl:param name="locale"/>
    <xsl:variable name="file1">../Renderer/Customization/cif/resource/PsychoCurrencyDet_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<xsl:variable name="configFile_1" select="document(concat($file1,''))"/>
<xsl:variable name="configLabels" select="$configFile_1/SRMBO/*"/>
<xsl:variable name="PsychographicURL" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='PsychographicBO.URL_']"></xsl:variable>
<xsl:variable name="allfields" select="/SRM/SRMData//Z"/>
<xsl:variable name="BaseCurrency" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='BaseCurrency']"></xsl:variable>
<!-- Ticket 237249 changes start-->
<xsl:variable name="CurrencyList" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CurrencyList']"></xsl:variable>  
<xsl:variable name="CurrencyAccList" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CurrencyAccList']"></xsl:variable>
<!-- Ticket 237249 changes end-->
<!-- Callid 411798 changes start-->
<xsl:variable name="BaseCurrencyLoc" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='BaseCurrencyLoc']"></xsl:variable>  
<!-- Callid 411798 changes end-->
<!-- added for Currency:start-->
<xsl:variable name="edit_Curr" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='PsychographicBO.MiscellaneousInfo.strText4']"></xsl:variable>
			<!--changes for tracker id 349409-->
<xsl:variable name="curren1" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='PsychographicBO.MiscellaneousInfo.strText10']"></xsl:variable>
<!-- added for Currency:end-->
<!--Changes for Approval: start-->
<xsl:variable name="boName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='boName']"></xsl:variable>
<!-- ticket 200698 changes to display currency details in view mode in View Customer details option start -->
<xsl:variable name="readMode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='readMode']"></xsl:variable>
<!-- ticket 200698 changes to display currency details in view mode in View Customer details option end -->

<!--Changes for Approval: end-->
<!-- CIF Changes for Caching Views : Start -->
    <xsl:param name="viewname"/>
    <xsl:variable name="PresFileName">../servlet/com.infy.cis.ui.cif.CIF_DetPresCacheServlet?ViewName=<xsl:value-of select="$viewname"/>&amp;BOName=<xsl:value-of select="$boName"/>&amp;Locale=<xsl:value-of select="$locale"/></xsl:variable>
    <xsl:variable name="PresFile" select="document(concat($PresFileName,''))"/>
    <xsl:variable name="PresData" select="$PresFile/SRM/SRMPresentation"/>
<!-- CIF Changes for Caching Views : End -->
<xsl:template match="/">
<html>
<head>
<script>
var locale = '<xsl:value-of select="$locale"/>';
<!-- Ticket 237249 changes -->
var currList = '<xsl:value-of select="$CurrencyList"/>';
var curraccList = '<xsl:value-of select="$CurrencyAccList"/>';
var psychourl = '<xsl:value-of select="$PsychographicURL"/>';
<!--recon by 354929 STARTS-->

var baseCurrency = '<xsl:value-of select="$BaseCurrency"/>';
<!--recon by 354929 ENDS-->
<!--Changes  by 411798 STARTS-->

var baseCurrencyLoc = '<xsl:value-of select="$BaseCurrencyLoc"/>';
<!--Changes  by 411798 ENDS-->
var readMode = '<xsl:value-of select="$readMode"/>'
<!-- Ticket 237249 changes  end-->
</script>
  <title><xsl:value-of select="//SRMPresentation/SRMSystem[@n='Strings']/SRMString[@n='Title']/@value"/></title>
  <LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
  <LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/SRMTableDisplay_{$locale}.css"/>
   <!-- <script type="text/javascript" src="../cif/js/AccForm.js" language="javascript"></script>-->
  <SCRIPT LANGUAGE='javascript' SRC='../common/js/FieldValidate.js'></SCRIPT>
  <!-- TrackerID:209607,CHANGES START -->
  <!--Added for call id:388265 and recon of call 384515 starts-->
  <script type="text/javascript" src="../common/html/utils.js" language="javascript"></script>
  <!--Added for call id: 388265 and recon of call 384515 ends-->
  <script type="text/javascript" src="../common/js/Rendcurrency_cif.js" language="javascript"></script>
  <!-- TrackerID:209607,CHANGES END -->
  
  	

<!--CRM61SR:SRCIUICU :TRACKER# 44233 **BEGIN OF CHANGES-->
  <script type="text/javascript" src="../Customization/js/PsychographicLifeStyleCustom.js" language="javascript"></script>
<!--CRM61SR:SRCIUICU :TRACKER# 44233 **END OF CHANGES-->
  <script type="text/javascript" src="../cif/js/Message_cif_{$locale}.js" language="javascript"></script>
  <script type="text/javascript" language="javascript">
  

  
  </script>
   </head>
    <script type="text/javascript" language="javascript">
    
   function enableClose(){
  			try{
  				document.getElementsByName("Close")[0].disabled = false;
  			}catch(e){
  			}
    }
    
function save()
 {
	// changes by Rozy for CNF
	try{
		removePercentFormat('3_PsychographicBO.MiscellaneousInfo.dbFloat1');
		removePercentFormat('3_PsychographicBO.MiscellaneousInfo.dbFloat2');
		removePercentFormat('3_PsychographicBO.MiscellaneousInfo.dbFloat3');

		FormatBeforeSave_Number('3_PsychographicBO.MiscellaneousInfo.dbFloat4');
	}
	catch(e)
	{
	}

 // CRM61SR:SRCIUICU :TRACKER# 44233 **BEGIN OF CHANGES **
 	try{
 	customSave();
 	}catch(e)
 	{
 	}
// CRM61SR:SRCIUICU :TRACKER# 44233 **END OF CHANGES  **
try{
		 retStat = ValidateFormContents(document.frm2,false);
		 if(retStat == "false") {
			 return "interactive";
		 }
		 //Tracker-103177 changes Begin
		 chk_Date = validateDate();
		 if(chk_Date == "false") {

		 	 return "interactive";
		 }
		 //Tracker-103177 changes End
		 <!-- Ticket 237249 changes start-->
	    	var baseCurrency = '<xsl:value-of select="$BaseCurrency"/>';
	    	var CustomerCurrency = document.getElementsByName("PsychographicBO.MiscellaneousInfo.strText10")[0].value;
		var currList = '<xsl:value-of select="$CurrencyList"/>';
		var curraccList = '<xsl:value-of select="$CurrencyAccList"/>';
		var ind=0;
		var CurrList1=new Array();
		var CurrAccList=new Array();
		var flag=0;
		var flag1=0;
		CurrList1=currList.split(",");
   		CurrAccList= curraccList.split(",");
   		// RemovedCurrency    = document.getElementsByName("PsychographicBO.MiscellaneousInfo.strText10")[0].value;
   		var len = CurrList1.length;
   		if(psychourl!='')
   		{
   		for(ind=len;ind>0;ind--){
					
		
				if(CurrList1[ind]==CustomerCurrency)
				{
				
				    flag=1;
				    continue;
				  
			        }
			 }
			 var chkArray = new Array();
			//Tracker 192434-START
			 /*	 if (flag==1){
			 	  chkArray[0] = CustomerCurrency;
			 	 showUserMessage('MSGJ50878',chkArray);
			 	 return;
			 }*/
			 //Tracker 192434-END
			 len = curraccList.length;
			 for(ind=len;ind>0;ind--){
			
			 		
			 
			 
			 		if(CurrAccList[ind]==CustomerCurrency)
			 		{
			 
			 		   flag1=1;
			 		   continue;
			 		  
			 	        }
			 }
			   
			//Tracker 192434-START
			/*if (flag1==1){
			  chkArray[0] = CustomerCurrency;
			  showUserMessage('MSGJ50877',chkArray);
			  return;
		 }*/
		 //Tracker 192434-END
		} 
	 <!-- Ticket 237249 changes end-->
		//Tracker:90196: Changes for attibute masking
		/*var CreditDiscountPercent = document.getElementsByName("PsychographicBO.MiscellaneousInfo.dbFloat1")[0].value;
		var DebitDiscountPercent = document.getElementsByName("PsychographicBO.MiscellaneousInfo.dbFloat2")[0].value;
		var WithholdTaxPcnt = document.getElementsByName("PsychographicBO.MiscellaneousInfo.dbFloat3")[0].value;*/
		var CreditDiscountPercent = document.getElementsByName("3_PsychographicBO.MiscellaneousInfo.dbFloat1")[0].value;
		var DebitDiscountPercent = document.getElementsByName("3_PsychographicBO.MiscellaneousInfo.dbFloat2")[0].value;
		var WithholdTaxPcnt = document.getElementsByName("3_PsychographicBO.MiscellaneousInfo.dbFloat3")[0].value;
		var PreferentialExpiryDate=document.getElementsByName("PsychographicBO.MiscellaneousInfo.dtDate1")[0].value;
		//Tracker:90196: End of changes for attribute masking
		var CurrencyList = '<xsl:value-of select="$CurrencyList"/>';
   		var CurrencyAccList = '<xsl:value-of select="$CurrencyAccList"/>';
		var WithholdTaxFloorLmt = document.getElementsByName("3_PsychographicBO.MiscellaneousInfo.dbFloat4")[0].value;
		var URL = document.frm2.hid_PsychographicURL.value;
		window.opener.addCurrencyInfo(URL,
						CustomerCurrency,
						CreditDiscountPercent,
						DebitDiscountPercent,
						WithholdTaxPcnt,
						WithholdTaxFloorLmt,
						PreferentialExpiryDate
					     );
		if(document.frm2.isMCEditedPsychoCurrency.value=="Y"){
			top.window.opener.setMCAttModifyFlag();
		}

		self.close();
		window.opener.focus();


	}catch(e){}
  }
  //Tracker-103177 changes Begin
  function validateDate(){
  
  	var todaydate = new String();
  	
  	todaydate.value = getTodayDate();
  	
  	
  	/* ERPBOCF1:113259 Changes start*/	
  	
  	elem1 = document.getElementsByName("PsychographicBO.MiscellaneousInfo.dtDate1")[0];
  	
  	if (elem1.value != '')
{
todaydate.value = convertDate(todaydate.value);
}		
/* ERPBOCF1:113259 Changes end*/	
  		//var mill1 = changetoMillisInUSFormat(todaydate.value);
  		// changes for 330982
var mill1 = changetoMillis(todaydate.value);  		
  		var mill2 = changetoMillis(elem1.value);
  		if (mill1 > mill2){
  			showUserMessage ('MSG_EXP_GEN', 'MSG_EXP_DATE');
  			elem1.value = "";
  			return "false";
  		}
  	return "true";
  }
//Tracker-103177 changes end
//Tracker-123531 changes start
	function cancelStyleDet() {
		
	      if(showConfirmMessage(MSGJ0123)){
			            top.window.close();
			window.opener.focus();
			        }
        
	}
	//Tracker-123531 changes end
	
	function formatDemographyAmount(){
	//Changes for call id:388265 and recon of call : 384515 starts
	var dateExp = document.getElementsByName("3_PsychographicBO.MiscellaneousInfo.dtDate1")[0].value;
	var expDate  = getEndDate1();
	if(dateExp==''){
	   document.getElementsByName("3_PsychographicBO.MiscellaneousInfo.dtDate1")[0].value = expDate;
	}
	else{
	
	   document.getElementsByName("3_PsychographicBO.MiscellaneousInfo.dtDate1")[0].value = dateExp; 
	}
		
	//Changes for call id: 388265  and recon of call 384515 ends
	//changes for ticket id-701662 starts
	if(readMode=='Y'){
	
	document.getElementById("dimg1").style.display = 'none';
	}
	try{
		var curren ='<xsl:value-of select="$edit_Curr"/>';
			<!--changes for tracker id 349409 BEGIN-->
		var curren1 ='<xsl:value-of select="$curren1"/>';
		document.getElementsByName("PsychographicBO.MiscellaneousInfo.strText10")[0].value = "<xsl:value-of select="$curren1"/>";
		document.getElementsByName("Cat_PsychographicBO.MiscellaneousInfo.strText10")[0].value = "<xsl:value-of select="$curren1"/>";
			<!--changes for tracker id 349409 END-->
		document.getElementsByName("PsychographicBO.MiscellaneousInfo.strText4")[0].value=curren;
		formatAmount("3_PsychographicBO.MiscellaneousInfo.dbFloat1","PsychographicBO.MiscellaneousInfo.strText4","N");
		}catch(e)
		{
		}
	
	    var dbFloat1 = document.getElementsByName("3_PsychographicBO.MiscellaneousInfo.dbFloat1")[0].value;
		var dbFloat2 = document.getElementsByName("3_PsychographicBO.MiscellaneousInfo.dbFloat2")[0].value;
		var dbFloat3 = document.getElementsByName("3_PsychographicBO.MiscellaneousInfo.dbFloat3")[0].value;
	
		if(dbFloat1 == ''){
			document.getElementsByName("3_PsychographicBO.MiscellaneousInfo.dbFloat1")[0].value = 0;
		}
		if(dbFloat2 == ''){
			document.getElementsByName("3_PsychographicBO.MiscellaneousInfo.dbFloat2")[0].value = 0;
		}
		if(dbFloat3 == ''){
			document.getElementsByName("3_PsychographicBO.MiscellaneousInfo.dbFloat3")[0].value = 0;
		}
	
		// changes by Rozy for CNF
		formatPercent("3_PsychographicBO.MiscellaneousInfo.dbFloat1");
		formatPercent("3_PsychographicBO.MiscellaneousInfo.dbFloat2");
		formatPercent("3_PsychographicBO.MiscellaneousInfo.dbFloat3");
	formatNumber("3_PsychographicBO.MiscellaneousInfo.dbFloat4");
	
	}

	//changes for ticket id-701662 ends

	   function setMCAttModifyFlag(){
			document.frm2.isMCEditedPsychoCurrency.value="Y";
	}
	function setValue()
	{
		//recon for 354929 STARTS

                var Currency = document.getElementsByName("PsychographicBO.MiscellaneousInfo.strText10")[0].value;
		var WithholdTaxFloor = document.getElementsByName("3_PsychographicBO.MiscellaneousInfo.dbFloat4")[0].value;
		try{
		if(WithholdTaxFloor=='')
		document.getElementsByName("3_PsychographicBO.MiscellaneousInfo.dbFloat4")[0].value='0';
		else
		document.getElementsByName("3_PsychographicBO.MiscellaneousInfo.dbFloat4")[0].value=WithholdTaxFloor;
		if (Currency == '' || Currency == null){	
		//411798 changes
			document.getElementsByName("Cat_PsychographicBO.MiscellaneousInfo.strText10")[0].value = baseCurrencyLoc;
			document.getElementsByName("PsychographicBO.MiscellaneousInfo.strText10")[0].value = baseCurrency;
			categoryLookup('CURRENCY', 'PsychographicBO.MiscellaneousInfo.strText10',true);
			document.getElementsByName("Cat_PsychographicBO.MiscellaneousInfo.strText10")[0].value = baseCurrency;
		//Changes for Ticket 726398 ends
		}
		//recon for 354929 ends
		}catch(e)
		{}
	}

	function check(){
        var CreditDiscountPercent = document.getElementsByName("3_PsychographicBO.MiscellaneousInfo.dbFloat1")[0].value;
	var DebitDiscountPercent = document.getElementsByName("3_PsychographicBO.MiscellaneousInfo.dbFloat2")[0].value;
        var WithholdTaxPcnt = document.getElementsByName("3_PsychographicBO.MiscellaneousInfo.dbFloat3")[0].value;
        if(CreditDiscountPercent > 100){
        showMessage(MSGJ50101);
	document.getElementsByName("3_PsychographicBO.MiscellaneousInfo.dbFloat1")[0].value = "";
	document.getElementsByName("3_PsychographicBO.MiscellaneousInfo.dbFloat1")[0].focus();
	}
	else if(DebitDiscountPercent > 100){
	showMessage(MSGJ50101);
	document.getElementsByName("3_PsychographicBO.MiscellaneousInfo.dbFloat2")[0].value = "";
	document.getElementsByName("3_PsychographicBO.MiscellaneousInfo.dbFloat2")[0].focus();
	}
	else if(WithholdTaxPcnt > 100){
	showMessage(MSGJ50101);
	document.getElementsByName("3_PsychographicBO.MiscellaneousInfo.dbFloat3")[0].value = "";
	document.getElementsByName("3_PsychographicBO.MiscellaneousInfo.dbFloat3")[0].focus();
	}
       }
			</script>
          <body class="popup">
          
		<xsl:choose>
		
		<xsl:when test="normalize-space($PsychographicURL)=''">
			<xsl:attribute name="onload">formatDemographyAmount();setValue();</xsl:attribute>
		</xsl:when>
		
		<xsl:otherwise>
			<!-- ticket 200698 changes to display currency details in view mode in View Customer details option start -->    	  
			<xsl:attribute name="onload">formatDemographyAmount();showInReadOnlyMode('<xsl:value-of select="$readMode"/>');enableClose();</xsl:attribute>
<!-- ticket 200698 changes to display currency details in view mode in View Customer details option end -->
    	  </xsl:otherwise>
        </xsl:choose>
		   <table class="background" width="100%" cellpadding="0" cellspacing="0" border="0"  align="center">
                 <xsl:apply-templates select="SRM"/>
                 </table>
                 <table class="background" width="100%" cellpadding="0" cellspacing="0" border="0"  align="center">

		 <xsl:choose>
		 	<xsl:when test="normalize-space($readMode)='Y'">
		 	<xsl:call-template name="user_button">
		 		<xsl:with-param name="button_name">Close</xsl:with-param>
		 		<xsl:with-param name="button_fnc">cancelStyleDet()</xsl:with-param>
		 	</xsl:call-template>
		 	</xsl:when>
		 	<xsl:otherwise>
		 	<xsl:call-template name="user_button_withText">
		 		<xsl:with-param name="button_name">SAVE</xsl:with-param>
		 		<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='SAVE']/@configLabel"/></xsl:with-param>
		 		<xsl:with-param name="button_fnc">save()</xsl:with-param>
		 		</xsl:call-template>&#160;
		 	
		 	
		 		<xsl:call-template name="user_button_withText">
		 		<!-- TRACKER ID 108387 begin changes for close button -->
		 		<xsl:with-param name="button_name">Close</xsl:with-param>
		 		<!-- Tracker-123531 changes start -->
		 		<xsl:with-param name="button_text"><xsl:value-of select="$configLabels[@name='CANCEL']/@configLabel"/></xsl:with-param>
		 		<!-- Tracker-123531 changes end -->
		 		<xsl:with-param name="button_fnc">cancelStyleDet()</xsl:with-param>  
		 	</xsl:call-template>
		 	</xsl:otherwise>
	</xsl:choose>
                </table>
         </body>
         </html>
		  </xsl:template>
			<!--changes for tracker id 349409 BEGIN-->
   <xsl:template name="PsychographicBO.MiscellaneousInfo.strText10">
   	        <xsl:call-template name="lookup">
   			<xsl:with-param name="res_name" select="$configLabels[@name='PsychographicBO.MiscellaneousInfo.strText10']"/>
   			<xsl:with-param name="elename"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText10</xsl:with-param>
   			<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.MiscellaneousInfo.strText10</xsl:with-param>
   			<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
   			<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
   			<xsl:with-param name="buttonone_fnc">categoryLookup('CURRENCY', '<xsl:value-of select="$boName"/>.MiscellaneousInfo.strText10')</xsl:with-param>
   			<xsl:with-param name="buttontwo_fnc">clearCategoryValue('<xsl:value-of select="$boName"/>.MiscellaneousInfo.strText10')</xsl:with-param>
   			<xsl:with-param name="checkASCII">false</xsl:with-param>
   		</xsl:call-template>
	        </xsl:template>	
			<!--changes for tracker id 349409 END-->

   <xsl:template name="PsychographicBO.MiscellaneousInfo.dbFloat1">
         <xsl:call-template name="label">
		 <xsl:with-param name="res_name" select="$configLabels[@name='PsychographicBO.MiscellaneousInfo.dbFloat1']"/>
		 <xsl:with-param name="ele_name">PsychographicBO.MiscellaneousInfo.dbFloat1</xsl:with-param>
		 <xsl:with-param name="ele_val">PsychographicBO.MiscellaneousInfo.dbFloat1</xsl:with-param>
		 <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		<xsl:with-param name="fn_onBlur">check();formatPercent("3_PsychographicBO.MiscellaneousInfo.dbFloat1");</xsl:with-param>


    	     </xsl:call-template>
   </xsl:template>

   <xsl:template name="PsychographicBO.MiscellaneousInfo.dbFloat2">
             <xsl:call-template name="label">
		 <xsl:with-param name="res_name" select="$configLabels[@name='PsychographicBO.MiscellaneousInfo.dbFloat2']"/>
		 <xsl:with-param name="ele_name">PsychographicBO.MiscellaneousInfo.dbFloat2</xsl:with-param>
		 <xsl:with-param name="ele_val">PsychographicBO.MiscellaneousInfo.dbFloat2</xsl:with-param>
		 <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		 <xsl:with-param name="fn_onBlur">check();formatPercent("3_PsychographicBO.MiscellaneousInfo.dbFloat2");</xsl:with-param>

    	     </xsl:call-template>
   </xsl:template>


    <xsl:template name="PsychographicBO.MiscellaneousInfo.dbFloat3">
             <xsl:call-template name="label">
		 <xsl:with-param name="res_name" select="$configLabels[@name='PsychographicBO.MiscellaneousInfo.dbFloat3']"/>
		 <xsl:with-param name="ele_name">PsychographicBO.MiscellaneousInfo.dbFloat3</xsl:with-param>
		 <xsl:with-param name="ele_val">PsychographicBO.MiscellaneousInfo.dbFloat3</xsl:with-param>
             <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
          <xsl:with-param name="fn_onBlur">check();formatPercent("3_PsychographicBO.MiscellaneousInfo.dbFloat3");</xsl:with-param>

    	     </xsl:call-template>
    </xsl:template>

    <xsl:template name="PsychographicBO.MiscellaneousInfo.dbFloat4">
                <xsl:call-template name="label">
    		 <xsl:with-param name="res_name" select="$configLabels[@name='PsychographicBO.MiscellaneousInfo.dbFloat4']"/>
    		 <xsl:with-param name="ele_name">PsychographicBO.MiscellaneousInfo.dbFloat4</xsl:with-param>
    		 <xsl:with-param name="ele_val">PsychographicBO.MiscellaneousInfo.dbFloat4</xsl:with-param>
                 <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
                 <xsl:with-param name="fn_onBlur">formatNumber("3_PsychographicBO.MiscellaneousInfo.dbFloat4");</xsl:with-param>
        	</xsl:call-template>
    </xsl:template>


    <xsl:template name="PsychographicBO.MiscellaneousInfo.dtDate1">
                <xsl:call-template name="label">
                    <xsl:with-param name="res_name" select="$configLabels[@name='PsychographicBO.MiscellaneousInfo.dtDate1']"/>
                    <xsl:with-param name="ele_name">PsychographicBO.MiscellaneousInfo.dtDate1</xsl:with-param>
                    <xsl:with-param name="ele_val">PsychographicBO.MiscellaneousInfo.dtDate1</xsl:with-param>
                   <!-- <xsl:with-param name="fn_onBlur">validateDate();</xsl:with-param> -->
                    <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
                    <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
                    <!-- calling the function isGregDate for on blur functionality-->
                    <xsl:with-param name="fn_onBlur">isGregDate("3_PsychographicBO.MiscellaneousInfo.dtDate1");</xsl:with-param>
                    <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
                </xsl:call-template>
   </xsl:template>
	<xsl:template match="*" mode="mode1">
	          <form name="frm2" method="post">
			  <input type="hidden" name="hid_PsychographicURL" value="{$PsychographicURL}"/>
			  <input type="hidden" name="hTodayDate" value=""/>
			  <input type="hidden" name="boName" value="{$boName}"/>
			  <input type="hidden" name="isMCEditedPsychoCurrency" value="N"/>
			  <!-- currency validation change-->
			<input type="hidden" name="CurrencyList" value="{$CurrencyList}"/>
			<input type="hidden" name="CurrencyAccList" value="{$CurrencyAccList}"/>	
			<!-- currency validation change ends-->	
		<xsl:call-template name="Begin"/>
		 <xsl:call-template name="PsychographicBO.MiscellaneousInfo.strText10"/>
		 <xsl:call-template name="PsychographicBO.MiscellaneousInfo.dbFloat1"/>
		<xsl:call-template name="End"/>
		<xsl:call-template name="Begin"/>

		 <xsl:call-template name="PsychographicBO.MiscellaneousInfo.dbFloat2"/>
		 <xsl:call-template name="PsychographicBO.MiscellaneousInfo.dbFloat3"/>
		<xsl:call-template name="End"/>
		<xsl:call-template name="Begin"/>
		 <xsl:call-template name="PsychographicBO.MiscellaneousInfo.dbFloat4"/>
		 <xsl:call-template name="PsychographicBO.MiscellaneousInfo.dtDate1"/>
		<xsl:call-template name="End"/>

	<!-- Start DataArray  -->
   <script>
        var DataArray = new Array;
        var DataCount = 0;
        <xsl:for-each select="/SRM/SRMData[@SRMDataSpace='Currency']/SRMComposite[@n='CurrencyRecordSet']/SRMRow">
            DataArray[DataCount] = '<xsl:value-of select="./Z[@n='CurrencyBO.CurrencyCode']"/>' + "|" + '<xsl:value-of select="./Z[@n='CurrencyBO.Format']"/>' + "|" + '<xsl:value-of select="./Z[@n='CurrencyBO.NumberOfDecimals']"/>' + "|" + '<xsl:value-of select="./Z[@n='CurrencyBO.MantissaSeperator']"/>'+"|"+'<xsl:value-of select="./Z[@n='CurrencyBO.DecimalSeperator']"/>';
            DataCount++;
        </xsl:for-each>
        var iCount = 0;
        ExArray = new Array;
        <xsl:for-each select="/SRM/SRMData[@SRMDataSpace='ExRate']/SRMComposite[@n='ExRateRecordSet']/SRMRow">
            ExArray[iCount] = '<xsl:value-of select="./Z[@n='ExchangeRateBO.FixedCurrencyCode']"/>' + "|" + '<xsl:value-of select="./Z[@n='ExchangeRateBO.VariableCurrencyCode']"/>' + "|" + '<xsl:value-of select="./Z[@n='ExchangeRateBO.NumberOfUnits']"/>' + "|" + '<xsl:value-of select="./Z[@n='ExchangeRateBO.ExchangeRate']"/>'
            iCount++;
        </xsl:for-each>
</script>
<!-- End DataArray -->
  </form>
	  </xsl:template>
      <xsl:template match="SRM">
	  <xsl:for-each select=".">
		      <table border="0" cellspacing="0" cellpadding="0" width="100%" class="tableborder" vspace="0" hspace="0">
			 <tr>
			  <td>
			    <table border="0" bgcolor='ffffff' cellspacing="0" cellpadding="0" class="innertable" width="100%" vspace="0" hspace="0">
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
			   <table bgcolor='ffffff' width="100%" border="0" cellspacing="0" cellpadding="2">
			      <xsl:apply-templates select="." mode="mode1"/>
				</table>
			      </td>
			   </tr>
			  </table>
			 </td>
			</tr>
	</table>
	   </xsl:for-each>
	  </xsl:template>

	  
  </xsl:stylesheet>











