<?xml version='1.0'?>
 <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 	<xsl:import href="../Renderer/common/display/getJVMProperties.xsl"/>
        <xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"/>
        <xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"/>


        <xsl:param name="locale"/>
        <!--ERPBOCF1:TRACKER113259:STORAGE OF DATES :STARTOFCHANGES-->
		<xsl:param name="ALTCALENDAR_TYPE"/>
<!--ERPBOCF1:TRACKER113259: STORAGE OF DATES :ENDOFCHANGES-->
         <!--tracker id 113227 starts-->
	<xsl:param name="altLocaleActv"/>
        <!--tracker id 113227 ends-->
    <xsl:variable name="file1">../Renderer/cif/resource/RetailTFInfo_<xsl:value-of select="$locale"/>.xml</xsl:variable>
	<xsl:variable name="configFile_1" select="document(concat($file1,''))"/>
	<xsl:variable name="boName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='boName']"></xsl:variable>
	<xsl:variable name="boDet" select="/SRM/SRMData[@SRMDataSpace='Main']/SRMComposite [@n=$boName]/Z"/>
	<xsl:variable name="dc_SanctioningAuthority" select="$boDet[@n=concat($boName,'.dc_SanctioningAuthority')]"/>
	<xsl:variable name="fc_SanctioningAuthority" select="$boDet[@n=concat($boName,'.fc_SanctioningAuthority')]"/>
	<xsl:variable name="party_Type"  select="$boName[@n=concat($boName,'.party_Type')]"/>
	<xsl:variable name="exp_Imp_Ind" select="$boDet[@n=concat($boName,'.exp_Imp_Ind')]"/>

	<xsl:variable name="entityType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='entityType']"></xsl:variable>
	<xsl:variable name="accountID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='accountID']"></xsl:variable>
	<!--<xsl:variable name="boName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='boName']"></xsl:variable>-->
	<xsl:variable name="accountKey" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='accountKey']"></xsl:variable>
	<xsl:variable name="apprFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='apprFlag']"></xsl:variable>
	<xsl:variable name="operationType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='operationType']"></xsl:variable>
	<xsl:variable name="byPassFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='byPassFlag']"></xsl:variable>
	<xsl:variable name="isCopy" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='isCopy']"></xsl:variable>
	<xsl:variable name="readMode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsReadOnly']"/>
        <xsl:variable name="configLabels" select="$configFile_1/SRMBO/*"/>
        <xsl:variable name="SRMTips" select="$configLabels[@name='Tips']/@value"/>
	<xsl:variable name="tFinURL" select="//SRMData//Z[@n=concat($boName,'.url_')]"></xsl:variable>
	<xsl:variable name="mainAccId" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='mainAccId']"></xsl:variable>

	<!-- vasanth's changes start -->
<xsl:variable name="dob" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='dob']"></xsl:variable>
    <xsl:variable name="BlackListed" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='BlackListed']"></xsl:variable>
    <xsl:variable name="Suspended" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Suspended']"></xsl:variable>
    <xsl:variable name="Negated" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='Negated']"></xsl:variable>
    <xsl:variable name="chkBSN" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='chkBSN']"></xsl:variable>

	<!-- vasanth's changes end -->
 <xsl:variable name="getMCRequired" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='MCRequired']"></xsl:variable>
 <xsl:variable name="mcJNDIFlag" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='mcJNDIFlag']"></xsl:variable>
 <xsl:variable name="isMCEdited" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='isMCEdited']"></xsl:variable>

	<xsl:variable name="concurDetectX" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='TradeFinanceBO.concurDetect_X']"></xsl:variable>
	<xsl:variable name="BaseCurrency" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='BaseCurrency']"/>
	<!-- Change for tracker 183462 by Badri -->
	<xsl:variable name="currencyCode" select="//SRMData[@SRMDataSpace='Main']/SRMComposite/Z[@n=concat($boName,'.crncy_Code')]"></xsl:variable>
	<xsl:variable name="entityKey" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='entityKey']"/>
	<xsl:variable name="entityName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='entityName']"/>
<!--changes for tracker 401769 fullname alteration begins-->
	<xsl:variable name="fullname" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='fullname']"/>

<!--changes for tracker 401769 fullname alteration ends-->
	<!--TrackerID 175120 :: START-->
	<xsl:variable name="PresFileName">../servlet/com.infy.cis.ui.cif.Acc_DetPresCacheServlet?ViewName=Ret_TradeFinance_Info&amp;BOName=<xsl:value-of select="$boName"/>&amp;Locale=<xsl:value-of select="$locale"/></xsl:variable>
	<xsl:variable name="PresFile" select="document(concat($PresFileName,''))"/>
	<xsl:variable name="PresCurrData" select="$PresFile/SRM/SRMData[@SRMDataSpace='Currency']"/>
	<!--TrackerID 175120 :: END-->

	<!--  Tracker ID:253845    -->
	    <xsl:variable name="convToCust" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='convToCust']"></xsl:variable>
	    <xsl:variable name="oldEntityType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='oldEntityType']"></xsl:variable>    
	    <xsl:variable name="oldEntityID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='oldEntityID']"></xsl:variable>    
	<!--  Tracker ID:253845    -->

<xsl:template match="/">
<html>
<head>
<!--Performance-->
<!--<script type="text/javascript" src="../common/js/ClientResourceBundle_{$locale}.js" language="javascript"></script>-->
<!--Performance-->
<script type="text/javascript" src="../cif/js/Message_cif_{$locale}.js" language="javascript"></script>
	<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Admin_{$locale}.css"/>
	<link rel="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
	<link rel="stylesheet" Type="text/css" href="../Branding/css/common/MultiTabs_{$locale}.css"/>
	<title><xsl:value-of select="//SRMPresentation/SRMSystem[@n='Strings']/SRMString[@n='Title']/@value"/></title>
<!--Performance-->
<!--	<script type="text/javascript" src="../common/html/validate.js" language="javascript"></script>-->
<!--Performance-->
	<!-- TrackerID:209607,CHANGES START -->
	<script type="text/javascript" src="../common/js/Reduce_Form.js" language="javascript"></script>
	<!-- TrackerID:209607,CHANGES END -->
<!--Performance-->
<!--	<script type="text/javascript" src="../common/html/utils.js" language="javascript"></script>-->
<!--Performance-->
    <!--performance patch:Commenting duplicate js call:354529-->
	<!--<script type="text/javascript" id="TableRowColor" src="../common/js/SRMTableRowColor.js"></script>-->
<!--Performance-->
	<!-- vasanth's changes start -->
<!--Performance-->
<!--	<script type="text/javascript" src="../common/html/validateL2.js" language="javascript"></script>-->
<!--Performance-->
<!-- vasanth's changes end -->
	<script type="text/javascript" src="../common/js/Rendcurrency_cif.js" language="javascript"></script>
	<script type="text/javascript" src="../common/js/SRMFormToggle.js"></script>
	<script>
	    var tFinURL = '<xsl:value-of select="$tFinURL"/>';
	    var apprFlag = '<xsl:value-of select="$apprFlag"/>';
	    /******* Save and Submit Changes : Start*********/
	    var operationType = '<xsl:value-of select="$operationType"/>';
   	    /******* Save and Submit Changes : End *********/
	    var boName = '<xsl:value-of select="$boName"/>';
	    var isCopy = '<xsl:value-of select="$isCopy"/>';

	    <!-- Change for tracker 183462 by Badri -->
	    var currencyCode = '<xsl:value-of select="$currencyCode"/>';
	    var locale = '<xsl:value-of select="$locale"/>';
	    var entityType = '<xsl:value-of select="$entityType"/>';
	    var accountKey = '<xsl:value-of select="$accountKey"/>';
	    var accountID = '<xsl:value-of select="$accountID"/>';
	    var readMode = '<xsl:value-of select="$readMode"/>';
	    var mainAccId = '<xsl:value-of select="$mainAccId"/>';
	    var submit = false;
	<!-- vasanth's changes start -->
		var BlackListed = '<xsl:value-of select="$BlackListed"/>';
		var Suspended = '<xsl:value-of select="$Suspended"/>';
		var Negated =  '<xsl:value-of select="$Negated"/>';
		var chkBSNFlg = '<xsl:value-of select="$chkBSN"/>';
		var dob = '<xsl:value-of select="$dob"/>';
		var entityKey = '<xsl:value-of select="$entityKey"/>';
		var entityName = '<xsl:value-of select="$entityName"/>';
<!--changes for tracker 401769 fullname alteration begins-->
		var fullname = '<xsl:value-of select="$fullname"/>';
