<?xml version='1.0'?>
  <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="../Renderer/common/display/SRMListTemplate.xsl"/>
        <xsl:param name="locale"/>
  <xsl:variable name="userArea" select="/SRM/SRMData[@SRMDataSpace='UserData']"/>
  <xsl:variable name="searchType" select="$userArea//Z[@n='SearchType']"/>
  <xsl:variable name="query" select="$userArea//Z[@n='options']"/>
  <xsl:variable name="ViewName" select="$userArea//Z[@n='ViewName']"/>
<!-- Tracker : 66615 - Account Holder Maintenance changes -->
  <xsl:variable name="ScreenName" select="$userArea//Z[@n='ScreenName']"/>
<!-- Tracker : 66615 - End of changes -->
  <xsl:variable name="queryText" select="$userArea//Z[@n='QueryText']"/>
  <xsl:param name="resfilename"/>
  <!-- Ticket id 216306 Begin of changes -->
  <xsl:param name="NumPages"/>
  <!-- Ticket id 216306 end of changes -->
<!-- GroupHousehold changes start-->
   <xsl:variable name="configFile_1" select="document(concat($resfilename,''))"/>
    <xsl:variable name="configLabels" select="$configFile_1/srmbo/*"/>
<!-- GroupHousehold changes start-->
  <xsl:param name="pageIndex" select="0"/>
<xsl:template match="/">
        <xsl:if test="$pageIndex &lt;=1">
        <xsl:call-template name="htmlstart"/>
      <head>
        <IFRAME MARGINHEIGHT='0' MARGINWIDTH='0' FRAMEBORDER='0' FRAMESPACING='0' HEIGHT='0' WIDTH='0' scrolling='no' id='hiddenFrame' name='hiddenFrame' src='' >  </IFRAME>
<script type="text/javascript" src="../common/js/ClientResourceBundle_{$locale}.js" language="javascript"></script>
<!-- Removal of Harcoded Resource ID Changes Start -->	 
<!-- Tracker# 174227 -: Changes for 404 errors -->
<!-- Tracker# 174227 -: Changes for 404 errors -->
<!-- Removal of Harcoded Resource ID Changes End -->
<script>
<!-- Removal of Harcoded Resource ID Changes Start -->
var CORESERVER= readCookie('COREServerName');
<!-- Removal of Harcoded Resource ID Changes End -->
var locale = '<xsl:value-of select="$locale"/>';
<!-- Ticket id 216306 Begin of changes -->
var NumPages = '<xsl:value-of select="$NumPages"/>';
<!-- Ticket id 216306 end of changes -->
</script>
             <link rel="stylesheet" type="text/css" href="../Branding/css/common/SRMTableDisplay_{$locale}.css"/>
        <link rel="stylesheet" Type="text/css" href="../Branding/css/common/PopupMenu_{$locale}.css"/>
        <LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/SRMListTemplate_{$locale}.css"/>
    <object id="factory" style='display:none'></object>
    <!-- Fix for ticket ID 260101 -->
        <script type="text/javascript" src="../common/js/PopupMenu.js"></script>
        <script type="text/javascript" src="../common/js/SSOUtils.js"></script>
        <script type="text/javascript" src="../Customization/searchconsole/js/BankAccountsListRightClick.js"></script>
        <script type="text/javascript" id="TableRowColor" src="../common/js/SRMTableRowColor.js"></script>        
	<script language="javascript" src="../common/js/ExportToExcel.js" type="text/javascript">
    </script>
    <!-- Fix for ticket ID 260101 -->
   <!-- Tracker : 66615 - Account Holder Maintenance changes -->
   	<xsl:choose>
   	    <xsl:when test="normalize-space($ScreenName)='Administration'">
   		<script type="text/javascript" src="../admin/js/MainAccountHolderRCLOptions_{$locale}.js"></script>
   	    </xsl:when>
   	    <xsl:otherwise>
   		<script type="text/javascript" src="../searchconsole/js/BankAccountsRCLOptions_{$locale}.js"></script>
   	    </xsl:otherwise>
   	</xsl:choose>
   <!-- Tracker : 66615 - End of Changes -->
        
        <script>

          var prevBankAccountURL = "";
          var bankAccountURL = "";
          var bankAccountId = "";
          var bankAccountNumber = "";
          <!-- Changes for Ticketid:353382 Call ID:-172098 Begins-->
           var branchCode = "";
          <!-- Changes for Ticketid:353382 Call ID:-172098 Ends-->
          var bankAccountProductURL = "";
          var BankAccountprodCatID = "";
          var prevBankAcctNum = "";
	  var AccountKey = "";
	  var mcyIndicator = "";
          var accTypeIndicator = "";
	  var expirationdate = new Date ();
          var local_prefix="SearchConsole";
          var prevBankAcctId = "-1";         // Tracker ID : 43543 : Initialise the variable
          /* *** Tracker # 50645, Begin of Changes *** */
          var prevSelectedRowID = "-1"; // row identifier...
          /* *** Tracker # 50645, Begin of Changes *** */
          /** TRACKER : 68864 BEGIN **/
          var entity = "";
          var productskey = "";
	  /** TRACKER : 68864 END **/
          function deleteall(){
             setCookie('BankAccountURL', "", expirationdate);
               setCookie('BankAccountID', "", expirationdate);
          }
            function selectLastSelected() {
		    prevBankAcctNum= getCookie('BankAccountNumber');
		    /* *** Tracker # 50645, Begin of Changes *** */
		    // Reset the customer ID value for showDefTabs(). Expiration time value is not
		    // taken care as it is going to be ignored by setCookie() method.
		    var selRow = document.getElementsByName ("mytr" + prevtrid);
		    if (selRow.length != 0) {
			var orgId = selRow[0].getAttribute("SaleBO.SaleCustomer.orgID");
			setCookie ("AccountID", orgId, expirationdate);
		    }
		    /* *** Tracker # 50645, End of Changes *** */
		    try{
			showDefTabs();
		    }catch(e){}
            }
