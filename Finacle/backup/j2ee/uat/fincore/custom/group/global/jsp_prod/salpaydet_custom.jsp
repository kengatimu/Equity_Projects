<html>
<%@ include file="/custom/commonInclude.jsp" %>
<%
    ContextManager ARJspCurr =(ContextManager)session.getAttribute("CustomARJspCurr");
	String sGroupName = ARJspCurr.getCurrentGroup();
	String funcCode = (String)ARJspCurr.getInput(sGroupName+".funcCode", "");
	SecurityInfo70 securityInfo = (SecurityInfo70)session.getAttribute("FinUserInfo");
	String schmCode = (String)ARJspCurr.getInput(sGroupName+".schmCode", "");
	
%>
<script language="javascript" src="../../javascripts/custom_functions.js" ></script>
<script language="javascript" src="../../javascripts/cust_post_evt.js" ></script>
<script language="javascript" src="../../javascripts/cust_pre_evt.js" ></script>
<script type="text/javascript">
with (document)
{
		write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="ctable" >');
        write('<tr>');
        write('<td>');
        write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table" >');
        write('<tr>');
        write('<td>');
        write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable" >');
        write('<tr>');
        write('<td>');
        write('<table width="100%" border="0" cellpadding="4" cellspacing="5" class="innertabletop1">');
        write('<tr>');
        write('<td class="textlabel">Total Amt</td>');
        write('<td>');
        write('<input class="textfieldamount" type="text" name="Totamt" id="Totamt" align="right" size="2" maxlength="30" disabled>&nbsp;&nbsp;');
        write('</td>');
        write('</tr>');
		//Customization addition
		write('<tr>');
        write('<td class="textlabel">Charge Code</td>');
        write('<td>');
        write('<input class="textfieldamount" type="text" id="chgrcode" name="chgrcode" size="10" maxlength="10"  value="">&nbsp;&nbsp;');
		write('<a id="solIdList"  href="JavaScript:fnCustSearcher()">');
        write('<img class="img" onmouseover="this.style.cursor=\'hand\';"  onmouseout=" this.style.cursor=\'default\';" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16" height="16" border="0" alt="ChrgDtls" width="24" height="20" onClick=""></img>');
        write('</a>');
		write('<input class="label" type="text" id="chgrdesc" name="chgrdesc" size="10" maxlength="10"  value="">&nbsp;&nbsp;');
        write('</td>');
        write('</tr>');
		//Customization end
        write('</table>');
        write('</td>');
        write('</tr>');
        write('</table>');
        write('</td>');
        write('</tr>');
        write('</table>');
        write('</td>');
        write('</tr>');
        write('</table>');
		

}
function pre_ONLOAD(){
	salpay_getFields();
}

function post_ONLOAD(){
	if(document.forms[0].customData.value == "")
	{
		document.forms[0].customData.value="0";
	}
	document.forms[0].Totamt.value = parseFloat(document.forms[0].customData.value,2);
	document.forms[0].Totamt.value = formatToMillion1(document.forms[0].Totamt.value, 2);
	var creditAmt=document.getElementById("creditAmt");
	creditAmt.onfocus = function(){fnOnFocus()};

	if(document.forms[0].tranRemarks.value == "")
	{
		document.forms[0].tranRemarks.value = "SALARY / REMITTANCE";
		document.forms[0].tranRemarks.disabled = true;
	}

	if(document.forms[0].tranParticulars.value == "")
	{
		document.forms[0].tranParticulars.value = "SALARY";
	}
	
	document.forms[0].tranRemarks.disabled = true;

//geo start 

    var radioButtons = document.getElementsByName('placeLienFlg')[0].disabled = true;
     var radioButtons = document.getElementsByName('placeLienFlg')[1].disabled = true;

// geo end
//Customization Addition for Charge collection


//End of Customization
}

function fnOnFocus()
{
	var creditAmount = 0;
	if(document.forms[0].creditAmt.value != "")
	{
		creditAmount = document.forms[0].creditAmt.value;
		creditAmount = creditAmount.replace(new RegExp(',','g'),"");
		creditAmount = parseFloat(creditAmount,2);
	}
	document.forms[0].customData.value = parseFloat(document.forms[0].customData.value,2) - creditAmount;
	document.forms[0].tranRemarks.disabled = true;
}

function salpaydet_ONBLUR(obj)
{
	if(obj.id=="creditAmt")
	{
		fnOnBlur();
	}
}