<!--changes for tracker 401769 fullname alteration ends-->
	<!-- vasanth's changes end -->
	/*Changes for Tracker 87171 - Start */
	    var baseCurrency = '<xsl:value-of select="$BaseCurrency"/>';
	    var DataArray = new Array;
	    var ExArray = new Array;

		var DataCount = 0;
		<xsl:for-each select="/SRM/SRMData[@SRMDataSpace='Currency']/SRMComposite[@n='CurrencyRecordSet']/SRMRow">
		    DataArray[DataCount] = '<xsl:value-of select="./Z[@n='CurrencyBO.CurrencyCode']"/>' + "|" + '<xsl:value-of select="./Z[@n='CurrencyBO.Format']"/>' + "|" + '<xsl:value-of select="./Z[@n='CurrencyBO.NumberOfDecimals']"/>' + "|" + '<xsl:value-of select="./Z[@n='CurrencyBO.MantissaSeperator']"/>'+"|"+'<xsl:value-of select="./Z[@n='CurrencyBO.DecimalSeperator']"/>';
		    DataCount++;

		</xsl:for-each>

		var iCount = 0;
        var cifMessage = '<xsl:value-of select="$configLabels[@name='CIFMESSAGE']/@configLabel"/>';

		<xsl:for-each select="/SRM/SRMData[@SRMDataSpace='ExRate']/SRMComposite[@n='ExRateRecordSet']/SRMRow">
		    ExArray[iCount] = '<xsl:value-of select="./Z[@n='ExchangeRateBO.FixedCurrencyCode']"/>' + "|" + '<xsl:value-of select="./Z[@n='ExchangeRateBO.VariableCurrencyCode']"/>' + "|" + '<xsl:value-of select="./Z[@n='ExchangeRateBO.NumberOfUnits']"/>' + "|" + '<xsl:value-of select="./Z[@n='ExchangeRateBO.ExchangeRate']"/>'
		    iCount++;
		</xsl:for-each>
  	/*Changes for Tracker 87171 - End */

	</script>
	<style>
	    size{width=120px;}
	</style>

     <!-- vasanth's changes start -->
     <script type="text/javascript" src="../cif/js/CheckBSNFlags.js" language="javascript"></script>
	<!-- vasanth's changes end -->
	<script>

	<![CDATA[function showFormTips() {


	                parent.parent.parent.parent.removeTips(parent.parent.parent.parent.frames(0).getSelectedTabId());
	                parent.parent.parent.parent.addTip(parent.parent.parent.parent.frames(0).getSelectedTabId(),"]]><xsl:value-of select="$SRMTips"/><![CDATA[");
	   if(accountID =="" || accountID == null || isCopy =='Y'){
	                parent.parent.parent.parent.addTip(parent.parent.parent.parent.frames(0).getSelectedTabId(), cifMessage);
	                }
	                parent.parent.parent.parent.showTip(parent.parent.parent.parent.frames(0).getSelectedTabId());
	                parent.parent.parent.parent.showTipsButton();

	        }
     ]]>


<!-- Tracker ID: 108385: Begin of changes : For focus on first field -->
function focusFirstField()
{
	try
	{
		document.getElementsByName("TradeFinanceBO.central_BankCode")[0].focus();
	}
	catch (e)
	{
	}
}
<!-- Tracker ID: 108385: End of changes -->

<!--ERPBOCF1:TRACKER:113259:STORAGE OF DATES :ENDOFCHANGES-->
function fnConvertDate(){

	var strSDcSancExpiryDt =document.getElementsByName("3_TradeFinanceBO.dc_SanctionExpiryDate")[0].value;
	var strReviewDate  =    document.getElementsByName("3_TradeFinanceBO.review_Date")[0].value;
	var strALTCALENDAR_TYPE = document.all.ALTCALENDAR_TYPE.value;
	if(strALTCALENDAR_TYPE == 'true')
		{
			if(strSDcSancExpiryDt != '')

			{
				var strFlag = isGregDateWithoutConv(strSDcSancExpiryDt);
				if(strFlag != 'true')
				{
					strSDcSancExpiryDt=convertHijToGreg(strSDcSancExpiryDt);
				}
			}
			if(strReviewDate != '')

				{
					var strFlag = isGregDateWithoutConv(strReviewDate);
					if(strFlag != 'true')
					{
						strReviewDate=convertHijToGreg(strReviewDate);
					}
			}
		}


		document.all.dcSancExpiryDt.value = strSDcSancExpiryDt;
		document.all.reviewDate.value = strReviewDate;


	}


<!--ERPBOCF1:TRACKER113259:STORAGE OF DATES :ENDOFCHANGE-->

	/******* Save and Submit Changes to know whether SAVE OR SUBMIT button pressed by passing the blFlag from CIFShowButtons.Html to the save()******/
	  function save(blFlag)
	    {


		if(document.frm2.isMCEdited.value=="Y"){
			document.frm2.isMCEditedTF.value="Y";
		}
		if(operationType!="Edit Entity"){
			if(operationType!="Queue"){
				document.frm2.isMCEditedTF.value=parent.parent.IFrmtab0.formDispFrame.document.frm2.isMCEditedGeneral.value;
			}
		}
		//changes by Rozy for CNF
		try
		{

		removePercentFormat('3_TradeFinanceBO.dc_MarginPercentage');
		FormatBeforeSave_Number('2_TradeFinanceBO.production_Cycle');
		FormatBeforeSave("3_TradeFinanceBO.cntrct_Limit");

		     var chkStat = "true";
		var accountID = '<xsl:value-of select="$accountID"/>';
		var tFinURL = '<xsl:value-of select="$tFinURL"/>';
		var isCopy = '<xsl:value-of select="$isCopy"/>';
		var entityType = '<xsl:value-of select="$entityType"/>';
		if(accountID =="" || accountID == null || isCopy =='Y')
		{
		    var accountID = parent.parent.IFrmtab0.formDispFrame.document.getElementsByName("accID")[0].value;
		}
               // vasanth's changes start

			var hasErrors = "";
        	var selTabId;
			var frameobj;

				if (top.frames(0).tabViewFrm==null)
				{
					frameobj = parent.parent.parent.parent;
					selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
				}else{
					frameobj = top.frames(0);
					selTabId = top.frames(0).tabViewFrm.getSelectedTabId();

				}

			hasErrors = ValidateDateFields(getUserMessage("MSG_DOB","dob"),dob);

			if(hasErrors == "true") {
					parent.parent.parent.parent.messageFrm.showMessages(selTabId);
					return "interactive";
			}


		// vasanth's changes end


	/***************** Save and Submit Changes : If SUBMIT pressed, do the Validation for all the Form Elements: Start************************/
		    /*if(blFlag == true) {
			noValidationMsg = false;
		    }
		    else {
			noValidationMsg = true;
		    }*/
		    //chkStat = parent.parent.parent.parent.ValidateFormContents(document.frm2,true, noValidationMsg);

	/********* Save and Submit Changes : Setting saveFlag=1 for SAVE and saveFlag=0 for SUBMIT:Start***********/
		if(blFlag==false)
		{
		    document.frm2.saveFlag.value=1;

		}
		else
		{
		    document.frm2.saveFlag.value=0;

		}
		/********* Save and Submit Changes : Setting saveFlag=1 for SAVE and saveFlag=0 for SUBMIT:End***********/
		    if (entityType=='Account')
		    {
		    document.getElementsByName("ModAccID")[0].value = parent.parent.IFrmtab0.formDispFrame.document.getElementsByName("ModAccID")[0].value;
		    }
		    document.getElementsByName("AddressFields")[0].value = parent.parent.IFrmtab0.formDispFrame.document.getElementsByName("AddressFields")[0].value;
		    document.getElementsByName("OtherTFFields")[0].value = parent.parent.IFrmtab0.formDispFrame.document.getElementsByName("OtherTFFields")[0].value;
		    document.getElementsByName("CoreCustID")[0].value = parent.parent.IFrmtab0.formDispFrame.document.getElementsByName("CoreCustID")[0].value;


		    if(chkStat == 'true'||chkStat == true)
		    {

<!--ERPBOCF1:TRACKER:113259:STORAGE OF DATES :ENDOFCHANGES-->
 			fnConvertDate();
<!--ERPBOCF1:TRACKER113259:STORAGE OF DATES :ENDOFCHANGE-->
		 /* Null Changes Begin */



                   /*begin Ticket:: 355587 Tracker ID :: 217480*/

                   if(entityType == 'NonCustomer' || operationType== 'Queue' || operationType=='Edit Entity' )
                   {
                      var frame = 'formSaveFrame';
		      newPara = document.getElementById("myPar");
                      TFURL="../servlet/com.infy.cis.ui.cif.RetailTFWriter?accountID=" + accountID +'&amp;accountKey=' +accountKey;
                      fnRemoveNull(newPara,TFURL,document.frm2,frame);
                   }
                   else
                   {

                     /*changes for Ticket 355787 , Tracker 217702:begin*/
                      var tfFlag = parent.parent.IFrmtab0.formDispFrame.document.getElementsByName("TfFlag")[0].value;
                          if(tfFlag=='Y')
                           {
		             var frame = 'formSaveFrame';
		             newPara = document.getElementById("myPar");
		             TFURL="../servlet/com.infy.cis.ui.cif.RetailTFWriter?accountID=" + accountID +'&amp;accountKey=' +accountKey;
		             fnRemoveNull(newPara,TFURL,document.frm2,frame);
		           }
		      /*changes for Ticket 355787 , Tracker 217702:end*/
                   }
                   /*Ticket:: 355587 Tracker ID :: 217480 end*/
                    return 'true';
                     }
                     else
			return 'false';


		}
		catch(ex)
		{
		    throw ex;
		}
	    }

