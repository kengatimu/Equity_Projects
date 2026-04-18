function printBlock()
{
	writeCustomHeader("hcashdx_res");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT031296") + '</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('<table class="ctable1" width="100%" border="0" cellspacing="0" cellpadding="0">');
	write('<tr class="rowspacing">');
	write('<td colspan="5">&nbsp;</td>');
	write('</tr>');
	write('</table>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="ctable">');
	write('<tr>');
	write('<td valign="top">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableborder">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write('<tr class="textfielddisplaylabel1" valign="middle">');
	write('<td colspan="5">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="resultpage">');
	write('<tr>');
	write('<td width="3%">');
	write('<img class="img" src="../Renderer/images/info.gif" width="29" height="29" align="right" border="0">');
	write('</img></td>');
	if(Message != "NULL"){
	write('<td width="97%" > ' + Message +'</td>');
	}
	else if(Message == ""){
	write('<td>Set the value for the variable RESULT_MSG using the userhook SetOrbOut in script.</td>');
	}
	else{
	write('<td>&nbsp;&nbsp;&nbsp;</td>');
	}
	write('</tr>');
	write('</table>');
	write('</td></tr>');
	write('</table></td></tr>');
	write('</table></td></tr>');
	write('</table></td></tr>');
	write('</table>');
	} //End with()
} //End function

function printFooterBlock()
{
	with (document) {
	write('<div class="ctable">');
	write('<input id="Ok" name="Ok" type="button" class="button" value="Ok"	onClick="javascript:return hcashdx_res_ONCLICK1(this);"" hotKeyId="Go">');
	//write('<input type="button" class="button" id="PRINT" value="PRINT" onClick="javascript:return fnhcashdxAdv();" hotKeyId="Go">');
	var tmpMessage = Message.split(":");
        var tranId = tmpMessage[1];
	/* if((tranId != undefined) && (tranId != "")){
		write('<input id="Printdenom" name="Printdenom" type="button" class="button" value="PRINT DENOM DETAILS"	onClick="javascript:return hcashdx_res_ONCLICK2(this);"" >');
	}*/
	writeFooter();
	write('</div>');
	}
}//End function


