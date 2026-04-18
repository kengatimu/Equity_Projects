// Generated from spec file 


function printBlock1()
{
	//alert("Hi");
	with (document) {
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" >');
	write('<tr>');
	write('<td class="popuptab">' + jspResArr.get("FLT003104") + '</td>');
	write('</tr>');
	write('</table>');

	} 
} //End function

function printBlock2()
{
	with (document) {
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableborder">');
	write('<tr><td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write('<tr><td valign="top">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertabletop">');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT003100") + '</td>');
	write('<td class="textfield">');
	write('<input  tabIndex="1" type="text" class="textfieldfont" name="fromAmt" id="fromAmt" size="24" maxlength="24" fdt="amount" fmnd="Y" onBlur="javascript:newformatAmt(\'' + format + '\', frm.fromAmt,frm.fromCrncy.value,\'N\');" onChange="fnChange(this);" style="TEXT-ALIGN:right">');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">&nbsp;</td>');
	write('<td class="textfield">&nbsp;</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT003101") + '</td>');
	write('<td class="textfield">');
	write('<input tabIndex="2" class="textfieldfont" name="fromCrncy" id="fromCrncy" size="6" maxlength="3" fmnd="Y" onChange="fnChange(this);" hotKeyId ="search1">&nbsp;');
	write('<a id="sLnk1" target="_self"  href=\'javascript:showCurrency(frm.fromCrncy,"morph","F");\'  onkeypress="if(window.event.keyCode==13){javascript:showCurrency(frm.fromCrncy,\'morph\',\'F\');}" onmouseover="this.style.cursor=\'hand\'" onmouseout="this.style.cursor=\'default\'">');
	write('<img class="img" tabIndex="3" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId ="search1"></img></a>');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT003102") + '</td>');
	write('<td class="textfield">');
	write('<input tabIndex="4" class="textfieldfont" name="toCrncy" id="toCrncy" size="6" maxlength="3" fmnd="Y" onChange="fnChange(this);" hotKeyId ="search2">&nbsp;');
	write('<a id="sLnk2" target="_self" href=\'javascript:showCurrency(frm.toCrncy,"morph","F");\'  onkeypress="if(window.event.keyCode==13){javascript:showCurrency(frm.toCrncy,\'morph\',\'F\');}" onmouseover="this.style.cursor=\'hand\'" onmouseout="this.style.cursor=\'default\'">');
	write('<img class="img" tabIndex="5" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId ="search2"></img></a>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000270") + '</td>');
	write('<td class="textfield">');
	write('<input tabIndex="6" class="textfieldfont" name="rateCode" id="rateCode" size="6" maxlength="5" fmnd="Y" onChange="fnChange(this);" hotKeyId ="search3">&nbsp;');
	write('<a id="sLnk3" target="_self"  href=\'javascript:getRateCodes();\' onkeypress="if(window.event.keyCode==13){javascript:getRateCodes();}" onmouseover="this.style.cursor=\'hand\'" onmouseout="this.style.cursor=\'default\'">');
	write('<img class="img" tabIndex="7" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId ="search3"></img></a>');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT002519") + '</td>');
	write('<td class="textfield">');
	write('<input tabIndex="8" class="textfieldfont" name="rate" id="rate" size="15" maxlength="12" fdt="frate" onChange="fnChange(this);">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT003103") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<input class="label" style={text-align:left} name="toAmt" id="toAmt" size="24" maxlength="24" fdt="amount" readOnly>');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">&nbsp;</td>');
	write('<td class="textfielddisplaylabel">&nbsp;</td>');
	write('</tr>');
	write('<input type="hidden" id="submitform" name="submitform">');
	write('<input type="hidden" id="returnReq" name="returnReq">');
	write('<input type="hidden" id="calledMenu" name="calledMenu">');
	write('</table>');
	write('</td></tr></table>');
	write('</td></tr></table>');
	write('<table  cellspacing="0" cellpadding="4" border="0" width="100%">');
	write('<tr><tr><td>');
	write('<input tabIndex="9" id="Submit" class="button" type="button" value="' + jspResArr.get("FLT000193") + '" onClick="fnSubmit();" hotKeyId="Submit" >');
	if (returnReq == "Y")
	write('<input tabIndex="9" id="Ok" class="button" type="button" value="' + jspResArr.get("FLT001166") + '" onClick="fnSubmitToParent();" hotKeyId="Go" >');
	write('<input tabIndex="10" id="Clear" class="button" type="button" value="' + jspResArr.get("FLT001439") + '" onClick="fnClearFields();">');
	write('<input tabIndex="11" id="Close" class="button" type="button" value="' + jspResArr.get("FLT000192") + '" onClick="parent.window.close()" hotKeyId="Cancel" >');
	write('</td></tr>');
	write('</table>');
	write('</span>');

	} 
} //End function

function fnPopulateControlValues()
{
	var frm = document.forms[0];

	frm.fromAmt.value = fromAmt;
	frm.fromCrncy.value = fromCrncy;
	frm.toCrncy.value = toCrncy;
	frm.rateCode.value = rateCode;
	frm.rate.value = rate;
	frm.toAmt.value = toAmt;
	frm.calledMenu.value = calledMenu;
	frm.returnReq.value = returnReq;
}