/* CRM11.0:TRACKER:113058:BEGINOFCHANGES */
        function showAccDetails(){
        /*Security Recon Changes : Tracker Id : 356601 STARTS:Account Id Hyperlink function call*/
        
        var hashkey=getCookie('HASHKEY');								
        var fldhashkey=getCookie('FLDHASHKEY');
        
     //   alert('hashkey'+hashkey);
     //   alert('fldhashkey'+fldhashkey);
	AccessOwnerGroup = getCookie('AccessOwnerGroup');

        try{
        	var viewName="";
            if (bankAccountId == null || bankAccountId=="" || bankAccountId== 'null') {
                showUserMessage("MSG014","MSG_BANKACCT");
                return;
            }
	    viewName=getViewName();
	    if (customerRole=="Main Account Holder"){
	       entity="Customer";
	    }
	    else if(contactRole=="Main Account Holder"){
	       entity="Contact";
	    }
	    /* Changes for Audit Enquiry CRMBAR02 Starts*/

	    /* ScreenId has been included in the Query String */

            var url = '../servlet/com.infy.cis.ui.admin.CommonAccountDetails?ScreenID=HRF360000001&amp;viewname='+ viewName +'&amp;salesId='+bankAccountId+'&amp;accountNumber='+ bankAccountNumber+'&amp;mcyIndicator='+ mcyIndicator+'&amp;accTypeIndicator='+ accTypeIndicator+'&amp;AccessOwnerGroup='+AccessOwnerGroup+'&amp;IsReadOnly=Y'+'&amp;entity='+entity+'&amp;SECUREHKEY='+ hashkey+'&amp;FLDHASHKEY='+ fldhashkey;

/* Changes for Audit Enquiry CRMBAR02 Ends*/
           showNewWindow(url);
            }catch(e){}
        }