function hcashdx_res_ONCLICK1(obj)
{
	var retVal = "";
	if (pre_ONCLICK('hcashdx_res',obj) == false) {
		return false;
	}
	if ((retVal = fnLastButtonClick()) == false) {
		return false;
	}
	if (post_ONCLICK('hcashdx_res',obj) == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hcashdx_res_ONCLICK2(obj)
{
	var retVal = "";
	if (pre_ONCLICK('hcashdx_res',obj) == false) {
		return false;
	}
	if ((retVal = showDenomDetails()) == false) {
		return false;
	}
	if (post_ONCLICK('hcashdx_res',obj) == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}


/*function fnhcashdxAdv()
{
	var input = ""
	var output="OUTPUTPATH";

		var out_fileName = Path;
		cust_doJsPrint(out_fileName,"printTransientFileOnDT","false","false");
		var val = retval.split("|");
	return (retval == undefined) ? true : retval;
}*/

function fnOnLoad()
{
	fnPrintReceipt();
}

function fnPrintReceipt(){
	
  
	if(fnIsNull(rptFilePath)){
	

	//var inputNameValues = "tranId|"+tranId;

        var tranId = Message.split(":");
        var inputNameValues = "tranId|"+tranId[1];

	var outputNames = "errorFlg|errorMsg|rptFilePath";
	var scriptName = "cashdxdp001.scr";
	var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
	var token = retVal.split("|");
	if(token != undefined){
		var errorFlg = token[1];
		var errorMsg = token[3];
		var rptFilePath = token[5];
		if(errorFlg == "Y"){
			return false;
		}else{
			cust_doJsPrint(rptFilePath,"printTransientFileOnDT","false","false");
		}
	}
    }

	return;
}

//      Function to display the advice in the popup windiow.

function cust_doJsPrint(rptFileName,printFunctionName,duplicatePrintAllowed,printOnLoad)
{
        var sUrl = "../custom/jsp/cust_rpt_print.jsp?";
        if(!cust_fnIsNull(rptFileName))
                sUrl += "&rptFileName="+rptFileName;
        if(!cust_fnIsNull(printFunctionName))
                sUrl += "&printFunctionName="+printFunctionName;
        if(!cust_fnIsNull(duplicatePrintAllowed))
                sUrl += "&duplicatePrintAllowed="+duplicatePrintAllowed;
        if(!cust_fnIsNull(printOnLoad))
                sUrl += "&printOnLoad="+printOnLoad;
	sUrl += "&retPage=Y";
        var xMax = screen.width, yMax = screen.height;
        var xOffset = (xMax - 120), yOffset = (yMax - 150);
        var params = "dialogWidth=500px;dialogHeight=500px;dialogLeft="+xOffset+"px;dialogTop="+yOffset+"px";
        params += ";status=no;toolbar=no;menubar=no;resizable=yes;help=no;center=no";
        var retVal = "";
        if("Netscape" == browser_name)
        {
                window.open(sUrl,"title","width=10px,height=10px,modal=yes,top="+yOffset+"px,left="+xOffset+"px,scrollbars=yes,toolbar=no,menubar=no,help=no");
        }
        else
        {
                //retVal = window.popModalWindow(sUrl,"",params);
		retVal = window.popModalWindow(sUrl,"");
		window.close();
        }
        if (retVal == null || retVal == undefined)
                        return retVal;
}

function showDenomDetails()
{
	var sUrl 	= "";
	var urlData 	= "";
	var tranId = Message.split(":");
	var inputNameValues = "tranId|"+tranId[1];
	var outputNames = "creditCoins|creditNotes|debitCoins|debitNotes|creditCoinsValue|creditNotesValue|debitCoinsValue|debitNotesValue|bankName|branchName|empName|creditCrncy|debitCrncy|homeCrncy|userId|bodDate|custName|idNum|phoneNo|docDetails|nationDet";
	var scriptName = "denomDetailsScreen.scr";
	var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
	var token = retVal.split("|");

	if(token != undefined){

		var iIndex = 1;
		var totalCoinsCredit = 0;
		var totalNotesCredit = 0;
		var totalCredit      = 0;

		var totalCoinsDebit = 0;
		var totalNotesDebit = 0;
		var totalDebit 	    = 0;
		var creditCoins = token[iIndex];
		var cCoins = creditCoins.split("-");
		var creditCoinsValue = token[iIndex+=2];
		var cCoinsValue = creditCoinsValue.split("-");


		for(var i = 0;i<cCoinsValue.length;i++ )
		{
			urlData+= "&creditCoinsValue["+i+"]="+cCoinsValue[i];
			urlData+= "&creditCoins["+i+"]="+cCoins[i];
			totalCoinsCredit += cCoins[i] * cCoinsValue[i];

		}

		var creditNotes = token[iIndex+=2];
		var cNotes = creditNotes.split("-");
		var creditNotesValue = token[iIndex+=2];
		var cNotesValue = creditNotesValue.split("-");

		for(var i = 0;i<cNotesValue.length;i++ )
		{
			urlData+= "&creditNotesValue["+i+"]="+cNotesValue[i];
			urlData+= "&creditNotes["+i+"]="+cNotes[i];
			totalNotesCredit += cNotes[i] * cNotesValue[i];
		}
		totalCredit = totalCoinsCredit + totalNotesCredit;

		var debitCoins = token[iIndex+=2];
		var dCoins = debitCoins.split("-");
		var debitCoinsValue = token[iIndex+=2];
		var dCoinsValue = debitCoinsValue.split("-");

		for(var i = 0;i<dCoinsValue.length;i++ )
		{
			urlData+= "&debitCoinsValue["+i+"]="+dCoinsValue[i];
			urlData+= "&debitCoins["+i+"]="+dCoins[i];
			totalCoinsDebit += dCoins[i] * dCoinsValue[i];

		}


		var debitNotes = token[iIndex+=2];
		var dNotes = debitNotes.split("-");
		var debitNotesValue = token[iIndex+=2];
		var dNotesValue = debitNotesValue.split("-");
		for(var i = 0;i<dNotesValue.length;i++ )
		{
			urlData+= "&debitNotesValue["+i+"]="+dNotesValue[i];
			urlData+= "&debitNotes["+i+"]="+dNotes[i];
			totalNotesDebit += dNotes[i] * dNotesValue[i];

		}

		totalDebit = totalCoinsDebit + totalNotesDebit;

		var bankName 		= token[iIndex+=2];
		var branchName 		= token[iIndex+=2];
		var empName 		= token[iIndex+=2];
		var creditCrncy 	= token[iIndex+=2];
		var debitCrncy 		= token[iIndex+=2];
		var homeCrncy           = token[iIndex+=2];
		var userId              = token[iIndex+=2];
		var bodDate             = token[iIndex+=2];

		var custName             = token[iIndex+=2];
		var idNum             = token[iIndex+=2];
		var phoneNo             = token[iIndex+=2];
		var docDetails             = token[iIndex+=2];
		var nationDet             = token[iIndex+=2];

		urlData+= "&bankName="+bankName;
		urlData+= "&branchName="+branchName;
		urlData+= "&empName="+empName;
		urlData+= "&creditCrncy="+creditCrncy;
		urlData+= "&debitCrncy="+debitCrncy;
		urlData+= "&totalCredit="+totalCredit;
		urlData+= "&totalDebit="+totalDebit;
		urlData+= "&homeCrncy="+homeCrncy;
		urlData+= "&userId="+userId;
		urlData+= "&bodDate="+bodDate;

		urlData+= "&custName="+custName;
		urlData+= "&idNum="+idNum;
		urlData+= "&phoneNo="+phoneNo;
		urlData+= "&docDetails="+docDetails;
		urlData+= "&nationDet="+nationDet;
	}

	var sUrl = "../custom/jsp/hcashx_denomDetails.jsp?";
	sUrl+= urlData;
	//alert("sUrl = "+sUrl);
	var xMax = screen.width, yMax = screen.height;
	var xOffset = (xMax - 120), yOffset = (yMax - 150);
	var params = "dialogWidth=800px;dialogHeight=50px;dialogLeft="+xOffset+"px;dialogTop="+yOffset+"px";
	params += ";status=yes;toolbar=yes;menubar=yes;resizable=yes;help=yes;center=no";
	 var retVal = "";
		if("Netscape" == browser_name)
		{
			window.open(sUrl,"title","width=10px,height=10px,modal=yes,top="+yOffset+"px,left="+xOffset+"px,scrollbars=yes,toolbar=no,menubar=no,help=no");

		}
		else
		{
			retVal = window.popModalWindow(sUrl,"",params);

		}
		if (retVal == null || retVal == undefined)
		{
			return retVal;
	}
}
