function printResBlock()
{
	writeCustomHeader("cprofileres");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FSC909815") + '</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
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
	write('<td width="97%" > ' + Message + '</td>');
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

function printResFooterBlock()
{
	with (document) {
	write('<div class="ctable ">');
	write('<input id="Ok" name="Ok" type="button" class="button" value="' + jspResArr.get("FLT026526") + '"	onClick="javascript:return cprofileres_ONCLICKOK(this);"" hotKeyId="Go">');
    if(!fnIsNull(printRptName)){
	write('<input id="viewPrintRpt" name="viewPrintRpt" type="button" class="button" value="' + jspResArr.get("FLT004705") + '"	onClick="javascript:return cprofileres_ONCLICKPRINT(this);"" >');
    }
	writeFooter();
	write('</div>');
	}
}//End function

function cprofileres_ONCLICKOK(obj)
{
	var retVal = "";
	if (preEventCall('cprofileres',obj,'ONCLICK') == false) {
		return false;
	}
    if(!fnIsNull(menuGroupParentMopId)){
        invokeMenu(menuGroupParentMopId);
        return false;
    }
	if ((retVal = fnLastButtonClick()) == false) {
		return false;
	}
	if (postEventCall('cprofileres',obj,'ONCLICK') == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cprofileres_ONCLICKPRINT(obj)
{
	var retVal = "";
	if (preEventCall('cprofileres',obj,'ONCLICK') == false) {
		return false;
	}
    retVal = fnFetchDataFromDB(["printRptFileName","FETCHDATA!PRINT_RPT_FILE!HCUTOFF",printRptName+"!"+submitTimeStamp,"N",""]);
    if((retVal[1] != undefined)&&(!fnIsNull(retVal[1]))){
        fnCustomReportPrint("Customize","Customize_ctrl.jsp",retVal[1],"printTransientFileOnDT","false","true");
    }else{
        alert("Report does not exists or has zero bytes");
    }
	if (postEventCall('cprofileres',obj,'ONCLICK') == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}