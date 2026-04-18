<!----------------------------------------------------------------------------------------------------------------------->
<!--description         : Memo pad.
<!--Date                : 22-05-2013
<!--Author              : Iranna
<!--Called By           : None
<!--Calling  Jsp        : None
<!--Menu Option         : HACCBAL
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------           -----------        ------------------
<!--     0.1            22-05-2013           Iranna           Original version
<!--     0.2            17-06-2013           Iranna           Added HACLI and HACCBAL menu
<!--     0.3            15-07-2013           Bharath          Cursor focus changed to Acct ID on onload for menu HACLI 
<!--	 0.4			 30-07-2013			Vijaya V			commented out commonInclude.jsp as a part TOL 363136
<!--     0.5            08-08-2013           Bharath          TOD Amount alert added for HACLI and HACCBAL menus
<!--     0.6            30-08-2013           Saby             Added part for 369963 
<!------------------------------------------------------------------------------------------------------------------------>
<%--
Source Name: "inquirycriteria_custom.jsp"
--%>
<!-- <%@ include file="../commonInclude.jsp"%> -->
<%@ include file="../../javascripts/core_signature.js" %>

<%
        FABCommon.SecurityInfo70 securityInfo = (FABCommon.SecurityInfo70)session.getAttribute("FinUserInfo");
        if(null == securityInfo)
        {
                securityInfo = (FABCommon.SecurityInfo70)session.getAttribute("UserInfo");
        }

        String sBODDate = (String)((securityInfo.bodDate).substring(0,10));
	String contextSol  = (String)((securityInfo.contextSolId));
%>
<script language="javascript" src="../Renderer/custom/javascripts/session.js"> </script>
<script type ="text/javascript">
var bodDate = '<%=sBODDate%>';
var acctIdStr = ""
var setId = '<%=contextSol%>';



function post_ONLOAD(){
	if(document.forms[0].cust_criteria_set_id != undefined)
	{
		document.forms[0].cust_criteria_set_id.value=setId;
	}
	if(typeof(mopId) != "undefined"){
		if(mopId == 'HSII') {
			element = document.forms[0].tran_foracid;
			element.onchange = function() { fnOnChangecust() };
		}
		if(mopId == 'HATI' || mopId == 'HAITINQ' ||mopId == 'HACSBIO') {
			element = document.forms[0].acct_num;
			element.onchange = function() { fnOnChangecust() };
		}
		if(mopId == 'HACLI') {
			element = document.forms[0].account_No;
			element.onchange = function() { fnOnChangecust() };	
		}
		if(mopId == 'HACCBAL') {
                        element = document.forms[0].foracid;
                        element.onchange = function() { fnOnChangecust() };
		}
	if(mopId=='HRELPI') {
		acctIdStr = "foracid";
		signFunction();
	}else if(mopId=='HACCBAL'){
		acctIdStr = "foracid";
		signFunction();
	}else if(mopId=='HACLI'){
		acctIdStr = "account_No";
		//signFunction();
		document.forms[0].account_No.focus();
	}
	}
}

function inquirycriteria_pre_ONCLICK(obj) 
{
        var catodAcctNum ;
	var objForm = document.forms[0];
if(typeof(mopId) != "undefined"){
	if(mopId=='HACLI')
	{
		if(obj.id == 'Submit')
		{
		if (profileId=="11")
		{
			// Document Expiration Check --- Anderson
			if (mopId=='HACLI' && document.forms[0].account_No.value != "")
		{
		alert(document.forms[0].account_No.value)
	     var inputNameValues = "foracid|" + document.forms[0].account_No.value;
             var outputNames = "msgFlg";
             var scrName="checkDocExpDate.scr";
             retVal=appFnExecuteScript(inputNameValues, outputNames, scrName, false);
             retVal = retVal.split("|");
             if (retVal[1]) {
                    alert(retVal[1]);
                }

		}

	// End Document Expiration Check --- Anderson
	}
		//	catod(objForm.account_No.value);
if(objForm.account_No.value != ""){
			setSValue("catodAcctNum|"+objForm.account_No.value);
}
                        if((document.forms[0].date_from_ui.value) != "" )
                        {
                                inputNameValues = "fromDate|" + document.forms[0].date_from_ui.value;
                                var outputNames     = "";
                                var scrName         = "aclidp001.scr";

                                var retValue          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
                                var ret1 = retValue.split("|");
                                if(ret1[1] != "" )
                                {
                                        alert(ret1[1]);
                                        return false;
                                }
                        }
		setFieldsToCustomData("account_No");
		//alert(document.forms[0].customData.value);
	
		}
			if (document.forms[0].account_No.value !="")
			 {
				var acct = document.forms[0].account_No.value;
				var input      = "acct|"+acct;
				var outputNames    = "output|outVal";
				var scrName     =   "bio_check.scr";
				var retVal = appFnExecuteScript(input,outputNames,scrName,false);
				var retBuff = retVal.split("|");
				var output = retBuff[0];
				var value = retBuff[1];
				var a = value;
				var retBuff = retVal.split("|");
				var output1 = retBuff[2];
				var value1 = retBuff[3];
				var b = value1;
				if (a!=1)
				{
					if (b!=4) 
					{
						alert("ENROLL CUSTOMER FOR BIO");
					}
					if (b==4) 
					{
						alert("PLEASE ENROLL CUSTOMER FOR BIO");
						document.forms[0].account_No.focus();
						return false;
					}
				}
			 }

	}
	if(mopId=='HACCBAL')
	{
		if(obj.id == 'Submit')
		{
		//	catod(objForm.foracid.value);
if(objForm.foracid.value != ""){			
			setSValue("catodAcctNum|"+objForm.foracid.value);
			}
		}
	}
}
}