/* CRM11.0:TRACKER:113058:ENDOFCHANGES */


        function getViewName(){
        	var viewName="";
            switch (BankAccountprodCatID)
            {
                case "1":
                    viewName="SavingsAccountDetails";
                    break;
                case "2":
                    viewName="DepositAccountDetails";
                    break;
                case "3":
                    viewName="CurrentAccountDetails";
                    break;
                case "4":
                    viewName="CreditcardDetails";
                    break;
                case "5":
                    viewName="HomeloanDetails";
                    break;
                case "6":
                    viewName="LoanDetails";
                    break;
                case "7":
                    viewName="MutualfundDetails";
                    break;
                case "8":
                    viewName="OtherInvestProductDetails";
                    break;
                case "9":
                    viewName="InsuranceDetails";
                    break;
                case "10":
                    viewName="DematAccountDetails";
                    break;
                case "11":
                    viewName="InvestmentPortfoliosDetails";
                    break;
            }
            return(viewName);
       }

        function getCoreCommand(){
        	var coreCommand="";
        	var mcycoreCommand = "";
		if(mcyIndicator == 'Y')
		{
			mcycoreCommand = "HMCAI";
		}
		else
		{
			mcycoreCommand = "HACI";
        	}
            switch (BankAccountprodCatID)
            {
                case "1":
					coreCommand = mcycoreCommand;
                    break;
                case "2":
					coreCommand = "HCUTD";
                    break;
                case "3":
					coreCommand = mcycoreCommand;
                    break;
                case "4":
					coreCommand = "";
                    break;
                case "5":
					coreCommand = "HACILA";
                    break;
                case "6":
					coreCommand = "HACILA";
                    break;
                case "7":
					coreCommand = "";
                    break;
                case "8":
					coreCommand = "";
                    break;
                case "9":
					coreCommand = "";
                    break;
                case "10":
					coreCommand = "";
                    break;
		case "11":
					coreCommand = "IINP";
                    break;
            }
            return(coreCommand);
       }

        function getAccNoFormat(){
        	var strAccNo="";
            switch (BankAccountprodCatID)
            {
                case "1":
					strAccNo = "hacm.acctNo=";
                    break;
                case "2":
				<!--start of changes by tracker 131224 -->
					strAccNo = "tdsumi.cifId=";
       				<!--end of changes by tracker 131224 -->
                    break;
                case "3":
					strAccNo = "hacm.acctNo=";
                    break;
                case "4":
					strAccNo = "";
                    break;
                case "5":
					strAccNo = "acmla.acctNo=";
                    break;
                case "6":
					strAccNo = "acmla.acctNo=";
                    break;
                case "7":
					strAccNo = "";
                    break;
                case "8":
					strAccNo = "";
                    break;
                case "9":
					strAccNo = "";
                    break;
                case "10":
					strAccNo = "";
                    break;
                case "11":
					strAccNo = "iinp.investmentid=";
                    break;
            }
            return(strAccNo);
       }


