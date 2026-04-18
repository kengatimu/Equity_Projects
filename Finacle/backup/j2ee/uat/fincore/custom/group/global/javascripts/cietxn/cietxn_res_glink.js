function printBlock()
{
	writeCustomHeader("cietxn_res");
	with (document){
	write('<input type="hidden" name="nextPage" id="nextPage">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0">');
	write('<tr>');
	write('<td class="page-heading">'+menuTitle+'</td>');
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
	write('<td width="97%" style="color:black"> ' + Message + '</td>');
	}
	else if(Message == ""){
	write('<td style="color:red">Set the value for the variable RESULT_MSG using the userhook SetOrbOut in script.</td>');
	}
	else{
	write('<td style="color:red">&nbsp;&nbsp;&nbsp;</td>');
	}
	write('</tr>');
	if(fnIsNull(randomRefNo)){
		fnDisplayTranDetails();
	}else{
		fnDisplayPymtToAcctGLDetails();	
	}
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
	write('<input id="Ok" name="Ok" type="button" class="button" value="Ok"	onClick="javascript:return cietxn_res_ONCLICK1(this);"" hotKeyId="Go">');
	if((fnIsNull(entity1)) && (fnIsNull(entity1TranId)) && (fnIsNull(chargeTranId)) && (fnIsNull(entity1TranId))){
		//No print option for referral
        }else{
		//Print Option for normal case
		if(fnIsNull(randomRefNo)){
			write('<input id="Print" name="Print Receipt" type="button" class="button" value="Print Receipt" onClick="javascript:return fnPrintReceipt();">');
		}else{
			write('<input id="Print" name="Print Receipt" type="button" class="button" value="Print Receipt" onClick="javascript:return fnPrintReceiptPAGL();">');
		}
	}
	writeFooter();
	write('</div>');
	}
}//End function