//Changes begin for Tracker:97346
   <![CDATA[
     function check(Tab,setFlag) {

     	/* Fix for ticket no 199756 start */
	var phLocalCode = document.getElementsByName("TradeFinanceBO.phone.localcode")[0].value;
	if(isNaN(phLocalCode))
	{
	     document.getElementsByName("TradeFinanceBO.phone.localcode")[0].value = '';

	}
     	/* Fix for ticket no 199756 end */


	if((accountID =="" || accountID == null || isCopy =="Y") && (entityType != "NonCustomer")){
	    var tfFlagAvl = parent.parent.IFrmtab0.formDispFrame.document.getElementsByName("TfFlag")[0].value;

	    if(tfFlagAvl == 'N' || tfFlagAvl == ''){
		   //Tracker 99827 changes BEGIN
		   document.getElementsByName(boName+".inland_Trade_Allowed")[0].IsMandatory = "false";
		   document.getElementsByName(boName+".cust_Native")[0].IsMandatory = "false";
	    	   //Tracker 99827 changes BEGIN
	    }
	}

	if(setFlag == false) {
		noValidationMsg = true;
	}
	else {

		noValidationMsg = false;
	}

	removePercentFormat('3_TradeFinanceBO.dc_MarginPercentage');
	return parent.parent.parent.parent.ValidateFormContents(document.frm2,true,noValidationMsg,Tab);

       }]]>
//Changes end for Tracker:97346

	    // CRM70t-ST :TRACKER# 78533 **BEGIN OF CHANGES **
	    function validatePercent(x){
			var perValue = document.getElementsByName(x)[0].value;
			if (perValue > 100){
				showMessage(MSGX0057);
				document.getElementsByName(x)[0].focus();
			}
		}
	    // CRM70t-ST :TRACKER# 78533 **END OF CHANGES **

	function setFocusOnComp(compName) {
		var elementName = document.getElementsByName(compName)[0];
		if(elementName) {
		    if(elementName.displayFieldName){
			elementName = document.getElementsByName(elementName.displayFieldName)[0];
		    }
		    if (elementName.type == 'text' || elementName.type == 'textarea')
		    {
			elementName.select();
		    }else{
			elementName.focus();
		    }
		}
	}
function showbuttonsVisible(btnFrmSize) {
try{
parent.parent.parent.parent.setCifButtonsVisible(true,btnFrmSize);
}catch(e)
{}
}


	function  clear()
	{
	    try
	    {
	        var accountID = '<xsl:value-of select="$accountID"/>';
	        var isCopy = '<xsl:value-of select="$isCopy"/>';
	        if(accountID =="" || accountID == null || isCopy =='Y')
	    	{
			document.getElementsByName("accountID")[0].value = parent.formSaveFrame.savedValue;
			//document.getElementsByName("ProcID")[0].value = parent.formSaveFrame.savedProcID;

			/*if(parent.formSaveFrame.savedValue == null)
			{
				if(isCopy == 'Y')
				{
					parent.parent.parent.parent.parent.parent.frames(0).submit();
				}
			}*/

		}
		/*else
		{
			parent.parent.parent.parent.parent.parent.frames(0).submit();
    	        }*/
	     }
	     catch(e)
	     {}
	}


	// vasanth's changes start


function ValidateDateFields(fieldDob,dob){

  	var retStat = "false";
	var hasOtherErrors;
	var selTabId;
	var element;
	var altCalendarHij = ALTCALENDAR_TYPE;
	if (top.frames(0).tabViewFrm==null)
	{
		selTabId = parent.parent.parent.parent.tabViewFrm.getSelectedTabId();
	}else{
		selTabId = top.frames(0).tabViewFrm.getSelectedTabId();
	}

	element = document.getElementsByName("3_TradeFinanceBO.dc_SanctionExpiryDate")[0];
	//tracker 113259:Hijri:change start
	//retStat = parent.parent.IFrmtab0.formDispFrame.Validate_againstDob(selTabId,element,fieldDob,dob);
	retStat = parent.parent.IFrmtab0.formDispFrame.Validate_againstDobHij(altCalendarHij,selTabId,element,fieldDob,dob);

	//tracker 113259:Hijri:change end
		if(retStat == "true"){
			hasOtherErrors = "true"	;
		}


	element = document.getElementsByName("3_TradeFinanceBO.review_Date")[0];
	//tracker 113259:Hijri:change start
	//retStat = parent.parent.IFrmtab0.formDispFrame.Validate_againstDob(selTabId,element,fieldDob,dob);
	retStat = parent.parent.IFrmtab0.formDispFrame.Validate_againstDobHij(altCalendarHij,selTabId,element,fieldDob,dob);
	//tracker 113259:Hijri:change end

		if(retStat == "true"){
			hasOtherErrors = "true"	;
		}

	return hasOtherErrors;
}

	// vasanth's changes end
function setMCAttModifyFlag(){
		document.frm2.isMCEditedTF.value="Y";
	}
function load()
{

<!--Tracker id 113227 start here-->
 document.frm2.altLocaleActv.value='<xsl:value-of select="$altLocaleActv"/>';
 <!--Tracker id 113227 end here-->
try{
	//changes by Rozy for CNF
	formatNumber("2_TradeFinanceBO.production_Cycle");
	formatPercent("3_TradeFinanceBO.dc_MarginPercentage");

	if(accountID =="" || accountID == null){
		document.getElementsByName("2_TradeFinanceBO.production_Cycle")[0].value=0;
	}

	if(isCopy =='Y' ){

		document.getElementsByName("TradeFinanceBO.OrgKey")[0].value='';
		document.getElementsByName("TradeFinanceBO.Name")[0].value='';
		document.getElementsByName("3_TradeFinanceBO.dc_MarginPercentage")[0].value=0;

	}else{
	<!--Tracker id 200178 start here-->
	<!-- Changes for the ticketid:355946 Starts -->
              <!-- Changes for call id 438150 starts here -->
	if((entityKey != null) &amp;&amp; (entityKey != "") &amp;&amp; (entityKey != "null")){
            <!-- Changes for call id 438150 ends here -->
	document.getElementsByName("TradeFinanceBO.OrgKey")[0].value=entityKey;
	}
<!--changes for tracker 401769 fullname alteration begins-->
              <!-- Changes for call id 438150 starts here -->
	if((entityName != null) &amp;&amp; (entityName != "") &amp;&amp; (entityName != "null")){
              <!-- Changes for call id 438150 ends here -->
	document.getElementsByName("TradeFinanceBO.Name")[0].value=entityName;
<!--changes for tracker 401769 fullname alteration ends-->
	}
	<!-- Changes for the ticketid:355946 Ends -->
	<!--Tracker id 200178 start here-->
	var dc_marpercent = document.getElementsByName("3_TradeFinanceBO.dc_MarginPercentage")[0].value;
	if(dc_marpercent==""){
	document.getElementsByName("3_TradeFinanceBO.dc_MarginPercentage")[0].value=0;
	}
	}
	document.getElementsByName("TradeFinanceBO.OrgKey")[0].readOnly=true;
	document.getElementsByName("TradeFinanceBO.Name")[0].readOnly=true;
customLoad();
}catch(e)
{ }
try{
	var obj = parent.parent.parent.parent.frames(3);
	obj.enableButton_Ub();
}catch(e)
{ }


}

function loadCode()
	{

		document.getElementsByName(boName + '.fc_SanctioningAuthority')[0].value = '<xsl:value-of select="$fc_SanctioningAuthority"/>';
		document.getElementsByName(boName + '.dc_SanctioningAuthority')[0].value = '<xsl:value-of select="$dc_SanctioningAuthority"/>';
		document.getElementsByName(boName + '.party_Type')[0].value = '<xsl:value-of select="$party_Type"/>';
		document.getElementsByName(boName + '.exp_Imp_Ind_Code')[0].value = '<xsl:value-of select="$exp_Imp_Ind"/>';
	}