function identifyme()
{
loadPersistData();
expirationdate.setTime(expirationdate.getTime() + ( 160 * 60 * 1 * 1000));
if(event.srcElement.parentElement.id != null &amp;&amp; event.srcElement.parentElement.id != '') {
    /* *** Tracker # 50645, Begin of Changes *** */
    thisRowID = event.srcElement.parentElement.id;
    /* *** Tracker # 50645, End of Changes *** */
    //Security Recon Changes : Tracker Id : 356601 STARTS
    
    secureKey=event.srcElement.parentElement.getAttribute('hashkey');   		
    secureField=event.srcElement.parentElement.getAttribute('fieldHashkey1');
    
   // alert('secureKey'+secureKey);
   // alert('secureField'+secureField);
    bankAccountURL = event.srcElement.parentElement.getAttribute('SaleBO.url_');
    bankAccountId = event.srcElement.parentElement.getAttribute('SaleBO.salesID');
    bankAccountNumber = event.srcElement.parentElement.getAttribute('SaleBO.accountNumber');
    bankAccountProductURL = event.srcElement.parentElement.getAttribute('ProductBO.url_');
    productFeature = event.srcElement.parentElement.getAttribute('ProductBO.ProductFeature2');
    AccountKey = event.srcElement.parentElement.getAttribute('SaleBO.SaleCustomer.cif_ID');
    accountId = event.srcElement.parentElement.getAttribute('SaleBO.SaleCustomer.orgID'); //Tracker ID : 43543 : Picks up the accountid from the Sale_Customer.Only the Main Account Holder.
    /** TRACKER : 68864 BEGIN **/
    contactId = event.srcElement.parentElement.getAttribute('SaleBO.SaleContact.contactID');
    customerRole = event.srcElement.parentElement.getAttribute('SaleBO.SaleCustomer.Role');
    contactRole = event.srcElement.parentElement.getAttribute('SaleBO.SaleContact.Role');
    /** TRACKER : 68864 END **/
    BankAccountprodCatID = event.srcElement.parentElement.getAttribute('SaleBO.prodCatID');

    <!--Tracker:90196: Changes for Attribute Masking-->
    AccessOwnerGroup=event.srcElement.parentElement.getAttribute('SaleBO.accessOwnerGroup');
    <!--Tracker:90196: End of Changes-->
    mcyIndicator = event.srcElement.parentElement.getAttribute('SaleBO.MCYIndicator');
    productFeature=event.srcElement.parentElement.getAttribute('ProductBO.ProductFeature2');
    accTypeIndicator = event.srcElement.parentElement.getAttribute('SaleBO.AccTypeIndicator');
    productskey = event.srcElement.parentElement.getAttribute('SaleBO.ProductsKey');

} else if (event.srcElement.parentElement.parentElement.id != null &amp;&amp;
                              event.srcElement.parentElement.parentElement.id != '') {
    /* *** Tracker # 50645, Begin of Changes *** */
    thisRowID = event.srcElement.parentElement.parentElement.id;
    /* *** Tracker # 50645, End of Changes *** */
     //Security Recon Changes : Tracker Id : 356601 STARTS
        
        secureKey=event.srcElement.parentElement.parentElement.getAttribute('hashkey');   		
        secureField=event.srcElement.parentElement.parentElement.getAttribute('fieldHashkey1');
        
    //alert('secureKey'+secureKey);
    //alert('secureField'+secureField);
    bankAccountURL = event.srcElement.parentElement.parentElement.getAttribute('SaleBO.url_');
    bankAccountId = event.srcElement.parentElement.parentElement.getAttribute('SaleBO.salesID');
    bankAccountNumber = event.srcElement.parentElement.parentElement.getAttribute('SaleBO.accountNumber');
    productFeature = event.srcElement.parentElement.parentElement.getAttribute('ProductBO.ProductFeature2');
    /* TRACKER : 49518 BEGIN OF CHANGES */
    accountId = event.srcElement.parentElement.parentElement.getAttribute('SaleBO.SaleCustomer.orgID');   //Tracker ID : 43543 : Picks up the accountid from the Sale_Customer.Only the Main Account Holder.
    /** TRACKER : 68864 BEGIN **/
    contactId = event.srcElement.parentElement.parentElement.getAttribute('SaleBO.SaleContact.contactID');
    customerRole = event.srcElement.parentElement.parentElement.getAttribute('SaleBO.SaleCustomer.Role');
    contactRole = event.srcElement.parentElement.parentElement.getAttribute('SaleBO.SaleContact.Role');
    /** TRACKER : 68864 END **/
    bankAccountProductURL = event.srcElement.parentElement.parentElement.getAttribute('ProductBO.url_');
    BankAccountprodCatID = event.srcElement.parentElement.parentElement.getAttribute('SaleBO.prodCatID');
    AccountKey = event.srcElement.parentElement.parentElement.getAttribute('SaleBO.SaleCustomer.cif_ID');

    <!--Tracker:90196: Changes for Attribute Masking-->
    AccessOwnerGroup= event.srcElement.parentElement.parentElement.getAttribute('SaleBO.accessOwnerGroup');
    <!--Tracker:90196: End of Changes-->
    mcyIndicator = event.srcElement.parentElement.parentElement.getAttribute('SaleBO.MCYIndicator');
    productFeature=event.srcElement.parentElement.parentElement.getAttribute('ProductBO.ProductFeature2');
    accTypeIndicator = event.srcElement.parentElement.parentElement.getAttribute('SaleBO.AccTypeIndicator');

    productskey = event.srcElement.parentElement.parentElement.getAttribute('SaleBO.ProductsKey');

} else {
    /* *** Tracker # 50645, Begin of Changes *** */
    thisRowID = event.srcElement.parentElement.parentElement.parentElement.id;
    /* *** Tracker # 50645, End of Changes *** */
     //Security Recon Changes : Tracker Id : 356601 STARTS
        
        secureKey=event.srcElement.parentElement.parentElement.parentElement.getAttribute('hashkey');   		
        secureField=event.srcElement.parentElement.parentElement.parentElement.getAttribute('fieldHashkey1');
        
       // alert('secureKey'+secureKey);
       //alert('secureField'+secureField);
    bankAccountURL = event.srcElement.parentElement.parentElement.parentElement.getAttribute('SaleBO.url_');
    bankAccountId = event.srcElement.parentElement.parentElement.parentElement.getAttribute('SaleBO.salesID');
    bankAccountNumber = event.srcElement.parentElement.parentElement.parentElement.getAttribute('SaleBO.accountNumber');
   <!-- Changes for Ticketid:353382 Call ID:-172098 Begins-->
   branchCode = event.srcElement.parentElement.parentElement.parentElement.getAttribute('SaleBO.AccBranchCode');
   <!-- Changes for Ticketid:353382 Call ID:-172098 Ends-->
    productFeature = event.srcElement.parentElement.parentElement.parentElement.getAttribute('ProductBO.ProductFeature2');
    accountId = event.srcElement.parentElement.parentElement.parentElement.getAttribute('SaleBO.SaleCustomer.orgID');   //Tracker ID : 43543 : Picks up the accountid from the Sale_Customer.Only the Main Account Holder.
    /* TRACKER : 49518 END OF CHANGES */
    /** TRACKER : 68864 BEGIN **/
    contactId = event.srcElement.parentElement.parentElement.parentElement.getAttribute('SaleBO.SaleContact.contactID');
    customerRole = event.srcElement.parentElement.parentElement.parentElement.getAttribute('SaleBO.SaleCustomer.Role');
    contactRole = event.srcElement.parentElement.parentElement.parentElement.getAttribute('SaleBO.SaleContact.Role');
    /** TRACKER : 68864 END **/
    bankAccountProductURL = event.srcElement.parentElement.parentElement.parentElement.getAttribute('ProductBO.url_');
    BankAccountprodCatID = event.srcElement.parentElement.parentElement.parentElement.getAttribute('SaleBO.prodCatID');
    AccountKey = event.srcElement.parentElement.parentElement.parentElement.getAttribute('SaleBO.SaleCustomer.cif_ID');
    <!--Tracker:90196: Changes for Attribute Masking-->
    AccessOwnerGroup=  event.srcElement.parentElement.parentElement.parentElement.getAttribute('SaleBO.accessOwnerGroup');
    <!--Tracker:90196: End of Changes-->
    mcyIndicator = event.srcElement.parentElement.parentElement.parentElement.getAttribute('SaleBO.MCYIndicator');
    productFeature=event.srcElement.parentElement.parentElement.parentElement.getAttribute('ProductBO.ProductFeature2');
    accTypeIndicator = event.srcElement.parentElement.parentElement.parentElement.getAttribute('SaleBO.AccTypeIndicator');
    productskey = event.srcElement.parentElement.parentElement.parentElement.getAttribute('SaleBO.ProductsKey');


}
if(prevBankAcctNum == bankAccountNumber) {
  //  return;
}
setCookie('BankAccountURL', bankAccountURL, expirationdate);
setCookie('BankAccountNumber', bankAccountNumber, expirationdate);
<!-- Changes for Ticketid:353382 Call ID:-172098 Begins-->
setCookie('BranchCode', branchCode, expirationdate);
<!-- Changes for Ticketid:353382 Call ID:-172098 Ends-->
setCookie('bankAccountID', bankAccountId, expirationdate);
setCookie('AccountID', accountId, expirationdate);
/** TRACKER : 68864 BEGIN **/
setCookie('ContactID', contactId, expirationdate);
setCookie('CustomerRole', customerRole, expirationdate);
setCookie('ContactRole', contactRole, expirationdate);
/** TRACKER : 68864 END **/
setCookie('bankAccountProductURL', bankAccountProductURL, expirationdate);
setCookie('BankAccountprodCatID', BankAccountprodCatID, expirationdate);
setCookie('AccountKey', AccountKey, expirationdate);
setCookie('MCYInd', mcyIndicator, expirationdate);

setCookie('productFeature',productFeature,expirationdate);
<!--Tracker:90196: Changes for Attribute Masking-->
setCookie('AccessOwnerGroup', AccessOwnerGroup, expirationdate);
<!--Tracker:90196: End of Changes-->
//Security Recon Changes : Tracker Id : 356601 STARTS
setCookie('HASHKEY', secureKey, expirationdate);
setCookie('FLDHASHKEY', secureField, expirationdate);
setCookie('productskey', productskey, expirationdate);

savePersistData();
/* *** Tracker # 50645, Begin of Changes *** */
<!-- Changes for call id 149660 starts - commented the following lines 
if (thisRowID != prevSelectedRowID) {
    prevSelectedRowID = thisRowID;
/* *** Tracker # 50645, End of Changes *** */
    prevBankAcctId = bankAccountId;-->
    showDefTabs();
<!--}
Changes for call id 149660 ends -->
}