function cietxn_res_ONCLICK1(obj)
{
	document.forms[0].menuName.value = "CIETXN";
	handleMenuDisplay(document.forms[0].menuName.value, true, null,'Go');
	return;
	var retVal = "";
	if (preEventCall('cietxn_res',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnLastButtonClick()) == false) {
		return false;
	}
	if (postEventCall('cietxn_res',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function fnDisplayTranDetails(){
	if((fnIsNull(entity1)) && (fnIsNull(entity1TranId)) && (fnIsNull(chargeTranId)) && (fnIsNull(entity1TranId))){
		return;
	}
	with (document){
        write('<!-- DETAILSBLOCK-BEGIN -->');
        write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertabletop1">');

	write('<tr class="subhdrbg">');
	write('<td colspan="5">');
	write('<h2 class="subhdr">Init Entity Transaction Details</h2>');
	write('</td>');
        write('</tr>');

	write('<tr>');
        write('<td class="textlabel">Entity Id</td>');
        write('<td align="left" class="textfielddisplaylabel">'+entity1+'</td>');
	write('<td>&nbsp;</td>');
        write('<td>&nbsp;</td>');
        write('</tr>');

	if(!fnIsNull(entity1TranId)){
	write('<tr>');
        write('<td class="textlabel">Transaction ID</td>');
        write('<td align="left" class="textfielddisplaylabel">'+entity1TranId+'</td>');
	write('<td class="textlabel">Transaction Date</td>');
        write('<td align="left" class="textfielddisplaylabel">'+entity1TranDate+'</td>');
        write('</tr>');
	}

	if(!fnIsNull(chargeTranId)){
	write('<tr>');
        write('<td class="textlabel">Charge Transaction ID</td>');
        write('<td align="left" class="textfielddisplaylabel">'+chargeTranId+'</td>');
	write('<td class="textlabel">Charge Transaction Date</td>');
        write('<td align="left" class="textfielddisplaylabel">'+chargeTranDate+'</td>');
        write('</tr>');
	}


	write('<tr>');
        write('<td>&nbsp;</td>');
        write('<td>&nbsp;</td>');
        write('<td>&nbsp;</td>');
        write('</tr>');

	write('<tr class="subhdrbg">');
        write('<td colspan="5">');
        write('<h2 class="subhdr">Target Entity Transaction Details </h2>');
        write('</td>');
        write('</tr>');
	
	//-------------------------------------------------------------------------------------->
	write('<tr>');
        write('<td class="textlabel">Entity Id</td>');
        write('<td align="left" class="textfielddisplaylabel">'+entity2+'</td>');
	write('<td>&nbsp;</td>');
        write('<td>&nbsp;</td>');
        write('</tr>');

	if(!fnIsNull(entity1TranId)){
	write('<tr>');
        write('<td class="textlabel">Transaction ID</td>');
        write('<td align="left" class="textfielddisplaylabel">'+entity2TranId+'</td>');
	write('<td class="textlabel">Transaction Date</td>');
        write('<td align="left" class="textfielddisplaylabel">'+entity2TranDate+'</td>');
        write('</tr>');
	}

	if(!fnIsNull(entity2TranId1)){
	write('<tr>');
        write('<td class="textlabel">RSC Charge Transaction ID</td>');
        write('<td align="left" class="textfielddisplaylabel">'+entity2TranId1+'</td>');
	write('<td class="textlabel">RSC Charge Transaction Date</td>');
        write('<td align="left" class="textfielddisplaylabel">'+entity2TranDate+'</td>');
        write('</tr>');
	}

	//--------------------------------------------------------------------------------->

        write('</table>');
        write('<!-- DETAILSBLOCK-END -->');
	} //End with()
}

function fnDisplayPymtToAcctGLDetails(){
	with (document){
        write('<!-- DETAILSBLOCK-BEGIN -->');
        write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertabletop1">');

        write('<tr class="subhdrbg">');
        write('<td colspan="5">');
        write('<h2 class="subhdr">Init Entity Transaction Details </h2>');
        write('</td>');
        write('</tr>');

        write('<tr>');
        write('<td class="textlabel">Entity Id</td>');
        write('<td align="left" class="textfielddisplaylabel">'+entity1+'</td>');
	write('<td class="textlabel">Random Reference Number</td>');
	write('<td align="left" class="textfielddisplaylabel">'+randomRefNo+'</td>');
	//write('<td align="left" class="textfielddisplaylabel">**********</td>');
        write('</tr>');

        if(!fnIsNull(entity1TranId)){
        write('<tr>');
        write('<td class="textlabel">Transaction ID</td>');
        write('<td align="left" class="textfielddisplaylabel">'+entity1TranId+'</td>');
        write('<td class="textlabel">Transaction Date</td>');
        write('<td align="left" class="textfielddisplaylabel">'+entity1TranDate+'</td>');
        write('</tr>');
        }

        write('<tr>');
        write('<td class="textlabel">Charge Transaction ID</td>');
        write('<td align="left" class="textfielddisplaylabel">'+chargeTranId+'</td>');
        write('<td class="textlabel">Charge Transaction Date</td>');
        write('<td align="left" class="textfielddisplaylabel">'+chargeTranDate+'</td>');
        write('</tr>');

        write('</table>');
        write('<!-- DETAILSBLOCK-END -->');
        } //End with()

}

function fnPrintReceipt(){
    if(fnIsNull(rptFilePath)){
	var inputNameValues = "ieTxnRefNo|"+ieTxnRefNo+"|acctName|"+acctName;
	var outputNames = "errorFlg|errorMsg|rptFilePath";
	var scriptName = "cietxndp049.scr"
	var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
	var token = retVal.split("|");
	if(token != undefined){
		var errorFlg = token[1];
		var errorMsg = token[3];
		var rptFilePath = token[5];

		if(errorFlg == "Y"){
			alert(errorMsg);
			return false;
		}else{
			cust_doJsPrint(rptFilePath,"printTransientFileOnDT","false","false");
		}
	}
    }
	
	return;
}

function fnPrintReceiptPAGL(){
    if(fnIsNull(rptFilePath)){
	var inputNameValues = "ieTxnRefNo|"+ieTxnRefNo;
        var outputNames = "errorFlg|errorMsg|rptFilePath";
        var scriptName = "cietxndp053.scr"
        var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
        var token = retVal.split("|");
        if(token != undefined){
                var errorFlg = token[1];
                var errorMsg = token[3];
                var rptFilePath = token[5];

                if(errorFlg == "Y"){
                        alert(errorMsg);
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
                retVal = window.popModalWindow(sUrl,"",params);
		window.close();
        }
        if (retVal == null || retVal == undefined)
                        return retVal;
}

