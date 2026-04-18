function printBlock()
{
	writeCustomHeader("cmntrtc_det");
	with (document){
	write('<input type="hidden" name="rateCodeDesc" size="10" maxlength="25" fds= "Y" disabled>')
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT032015") + '</td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT006657") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' +fnGetFunctionCodeDesc(funcCode)+ '</label>');
	write('</td>');
	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfielddisplaylabel"> </td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">');
	write('<br>From Currency');
	write('</td>');
	write('<td class="textfielddisplaylabel">');
	write('<br>');
	write('<label id="compField">' + fromCrncy + '</label>');
	write('</td>');
	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel">');
	write('<br>To Currency');
	write('</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">');
	write('<br>' + toCrncy + '');
	write('</label>');
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
	write('<div></div>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT032032") + '</td>');
	write('<td class="textfield" style="width: 198px;">');
	write('<input hotKeyId="search1" type="text" class="textfieldfont" name="' + subGroupName + '.rateCodeCash" id="rateCodeCash"  fdt="String" ' + cmntrtcProps.get("rateCodeCash_ENABLED") + ' style="width: 164px;" onChange="javascript:return cmntrtc_det_ONCHANGE3(this);" >&nbsp;');
	write('<a target=_self id ="sLnk2" href="javascript:showRefCode(document.forms[0].rateCodeCash,\'67\',\'N\',\'F\',document.forms[0].rateCodeDesc)">');
	write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel" style="width: 148px;">' + jspResArr.get("FLT032033") + '</td>');
	write('<td class="textfield" style="width: 198px;">');
	write('<input hotKeyId="search2" type="text" class="textfieldfont" name="' + subGroupName + '.rateCodeTransfer" id="rateCodeTransfer"  fdt="String" ' + cmntrtcProps.get("rateCodeTransfer_ENABLED") + ' style="width: 164px;" onChange="javascript:return cmntrtc_det_ONCHANGE4(this);" >&nbsp;');
	 write('<a target=_self id="sLnk3" href="javascript:showRefCode(document.forms[0].rateCodeTransfer,\'67\',\'N\',\'F\',document.forms[0].rateCodeDesc)">');

	write('<img border="0" height="17" hotKeyId="search2" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px"> </td>');
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
	write('<input type="button" class="Button" id="Submit" value="'+jspResArr.get("FLT000193")+ '" onClick="javascript:return doRefSubmit(this);" hotKeyId="Submit" >');
	}
	writeRefFooter();
	write('<input type="button" class="Button" id="_BackRef_" value="'+jspResArr.get("FLT001721")+ '" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	if(funcCode !='I'){
	write('<div class="ctable">');
	write('<input id="Submit" name="Submit" type="button" class="button"	onClick="javascript:return cmntrtc_det_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT000193") + '" hotKeyId="Submit">');
	write('<input id="Validate" name="Validate" type="button" class="button" value="' + jspResArr.get("FLT000194") + '"	onClick="javascript:return cmntrtc_det_ONCLICK2(this,this);"" hotKeyId="Validate">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="' + jspResArr.get("FLT001721") + '"	onClick="javascript:return cmntrtc_det_ONCLICK3(this,this.id);"" hotKeyId="Cancel">');
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

	pre_ONLOAD('cmntrtc_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	if(funcCode == 'I' ||  funcCode =='U' || sReferralMode =='I' || sReferralMode =='S'){
		fnDisableFormDataControls('V',ObjForm,0);
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('cmntrtc_det',this);
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	ObjForm.rateCodeCash.value = rateCodeCash;
	ObjForm.rateCodeTransfer.value = rateCodeTransfer;
}


function cmntrtc_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (preEventCall('cmntrtc_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cmntrtc_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cmntrtc_det_ONCLICK2(obj,p1)
{
	var retVal = "";
	if (preEventCall('cmntrtc_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cmntrtc_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cmntrtc_det_ONCLICK3(obj,p1)
{
	var retVal = "";
	if (preEventCall('cmntrtc_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  doSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cmntrtc_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cmntrtc_det_ONCHANGE3(obj)
{
        var retVal = "";
        if (preEventCall('cmntrtc_det',obj,'ONBLUR') == false) {
                return false;
        }
        if ((retVal = fnGetrateCodeCash(obj)) == false) {
                return false;
        }


        if (postEventCall('cmntrtc_det',obj,'ONBLUR') == false) {
                return false;
        }
                if((funcCode == "I") || (funcCode == "V")){
                        hideImage("sLnk2");
                }
        return (retVal == undefined) ? true : retVal;
}

function cmntrtc_det_ONCHANGE4(obj)
{
        var retVal = "";
        if (preEventCall('cmntrtc_det',obj,'ONBLUR') == false) {
                return false;
        }
        if ((retVal = fnGetrateCodetransfer(obj)) == false) {
                return false;
        }


        if (postEventCall('cmntrtc_det',obj,'ONBLUR') == false) {
                return false;
        }
                if((funcCode == "I") || (funcCode == "V")){
                        hideImage("sLnk3");
                }
        return (retVal == undefined) ? true : retVal;
}