function selectProcess()
{
	if(document.frm2.isMCEditedTF.value=="N"){
        			apprFlag="false";
       		}
	submit = true;
	var entityType = '<xsl:value-of select="$entityType"/>';
	var accountID = '<xsl:value-of select="$accountID"/>';
	var savedID  = parent.formSaveFrame.savedValue;

	if( apprFlag=='true' &amp;&amp; mainAccId == '')
	{
		entityType = entityType+"Mod";
		accountID=savedID;
	}
	if(mainAccId != '') entityType = entityType+"Mod";

	/***** Save and Submit changes : setting the savedID to accountID when SUBMIT pressed in Entity Queue When ApprovalDisabled: Start********/
	if(apprFlag == 'false')
	{
	    accountID=savedID;
	}
	/***** Save and Submit changes : setting the savedID to accountID when SUBMIT pressed in Entity Queue When ApprovalDisabled: End********/
/* Fix for Tracker# 79666 Starts: following line was overwriting the acount id. So commented */
//	var accountID  = parent.formSaveFrame.savedValue;
/* Fix for Tracker# 79666 Ends */
	if(!(document.frm2.byPassFlag.value=="Y"))
	{
		/*Tracker :93811 Fix start */
		// Checksum security recon changes from 10.3 SUPP start
		var secureHKey = document.getElementsByName("SECUREHKEY")[0].value;	
		var keyField = document.getElementsByName("FLDHASHKEY")[0].value;
		//window.open('../../../servlet/com.infy.cis.ui.cif.CIFProcessSelectionDetWizard?entityId='+accountID+'&amp;entityType='+entityType+'&amp;isPopup=Yes&amp;SECUREHKEY='+secureHKey+'&amp;FLDHASHKEY='+keyField,'save','directories=No, height=436, left=210, top=120, width=575, location=no, menubar=no, resizable=no, status=no, toolbar=no, scrollbars=yes');
		// Checksum security recon changes from 10.3 SUPP end
		/*Tracker :93811 Fix End */
		    //Changes for call id 373394 Starts : Process window was not coming in focus
		window.showModalDialog('../servlet/com.infy.cis.ui.cif.CIFProcessSelectionDetWizard?entityId='+accountID+'&amp;entityType='+entityType+'&amp;isPopup=Yes&amp;SECUREHKEY='+secureHKey+'&amp;FLDHASHKEY='+keyField,'save','dialogHeight:360px; dialogLeft:'+ (screen.width - 900) / 2 +'px;dialogTop:'+ (screen.height - 360) / 2+'px; dialogWidth:500px;center:yes;resizable:no;status:no;scroll:no;help:no;');
		  
               //Changes for call id 373394 Ends : Process window was not coming in focus
               <!--Changes for Callid:410377-recon for 408837 starts-->    			
	       		top.close();
		<!--Changes for Callid:410377-recon for 408837 ends-->

	}


}
function formatTFInfoIntField(){
	if(document.getElementsByName("3_TradeFinanceBO.dc_MarginPercentage")[0].value != ""){
		//Tracker 194631 Starts
		//formatInt(document.getElementsByName("3_TradeFinanceBO.dc_MarginPercentage")[0],gettingDigitGroupNumber());
		formatPercent("3_TradeFinanceBO.dc_MarginPercentage");
		//Tracker 194631 Ends

	}
	if(document.getElementsByName("3_TradeFinanceBO.cntrct_Limit")[0].value != ""){
		formatAmount("3_TradeFinanceBO.cntrct_Limit",'<xsl:value-of select="$boName"/>'+".crncy_Code","N")
	}

}
function formatTFInfoIntFieldRead(){
	if(document.getElementsByName("TradeFinanceBO.dc_MarginPercentage")[0].value != ""){
		formatInt(document.getElementsByName("TradeFinanceBO.dc_MarginPercentage")[0],gettingDigitGroupNumber());
	}
	if(document.getElementsByName("3_TradeFinanceBO.cntrct_Limit")[0].value != ""){
		formatAmount("3_TradeFinanceBO.cntrct_Limit",'<xsl:value-of select="$boName"/>'+".crncy_Code","N")
	}

}

function shouldRefresh()
{
 	var oprType = '<xsl:value-of select="$operationType"/>';
 	if(oprType == 'Queue'){
 		return true;
 	}
 	else{
 		return false;
 	}
}
function resubmit(){
		parent.parent.parent.parent.parent.parent.frames(0).submit();
	}
<!-- CRM102ST: TrackerID:165886 Begin of Change -->
function closebtn(){
	if (accountID=='')
	{
		parent.frames(0).location.href = parent.frames(0).location.href;

	}
	else if(!submit){
		top.window.close();
	}
	else if(accountID!=0 &amp;&amp; (boName=='TradeFinanceModBO' || boName=='TradeFinanceBO')){
			top.window.close();
		}
}
function refreshParent(){
	frm = top.opener.parent.frames(1);
	frm.navigate (frm.location.href);
 }
<!-- CRM102ST: TrackerID:165886 End of Change -->
/*Changes for Tracker 87171 - Start */
			<!--changes for tracker id 349409 BEGIN-->
function defaultCurrency(){

	document.getElementsByName(boName+".crncy_Code")[0].value = baseCurrency;
	document.getElementsByName("Cat_"+boName+".crncy_Code")[0].value = baseCurrency;
}
			<!--changes for tracker id 349409 END-->
/*Changes for Tracker 87171 - Start */



	</script>
</head>

<!-- DBS Enhancement tracker ID :-402520 by rattandeep_singh01 start-->
<body class="popup" onkeypress="onLoadSetTime()" onclick="onLoadSetTime()">
<!-- DBS Enhancement tracker ID :-402520 by rattandeep_singh01 end-->
<xsl:choose>
<xsl:when test="normalize-space($tFinURL)='' and not($readMode ='Y')">
<xsl:attribute name="onload">focusFirstField();chkBSN();formatTFInfoIntField();showbuttonsVisible(45);load();defaultCurrency();showFormTips();
</xsl:attribute>
</xsl:when>
<xsl:when test="normalize-space($readMode)='Y'">
<xsl:attribute name="onload">chkBSN();formatTFInfoIntFieldRead();showInReadOnlyMode('<xsl:value-of select="$readMode"/>');load();
</xsl:attribute>
</xsl:when>
<xsl:otherwise>
<xsl:attribute name="onload">focusFirstField();chkBSN();formatTFInfoIntField();showbuttonsVisible(45);showFormTips();load();loadCode();
</xsl:attribute>
</xsl:otherwise>
</xsl:choose>


<xsl:apply-templates select="SRM"/>

</body>
</html>
</xsl:template>