function fnContextSwitchviaDB(){
    if (productFeature !="FINACLECORE" || productFeature == null) {
    	showMessage(MSGJ50407);
    	return;
    }
	var coreCommand = getCoreCommand();
	var data = '';

    try{
		//BankAccountprodCatID
		if(coreCommand == "") {
         	    showMessage(MSGJ50242);
		}
		else{
			var cifid = getCookie('AccountKey');

			//var data = 'STDIN.acct_num=' + bankAccountNumber;
			if(coreCommand == "IINP"){
				<![CDATA[
				data = 'iinp.investmentId='+bankAccountNumber+'&iinp.cifId='+cifid;
				]]>

			}else if(coreCommand == "HCUTD"){
				data = getAccNoFormat();
				data = data+cifid;

			}else if(coreCommand == "HMCAI"){

				<![CDATA[
				data = 'mcai.multiCcyAccNum='+bankAccountNumber+'&mcai.cifId='+cifid;
				]]>

			}else {
				data = getAccNoFormat();
				data = data+bankAccountNumber;
			}
			if(!fnContextSwitch){
			    <!--
			    //submit form data to servlet.
			    document.form1.CALLTYPE.value = "CONTEXT_SWITCH";
			    document.form1.SERVICE_NAME.value = CORESERVER;
			    document.form1.LCLANG.value = LANGUAGEID;
			    document.form1.ACNT_NUMBER.value = bankAccountNumber;
			    document.form1.ACNT_BALANCE.value = null;
			    document.form1.SESSION_ID.value = top.window.loginFrame.getSessionID();
			    document.form1.target= "hiddenFrame";
			    document.form1.submit();
			    -->
        		   top.window.loginFrame.invokeApplicationContext(CORESERVER, data, coreCommand);
			}else{
				 fnContextSwitch(CORESERVER, data, coreCommand);
			}
       		}
    }catch(e){
    }
}
       function sortMe(sortColumn,sortOrder) {
                var expirationdate = new Date ();
                expirationdate.setTime(expirationdate.getTime() + ( 160 * 60 * 60 * 1000));
                <![CDATA[var vName=]]>"<xsl:value-of select="$ViewName"/>"
                setCookie('SORT_ORDER_' + vName, sortOrder,expirationdate);
                setCookie('SORT_COLUMN_' + vName, sortColumn,expirationdate);
                savePersistData();
        <xsl:choose>
            <xsl:when test="normalize-space($searchType)='Advance'">
                document.AdvanceFindForm.SortOrder.value=sortOrder;
                document.AdvanceFindForm.SortColumn.value=sortColumn;
                document.AdvanceFindForm.submit();
            </xsl:when>
            <xsl:otherwise>
                var doc = parent.parent.frames(0).frames(0).document;
                doc.all.SortColumn.value = sortColumn;
                doc.all.SortOrder.value = sortOrder;
                doc.form_filters.submit();
                </xsl:otherwise>
        </xsl:choose>
          }
	// CIFGroupHouseHold Changes starts
		function onClickHouseHold() {
			entityId = getCookie('AccountID');
			if (entityId== null || entityId=="" || entityId== 'null') {
			             return;
       		 }
			entityType = 'Customer';
			var str = "";
			str = "../servlet/com.infy.cis.ui.corpcif.ListofGroupHshldLinked?EntityID=" + entityId + "&amp;EntityType=" + entityType;
			var newWin = window.open(str, 'ListofHouseHoldLinked','height=500,width=750,left=150,top=100,resizable=yes,menubar=no,titlebar=no,toolbar=no,status=no,scrollbars');
			}
	// CIF GroupHouseHold Change ends
	/*Added by Niharika for 360DegreeView CR*/
	function viewBalance(){
		try{
		//alert('bankAccountNumber is :'+bankAccountNumber);
		//alert('BankAccountprodCatID is :'+BankAccountprodCatID);
		var productskey = getCookie('productskey');
		//alert("viewBalance "+productskey);
		//productskey="SB190";
		 if(productskey == "SB190")
		   {
		   alert("You are not authorised to view");
		   return;
                   }
	    if(bankAccountNumber!=null){
				windowAlign();
				<![CDATA[
				url='../servlet/com.infy.cis.ui.searchconsole.AccountBalanceInquiry?AccountNumber='+bankAccountNumber+'&ProdCatID='+BankAccountprodCatID;
				]]>
				var newWin = window.open(url, '','height=436,width=575,left=210,top=120,location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=no');
			}
			else{

				showMessage("MSGJ0119");
				}
			}
			catch(e){ alert(e.message);
			}

}
	/*End of changes by Niharika for 360DegreeView CR*/
        </script>
        </head>
        <xsl:call-template name="bodystart"/>
        <xsl:choose>
            <xsl:when test="normalize-space($searchType)='Advance'">
                         <form name="AdvanceFindForm" target='ResultArea' method="Get" action="../servlet/com.infy.cis.ui.common.AdvancedContactSearchResults">
                            <input type="hidden" name="Query" value="{$query}"/>
                            <input type="hidden" name="BOName" value="SaleBO"/>
                        <input type="hidden" name="ViewName" value="BankAccount_Search"/>
                        <input type="hidden" name="QueryText" value="{$queryText}"/>
                            <input type="hidden" name="SortOrder" value=""/>
                        <input type="hidden" name="SortColumn" value=""/>
                    </form>
            </xsl:when>
        </xsl:choose>
        <form name="form1" type="hidden" action="../servlet/com.infy.cis.ui.common.CRMContextServer">
        <input type="hidden" name="CALLTYPE" value=""/>
        <input type="hidden" name="SERVICE_NAME" value=""/>
        <input type="hidden" name="LCLANG" value=""/>
        <input type="hidden" name="SESSION_ID" value = ""/>
        <input type="hidden" name="ACNT_NUMBER" value = ""/>
        <input type="hidden" name="ACNT_BALANCE" value = ""/>
        </form>
      </xsl:if>
    <xsl:call-template name="mainbody">
        <xsl:with-param name="tablename">RecordSet</xsl:with-param>
        <xsl:with-param name="pageIndex"><xsl:value-of select="$pageIndex"/></xsl:with-param>
        <!-- Ticket id 216306 Begin of changes -->
        <xsl:with-param name="NumPages"><xsl:value-of select="$NumPages"/></xsl:with-param>
        <!-- Ticket id 216306 end of changes -->
        <xsl:with-param name="extra_tableHeader"><xsl:value-of select='$queryText' /></xsl:with-param>
        <xsl:with-param name="showNext">true</xsl:with-param>
        <!--<xsl:with-param name="callcalme">1</xsl:with-param>-->
        <xsl:with-param name="callselectLastSelected">1</xsl:with-param>
        <xsl:with-param name="rclickshow">true</xsl:with-param>
        <xsl:with-param name="rowhighlight">true</xsl:with-param>
        <xsl:with-param name="rsfilenm"><xsl:value-of select="$resfilename"/></xsl:with-param>
