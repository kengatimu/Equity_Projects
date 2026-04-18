function printBlock()
{
	//writeCustomHeader("cpmod_DET");
	writeCustomHeader("Customizedet");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading"> CPARAM MODULE MAINTENANCE</td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	//write('<td class="textlabel">' + jspResArr.get("FLTI00006") + '</td>');
	//write('<td class="textfielddisplaylabel"> </td>');
	//write('<td class="columnwidth">&nbsp; </td>');
	//write('<td class="textlabel">' + jspResArr.get("FLTI00006") + '</td>');
	//write('<td class="textfielddisplaylabel"> </td>');
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
	write('<td class="textlabel" style="width: 94px">' + jspResArr.get("FLTI00005") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" name="' + subGroupName + '.moduleId" id="moduleId" ' + cpmodProps.get("moduleId_ENABLED") + ' style="width: 138px" maxlength="30">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel" style="width: 115px">' + jspResArr.get("FLTI00006") + '</td>');
	write('<td class="textfield">');
	write('<textarea style="text-transform:none" name="' + subGroupName + '.moduleDesc" id="moduleDesc" ' + cpmodProps.get("moduleDesc_ENABLED") + ' style="width: 142px" rows="2" cols="40"></textarea>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfield"> </td>');
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
	write('<input type="button" class="Button" id="Submit" value="SUBMIT" onClick="javascript:return doRefSubmit(this);" hotKeyId="Submit" >');
	}
	writeRefFooter();
	write('<input type="button" class="Button" id="_BackRef_" value="CANCEL" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	if(funcCode !='I'){
	write('<div class="ctable">');
	write('<input id="Submit" name="Submit" type="button" class="button"	onClick="javascript:return cpmod_DET_ONCLICK1(this,this);"" value="Submit" hotKeyId="Submit">');
	//write('<input id="Validate" name="Validate" type="button" class="button" value="Validate"	onClick="javascript:return cpmod_DET_ONCLICK2(this,this);"" hotKeyId="Validate">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="Cancel"	onClick="javascript:return cpmod_DET_ONCLICK3(this,this.id);"" hotKeyId="Cancel">');
	}else{
	write('&nbsp;<input class="button" type="button" id="Back" value="OK" onClick="javascript:return doSubmit(this.id)" hotKeyId="Ok">');
	}
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];
	//alert("before pre");
	pre_ONLOAD('cpmod_DET',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	if(funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='U' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
		fnDisableFormControls(ObjForm);
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}
	//alert("after post");
	post_ONLOAD('cpmod_DET',this);
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	ObjForm.moduleId.value = moduleId;
	ObjForm.moduleDesc.value = moduleDesc;
}


function cpmod_DET_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (preEventCall('cpmod_DET',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cpmod_DET',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cpmod_DET_ONCLICK2(obj,p1)
{
	var retVal = "";
	if (preEventCall('cpmod_DET',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValidateData(p1)) == false) {
		return false;
	}
	if (postEventCall('cpmod_DET',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cpmod_DET_ONCLICK3(obj,p1)
{
	var retVal = "";
	if (preEventCall('cpmod_DET',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  doSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cpmod_DET',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function doSubmit(actionCode){
        var frm = document.forms[0];
        if(frm.submitform != undefined){
                frm.submitform.value = actionCode;
        }
        frm.actionCode.value = actionCode;
        enableFormElements();
        hideAnchors();
        disableButtons();
        frm.submit();
}