<!-- Template definations here  -->
    <xsl:template name="TradeFinanceBO.central_BankCode">
	<xsl:call-template name="label">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.central_BankCode']"/>
	    <xsl:with-param name="ele_name">TradeFinanceBO.central_BankCode</xsl:with-param>
	    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.central_BankCode</xsl:with-param>
	    <xsl:with-param name="size">10</xsl:with-param>
	</xsl:call-template>
    </xsl:template>
    <xsl:template name="TradeFinanceBO.trade_AuthorityCode">
	<xsl:call-template name="label">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.trade_AuthorityCode']"/>
	    <xsl:with-param name="ele_name">TradeFinanceBO.trade_AuthorityCode</xsl:with-param>
	    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.trade_AuthorityCode</xsl:with-param>
	    <xsl:with-param name="size">12</xsl:with-param>
	</xsl:call-template>
    </xsl:template>
    <xsl:template name="TradeFinanceBO.leasing_Liabilities">
	<xsl:call-template name="label">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.leasing_Liabilities']"/>
	    <xsl:with-param name="ele_name">TradeFinanceBO.leasing_Liabilities</xsl:with-param>
	    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.leasing_Liabilities</xsl:with-param>
	    <xsl:with-param name="size">50</xsl:with-param>
	</xsl:call-template>
    </xsl:template>
    <xsl:template name="TradeFinanceBO.production_Cycle">
	<xsl:call-template name="label">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.production_Cycle']"/>
	    <xsl:with-param name="ele_name">TradeFinanceBO.production_Cycle</xsl:with-param>
	    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.production_Cycle</xsl:with-param>
        <xsl:with-param name="max_length">3</xsl:with-param>
            <xsl:with-param name="fn_onBlur">formatNumber("2_TradeFinanceBO.production_Cycle");</xsl:with-param>
	</xsl:call-template>
    </xsl:template>
    <xsl:template name="TradeFinanceBO.dc_SanctioningAuthority">
	<xsl:call-template name="mdrpdown">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.dc_SanctioningAuthority_Code']"/>
	    <!--<xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.dc_SanctioningAuthority</xsl:with-param>-->
	    <xsl:with-param name="selectdisp">TradeFinanceBO.dc_SanctioningAuthority_Code</xsl:with-param>
	    <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.dc_SanctioningAuthority</xsl:with-param>
	    <xsl:with-param name="choice_name">TradeFinanceBO.dc_SanctioningAuthority_Code</xsl:with-param>
	    <xsl:with-param name="search_type">url</xsl:with-param>
	</xsl:call-template>
    </xsl:template>
    <xsl:template name="TradeFinanceBO.fc_SanctioningAuthority">
	<xsl:call-template name="mdrpdown">
    	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.fc_SanctioningAuthority_Code']"/>
    	    <!--<xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.fc_SanctioningAuthority</xsl:with-param>-->
    	    <xsl:with-param name="selectdisp"><xsl:value-of select="$boName"/>.fc_SanctioningAuthority_Code</xsl:with-param>
    	    <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.fc_SanctioningAuthority_Code</xsl:with-param>
    	    <xsl:with-param name="choice_name">TradeFinanceBO.fc_SanctioningAuthority_Code</xsl:with-param>
    	    <xsl:with-param name="search_type">url</xsl:with-param>
	</xsl:call-template>
    </xsl:template>
    <xsl:template name="TradeFinanceBO.authorised_Sign1">
	<xsl:call-template name="label">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.authorised_Sign1']"/>
	    <xsl:with-param name="ele_name">TradeFinanceBO.authorised_Sign1</xsl:with-param>
	    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.authorised_Sign1</xsl:with-param>
	    <xsl:with-param name="size">80</xsl:with-param>
	</xsl:call-template>
    </xsl:template>
    <xsl:template name="TradeFinanceBO.authorised_Sign2">
	<xsl:call-template name="label">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.authorised_Sign2']"/>
	    <xsl:with-param name="ele_name">TradeFinanceBO.authorised_Sign2</xsl:with-param>
	    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.authorised_Sign2</xsl:with-param>
	    <xsl:with-param name="size">80</xsl:with-param>
	</xsl:call-template>
    </xsl:template>
    <xsl:template name="TradeFinanceBO.authorised_Sign3">
	<xsl:call-template name="label">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.authorised_Sign3']"/>
	    <xsl:with-param name="ele_name">TradeFinanceBO.authorised_Sign3</xsl:with-param>
	    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.authorised_Sign3</xsl:with-param>
	    <xsl:with-param name="size">80</xsl:with-param>
	</xsl:call-template>
    </xsl:template>
    <xsl:template name="TradeFinanceBO.dc_MarginPercentage">
	<xsl:call-template name="label">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.dc_MarginPercentage']"/>
	    <xsl:with-param name="ele_name">TradeFinanceBO.dc_MarginPercentage</xsl:with-param>
	    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.dc_MarginPercentage</xsl:with-param>
	    <!-- CRM70t-ST :TRACKER# 78533 **BEGIN OF CHANGES ** -->
	    <xsl:with-param name="fn_onBlur">validatePercent("3_TradeFinanceBO.dc_MarginPercentage");</xsl:with-param>
	    <!-- Tracker 194631 Starts -->
	    <xsl:with-param name="fn_onBlur">formatPercent("3_TradeFinanceBO.dc_MarginPercentage");</xsl:with-param>
	    <!--<xsl:with-param name="fn_onBlur">formatInt(document.getElementsByName("3_TradeFinanceBO.dc_MarginPercentage")[0],gettingDigitGroupNumber());</xsl:with-param>-->
	    <!-- Tracker 194631 ends -->
	    <!-- CRM70t-ST :TRACKER# 78533 **END OF CHANGES ** -->
	</xsl:call-template>
    </xsl:template>
    <xsl:template name="TradeFinanceBO.dc_SanctionExpiryDate">
	<xsl:call-template name="label">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.dc_SanctionExpiryDate']"/>
	    <xsl:with-param name="ele_name">TradeFinanceBO.dc_SanctionExpiryDate</xsl:with-param>
	    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.dc_SanctionExpiryDate</xsl:with-param>
	    <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
	    <!-- calling the function isGregDate for on blur functionality-->
	    <xsl:with-param name="fn_onBlur">isGregDate("3_TradeFinanceBO.dc_SanctionExpiryDate");</xsl:with-param>
	    <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
	</xsl:call-template>
    </xsl:template>
    <xsl:template name="TradeFinanceBO.dc_NextNoCode">
	<xsl:call-template name="mdrpdown">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.dc_NextNoCode_rcode']"/>
		<xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.dc_NextNoCode</xsl:with-param>
	    <xsl:with-param name="selectdisp">TradeFinanceBO.dc_NextNoCode_rcode</xsl:with-param>
	    <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.dc_NextNoCode_rcode</xsl:with-param>
		<xsl:with-param name="choice_name">TradeFinanceBO.dc_NextNoCode_rcode</xsl:with-param>
		<xsl:with-param name="search_type">url</xsl:with-param>
	</xsl:call-template>
    </xsl:template>
    <xsl:template name="TradeFinanceBO.remarks">
	<xsl:call-template name="mtextarea">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.remarks']"/>
	    <xsl:with-param name="mcols">30</xsl:with-param>
	    <xsl:with-param name="mrows">2</xsl:with-param>
	    <xsl:with-param name="mcolspan">3</xsl:with-param>
	    <xsl:with-param name="mvalue"><xsl:value-of select="$boName"/>.remarks</xsl:with-param>
	    <xsl:with-param name="mname">TradeFinanceBO.remarks</xsl:with-param>
	    <xsl:with-param name="mread">false</xsl:with-param>
	    <xsl:with-param name="fn_onblur">txtLimit(this,75,"TradeFinanceBO.remarks","remarks")</xsl:with-param>
	    <xsl:with-param name="checkASCII">false</xsl:with-param>
	</xsl:call-template>
    </xsl:template>
    <xsl:template name="TradeFinanceBO.exp_Imp_Ind">
	<xsl:call-template name="mdrpdown">
	    	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.exp_Imp_Ind_Code']"/>
	    	    <xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.exp_Imp_Ind</xsl:with-param>
	    	    <xsl:with-param name="selectdisp"><xsl:value-of select="$boName"/>.exp_Imp_Ind_Code</xsl:with-param>
	    	    <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.exp_Imp_Ind_Code</xsl:with-param>
	    	    <xsl:with-param name="choice_name">TradeFinanceBO.exp_Imp_Ind_Code</xsl:with-param>
	    	    <xsl:with-param name="search_type">url</xsl:with-param>
	    	    <xsl:with-param name="size">5</xsl:with-param>
	</xsl:call-template>
    </xsl:template>
    <xsl:template name="TradeFinanceBO.caution_Stat">
	<xsl:call-template name="mdrpdown">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.caution_Stat']"/>
	    <xsl:with-param name="selectdisp"><xsl:value-of select="$boName"/>.caution_Stat</xsl:with-param>
	    <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.caution_Stat</xsl:with-param>
	    <xsl:with-param name="choice_name">TradeFinanceBO.caution_Stat</xsl:with-param>
	    <!-- Tracker : 85093 Begin of changes -->
	    <xsl:with-param name="search_type">value</xsl:with-param>
	    <!-- Tracker : 85093 End of changes -->
	</xsl:call-template>
     </xsl:template>
    <xsl:template name="TradeFinanceBO.party_Type">
	<xsl:call-template name="mdrpdown">
    	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.party_Type_Code']"/>
    	    <xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.party_Type</xsl:with-param>
    	    <xsl:with-param name="selectdisp"><xsl:value-of select="$boName"/>.party_Type_Code</xsl:with-param>
    	    <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.party_Type_Code</xsl:with-param>
    	    <xsl:with-param name="choice_name">TradeFinanceBO.party_Type_Code</xsl:with-param>
    	    <xsl:with-param name="search_type">url</xsl:with-param>
	    <xsl:with-param name="size">5</xsl:with-param>
	</xsl:call-template>
    </xsl:template>
    <xsl:template name="TradeFinanceBO.hund_Pcnt_Eou_Flg">
	<xsl:call-template name="mdrpdown">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.hund_Pcnt_Eou_Flg']"/>
	    <xsl:with-param name="selectdisp"><xsl:value-of select="$boName"/>.hund_Pcnt_Eou_Flg</xsl:with-param>
	    <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.hund_Pcnt_Eou_Flg</xsl:with-param>
	    <xsl:with-param name="choice_name">TradeFinanceBO.hund_Pcnt_Eou_Flg</xsl:with-param>
	    <xsl:with-param name="search_type">value</xsl:with-param>
	</xsl:call-template>
    </xsl:template>
    <xsl:template name="TradeFinanceBO.inland_Trade_Allowed">
	<xsl:call-template name="mdrpdown">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.inland_Trade_Allowed']"/>
	    <xsl:with-param name="selectdisp"><xsl:value-of select="$boName"/>.inland_Trade_Allowed</xsl:with-param>
	    <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.inland_Trade_Allowed</xsl:with-param>
	    <xsl:with-param name="choice_name">TradeFinanceBO.inland_Trade_Allowed</xsl:with-param>
	    <xsl:with-param name="search_type">value</xsl:with-param>
	</xsl:call-template>
    </xsl:template>
