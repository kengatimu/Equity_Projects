function printBlock()
{
	writeCustomHeader("cltfm_crit");
	with (document){
	write('<input id="subheadCode" type="hidden" value=" ">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT032011") + '</td>');
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
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT006657") + '</td>');
	write('<td class="textfield">');
	write('<select name="' + subGroupName + '.funcCode" id="funcCode"  fdt="String" ' + cltfmProps.get("funcCode_ENABLED") + ' class="listboxfont;"  style="width: 161px;">');
	write('<option value="">' + jspResArr.get("FLT031845") + '</option>');
	write('<option value="A">' + jspResArr.get("FLT031874") + '</option>');
	write('<option value="M">' + jspResArr.get("FLT031882") + '</option>');
	write('<option value="V">' + jspResArr.get("FLT031876") + '</option>');
	write('<option value="I">' + jspResArr.get("FLT031877") + '</option>');
	write('<option value="X">' + jspResArr.get("FLT031883") + '</option>');
	write('</select>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT007206") + '</td>');
	write('<td class="textfield">');
	write('<select name="' + subGroupName + '.type" id="type"  fdt="String" ' + cltfmProps.get("type_ENABLED") + ' class="listboxfont;"  style="width: 161px;" OnChange="javascript:fnOnChange();" >');
	write('<option value="">' + jspResArr.get("FLT031845") + '</option>');
	write('<option value="scheme">' + jspResArr.get("FLT032012") + '</option>');
	write('<option value="customer">' + jspResArr.get("FLT032013") + '</option>');
	write('<option value="account">ACCOUNT LEVEL</option>');
	write('</select>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">');
	write('<br>Scheme Code');
	write('</td>');
	write('<td class="textfield">');
	write('<br>');
	write('<input hotKeyId="search1" type="text" class="textfieldfont" name="' + subGroupName + '.schmCode" id="schmCode"  fdt="String" ' + cltfmProps.get("schmCode_ENABLED") + ' style="width: 161px;"onChange="javascript:return cltfm_crit_ONCHANGE3(this);">&nbsp;');
	//write('<a target=_self id ="sLnk2" href="javascript:showSchmCodes(document.forms[0].schmCode,\' \',\' \',\' \',\' \',\' \',\' \')">');
	//write('<a target=_self id ="sLnk2" href="javascript:showSchmCodes(document.forms[0].schmCode,document.forms[0].subheadCode,\' \',\' \',\' \',\' \',\' \')">');
	write('<a target=_self id ="sLnk2" href="javascript:showSchmCodes(document.forms[0].schmCode,document.forms[0].subheadCode,\'\')">');
	write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">');
	write('<br>Customer ID');
	write('</td>');
	write('<td class="textfield">');
	write('<br>');
	write('<input hotKeyId="search2" type="text" class="textfieldfont" name="' + subGroupName + '.cifId" id="cifId"  fdt="String" ' + cltfmProps.get("cifId_ENABLED") + ' style="width: 161px;"onChange="javascript:return cltfm_crit_ONCHANGE4(this);">&nbsp;');
	 write('<a target=_self id="sLnk3" href="javascript:showCustId(document.forms[0].cifId,\'ctrl\',\'F\')">');
	write('<img border="0" height="17" hotKeyId="search2" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</tr>');
        write('<tr>');
        write('<td class="textlabel" style="height: 15px">');
        write('<br>Account Number');
        write('</td>');
        write('<td class="textfield">');
        write('<br>');
	 write('<input hotKeyId="search3" type="text" class="textfieldfont" name="' + subGroupName + '.acctId" id="acctId"  fdt="String" ' + cltfmProps.get("acctId_ENABLED") + ' style="width: 161px;"onChange="javascript:return cltfm_crit_ONCHANGE5(this);">&nbsp;');
	 write('<a target = _self id ="sLnk4" href="Javascript:showAccountIdList(document.forms[0].acctId,\'F\',\'F\',\'F\',\'F\')">');
	 write('<img border="0" height="17" hotKeyId="search3" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
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
	write('<input id="Accept" name="Go" type="button" class="button"	onClick="javascript:return cltfm_crit_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT004977") + '" hotKeyId="Go">');
	write('<input id="Clear" name="Clear" type="button" class="button" value="' + jspResArr.get("FLT001439") + '"	onClick="javascript:return cltfm_crit_ONCLICK2(this);"">');
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	initFocusHandler();

	pre_ONLOAD('cltfm_crit',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('cltfm_crit',this);
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
	ObjForm.type.value = type;
	ObjForm.schmCode.value = schmCode;
	ObjForm.cifId.value = cifId;
	ObjForm.acctId.value = acctId;
}


function cltfm_crit_ONCLICK1(obj,p1)
{
	var retVal = "";

	if (preEventCall('cltfm_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cltfm_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cltfm_crit_ONCLICK2(obj)
{
	
	var retVal = "";
	if (preEventCall('cltfm_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnClearFields()) == false) {
		return false;
	}
	if (postEventCall('cltfm_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cltfm_crit_ONCHANGE3(obj)
{
        var retVal = "";
        if (preEventCall('cltfm_crit',obj,'ONBLUR') == false) {
                return false;
        }
        if ((retVal = fnSchmCode(obj)) == false) {
                return false;
        }


        if (postEventCall('cltfm_crit',obj,'ONBLUR') == false) {
                return false;
        }
                if((funcCode == "I") || (funcCode == "V")){
                        hideImage("sLnk2");
                }
        return (retVal == undefined) ? true : retVal;
}


function cltfm_crit_ONCHANGE4(obj)
{
        var retVal = "";
        if (preEventCall('cltfm_crit',obj,'ONBLUR') == false) {
                return false;
        }
        if ((retVal = fnGetCifIdVal(obj)) == false) {
                return false;
        }


        if (postEventCall('cltfm_crit',obj,'ONBLUR') == false) {
                return false;
        }
                if((funcCode == "I") || (funcCode == "V")){
                        hideImage("sLnk2");
                }
        return (retVal == undefined) ? true : retVal;
}

function cltfm_crit_ONCHANGE5(obj)
{
        var retVal = "";
        if (preEventCall('cltfm_crit',obj,'ONBLUR') == false) {
                return false;
        }
        if ((retVal = fnAcctNumVal(obj)) == false) {
                return false;
        }


        if (postEventCall('cltfm_crit',obj,'ONBLUR') == false) {
                return false;
        }
                if((funcCode == "I") || (funcCode == "V")){
                        hideImage("sLnk2");
                }
        return (retVal == undefined) ? true : retVal;
}

