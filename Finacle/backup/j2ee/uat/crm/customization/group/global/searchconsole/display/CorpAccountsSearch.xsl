<?xml version='1.0'?>
  <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="../Renderer/common/display/SRMListTemplate.xsl"/>
        <xsl:param name="locale"/>
  <xsl:variable name="userArea" select="/SRM/SRMData[@SRMDataSpace='UserData']"/>
  <xsl:variable name="searchType" select="$userArea//Z[@n='SearchType']"/>
  <xsl:variable name="query" select="$userArea//Z[@n='options']"/>
  <xsl:variable name="ViewName" select="$userArea//Z[@n='ViewName']"/>
  <xsl:variable name="searchFrom" select="/SRM/SRMData[@SRMDataSpace='UserData']/Z[@n='SearchFrom']"></xsl:variable>
<!-- Tracker : 66615 - Account Holder Maintenance changes -->
  <xsl:variable name="ScreenName" select="$userArea//Z[@n='ScreenName']"/>
<!-- Tracker : 66615 - End of changes -->
  <xsl:variable name="queryText" select="$userArea//Z[@n='QueryText']"/>
  <xsl:param name="resfilename"/>
  <xsl:variable name="configFile_1" select="document(concat($resfilename,''))"/>
  <xsl:variable name="configLabels" select="$configFile_1/SRMBO/*"/>
  <xsl:param name="pageIndex" select="0"/>
<xsl:param name="NumPages"/> <!-- TRACKER# 92380-->
<xsl:template match="/">
        <xsl:if test="$pageIndex &lt;=1">
        <xsl:call-template name="htmlstart"/>
      <head>
        <IFRAME MARGINHEIGHT='0' MARGINWIDTH='0' FRAMEBORDER='0' FRAMESPACING='0' HEIGHT='0' WIDTH='0' scrolling='no' id='hiddenFrame' name='hiddenFrame' src='' >  </IFRAME>
