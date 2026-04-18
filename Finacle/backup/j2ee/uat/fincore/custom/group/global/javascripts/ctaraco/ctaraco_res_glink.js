function printBlock()
{
	writeCustomHeader("ctaraco_res");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT033494") + '</td>');
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
	write('<td width="97%" > ' + Message + '</td>');
	}
	else if(Message == ""){
	write('<td>Set the value for the variable RESULT_MSG using the userhook SetOrbOut in script.</td>');
	}
	else{
	write('<td>&nbsp;&nbsp;&nbsp;</td>');
	}
	write('</tr>');
		fnDisplayTranDetails();
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
	write('<input id="Ok" name="Ok" type="button" class="button" value="' + jspResArr.get("FLT031310") + '"	onClick="javascript:return ctaraco_res_ONCLICK1(this);"" hotKeyId="Go">');
	writeFooter();
	write('</div>');
	}
}//End function



function ctaraco_res_ONCLICK1(obj)
{
	var retVal = "";
	if (preEventCall('ctaraco_res',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnLastButtonClick()) == false) {
		return false;
	}
	if (postEventCall('ctaraco_res',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
function fnDisplayTranDetails(){
	if(fnIsNull(tranId)){
		return;
	}
	with (document){
	write('<!-- DETAILSBLOCK-BEGIN -->');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertabletop1">');

	write('<tr class="subhdrbg">');
	write('<td colspan="5">');
	write('<h2 class="subhdr">Transaction Details:</h2>');
	write('</td>');
    write('</tr>');

	if(!fnIsNull(tranId)){
		write('<tr>');
		write('<td class="textlabel">Transaction ID</td>');
		write('<td align="left" class="textfielddisplaylabel">'+tranId+'</td>');
		write('<td class="textlabel">Transaction Date</td>');
		write('<td align="left" class="textfielddisplaylabel">'+tranDate+'</td>');
		write('</tr>');
	}

	write('<tr>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('</tr>');

	write('</table>');
	write('<!-- DETAILSBLOCK-END -->');
	} 
}
