function printBlock()
{
	writeCustomHeader("cmntrtc_crit");
	with (document){
	write('<input class="label" name="rateCodeDesc" size="10" maxlength="25" fds= "Y" disabled>')
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT032015") + '</td>');
	write('</tr>');
	write('</table>');
	write('<!-- DETAILSBLOCK-BEGIN -->');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td valign="top">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableborder">');
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
	write('<a href="javascript:showHelpFile(\'crit_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="17" height="17" vspace="1" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT006657") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<select name="' + subGroupName + '.funcCode" id="funcCode"  fdt="String" ' + cmntrtcProps.get("funcCode_ENABLED") + ' class="listboxfont;"   style="width: 164px;">');
	write('<option value="">' + jspResArr.get("FLT032016") + '</option>');
	write('<option value="A">' + jspResArr.get("FLT031874") + '</option>');
	write('<option value="M">' + jspResArr.get("FLT031882") + '</option>');
	write('<option value="V">' + jspResArr.get("FLT031876") + '</option>');
	write('<option value="I">' + jspResArr.get("FLT031877") + '</option>');
	write('<option value="X">' + jspResArr.get("FLT031883") + '</option>');
	write('<option value="D">' + jspResArr.get("FLT032031") + '</option>');
	write('</select>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfield"> </td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">');
	write('<br>From Currency');
	write('</td>');
	write('<td class="textfield">');
	write('<br>');
	write('<input hotKeyId="search1" type="text" class="textfieldfont" name="' + subGroupName + '.fromCrncy" id="fromCrncy"  fdt="String" ' + cmntrtcProps.get("fromCrncy_ENABLED") + ' style="width: 164px;" onChange="javascript:return cmntrtc_crit_ONCHANGE3(this);" &nbsp;>');

	write('<a target=_self id="sLnk2"  href="javascript:showCurrencyList(document.forms[0].fromCrncy)">');
	write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">');
	write('<br>To Currency');
	write('</td>');
	write('<td class="textfield">');
	write('<br>');
	write('<input hotKeyId="search2" type="text" class="textfieldfont" name="' + subGroupName + '.toCrncy" id="toCrncy"  fdt="String" ' + cmntrtcProps.get("toCrncy_ENABLED") + ' style="width: 164px;" onChange="javascript:return cmntrtc_crit_ONCHANGE4(this);" >&nbsp;');
	write('<a target=_self id ="sLnk3"  href="javascript:showCurrencyList(document.forms[0].toCrncy)">');
	write('<img border="0" height="17" hotKeyId="search2" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
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
	write('<input type="button" class="Button" id="_BackRef_" value="'+jspResArr.get("FLT001721")+ '" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	write('<div class="ctable">');
	write('<input id="Accept" name="Go" type="button" class="button"	onClick="javascript:return cmntrtc_crit_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT004977") + '" hotKeyId="Go">');
	write('<input id="Clear" name="Clear" type="button" class="button" value="' + jspResArr.get("FLT001439") + '"	onClick="javascript:return cmntrtc_crit_ONCLICK2(this);"">');
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	initFocusHandler();

	pre_ONLOAD('cmntrtc_crit',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('cmntrtc_crit',this);
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	ObjForm.funcCode.value = funcCode;
	ObjForm.fromCrncy.value = fromCrncy;
	ObjForm.toCrncy.value = toCrncy;
}


function cmntrtc_crit_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (preEventCall('cmntrtc_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cmntrtc_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cmntrtc_crit_ONCLICK2(obj)
{
	var retVal = "";
	if (preEventCall('cmntrtc_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnClearFields()) == false) {
		return false;
	}
	if (postEventCall('cmntrtc_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cmntrtc_crit_ONCHANGE3(obj)
{
        var retVal = "";
        if (preEventCall('cmntrtc_crit',obj,'ONBLUR') == false) {
                return false;
        }
        if ((retVal = fnGetCurrency(obj)) == false) {
                return false;
        }


        if (postEventCall('cmntrtc_crit',obj,'ONBLUR') == false) {
                return false;
        }
                if((funcCode == "I") || (funcCode == "V")){
                        hideImage("sLnk2");
                }
        return (retVal == undefined) ? true : retVal;
}
function cmntrtc_crit_ONCHANGE4(obj)
{
        var retVal = "";
        if (preEventCall('cmntrtc_crit',obj,'ONBLUR') == false) {
                return false;
        }
        if ((retVal = fnGetCurrency1(obj)) == false) {
                return false;
        }


        if (postEventCall('cmntrtc_crit',obj,'ONBLUR') == false) {
                return false;
        }
                if((funcCode == "I") || (funcCode == "V")){
                        hideImage("sLnk2");
                }
        return (retVal == undefined) ? true : retVal;
}