<!--Changes for Tracker 87171 - Start -->
    <xsl:template name="TradeFinanceBO.cntrct_Limit">
    	<xsl:call-template name="amountlabel">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.cntrct_Limit']"/>
	    <xsl:with-param name="ele_name">TradeFinanceBO.cntrct_Limit</xsl:with-param>
	    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.cntrct_Limit</xsl:with-param>
	<xsl:with-param name="fncname">rate("3_TradeFinanceBO.cntrct_Limit",boName+".crncy_Code",'<xsl:value-of select="$BaseCurrency"/>');</xsl:with-param>
	<xsl:with-param name="showdropdown">false</xsl:with-param>
	<!-- Tracker ID 113058 Changes Start -->
	<!-- <xsl:with-param name="max_length">16</xsl:with-param> -->
	<!-- Tracker ID 113058 Changes End -->
	<xsl:with-param name="fn_onBlur">formatAmount("3_TradeFinanceBO.cntrct_Limit",'<xsl:value-of select="$boName"/>'+".crncy_Code","N");</xsl:with-param>
	</xsl:call-template>
    </xsl:template>
<!--Changes for Tracker 87171 - End -->
			<!--changes for tracker id 349409 BEGIN-->
<xsl:template name="TradeFinanceBO.crncy_Code">
	        <xsl:call-template name="lookup">
			<xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.crncy_Code']"/>
			<xsl:with-param name="elename"><xsl:value-of select="$boName"/>.crncy_Code</xsl:with-param>
			<xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.crncy_Code</xsl:with-param>
			<xsl:with-param name="buttonone_name" select="$configLabels[@name='LOOKUP']/@configLabel"/>
			<xsl:with-param name="buttontwo_name" select="$configLabels[@name='CLEAR']/@configLabel"/>
			<xsl:with-param name="buttonone_fnc">categoryLookup('CURRENCY', '<xsl:value-of select="$boName"/>.crncy_Code')</xsl:with-param>
			<xsl:with-param name="buttontwo_fnc">clearCategoryValue('<xsl:value-of select="$boName"/>.crncy_Code')</xsl:with-param>
			<xsl:with-param name="checkASCII">false</xsl:with-param>
		</xsl:call-template>
</xsl:template>
			<!--changes for tracker id 349409 END-->
    <xsl:template name="TradeFinanceBO.cust_flg">
	<xsl:call-template name="mdrpdown">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.cust_flg']"/>
	    <xsl:with-param name="selectdisp"><xsl:value-of select="$boName"/>.cust_flg</xsl:with-param>
	    <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.cust_flg</xsl:with-param>
	    <xsl:with-param name="choice_name">TradeFinanceBO.cust_flg</xsl:with-param>
	    <xsl:with-param name="search_type">value</xsl:with-param>
	</xsl:call-template>
    </xsl:template>
    <xsl:template name="TradeFinanceBO.cust_Native">
	<xsl:call-template name="mdrpdown">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.cust_Native']"/>
	    <xsl:with-param name="selectdisp"><xsl:value-of select="$boName"/>.cust_Native</xsl:with-param>
	    <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.cust_Native</xsl:with-param>
	    <xsl:with-param name="choice_name">TradeFinanceBO.cust_Native</xsl:with-param>
	    <xsl:with-param name="search_type">value</xsl:with-param>
	</xsl:call-template>
    </xsl:template>
    <xsl:template name="TradeFinanceBO.review_Date">
	<xsl:call-template name="label">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.review_Date']"/>
	    <xsl:with-param name="ele_name">TradeFinanceBO.review_Date</xsl:with-param>
	    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.review_Date</xsl:with-param>
	    <!-- ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)-->
	    <!-- calling the function isGregDate for on blur functionality-->
	    <xsl:with-param name="fn_onBlur">isGregDate("3_TradeFinanceBO.review_Date");</xsl:with-param>
	    <!-- ERPBOCF1:TRACKER:113259:END OF CHANGES(HIJRI)-->
	</xsl:call-template>
    </xsl:template>
    <xsl:template name="TradeFinanceBO.ssi_Flag">
	<xsl:call-template name="mdrpdown">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.ssi_Flag']"/>
	    <xsl:with-param name="selectdisp"><xsl:value-of select="$boName"/>.ssi_Flag</xsl:with-param>
	    <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.ssi_Flag</xsl:with-param>
	    <xsl:with-param name="choice_name">TradeFinanceBO.ssi_Flag</xsl:with-param>
	    <xsl:with-param name="search_type">value</xsl:with-param>
	</xsl:call-template>
    </xsl:template>
    <xsl:template name="TradeFinanceBO.special_Cust_Flag">
	<xsl:call-template name="mdrpdown">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.special_Cust_Flag']"/>
	    <xsl:with-param name="selectdisp"><xsl:value-of select="$boName"/>.special_Cust_Flag</xsl:with-param>
	    <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.special_Cust_Flag</xsl:with-param>
	    <xsl:with-param name="choice_name">TradeFinanceBO.special_Cust_Flag</xsl:with-param>
	    <xsl:with-param name="search_type">value</xsl:with-param>
	</xsl:call-template>
    </xsl:template>
    <xsl:template name="TradeFinanceBO.party_Const">
	<xsl:call-template name="mdrpdown">
    	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.party_Const_Code']"/>
    	    <xsl:with-param name="selectDesc"><xsl:value-of select="$boName"/>.party_Const</xsl:with-param>
    	    <xsl:with-param name="selectdisp"><xsl:value-of select="$boName"/>.party_Const_Code</xsl:with-param>
    	    <xsl:with-param name="selectname"><xsl:value-of select="$boName"/>.party_Const_Code</xsl:with-param>
	    <xsl:with-param name="choice_name">TradeFinanceBO.party_Const</xsl:with-param>
    	    <xsl:with-param name="search_type">url</xsl:with-param>
	</xsl:call-template>
    </xsl:template>
    <xsl:template name="TradeFinanceBO.state_Desc">
	<xsl:call-template name="lookup">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.state_Desc']"/>
	    <xsl:with-param name="elename">TradeFinanceBO.state_Desc</xsl:with-param>
	    <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.state_Desc</xsl:with-param>
	    <xsl:with-param name="buttonone_name">LookUp<xsl:value-of select="$configLabels[@name='LOOKUP']/@configLabel"/></xsl:with-param>
	    <xsl:with-param name="buttontwo_name">Clear<xsl:value-of select="$configLabels[@name='CLEAR']/@configLabel"/></xsl:with-param>
	    <xsl:with-param name="buttonone_fnc">categoryLookup('CORP_STATE_CODE', 'TradeFinanceBO.state_Desc')</xsl:with-param>
	    <xsl:with-param name="buttontwo_fnc">clearCategoryValue('TradeFinanceBO.state_Desc')</xsl:with-param>
	    <xsl:with-param name="checkASCII">false</xsl:with-param>
    	</xsl:call-template>
    </xsl:template>
    <xsl:template name="TradeFinanceBO.Name">
	<xsl:call-template name="label">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.Name']"/>
	    <xsl:with-param name="ele_name">TradeFinanceBO.Name</xsl:with-param>
	    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Name</xsl:with-param>
	    <!-- <xsl:with-param name="read_val">true</xsl:with-param>-->
	    <xsl:with-param name="size">80</xsl:with-param>
	</xsl:call-template>
    </xsl:template>

    <!--TrackerID: 113227 start of changes-->
     <xsl:template name="TradeFinanceBO.Name_alt1">
    	<xsl:call-template name="label_alternate">
    	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.Name']"/>
    	    <xsl:with-param name="ele_name">TradeFinanceBO.Name_alt1</xsl:with-param>
    	    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.Name_alt1</xsl:with-param>
    	    <xsl:with-param name="size">80</xsl:with-param>
    	</xsl:call-template>
    </xsl:template>

      <!--TrackerID: 113227 end of changes-->

    <xsl:template name="TradeFinanceBO.phone">
	<xsl:call-template name="label">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.phone']"/>
	    <xsl:with-param name="ele_name">TradeFinanceBO.phone</xsl:with-param>
	    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.phone</xsl:with-param>
	    <xsl:with-param name="size">20</xsl:with-param>
	</xsl:call-template>
    </xsl:template>