function fnOnChangecust() {
if(typeof(mopId) != "undefined"){
	var inputNameValues = "";
	if(mopId == 'HSII') {
		retVal = txtSrh_ONCHANGE(this,"postChangeSearch('VALACCTID','F','tran_foracid','tran_foracid_crncy|tran_foracid_sol_id|tran_acct_name')");
		crncy = document.forms[0].tran_foracid_crncy.value;
		inputNameValues = "acctNum|"+document.forms[0].tran_foracid.value;
	} else if(mopId == 'HATI') {
		retVal = txtSrh_ONCHANGE(this);
		crncy = ' ';
		inputNameValues = "acctNum|"+document.forms[0].acct_num.value;
	} else if(mopId == 'HAITINQ') {
		retVal = txtSrh_ONCHANGE(this,"postChangeSearch('VALXBANKCUSTACCTID','F','acct_num|targetBankId','crncy_code|sol_id|acct_name','N')")
		crncy =  document.forms[0].crncy_code.value;
		inputNameValues = "acctNum|"+document.forms[0].acct_num.value;
	} else if(mopId == 'HACSBIO') {
		retVal = txtSrh_ONCHANGE(this,"postChangeSearch('VALACCTID','F','acct_num','crncy_code|sol_id|acct_name','N')")
		crncy =  document.forms[0].crncy_code.value;
		inputNameValues = "acctNum|"+document.forms[0].acct_num.value;
	} else if(mopId == 'HACLI'){

		//retVal = txtSrh_ONCHANGE(this);
                crncy = ' ';
		inputNameValues = "acctNum|"+document.forms[0].account_No.value;
        var outputNames = "errorFlg|errorMsg|acctNumEntityId|acctNumSolId|acctNumCcy|acctName|acctNum";
        var scrName = "accnt_details.scr"
        var retVal = appFnExecuteScript(inputNameValues,outputNames,scrName,false);
        var token = retVal.split("|");
        if(token != undefined){
                var errorFlg = token[1];
                var errorMsg = token[3];
                var AcctNumEntityId = token[5];
                var AcctNumSolId = token[7];
                var AcctNumCcy = token[9];
                var AcctName = token[11];
                var AcctNum = token[13];

				document.forms[0].sol_id.value = AcctNumSolId;
				document.forms[0].crncy_code.value = AcctNumCcy;
				}
		}
	else if(mopId == 'HACCBAL'){
	//Saby-Added part for 369963
		inputNameValues = "acctId|" + document.forms[0].foracid.value;
		var outputNames     = "";
		var scrName         = "acctentitycheck.scr";
		var retValue          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
		var ret1 = retValue.split("|");
		if(ret1[0] == "BNK" )
		{
				document.forms[0].targetBankId.value = ret1[1];
		}
	//Ended
		retVal = txtSrh_ONCHANGE(this,"postChangeSearch('VALXBANKACCTID','F','foracid|targetBankId','crncy_code|sol_id|acct_name','N')");
		crncy = ' ';
		inputNameValues = "acctNum|"+document.forms[0].foracid.value;
	}


	if(retVal){
		if(crncy != '') {
      		var outputNames     = "";
       		var scrName         = "formatacctdp001.scr";
       		var retValue          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
       		var ret1 = retValue.split("|");
       		if(ret1[0] == "MSG" )
        	{
                alert(ret1[1]);
       		}
		}
	}
}
}

function signFunction(){
var a = document.getElementsByTagName("td");
var acctLabel = "A/c. ID";
var tmpSignStr = '<a id="sigLnk" href="javascript:fnCustShowSignature();">';
tmpSignStr = tmpSignStr + '<img class="img" title="Signature" src="../Renderer/images/INFENG/sig_new1.gif" width="16" height="18" border="0"></img></a>&nbsp;'
for(i=0;i<a.length;i++)
{
	if(a[i].innerHTML.indexOf(acctLabel) != -1)
	{
		if(a[i+1].innerHTML.indexOf('<INPUT') != -1 && a[i+1].innerHTML.indexOf('<INPUT') == 0) {
			var str = a[i+1].innerHTML;
			var indx = str.indexOf('</A>') + 4;
			if(str.indexOf('sigLnk') == -1) {
				a[i+1].innerHTML = str.substr(0,indx) + tmpSignStr + str.substr(indx);
			}
			return;
		}
	}
}

}
function fnCustShowSignature() {
	var solIdStr = "";
	var tmpAcctObj = document.getElementById(acctIdStr);
	if('X'+solIdStr != 'X') {
	var tmpSolObj = document.getElementById(solIdStr).value;
	}
	else
	{
	tmpSolObj = ""
	}
	if (fnIsNull(tmpAcctObj.value)) {
		alert("Enter the field.");
		tmpAcctObj.focus();
		return ;
	}
	var data = '?sAcctId='+escape(tmpAcctObj.value)+'&sSolId='+escape(tmpSolObj)+'&sActiveDate='+escape(bodDate)+'&fromAppId='+escape(fromAppId)+'&toMenu='+ mopId.toLowerCase() +'&contextSwitch=Y';
	displaySVSWindow(data);
}
function callbackSVS(data,menu)
{
// for SSO Context Switching
}

function catod(acctId)
{
    if (acctId != "")
    {
        var input = "acctId|" + acctId;
        var retVal = appFnExecuteScript(input, "", "ctodadp014.scr", false);
        if (retVal != null && retVal != undefined && retVal != "")
        {
                var ret = retVal.split("|");
                var message = ret[1];
                if (message != "")
                {
                        alert(message);
                }
        }
    }
}

</script>
