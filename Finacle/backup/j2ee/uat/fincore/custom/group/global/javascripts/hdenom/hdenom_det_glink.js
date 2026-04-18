function printBlock()
{
	writeCustomHeader("hdenom_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT031734") + '</td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT112254") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + fnGetFuncCodeDesc(funcCode) + '</label>');
	write('</td>');
	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT030604") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + crncyName + '</label>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT031735") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + decimalPointAllow + '</label>');
	write('</td>');
	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField"></label>');
	write('</td>');
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
	//write('<a href="javascript:getHelpFile(\'hdenom_det\');" id="sLnk1">');
	write('<a href="javascript:showHelpFile(\'hdenom_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" vspace="1" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px; background-color:#E8E8E8;color:#0066FF">' + jspResArr.get("FLT003523") + '</td>');
	write('<td class="columnwidth" style="background-color:#E8E8E8"> </td>');
	write('<td class="textfield" style="background-color:#E8E8E8"> </td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">');
	write('<B>Note Denomination');
	write('</B>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">');
	write('<B>Coin Denomination');
	write('</B>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textfield" style="height: 15px"> &nbsp;');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.noteDenom01" id="noteDenom01" ' + hdenomProps.get("noteDenom01_ENABLED") + ' size="13" maxlength="13">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textfield"> &nbsp;');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.coinDenom01" id="coinDenom01" ' + hdenomProps.get("coinDenom01_ENABLED") + ' size="13" maxlength="13">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textfield" style="height: 15px"> &nbsp;');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.noteDenom02" id="noteDenom02" ' + hdenomProps.get("noteDenom02_ENABLED") + ' size="13" maxlength="13">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textfield"> &nbsp;');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.coinDenom02" id="coinDenom02" ' + hdenomProps.get("coinDenom02_ENABLED") + ' size="13" maxlength="13">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textfield" style="height: 15px"> &nbsp;');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.noteDenom03" id="noteDenom03" ' + hdenomProps.get("noteDenom03_ENABLED") + ' size="13" maxlength="13">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textfield"> &nbsp;');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.coinDenom03" id="coinDenom03" ' + hdenomProps.get("coinDenom03_ENABLED") + ' size="13" maxlength="13">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textfield" style="height: 15px"> &nbsp;');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.noteDenom04" id="noteDenom04" ' + hdenomProps.get("noteDenom04_ENABLED") + ' size="13" maxlength="13">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textfield"> &nbsp;');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.coinDenom04" id="coinDenom04" ' + hdenomProps.get("coinDenom04_ENABLED") + ' size="13" maxlength="13">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textfield" style="height: 15px"> &nbsp;');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.noteDenom05" id="noteDenom05" ' + hdenomProps.get("noteDenom05_ENABLED") + ' size="13" maxlength="13">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textfield"> &nbsp;');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.coinDenom05" id="coinDenom05" ' + hdenomProps.get("coinDenom05_ENABLED") + ' size="13" maxlength="13">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textfield" style="height: 15px"> &nbsp;');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.noteDenom06" id="noteDenom06" ' + hdenomProps.get("noteDenom06_ENABLED") + ' size="13" maxlength="13">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textfield"> &nbsp;');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.coinDenom06" id="coinDenom06" ' + hdenomProps.get("coinDenom06_ENABLED") + ' size="13" maxlength="13">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textfield" style="height: 15px"> &nbsp;');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.noteDenom07" id="noteDenom07" ' + hdenomProps.get("noteDenom07_ENABLED") + ' size="13" maxlength="13">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textfield"> &nbsp;');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.coinDenom07" id="coinDenom07" ' + hdenomProps.get("coinDenom07_ENABLED") + ' size="13" maxlength="13">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textfield" style="height: 15px"> &nbsp;');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.noteDenom08" id="noteDenom08" ' + hdenomProps.get("noteDenom08_ENABLED") + ' size="13" maxlength="13">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textfield"> &nbsp;');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.coinDenom08" id="coinDenom08" ' + hdenomProps.get("coinDenom08_ENABLED") + ' size="13" maxlength="13">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textfield" style="height: 15px"> &nbsp;');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.noteDenom09" id="noteDenom09" ' + hdenomProps.get("noteDenom09_ENABLED") + ' size="13" maxlength="13">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textfield"> &nbsp;');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.coinDenom09" id="coinDenom09" ' + hdenomProps.get("coinDenom09_ENABLED") + ' size="13" maxlength="13">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textfield" style="height: 15px"> &nbsp;');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.noteDenom10" id="noteDenom10" ' + hdenomProps.get("noteDenom10_ENABLED") + ' size="13" maxlength="13">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textfield"> &nbsp;');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.coinDenom10" id="coinDenom10" ' + hdenomProps.get("coinDenom10_ENABLED") + ' size="13" maxlength="13">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textfield" style="height: 15px"> &nbsp;');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.noteDenom11" id="noteDenom11" ' + hdenomProps.get("noteDenom11_ENABLED") + ' size="13" maxlength="13">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textfield"> &nbsp;');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.coinDenom11" id="coinDenom11" ' + hdenomProps.get("coinDenom11_ENABLED") + ' size="13" maxlength="13">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textfield" style="height: 15px"> &nbsp;');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.noteDenom12" id="noteDenom12" ' + hdenomProps.get("noteDenom12_ENABLED") + ' size="13" maxlength="13">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textfield"> &nbsp;');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.coinDenom12" id="coinDenom12" ' + hdenomProps.get("coinDenom12_ENABLED") + ' size="13" maxlength="13">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textfield" style="height: 15px"> &nbsp;');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.noteDenom13" id="noteDenom13" ' + hdenomProps.get("noteDenom13_ENABLED") + ' size="13" maxlength="13">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textfield"> &nbsp;');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.coinDenom13" id="coinDenom13" ' + hdenomProps.get("coinDenom13_ENABLED") + ' size="13" maxlength="13">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textfield" style="height: 15px"> &nbsp;');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.noteDenom14" id="noteDenom14" ' + hdenomProps.get("noteDenom14_ENABLED") + ' size="13" maxlength="13">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textfield"> &nbsp;');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.coinDenom14" id="coinDenom14" ' + hdenomProps.get("coinDenom14_ENABLED") + ' size="13" maxlength="13">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textfield" style="height: 15px"> &nbsp;');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.noteDenom15" id="noteDenom15" ' + hdenomProps.get("noteDenom15_ENABLED") + ' size="13" maxlength="13">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textfield"> &nbsp;');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.coinDenom15" id="coinDenom15" ' + hdenomProps.get("coinDenom15_ENABLED") + ' size="13" maxlength="13">');
	write('</td>');
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
	write('<input type="button" class="Button" id="_BackRef_" value="'+jspResArr.get("FLT027575")+ '" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	if(funcCode !='I'){
	write('<div class="ctable">');
	write('<input id="Submit" name="Submit" type="button" class="button"	onClick="javascript:return hdenom_det_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT000193") + '" hotKeyId="Submit">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="' + jspResArr.get("FLT027575") + '"	onClick="javascript:return hdenom_det_ONCLICK2(this,this.id);"" hotKeyId="Cancel">');
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

	pre_ONLOAD('hdenom_det',this);

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

	post_ONLOAD('hdenom_det',this);
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	ObjForm.noteDenom01.value = noteDenom01;
	ObjForm.coinDenom01.value = coinDenom01;
	ObjForm.noteDenom02.value = noteDenom02;
	ObjForm.coinDenom02.value = coinDenom02;
	ObjForm.noteDenom03.value = noteDenom03;
	ObjForm.coinDenom03.value = coinDenom03;
	ObjForm.noteDenom04.value = noteDenom04;
	ObjForm.coinDenom04.value = coinDenom04;
	ObjForm.noteDenom05.value = noteDenom05;
	ObjForm.coinDenom05.value = coinDenom05;
	ObjForm.noteDenom06.value = noteDenom06;
	ObjForm.coinDenom06.value = coinDenom06;
	ObjForm.noteDenom07.value = noteDenom07;
	ObjForm.coinDenom07.value = coinDenom07;
	ObjForm.noteDenom08.value = noteDenom08;
	ObjForm.coinDenom08.value = coinDenom08;
	ObjForm.noteDenom09.value = noteDenom09;
	ObjForm.coinDenom09.value = coinDenom09;
	ObjForm.noteDenom10.value = noteDenom10;
	ObjForm.coinDenom10.value = coinDenom10;
	ObjForm.noteDenom11.value = noteDenom11;
	ObjForm.coinDenom11.value = coinDenom11;
	ObjForm.noteDenom12.value = noteDenom12;
	ObjForm.coinDenom12.value = coinDenom12;
	ObjForm.noteDenom13.value = noteDenom13;
	ObjForm.coinDenom13.value = coinDenom13;
	ObjForm.noteDenom14.value = noteDenom14;
	ObjForm.coinDenom14.value = coinDenom14;
	ObjForm.noteDenom15.value = noteDenom15;
	ObjForm.coinDenom15.value = coinDenom15;
}


function hdenom_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (preEventCall('hdenom_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('hdenom_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hdenom_det_ONCLICK2(obj,p1)
{
	var retVal = "";
	if (preEventCall('hdenom_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  doSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('hdenom_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
