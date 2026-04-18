 function printBlock()
{
	writeCustomHeader("cucs_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT648026") + '</td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT006657") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + funcCode + '</label>');
	write('</td>');
	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT648034") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + acctNo + '</label>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT648035") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + chqNo + '</label>');
	write('</td>');
	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel"></td>');
	write('<td></td>');
	write('</tr>');
	write('</table>');
	write('<br />');
	write('<!-- DETAILSBLOCK-BEGIN -->');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td valign="top">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertabletop1">');
	write('<tr>');
	write('<td height="25" colspan="5" align="right">');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td align="right">');
	write('<a href="javascript:showHelpFile(\'cucs_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="17" height="17" vspace="1" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT002671") + '</td>');
	write('<td class="textfield">');
	write('<select name="' + subGroupName + '.status" id="status"  fdt="String" ' + cucsProps.get("status_ENABLED") + '   style="width: 175px;">');
	write('<option value="Y">' + jspResArr.get("FLT648038") + '</option>');
	write('<option value="Z">' + jspResArr.get("FLT648039") + '</option>');
	write('<option value="P">' + jspResArr.get("FLT648040") + '</option>');
	write('</select>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT648036") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.chqAmt" id="chqAmt"  fdt="String" ' + cucsProps.get("chqAmt_ENABLED") + ' style="width: 175px;">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT648037") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.paidAmt" id="paidAmt"  fdt="String" ' + cucsProps.get("paidAmt_ENABLED") + ' style="width: 175px;">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfield">   </td>');
	write('</tr>');
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
	write('<!-- DETAILSBLOCK-END -->');
	write('</td>');
	write('</tr>');
	write('</table>');
	} //End with()
} //End function

function printFooterBlock()
{
	with (document) {
	if ((sReferralMode == 'I')||(sReferralMode == 'S')){
	write('<div align="left" class="ctable">');
	if (sReferralMode == 'S'){
	write('<input type="button" class="Button" id="Submit" value="'+jspResArr.get("FLT000193")+ '" onClick="javascript:return doRefSubmit(this);" hotKeyId="Submit" >');
	}
	writeRefFooter();
	write('<input type="button" class="Button" id="_BackRef_" value="'+jspResArr.get("FLT001721")+ '" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	if(funcCode !='I'){
	write('<div class="ctable">');
	write('<input id="Submit" name="Submit" type="button" class="button"	onClick="javascript:return cucs_det_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT000193") + '" hotKeyId="Submit">');
	write('<input id="Validate" name="Validate" type="button" class="button" value="' + jspResArr.get("FLT000194") + '"	onClick="javascript:return cucs_det_ONCLICK2(this,this);"" hotKeyId="Validate">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="' + jspResArr.get("FLT001721") + '"	onClick="javascript:return cucs_det_ONCLICK3(this,this.id);"" hotKeyId="Cancel">');
	}else{
	write('<div class="ctable">');
	write('<input class="button" type="button" id="Back" value="'+jspResArr.get("FLT026526")+ '" onClick="javascript:return doSubmit(this.id)" hotKeyId="Ok">');
	}
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	initFocusHandler();

	pre_ONLOAD('cucs_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	if(funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='U' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
		fnDisableFormDataControls('V',ObjForm,0);
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('cucs_det',this);
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	ObjForm.status.value = status;
	ObjForm.chqAmt.value = chqAmt;
	ObjForm.paidAmt.value = paidAmt;
}


function cucs_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (preEventCall('cucs_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cucs_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cucs_det_ONCLICK2(obj,p1)
{
	var retVal = "";
	if (preEventCall('cucs_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cucs_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cucs_det_ONCLICK3(obj,p1)
{
	var retVal = "";
	if (preEventCall('cucs_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  doSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cucs_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