function fnOnBlur()
{
	var creditAmount = 0;
	if(document.forms[0].creditAmt.value != "")
	{
		creditAmount = document.forms[0].creditAmt.value;
		creditAmount = creditAmount.replace(new RegExp(',','g'),"");
		creditAmount = parseFloat(creditAmount,2);
	}
	document.forms[0].customData.value = parseFloat(document.forms[0].customData.value,2) + creditAmount;

	document.forms[0].Totamt.value = parseFloat(document.forms[0].customData.value,2);
	document.forms[0].Totamt.value = formatToMillion1(document.forms[0].Totamt.value, 2);
	
	document.forms[0].tranRemarks.disabled = true;
}

function salpaydet_pre_ONCLICK(obj)
{
	if(obj.id == "chkdelFlg")
	{
		var creditAmount = 0;
		if(document.forms[0].creditAmt.value != "")
		{
			creditAmount = document.forms[0].creditAmt.value;
			creditAmount = creditAmount.replace(new RegExp(',','g'),"");
			creditAmount = parseFloat(creditAmount,2);
		}
		var chkFlg = document.forms[0].chkdelFlg.checked;		
		if(chkFlg == true)
		{
			document.forms[0].customData.value = parseFloat(document.forms[0].customData.value,2) - creditAmount;
		}
		else
		{
			document.forms[0].customData.value = parseFloat(document.forms[0].customData.value,2) + creditAmount;
		}
		document.forms[0].Totamt.value = parseFloat(document.forms[0].customData.value,2);
		document.forms[0].Totamt.value = formatToMillion1(document.forms[0].Totamt.value, 2);
	}
	
	if(document.forms[0].chgrcode.value == ""){
		alert("Please enter the charge Code. For no charge collection enter NA.");
		document.forms[0].chgrcode.focus();
		return false;	
	}
	else{
	var chrg = document.forms[0].chgrcode.value.toUpperCase();
	if(chrg != "NA"){
		var inputNameValues    = "chgrcode|"+chrg;
        var outputNames        = "";
        var scrName            = "salpayVal.scr";
        var retVal             = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        ret = retVal.split("|");
        if(ret[0] == "Error") {
                alert(ret[1]);
				document.forms[0].chgrcode.focus();
        }
		}
	
	
	}

	document.forms[0].tranRemarks.disabled = true;
	salpay_setFields();
}

function salpaydet_ONCHANGE(obj)
{
	if(obj.id == "operAcctNo" && document.forms[0].operAcctNo.value != "" ) {
	var operAcctNo=document.forms[0].operAcctNo.value;
	var inputNameValues = 'operAcctNo|'+operAcctNo;
 	var outputNames = "";;
        var scrName     = "formatsalpay.scr";
        var retVal      = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
	var ret = retVal.split("|");	
	alert(ret[1])
	if(ret[0] == "Error") {
    	alert(ret[1]);
        return false;
    }
	else  {
	   	document.forms[0].operAcctNo.value = ret[1];
	}
	return true;
	}
	document.forms[0].tranRemarks.disabled = true;
	return true;
}

// Overridding system function 
function fnOperAccountIDList(){
        showAccountIdList(objForm.operAcctNo,objForm.operAcctSolId,objForm.operAcctName,'F',objForm.operAcctCcy,'','','');

        objForm.operAcctSolId.value = "";
        objForm.operAcctName.value = "";
        objForm.operAcctCcy.value = "";
        objForm.operAcctschmType.value = "";

        fnCallSendToServerForOperAccountId(objForm.operAcctNo,objForm.operAcctCcy,objForm.operAcctSolId,objForm.operAcctName,objForm.operAcctschmType);

        if (objForm.operAcctName.value.length>22)
        {
        objForm.operAcctName.value=objForm.operAcctName.value.substring(0,22);
        }
	salpaydet_ONCHANGE(document.forms[0].operAcctNo);
}

//Customization Addition
function fnCustSearcher() {
		var inputNameValues = "";
        var outputNames = "chgrcode|chgrdesc";
        var scrName     = "salpaydp001.scr";
        var title       = "Charge Codes - Salpay ";
        var literalNames= "Charge Code | Description";
        var hyperLnks   = "1";
        var retVal = fnExecuteScriptForList(inputNameValues, outputNames, scrName, title, literalNames, hyperLnks, true);
}





function salpay_setFields() {
        setFieldsToCustomData("chgrcode","chgrdesc");
        return true;
}



function salpay_getFields() {
            getFieldsFromCustomData("chgrcode","chgrdesc");
}





//Customization End
</script>
</html>
