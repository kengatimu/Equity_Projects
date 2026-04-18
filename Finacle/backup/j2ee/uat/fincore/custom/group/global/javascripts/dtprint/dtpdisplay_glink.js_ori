// Generated from spec file 

function printBlock()
{
	writeHeader("dtpdisplay");
	with (document) {
	write('<input type="hidden" name="' + sGrpName + '.deleteFile" id="deleteFile" value="">');
	write('<input type="hidden" name="' + sGrpName + '.inventoryUsed" id="inventoryUsed" value="">');
	write('<input type="hidden" name="' + sGrpName + '.printedSuccessfully" id="printedSuccessfully" value="">');
	write('<table><tr>');
	write('<td width="20%" class="textlabel">' +  jspResArr.get("FLT007556")  + '');
	write('<script>setMandatory("Y");</script>');
	write('</td>');
	write('<td colspan="5" width="30%" class="textfield">');
	write('<select onChange="javascript:return custom_ONCHANGE(\'dtpdisplay\',this);" class="listboxfont" id="deviceId" fmnd="Y" fmb="N" fdt="default" fblk="defaultFblk1" name="' +  sGrpName  + '.deviceId" >');
	loadDeviceIdOptionList();
	write('</select>');
	write('</td>');
	write('</tr></table>');

	} //End with()
} //End function

function printFooterBlock()
{
	with (document) {
	if ((sReferralMode == 'I')||(sReferralMode == 'S')){
	write('<div class="ctable">');
	if (sReferralMode == 'S'){
	write('<input type="button" class="Button" id="Submit" value="' + jspResArr.get("FLT000193") + '" onClick="javascript:return doRefSubmit(this);"	hotKeyId="Submit" >');
	}
	writeRefFooter();
	write('<input type="button" class="Button" id="_BackRef_" value="' + jspResArr.get("FLT000192") + '" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	write('<div class="ctable">');
	write('<input type="button" class="button" id="Print" name="Print" value="' + jspResArr.get("FLT001051") + '" onClick="javascript:return dtpdisplay_ONCLICK4(this,this);" hotKeyId="Print" disabled >');
	write('<span id="divCancel">');
	write('<input type="button" class="button" id="Cancel" name="Cancel" value="' + jspResArr.get("FLT000192") + '" onClick="javascript:return dtpdisplay_ONCLICK5(this,this);" hotKeyId="Cancel">');
	write('</span>');
	write('<span id="divReturn">');
	write('<input type="button" class="button" id="Return" name="Return" value="' + jspResArr.get("FLT011593") + '" onClick="javascript:return dtpdisplay_ONCLICK6(this,this);" hotKeyId="Return">');
	write('</span>');
	writeFooter();
	write('</div>');
	}
	} //End with()
} //End function

function printCustomFooterBlock()
{
	with (document) {
	if ((sReferralMode == 'I')||(sReferralMode == 'S')){
	write('<div class="ctable">');
	if (sReferralMode == 'S'){
	write('<input type="button" class="Button" id="Submit" value="' + jspResArr.get("FLT000193") + '" onClick="javascript:return doRefSubmit(this);"	hotKeyId="Submit" style="display: none;">');
	}
	writeRefFooter();
	write('<input type="button" class="Button" id="_BackRef_" value="' + jspResArr.get("FLT000192") + '" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" style="display: none;">');
	write('</div>');
	}else{
	write('<div class="ctable">');
	write('<input type="button" class="button" id="Print" name="Print" value="' + jspResArr.get("FLT001051") + '" onClick="javascript:return dtpdisplay_ONCLICK4(this,this);" hotKeyId="Print" disabled style="display: none;">');
	write('<span id="divCancel">');
	write('<input type="button" class="button" id="Cancel" name="Cancel" value="' + jspResArr.get("FLT000192") + '" onClick="javascript:return dtpdisplay_ONCLICK5(this,this);" hotKeyId="Cancel" style="display: none;">');
	write('</span>');
	write('<span id="divReturn">');
	write('<input type="button" class="button" id="Return" name="Return" value="' + jspResArr.get("FLT011593") + '" onClick="javascript:return dtpdisplay_ONCLICK6(this,this);" hotKeyId="Return" style="display: none;">');
	write('</span>');
	writeFooter();
	write('</div>');
	}
	} //End with()
} //End function

function dtpdisplay_ONKEYDOWN1(obj,p1)
{
	var retVal = "";
	if (preEventCall('dtpdisplay',obj,'ONKEYDOWN') == false) { 
		return false;
	}
	if ((retVal = fnKeyDownProcessor(p1)) == false) {
		return false;
	}
	if (postEventCall('dtpdisplay',obj,'ONKEYDOWN') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function dtpdisplay_ONKEYUP2(obj,p1)
{
	var retVal = "";
	if (preEventCall('dtpdisplay',obj,'ONKEYUP') == false) { 
		return false;
	}
	if ((retVal = fnKeyUpProcessor(p1)) == false) {
		return false;
	}
	if (postEventCall('dtpdisplay',obj,'ONKEYUP') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function dtpdisplay_ONLOAD3(obj)
{
	var retVal = "";
	var frmObj = document.forms[0];
	if (pre_ONLOAD('dtpdisplay',obj) == false) { 
		return false;
	}
	if ((retVal = fnOnLoad()) == false) {
		return false;
	}
	fnPopUpExceptionWindow(frmObj.actionCode);
	if (post_ONLOAD('dtpdisplay',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function dtpdisplay_ONCLICK4(obj,p1)
{
	var retVal = "";
	if (preEventCall('dtpdisplay',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnOnButtonClick(p1)) == false) {
		return false;
	}
	if (postEventCall('dtpdisplay',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function dtpdisplay_ONCLICK5(obj,p1)
{
	var retVal = "";
	if (preEventCall('dtpdisplay',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnOnButtonClick(p1)) == false) {
		return false;
	}
	if (postEventCall('dtpdisplay',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function dtpdisplay_ONCLICK6(obj,p1)
{
	var retVal = "";
	if (preEventCall('dtpdisplay',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnOnButtonClick(p1)) == false) {
		return false;
	}
	if (postEventCall('dtpdisplay',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