<script type="text/javascript" src="../common/js/ClientResourceBundle_{$locale}.js" language="javascript"></script>
<!-- <script type="text/javascript" src="../searchconsole/js/Message_Searchconsole_{$locale}.js" language="javascript"></script> -->
<script type="text/javascript" src="../Customization/js/SSOContextSwitchCustom.js" language="javascript"></script>
<!-- Removal of Harcoded Resource ID Changes Start -->		
<!-- Tracker# 174227 -: Changes for 404 errors -->
<script type="text/javascript" src="../common/js/SSOParameter.js" language="javascript"></script>
<!-- Tracker# 174227 -: Changes for 404 errors -->
<!-- Removal of Harcoded Resource ID Changes End -->
<script>
<!-- Removal of Harcoded Resource ID Changes Start -->
var CORESERVER= readCookie('COREServerName');
<!-- Removal of Harcoded Resource ID Changes End -->
var locale = '<xsl:value-of select="$locale"/>';
var NumPages = '<xsl:value-of select="$NumPages"/>';<!-- TRACKER# 92380-->
</script>
             <link rel="stylesheet" type="text/css" href="../Branding/css/common/SRMTableDisplay_{$locale}.css"/>
        <link rel="stylesheet" Type="text/css" href="../Branding/css/common/PopupMenu_{$locale}.css"/>
        <LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/SRMListTemplate_{$locale}.css"/>
    <object id="factory" style='display:none'></object>
        <script type="text/javascript" src="../common/js/PopupMenu.js"></script>
   <!-- Tracker : 66615 - Account Holder Maintenance changes -->
   	<xsl:choose>
   	    <xsl:when test="normalize-space($ScreenName)='Administration'">
   		<!-- <script type="text/javascript" src="../admin/js/MainAccountHolderRCLOptions_{$locale}.js"></script> -->
   	    </xsl:when>
   	    <xsl:otherwise>
   		<script type="text/javascript" src="../searchconsole/js/BankCorpAccountsRCLOptions_{$locale}.js"></script> 
   	    </xsl:otherwise>
   	</xsl:choose>
   <!-- Tracker : 66615 - End of Changes -->
        <script type="text/javascript" id="TableRowColor" src="../common/js/SRMTableRowColor.js"></script>
		<script type="text/javascript" src="../searchconsole/js/CorpEntitySearch.js"></script>
        <script type="text/javascript" src="../searchconsole/js/BankAccountsListRightClick.js"></script>

        <script language="javascript" src="../common/js/ExportToExcel.js" type="text/javascript">
    </script>
        <script>
          var prevBankAccountURL = "";
          var bankAccountURL = "";
          var bankAccountId = "";
          var bankAccountNumber = "";
          //var bankAccountProductURL = "";
          var BankAccountprodCatID = "";
          var prevBankAcctNum = "";

	  var AccountKey = "";
	  var mcyIndicator = "";

          var expirationdate = new Date ();
          var local_prefix="SearchConsole";
          var prevBankAcctId = "-1";         // Tracker ID : 43543 : Initialise the variable
          /* *** Tracker # 50645, Begin of Changes *** */
          var prevSelectedRowID = "-1"; // row identifier...
          /* *** Tracker # 50645, Begin of Changes *** */
          /** TRACKER : 68864 BEGIN **/
          var entity = "";
	  /** TRACKER : 68864 END **/	
	  var corpId = "";
          var accountId = "";
          var corp_ID = "";
          var AccessOwnerGroup = "";
          var productFeature = "";
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
			var corp_ID = selRow[0].getAttribute("CorporateBO.corp_ID");

			setCookie ("CorpID", corp_ID, expirationdate);
		    }
		    /* *** Tracker # 50645, End of Changes *** */
		    try{
			/*changes for Ticket 328766 begin*/
			showDefTabsCorp();
			/*changes for Ticket 328766 begin*/
		    }catch(e){}
            }
        function showAccDetails(){
        try{
        	<!--Tracker:90196: Changes for Attribute Masking-->	    		
		AccessOwnerGroup = getCookie('AccessOwnerGroup');
        	<!--Tracker:90196: End of Changes-->
        	var viewName="";
            if (bankAccountId == null || bankAccountId=="" || bankAccountId== 'null') {
                showUserMessage("MSG014","MSG_BANKACCT");
                return;
            }
	    viewName=getViewName();
		<!-- CRM102BETA:TrackerID:195035 Being of Change -->
		if(viewName == "" || viewName == null) {
		<!-- CRM102BETA:TrackerID:195035 End of Change -->
		/* Changes for ticket 315295 starts */
			showMessage(MSGH0008);
		/* Changes for ticket 315295 ends */
			return;
		}

	    /** TRACKER : 68864 BEGIN **/
	    //if (customerRole=="Main Account Holder"){
	       entity="Corporate";
	    //}
	    /*else if(contactRole=="Main Account Holder"){
	       entity="Contact";
	    }*/
	    /** TRACKER : 68864 END **/
	    
            /* RECON TRACKER 49740 BEGIN OF CHANGES **************/
            /* Changes for Audit Enquiry CRMBAR02 Starts*/
	    
	/* ScreenId has been included in the Query String */
            var url = '../servlet/com.infy.cis.ui.admin.CommonAccountDetails?ScreenID=HRF360000003&amp;viewname='+ viewName +'&amp;salesId='+bankAccountId+'&amp;accountNumber='+bankAccountNumber+'&amp;AccessOwnerGroup='+AccessOwnerGroup+'&amp;IsReadOnly=Y'+'&amp;entity='+entity; /** TRACKER : 68864 PASSING ENTITY PARAMETER **/
            /* Changes for Audit Enquiry CRMBAR02 Ends*/
            /* RECON TRACKER 49740 END OF CHANGES **************/
            showNewWindow(url);
            }catch(e){}
        }
        
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
                //changes done for 421024
                case "12":
                    viewName="LoanDetails";
                    break;
                //changes done for 421024
            }
            return(viewName);
       }