<!-- This field is made non-editable -->
    <xsl:template name="TradeFinanceBO.OrgKey">
	<xsl:call-template name="label">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.OrgKey']"/>
	    <xsl:with-param name="ele_name">TradeFinanceBO.OrgKey</xsl:with-param>
	    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.OrgKey</xsl:with-param>
	   <!-- <xsl:with-param name="read_val">true</xsl:with-param>-->
	    <xsl:with-param name="IsMandatory" select="No"/>
	</xsl:call-template>
    </xsl:template>
    <xsl:template name="TradeFinanceBO.addr_1">
	<xsl:call-template name="label">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.addr_1']"/>
	    <xsl:with-param name="ele_name">TradeFinanceBO.addr_1</xsl:with-param>
	    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.addr_1</xsl:with-param>
	    <xsl:with-param name="size">45</xsl:with-param>
	</xsl:call-template>
    </xsl:template>
    <xsl:template name="TradeFinanceBO.addr_2">
	<xsl:call-template name="label">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.addr_2']"/>
	    <xsl:with-param name="ele_name">TradeFinanceBO.addr_2</xsl:with-param>
	    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.addr_2</xsl:with-param>
	    <xsl:with-param name="size">45</xsl:with-param>
	</xsl:call-template>
    </xsl:template>
    <xsl:template name="TradeFinanceBO.addr_3">
	<xsl:call-template name="label">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.addr_3']"/>
	    <xsl:with-param name="ele_name">TradeFinanceBO.addr_3</xsl:with-param>
	    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.addr_3</xsl:with-param>
	    <xsl:with-param name="size">45</xsl:with-param>
	</xsl:call-template>
    </xsl:template>
    <xsl:template name="TradeFinanceBO.cntry_Desc">
	<xsl:call-template name="lookup">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.cntry_Desc']"/>
	    <xsl:with-param name="elename">TradeFinanceBO.cntry_Desc</xsl:with-param>
	    <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.cntry_Desc</xsl:with-param>
		<!-- Field Rationalization changes start-->
		<xsl:with-param name="code_req">true</xsl:with-param>
		<!-- Field Rationalization changes end-->
	    <xsl:with-param name="buttonone_name">LookUp<xsl:value-of select="$configLabels[@name='LOOKUP']/@configLabel"/></xsl:with-param>
	    <xsl:with-param name="buttontwo_name">Clear<xsl:value-of select="$configLabels[@name='CLEAR']/@configLabel"/></xsl:with-param>
	    <xsl:with-param name="buttonone_fnc">categoryLookup('COUNTRY', 'TradeFinanceBO.cntry_Desc')</xsl:with-param>
	    <xsl:with-param name="buttontwo_fnc">clearCategoryValue('TradeFinanceBO.cntry_Desc')</xsl:with-param>
	    <xsl:with-param name="checkASCII">false</xsl:with-param>
	</xsl:call-template>
    </xsl:template>
    <xsl:template name="TradeFinanceBO.faxNo">
	<xsl:call-template name="label">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.faxNo']"/>
	    <xsl:with-param name="ele_name">TradeFinanceBO.faxNo</xsl:with-param>
	    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.faxNo</xsl:with-param>
	    <xsl:with-param name="size">20</xsl:with-param>
	</xsl:call-template>
    </xsl:template>
    <xsl:template name="TradeFinanceBO.telex">
	<xsl:call-template name="label">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.telex']"/>
	    <xsl:with-param name="ele_name">TradeFinanceBO.telex</xsl:with-param>
	    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.telex</xsl:with-param>
	    <xsl:with-param name="size">12</xsl:with-param>
	</xsl:call-template>
    </xsl:template>
    <xsl:template name="TradeFinanceBO.city">
	<xsl:call-template name="lookup">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.city']"/>
	    <xsl:with-param name="elename">TradeFinanceBO.city</xsl:with-param>
	    <xsl:with-param name="eleval"><xsl:value-of select="$boName"/>.city</xsl:with-param>
	    <xsl:with-param name="buttonone_name">LookUp<xsl:value-of select="$configLabels[@name='LOOKUP']/@configLabel"/></xsl:with-param>
	    <xsl:with-param name="buttontwo_name">Clear<xsl:value-of select="$configLabels[@name='CLEAR']/@configLabel"/></xsl:with-param>
	    <xsl:with-param name="buttonone_fnc">categoryLookup('CITY', 'TradeFinanceBO.city')</xsl:with-param>
	    <xsl:with-param name="buttontwo_fnc">clearCategoryValue('TradeFinanceBO.city')</xsl:with-param>
	    <xsl:with-param name="checkASCII">false</xsl:with-param>
	</xsl:call-template>
    </xsl:template>
    <xsl:template name="TradeFinanceBO.zip">
	<xsl:call-template name="label">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.zip']"/>
	    <xsl:with-param name="ele_name">TradeFinanceBO.zip</xsl:with-param>
	    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.zip</xsl:with-param>
	    <xsl:with-param name="size">6</xsl:with-param>
	</xsl:call-template>
    </xsl:template>
<!-- This field is made non-editable -->
    <xsl:template name="TradeFinanceBO.core_Cust_ID">
	<xsl:call-template name="label">
	    <xsl:with-param name="res_name" select="$configLabels[@name='TradeFinanceBO.core_Cust_ID']"/>
	    <xsl:with-param name="ele_name">TradeFinanceBO.core_Cust_ID</xsl:with-param>
	    <xsl:with-param name="ele_val"><xsl:value-of select="$boName"/>.core_Cust_ID</xsl:with-param>
	    <xsl:with-param name="read_val">true</xsl:with-param>
	    <xsl:with-param name="IsMandatory" select="No"/>
	</xsl:call-template>
    </xsl:template>
<xsl:template match="*" mode="mode1">
    <xsl:call-template name="Begin"/>
    <form name="frm2" target='formSaveFrame'  method="post" action="../servlet/com.infy.cis.ui.cif.RetailTFWriter">
	<!--Tracker id 113227 changes start-->
	<input type="hidden" name="altLocaleActv" />
 	<!--Tracker id 113227 changes end-->
	<input type="hidden" name="dc_SanctioningAuthority_Code" value=""/>
	<input type="hidden" name="fc_SanctioningAuthority_Code" value=""/>
	<input type="hidden" name="party_Type_Code" value=""/>
	<input type="hidden" name="exp_Imp_Ind_Code" value=""/>
	<input type="hidden" name="isCopy" value="{$isCopy}"/>
	<input type="hidden" name="hid_apprFlag" value="{$apprFlag}"/>
	<!-- Save and Submit Passing the operationType & saveFlag to the Writer : Start  -->
	<input type="hidden" name="operationType" value="{$operationType}"/>
	<input type="hidden" name="saveFlag" value=""/>
	<!-- Save and Submit Passing the operationType & saveFlag to the Writer : End  -->
	<input type="hidden" name="hid_concurDetectX" value="{$concurDetectX}"/>
	<input type="hidden" name="hid_tFinURL" value="{$tFinURL}"/>
	<input type="hidden" name="hreadOnly" value="{$readMode}"/>
	<input type="hidden" name="boName" value="{$boName}"/>
	<input type="hidden" name="accountID" value="{$accountID}"/>
	<input type="hidden" name="entityType" value="{$entityType}"/>
        <input type="hidden" name="accountKey" value="{$accountKey}"/>
        <input type="hidden" name="ProcID" value=""/>
        <input type="hidden" name="byPassFlag" value="{$byPassFlag}"/>
        <input type="hidden" name="mainAccId" value="{$mainAccId}"/>
        <input type="hidden" name="ModAccID" value=""/>
        <input type="hidden" name="AddressFields" value=""/>
        <input type="hidden" name="OtherTFFields" value=""/>
        <input type="hidden" name="CoreCustID" value=""/>
	<input type="hidden" name="isMCEditedTF" value="N"/>
	<input type="hidden" name="isMCEdited" value="{$isMCEdited}"/>
	<input type="hidden" name="mcJNDIFlag" value="{$mcJNDIFlag}"/>
	<input type="hidden" name="getMCRequired" value="{$getMCRequired}"/>

	<!--  Tracker ID:253845    -->
	<input type="hidden" name="convToCust" value="{$convToCust}"/>
	<input type="hidden" name="oldEntityType" value="{$oldEntityType}"/>
	<input type="hidden" name="oldEntityID" value="{$oldEntityID}"/>        
	<!--  Tracker ID:253845    -->
	<!--ERPBOCF1:TRACKER:113259:STORAGE OF DATES :STARTOFCHANGES-->

	<input type="hidden" name="reviewDate" value=""/>
	<input type="hidden" name="dcSancExpiryDt" value=""/>
	<input type="hidden" value="{$ALTCALENDAR_TYPE}" name="ALTCALENDAR_TYPE"/>
