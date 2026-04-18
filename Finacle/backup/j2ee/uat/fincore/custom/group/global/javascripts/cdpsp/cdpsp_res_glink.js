function printBlock()
{
	var ret = Message.split('!');
	Message = ret[0];
	noofpg = ret[1];
	writeCustomHeader("cdpsp_res");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">Duplicate Pass Sheet Printing</td>');
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
	write('<td style="color:black">Set the value for the variable RESULT_MSG using the userhook SetOrbOut in script.</td>');
	}
	else{
	write('<td style="color:black">&nbsp;&nbsp;&nbsp;</td>');
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
	write('<input type="button" class="button" id="ok" value="Ok" onClick="javascript:return cdpsp_res_ONCLICK1(this);" hotKeyId="Go">');
	write('<input id="Print" name="Print" type="button" class="button" value="Print" onClick="javascript:return fnPrintReport();">');
	writeFooter();
	write('</div>');
	}
}//End function

function cdpsp_res_ONCLICK1(obj)
{
	var retVal = "";
	/*
	if (pre_ONCLICK('cdpsp_res',obj) == false) { 
		return false;
	}
	*/
	if ((retVal = fnLastButtonClick()) == false) {
		return false;
	}
	/*
	if (post_ONCLICK('cdpsp_res',obj) == false) { 
		return false;
	}
	*/
	return (retVal == undefined) ? true : retVal;
}

function fnPrintReport(){
	if ( noofpg > 5 )
	{
		alert("Please print the report in HPR.");
		return false;
	}
    if(fnIsNull(rptFilePath)){
	var inputNameValues = "";
	var outputNames = "errorFlg|errorMsg|rptFilePath";
	var scriptName = "cdpspRptPrint.scr"
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