/* Changes for ticket 315295 starts */
function identifyme1()
/* Changes for ticket 315295 ends */
{
loadPersistData();
expirationdate.setTime(expirationdate.getTime() + ( 160 * 60 * 1 * 1000));
if(event.srcElement.parentElement.id != null &amp;&amp; event.srcElement.parentElement.id != '') {


//Security Recon Changes : Tracker Id : 356601 
secureKey=event.srcElement.parentElement.getAttribute('hashkey');   	
secureField=event.srcElement.parentElement.getAttribute('fieldHashkey1');


    /* *** Tracker # 50645, Begin of Changes *** */
    thisRowID = event.srcElement.parentElement.id;
    /* *** Tracker # 50645, End of Changes *** */
    bankAccountURL = event.srcElement.parentElement.getAttribute('SaleBO.url_');
    bankAccountId = event.srcElement.parentElement.getAttribute('SaleBO.salesID');
    bankAccountNumber = event.srcElement.parentElement.getAttribute('SaleBO.accountNumber');
    productFeature = event.srcElement.parentElement.getAttribute('ProductBO.ProductFeature2');
    accountId = event.srcElement.parentElement.getAttribute('SaleBO.SaleCustomer.orgID'); 
    corp_ID = event.srcElement.parentElement.getAttribute('CorporateBO.corp_ID'); //Tracker ID : 43543 : Picks up the accountid from the Sale_Customer.Only the Main Account Holder.

	BankAccountprodCatID = event.srcElement.parentElement.getAttribute('SaleBO.prodCatID');
	
	<!--Tracker:90196: Changes for Attribute Masking-->	    		
	AccessOwnerGroup=event.srcElement.parentElement.getAttribute('CorporateBO.accessOwnerGroup');
	<!--Tracker:90196: End of Changes-->
	AccountKey = event.srcElement.parentElement.getAttribute('CorporateBO.corp_Key'); 
	mcyIndicator = event.srcElement.parentElement.getAttribute('SaleBO.MCYIndicator');
} else if (event.srcElement.parentElement.parentElement.id != null &amp;&amp;
                              event.srcElement.parentElement.parentElement.id != '') {
   //Security Recon Changes : Tracker Id : 356601                            
 secureKey=event.srcElement.parentElement.parentElement.getAttribute('hashkey');   	
 secureField=event.srcElement.parentElement.parentElement.getAttribute('fieldHashkey1');
			      

                              
    /* *** Tracker # 50645, Begin of Changes *** */
    thisRowID = event.srcElement.parentElement.parentElement.id;
    /* *** Tracker # 50645, End of Changes *** */
    bankAccountURL = event.srcElement.parentElement.parentElement.getAttribute('SaleBO.url_');
    bankAccountId = event.srcElement.parentElement.parentElement.getAttribute('SaleBO.salesID');
    bankAccountNumber = event.srcElement.parentElement.parentElement.getAttribute('SaleBO.accountNumber');
    productFeature = event.srcElement.parentElement.parentElement.getAttribute('ProductBO.ProductFeature2');
    /* TRACKER : 49518 BEGIN OF CHANGES */
    corp_ID = event.srcElement.parentElement.parentElement.getAttribute('CorporateBO.corp_ID');   //Tracker ID : 43543 : Picks up the accountid from the Sale_Customer.Only the Main Account Holder.
    accountId = event.srcElement.parentElement.parentElement.getAttribute('SaleBO.SaleCustomer.orgID'); 

	BankAccountprodCatID = event.srcElement.parentElement.parentElement.getAttribute('SaleBO.prodCatID');
	<!--Tracker:90196: Changes for Attribute Masking-->	    		
	AccessOwnerGroup=event.srcElement.parentElement.parentElement.getAttribute('CorporateBO.accessOwnerGroup');
	<!--Tracker:90196: End of Changes-->
	AccountKey = event.srcElement.parentElement.parentElement.getAttribute('CorporateBO.corp_Key');   
	mcyIndicator = event.srcElement.parentElement.parentElement.getAttribute('SaleBO.MCYIndicator');
} else {
    /* *** Tracker # 50645, Begin of Changes *** */
    thisRowID = event.srcElement.parentElement.parentElement.parentElement.id;
    /* *** Tracker # 50645, End of Changes *** */
    
    //Security Recon Changes : Tracker Id : 356601 
    
    secureKey=event.srcElement.parentElement.parentElement.parentElement.getAttribute('hashkey');   	
     secureField=event.srcElement.parentElement.parentElement.parentElement.getAttribute('fieldHashkey1');
    			      
  
    
    
    bankAccountURL = event.srcElement.parentElement.parentElement.parentElement.getAttribute('SaleBO.url_');
    bankAccountId = event.srcElement.parentElement.parentElement.parentElement.getAttribute('SaleBO.salesID');
    bankAccountNumber = event.srcElement.parentElement.parentElement.parentElement.getAttribute('SaleBO.accountNumber');
    productFeature = event.srcElement.parentElement.parentElement.parentElement.getAttribute('ProductBO.ProductFeature2');
    corp_ID = event.srcElement.parentElement.parentElement.parentElement.getAttribute('CorporateBO.corp_ID');   //Tracker ID : 43543 : Picks up the accountid from the Sale_Customer.Only the Main Account Holder.
    accountId = event.srcElement.parentElement.parentElement.parentElement.getAttribute('SaleBO.SaleCustomer.orgID'); 


    /* TRACKER : 49518 END OF CHANGES */
    BankAccountprodCatID = event.srcElement.parentElement.parentElement.parentElement.getAttribute('SaleBO.prodCatID');
    <!--Tracker:90196: Changes for Attribute Masking-->	    		
    AccessOwnerGroup=event.srcElement.parentElement.parentElement.parentElement.getAttribute('CorporateBO.accessOwnerGroup');
    <!--Tracker:90196: End of Changes-->
    AccountKey = event.srcElement.parentElement.parentElement.parentElement.getAttribute('CorporateBO.corp_Key');  
    mcyIndicator = event.srcElement.parentElement.parentElement.parentElement.getAttribute('SaleBO.MCYIndicator');
}


		
if(prevBankAcctNum == bankAccountNumber) {
  //  return;
}
setCookie('BankAccountURL', bankAccountURL, expirationdate);
setCookie('BankAccountNumber', bankAccountNumber, expirationdate);
setCookie('bankAccountID', bankAccountId, expirationdate);
setCookie('CorpID', corp_ID, expirationdate);
setCookie('AccountID', accountId, expirationdate);
setCookie('AccountKey', AccountKey, expirationdate);
setCookie('MCYInd', mcyIndicator, expirationdate);

<!--Tracker:90196: Changes for Attribute Masking-->	    		
setCookie('AccessOwnerGroup', AccessOwnerGroup, expirationdate);
<!--Tracker:90196: End of Changes-->
				
setCookie('productFeature',productFeature,expirationdate);
	
/** TRACKER : 68864 BEGIN **/
/** TRACKER : 68864 END **/
//setCookie('bankAccountProductURL', bankAccountProductURL, expirationdate);
setCookie('BankAccountprodCatID', BankAccountprodCatID, expirationdate);

setCookie('HASHKEY', secureKey, expirationdate);	
setCookie('FLDHASHKEY', secureField, expirationdate);

savePersistData();
/* *** Tracker # 50645, Begin of Changes *** */
if (thisRowID != prevSelectedRowID) {
    prevSelectedRowID = thisRowID;
/* *** Tracker # 50645, End of Changes *** */
    prevBankAcctId = bankAccountId;
	/*changes for Ticket 328766 begin*/
    showDefTabsCorp();
	/*changes for Ticket 328766 end*/
}
}