<!--ERPBOCF1:TRACKER:113259:STORAGE OF DATES :ENDOFCHANGES-->

	<xsl:call-template name="Begin"/>
	<table width="100%" bgcolor='FFFFFF' cellspacing="0" vspace="0" hspace="0" border="0" align = "center">
	<!-- call your templates here -->

	    <xsl:call-template name="Begin"/>
		<xsl:call-template name="TradeFinanceBO.central_BankCode"/>
		<xsl:call-template name="TradeFinanceBO.trade_AuthorityCode"/>
	    <xsl:call-template name="End"/>
	    <xsl:call-template name="Begin"/>
		<xsl:call-template name="TradeFinanceBO.leasing_Liabilities"/>
		<xsl:call-template name="TradeFinanceBO.production_Cycle"/>
	    <xsl:call-template name="End"/>
	    <xsl:call-template name="Begin"/>
		<xsl:call-template name="TradeFinanceBO.dc_SanctioningAuthority"/>
		<xsl:call-template name="TradeFinanceBO.fc_SanctioningAuthority"/>
	    <xsl:call-template name="End"/>
	    <xsl:call-template name="Begin"/>
		<xsl:call-template name="TradeFinanceBO.authorised_Sign1"/>
		<xsl:call-template name="TradeFinanceBO.authorised_Sign2"/>
	    <xsl:call-template name="End"/>
	    <xsl:call-template name="Begin"/>
		<xsl:call-template name="TradeFinanceBO.authorised_Sign3"/>
		<xsl:call-template name="TradeFinanceBO.dc_MarginPercentage"/>
	    <xsl:call-template name="End"/>
	    <xsl:call-template name="Begin"/>
		<xsl:call-template name="TradeFinanceBO.dc_SanctionExpiryDate"/>
		<xsl:call-template name="TradeFinanceBO.dc_NextNoCode"/>
	    <xsl:call-template name="End"/>
	    <xsl:call-template name="Begin"/>
		<xsl:call-template name="TradeFinanceBO.exp_Imp_Ind"/>
		<xsl:call-template name="TradeFinanceBO.caution_Stat"/>
	    <xsl:call-template name="End"/>
	    <xsl:call-template name="Begin"/>
		<xsl:call-template name="TradeFinanceBO.party_Type"/>
		<xsl:call-template name="TradeFinanceBO.hund_Pcnt_Eou_Flg"/>
	    <xsl:call-template name="End"/>
	    <xsl:call-template name="Begin"/>
		<xsl:call-template name="TradeFinanceBO.inland_Trade_Allowed"/>
		<xsl:call-template name="TradeFinanceBO.cntrct_Limit"/>
	    <xsl:call-template name="End"/>
	    <xsl:call-template name="Begin"/>
		<xsl:call-template name="TradeFinanceBO.crncy_Code"/>
		<!-- <xsl:call-template name="TradeFinanceBO.cust_flg"/> -->
		<xsl:call-template name="TradeFinanceBO.cust_Native"/>
	    <xsl:call-template name="End"/>
	    <xsl:call-template name="Begin"/>
		<xsl:call-template name="TradeFinanceBO.review_Date"/>
		<xsl:call-template name="TradeFinanceBO.ssi_Flag"/>
	    <xsl:call-template name="End"/>
	    <xsl:call-template name="Begin"/>
		<xsl:call-template name="TradeFinanceBO.special_Cust_Flag"/>
		<xsl:call-template name="TradeFinanceBO.party_Const"/>
	    <xsl:call-template name="End"/>
	    <xsl:call-template name="Begin"/>
		<!--<xsl:call-template name="TradeFinanceBO.state_Desc"/>-->
	    <xsl:call-template name="End"/>
	    <xsl:call-template name="Begin"/>
		<xsl:call-template name="TradeFinanceBO.Name"/>
		<xsl:call-template name="TradeFinanceBO.phone"/>
	    <xsl:call-template name="End"/>
	    <xsl:call-template name="Begin"/>
		<xsl:call-template name="TradeFinanceBO.OrgKey"/>
		<!--<xsl:call-template name="TradeFinanceBO.addr_1"/>
	    <xsl:call-template name="End"/>
	    <xsl:call-template name="Begin"/>
		<xsl:call-template name="TradeFinanceBO.addr_2"/>
		<xsl:call-template name="TradeFinanceBO.addr_3"/>
	    <xsl:call-template name="End"/>
	    <xsl:call-template name="Begin"/>
		<xsl:call-template name="TradeFinanceBO.cntry_Desc"/>-->
		<xsl:call-template name="TradeFinanceBO.faxNo"/>
	    <xsl:call-template name="End"/>
	    <xsl:call-template name="Begin"/>
		<xsl:call-template name="TradeFinanceBO.telex"/>
		<!--<xsl:call-template name="TradeFinanceBO.city"/>
	    <xsl:call-template name="End"/>
	    <xsl:call-template name="Begin"/>
		<xsl:call-template name="TradeFinanceBO.zip"/>-->
<!-- Fix for Ticket#133159 Starts: Core_CustID is made hidden -->
<!--		<xsl:call-template name="TradeFinanceBO.core_Cust_ID"/> -->

<!-- Fix for Ticket#133159 Ends -->
		<xsl:call-template name="TradeFinanceBO.remarks"/>
	    <xsl:call-template name="End"/>
		<!--TrackerID: 113227 start of changes-->
		 <xsl:choose>
		<xsl:when test="normalize-space($altLocaleActv)='true'">
		 <xsl:variable name="TRADE"><xsl:value-of select="$configLabels[@name='Details in Alternate Language']/@configLabel"/></xsl:variable>
			    	<table  bgcolor='FFFFFF' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
			    		<tr style="cursor:hand" STYLE="border-bottom: 10px black;" ID="rowTrade" name="rowTrade">
			    		<xsl:attribute name="oncontextmenu">setClickedArea();doContextMenu();</xsl:attribute>
			    		<td onclick="Toggle('Trade','all');" colspan = "5" NOWRAP="true" class="LabelFont">
			    		     <A HREF="javascript:Toggle('TRADE','all');"><IMG onclick="Toggle('Trade','all');" SRC="../reports/images/minus.gif" ID="Tradegif"
			    		      BORDER="0" ALIGN="absmiddle" HEIGHT="12" WIDTH="12" HSPACE="3" VSPACE="4"/></A>
			    		     <label FOR="CPD" class="LabelFont"><xsl:value-of select="$TRADE"/>
			    		     </label>
			    		</td>
			    		</tr>
			    		</table>

			    	<DIV ID = 'native' STYLE= 'visibility:visible;'>

					 <table  bgcolor='FFFFFF' width="100%" border = "0" cellspacing="0" vspace="0" hspace="0" >
						<TR ID='rowTrade' name='rowTrade'>

						<xsl:call-template name="TradeFinanceBO.Name_alt1">
						</xsl:call-template>

						</TR>
					</table>
			    	</DIV>
		</xsl:when>

  	</xsl:choose>
			<!--TrackerID: 113227 end of changes-->

<!--	    <xsl:call-template name="Begin"/>

	    <xsl:call-template name="End"/>-->
	</table>
	<xsl:call-template name="End"/>
<!-- View : Trade Finance :END -->

    </form>
    <!-- TrackerID:209607,CHANGES START -->
    <p id="myPar"/>
    <!-- TrackerID:209607,CHANGES END -->
</xsl:template>
<xsl:template match="SRM">
<xsl:for-each select=".">
<xsl:call-template name="startTable"/>
<table bgcolor='FFFFFF' border="0" cellspacing="0" cellpadding="2" width="100%" vspace="0" hspace="0">
    <tr>
	 <xsl:call-template name="Begin"/>
			<xsl:call-template name="apply">
			    <xsl:with-param name="apply_head">
			    <b><xsl:value-of select="$configLabels[@name='MLHeader']/@configLabel"/></b><br/>
			    </xsl:with-param>
		    	</xsl:call-template>
	    <xsl:call-template name="End"/>
    </tr>
</table>
<table bgcolor='FFFFFF' width="100%" border="0" cellspacing="0" cellpadding="2">
    <xsl:apply-templates select="." mode="mode1"/>
</table>
<xsl:call-template name="endTable"/>
</xsl:for-each>


	      <!--TrackerID 175120 :: START-->
	<script>
		var iCount = 0;

		CurrencyVal = document.getElementsByName(boName+".crncy_Code")[0];

		<xsl:for-each select="$PresCurrData/SRMComposite[@n='CurrencyRecordSet']/SRMRow">
		  currCode = '<xsl:value-of select="./Z[@n='CurrencyBO.CurrencyCode']"/>' ;
		  CurrencyVal.options[iCount+1]=new Option(currCode , currCode);
		  iCount++;
		</xsl:for-each>

		<!-- Change for tracker 183462 by Badri -->
		document.getElementsByName(boName+'.crncy_code')[0].value=currencyCode;
	</script>
		<!--TrackerID 175120 :: END-->



</xsl:template>
</xsl:stylesheet>




