<!-- CRM11.0:TRACKER:113058:BEGINOFCHANGES -->
        <xsl:with-param name="colhrefname">SaleBO.accountNumber</xsl:with-param>
        <xsl:with-param name="colhref_function">showAccDetails()</xsl:with-param>
	<xsl:with-param name="colhref_two">SaleBO.AccBranchCode</xsl:with-param>
	<xsl:with-param name="colhreftwo_function">fnshowBranchCodeDetails()</xsl:with-param>
<!-- CRM11.0:TRACKER:113058:ENDOFCHANGES -->
        <xsl:with-param name="button_value">false</xsl:with-param>
        <xsl:with-param name="showbutton">false</xsl:with-param>
        <xsl:with-param name="imageFieldname">SaleBO.accountNumber</xsl:with-param>
        <xsl:with-param name="imageClick">fnContextSwitchviaDB()</xsl:with-param>
        <xsl:with-param name="imageName">../common/images/core_acm.gif</xsl:with-param>
        <xsl:with-param name="imageRequired">true</xsl:with-param>
        <!--Changes by Niharika for 360DegreeView CR-->
        <xsl:with-param name="extra_colheader2">A/c. Balance</xsl:with-param>
      	<xsl:with-param name="button">true</xsl:with-param>
	    <xsl:with-param name="width">100%</xsl:with-param>
	    <xsl:with-param name="name">View</xsl:with-param>
	    <xsl:with-param name="onClick">identifyme(),viewBalance()</xsl:with-param>
       <!--End of Changes by Niharika for 360DegreeView CR-->
       <!--Tracker:108381:Changes for 360Degree tertiary pane default tab-->
        <xsl:with-param name="jscriptfnc">,identifyme(),def_TabHelper()</xsl:with-param>
       <!--Tracker:108381:End of Changes-->
    <!--Changes by Niharika for 360DegreeView CR-->
	<!-- GroupHousehold changes start-->
	<!--<xsl:with-param name="name"><xsl:value-of select="$configLabels[@name='HouseHold']/@configLabel"/></xsl:with-param>
	<xsl:with-param name="hardcoded_string">true</xsl:with-param>
	<xsl:with-param name="extra_colheader2"><xsl:value-of select="$configLabels[@name='HouseHold']/@configLabel"/></xsl:with-param>
	<xsl:with-param name="colhrefone_function">onClickHouseHold()</xsl:with-param>-->
	<!-- GroupHousehold changes end-->
	<!--End of Changes by Niharika for 360DegreeView CR-->
    </xsl:call-template>
  </xsl:template>
 </xsl:stylesheet>