function fnContextSwitchviaDB(){
    if (productFeature != "FINACLECORE") {
    	showMessage(MSGJ50407);
    	return;
    } 
	var coreCommand = getCoreCommand();
	var data = '';
    
    try{
		if(coreCommand == "") {
			showMessage(MSGJ50242);
		} 
		else{
		
		
			var cifid = getCookie('AccountKey');
			
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
				top.window.loginFrame.invokeApplicationContext(CORESERVER, data, coreCommand);
			}else{
				 fnContextSwitch(CORESERVER, data, coreCommand);
			}
       		}
    }catch(e){
    
    }
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
       function sortMe(sortColumn,sortOrder) {
                var expirationdate = new Date (); 
                expirationdate.setTime(expirationdate.getTime() + ( 160 * 60 * 60 * 1000));
                <![CDATA[var vName=]]>"<xsl:value-of select="$ViewName"/>"
                setCookie('SORT_ORDER_' + vName, sortOrder,expirationdate);
                setCookie('SORT_COLUMN_' + vName, sortColumn,expirationdate); 
                savePersistData();
        <xsl:choose>
            <xsl:when test="normalize-space($searchType)='Advance'">
						var options="<xsl:value-of select="$query"/>";
						var searchFrom="<xsl:value-of select="$searchFrom"/>";
						 eval("window.location.href='../servlet/com.infy.cis.ui.common.AdvancedContactSearchResults?SortColumn=" +sortColumn+ "&amp;SortOrder=" +sortOrder+ "&amp;Query=" +escape(options)+ "&amp;BOName=CorporateBO&amp;ViewName="+vName+"&amp;SearchFrom=" +searchFrom+"'");               </xsl:when>
            <xsl:otherwise>
                var doc = parent.parent.frames(0).frames(0).document;
                doc.all.SortColumn.value = sortColumn;
                doc.all.SortOrder.value = sortOrder;
                doc.form_filters.submit();
                </xsl:otherwise>
        </xsl:choose>
          }
 	// CIF GroupHouseHold Change starts
 	 function onClickGroup() {
 		corpID = getCookie('CorpID');
 		if (corpID== null || corpID=="" || corpID== 'null') {
 					 return;
 		}
 
 		entityId = getCookie('CorpID');
 		entityType = 'Corporate'
 		isGroup = 'Y';
 	
 	
 		var str = "";
 		str = "../servlet/com.infy.cis.ui.corpcif.ListofGroupHshldLinked?EntityID=" + entityId + "&amp;EntityType=" + entityType + "&amp;isGroup=" + isGroup;
 		/* Tracker: 108382: Changes for centering popup */
 		windowAlign();
 		var newWin = window.open(str, 'ListofGroupsLinked','height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=yes,menubar=no,titlebar=no,toolbar=no,status=no,scrollbars');
 		/* Tracker: 108382: End of Changes */
 	}
 	// CIF GroupHouseHold Change ends
 	/*Added by Niharika for 360DegreeView CR*/
		function viewBalance(){
			try{
			//alert('bankAccountNumber is :'+bankAccountNumber);
			//alert('BankAccountprodCatID is :'+BankAccountprodCatID);
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
        <xsl:with-param name="NumPages"><xsl:value-of select="$NumPages"/></xsl:with-param><!--TRACKER# 92380-->
        <xsl:with-param name="extra_tableHeader"><xsl:value-of select='$queryText' /></xsl:with-param>
        <xsl:with-param name="showNext">true</xsl:with-param>
        <!--<xsl:with-param name="callcalme">1</xsl:with-param>-->
        <xsl:with-param name="callselectLastSelected">1</xsl:with-param>
        <xsl:with-param name="rclickshow">true</xsl:with-param>
        <xsl:with-param name="rowhighlight">true</xsl:with-param>
        <xsl:with-param name="rsfilenm"><xsl:value-of select="$resfilename"/></xsl:with-param>
        <xsl:with-param name="colhrefname">SaleBO.accountNumber</xsl:with-param>
        <xsl:with-param name="colhref_function">showAccDetails()</xsl:with-param>
        <xsl:with-param name="button_value">false</xsl:with-param>
        <xsl:with-param name="showbutton">false</xsl:with-param>
        <xsl:with-param name="imageFieldname">SaleBO.accountNumber</xsl:with-param>
		<!-- Changes for ticket 315295 starts -->
		<xsl:with-param name="imageClick">identifyme1();fnContextSwitchviaDB()</xsl:with-param>
        <xsl:with-param name="imageName">../common/images/core_acm.gif</xsl:with-param>
        <xsl:with-param name="imageRequired">true</xsl:with-param>
        <!--Changes by Niharika for 360DegreeView CR-->
		<xsl:with-param name="extra_colheader2">A/c. Balance</xsl:with-param>
		<xsl:with-param name="button">true</xsl:with-param>
		<xsl:with-param name="width">100%</xsl:with-param>
		<xsl:with-param name="name">View</xsl:with-param>
		<xsl:with-param name="onClick">identifyme(),viewBalance()</xsl:with-param>
       <!--End of Changes by Niharika for 360DegreeView CR-->
        <!--Changes for Ticket#328766 begin-->
		<xsl:with-param name="jscriptfnc">,identifyme1(),def_TabHelperCorp()</xsl:with-param>
		<!--Changes for Ticket#328766 end-->
		<!-- Changes for ticket 315295 ends -->
		<!--Changes by Niharika for 360DegreeView CR-->
	<!--<xsl:with-param name="name"><xsl:value-of select="$configLabels[@name='Group']/@configLabel"/></xsl:with-param>
	<xsl:with-param name="hardcoded_string">true</xsl:with-param>
	<xsl:with-param name="extra_colheader2"><xsl:value-of select="$configLabels[@name='Group']/@configLabel"/></xsl:with-param>
	<xsl:with-param name="colhrefone_function">onClickGroup()</xsl:with-param>-->
	<!--End of Changes by Niharika for 360DegreeView CR-->
    </xsl:call-template>
  </xsl:template>
 </xsl:stylesheet>








