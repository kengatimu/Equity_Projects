function printBlock()
{
	writeCustomHeader("cltfm_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT032011") + '</td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT006657") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + funcCode + '</label>');
	write('</td>');
	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT007206") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + type + '</label>');
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
	write('<a href="javascript:showHelpFile(\'det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="17" height="17" vspace="1" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT012932") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.schmCode" id="schmCode"  fdt="String" ' + cltfmProps.get("schmCode_ENABLED") + ' style="width: 161px;">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT015774") + '</td>');
	write('<td class="textfield">');
	//write('<br>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.cifId" id="cifId"  fdt="String" ' + cltfmProps.get("cifId_ENABLED") + ' style="width: 161px;">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	//write('<br>');
	 write('<td class="textlabel" style="height: 15px">');
        write('<br>Account Number');
	write('</td>');
	write('<td class="textfield">');
	write('<br>');
         write('<input type="text" class="textfieldfont" name="' + subGroupName + '.acctId" id="acctId"  fdt="String" ' +cltfmProps.get("acctId_ENABLED") + ' style="width: 161px;">');
	write('</td>');
	 write('<td class="columnwidth"> </td>');
	write('<td class="textlabel" style="height: 15px">');
	write('<br>Charges Applicable');
	write('</td>');
	write('<td class="textfield">');
	write('<br>');
	write('<input type="radio" name="' + subGroupName + '.tax" id="tax" value="Y"  fdt="String" onClick ="document.forms[0].percentage.disabled=false;" ' + cltfmProps.get("tax_ENABLED") + '>YES');

	//write('<input type="radio" name="' + subGroupName + '.tax" id="tax" value="N"  fdt="String" onClick ="document.forms[0].percentage.disabled=true;" ' + cltfmProps.get("tax_ENABLED") + '>NO');
	write('<input type="radio" name="' + subGroupName + '.tax" id="tax" value="N"  fdt="String" onClick ="javascript:return cltfm_det_ONCLICK6(this);" ' + cltfmProps.get("tax_ENABLED") + '>NO');

	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<br>');
	 write('<td class="textlabel" style="height: 15px">');
	write('<br>Charge Percentage');
	write('</td>');
        write('<td class="textfield">');
       write('<br>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.percentage" id="percentage"  fdt="String" ' +cltfmProps.get("percentage_ENABLED") + ' style="width: 161px;">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfield"> </td>');
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
	write('<input id="Submit" name="Submit" type="button" class="button"	onClick="javascript:return cltfm_det_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT000193") + '" hotKeyId="Submit">');
	write('<input id="Validate" name="Validate" type="button" class="button" value="' + jspResArr.get("FLT000194") + '"	onClick="javascript:return cltfm_det_ONCLICK2(this,this);"" hotKeyId="Validate">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="' + jspResArr.get("FLT001721") + '"	onClick="javascript:return cltfm_det_ONCLICK3(this,this.id);"" hotKeyId="Cancel">');
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

	pre_ONLOAD('cltfm_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	if( funcCode =='I' || funcCode =='D' || funcCode =='U'  || sReferralMode =='I' || sReferralMode =='S'){
		fnDisableFormDataControls('V',ObjForm,0);
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('cltfm_det',this);
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	ObjForm.schmCode.value = schmCode;
	ObjForm.cifId.value = cifId;
	ObjForm.tax.value = tax;
	ObjForm .percentage.value = percentage;
	ObjForm.acctId.value = acctId;
	fnCheckControls();

}

function fnCheckControls()
{
	var ObjForm = document.forms[0];

	checkRadio(ObjForm.tax,tax);
}


function cltfm_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (preEventCall('cltfm_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cltfm_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cltfm_det_ONCLICK2(obj,p1)
{
	var retVal = "";
	if (preEventCall('cltfm_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cltfm_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cltfm_det_ONCLICK3(obj,p1)
{
	var retVal = "";
	if (preEventCall('cltfm_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  doSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cltfm_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cltfm_det_ONCHANGE3(obj)
{
        var retVal = "";
        if (preEventCall('cltfm_det',obj,'ONBLUR') == false) {
                return false;
        }
        if ((retVal = fnOnClick(obj)) == false) {
                return false;
        }


        if (postEventCall('cltfm_det',obj,'ONBLUR') == false) {
                return false;
        }
                if((funcCode == "I") || (funcCode == "V")){
                        hideImage("sLnk2");
                }
        return (retVal == undefined) ? true : retVal;
}

function cltfm_det_ONCLICK6(obj)
{
document.forms[0].percentage.disabled=true;
document.forms[0].percentage.value="";
}

