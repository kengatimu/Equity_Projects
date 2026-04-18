function printBlock()
{
	writeCustomHeader("hdenro_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">Transaction Round Off Consolidation Screen</td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td valign="top">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableborder">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0">');
	write('<tr class="innertabletop1">');
	write('<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>');
	write('<td>&nbsp; &nbsp;</td><td>&nbsp;&nbsp</td>');
	write('<td colspan="2" align="right">');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<td align="right">');
	write('<a href="javascript:showHelpFile(\'hdenro_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0"></a>');
	write('</td>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT020285") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield"><input name="' + subGroupName + '.setId" id="setId" ' + hdenroProps.get("setId_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldfont" size="25" maxlength="15" >&nbsp;');
	write('<img hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16" height="17" border="0" onClick="javascript:return showSetList(document.forms[0].setId,\'ctrl\',\'F\',\'null\');" style="cursor:hand"></a></td>');
	//write('<a href="javascript:showSolId(document.forms[0].setId,'ctrl','F','null');">');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT014433") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield"><input name="' + subGroupName + '.tellerId" id="tellerId" ' + hdenroProps.get("tellerId_ENABLED") + ' hotKeyId="search2" type="text" class="textfieldfont" size="25" maxlength="15" >&nbsp;');
	write('<img hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16" height="17" border="0" onClick="javascript:return tellerList();" style="cursor:hand"></a></td>');
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
	write('<input name="Submit" type="button" class="button" onClick="javascript:return hdenro_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	write('<input type="button" name="Clear" value="Clear" class="button" id="Clear" onClick="javascript:return hdenro_det_ONCLICK3(this);">');
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

	pre_ONLOAD('hdenro_det',this);

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
	ObjForm.setId.focus();

	post_ONLOAD('hdenro_det',this);
}

function fnValidateData()
{
	var ObjForm = document.forms[0];

	if (fnIsNull(ObjForm.setId.value))
	{
		alert("Set Id is Mandatory");
		ObjForm.setId.focus();
		return false;
	}
	if (fnIsNull(ObjForm.tellerId.value))
        {
                alert("Teller ID is mandatory");
                ObjForm.tellerId.focus();
                return false;
        }
	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	ObjForm.setId.value = setId;
	ObjForm.tellerId.value = tellerId;
}


function hdenro_det_ONCLICK1(obj,p1)
{
	var retVal = "";
        if (preEventCall('hdenro_det',obj,'ONCLICK') == false) {
                return false;
        }
        if ((retVal = fnValAndSubmit(p1)) == false) {
                return false;
        }
        if (postEventCall('hdenro_det',obj,'ONCLICK') == false) {
                return false;
        }
        
	return (retVal == undefined) ? true : retVal;
}

function hdenro_det_ONCLICK2(obj)
{
        var retVal = "";
        if (preEventCall('hdenro_det',obj,'ONCLICK') == false) {
                return false;
        }
        if ((retVal = fnValidateData()) == false) {
                return false;
        }
        if (postEventCall('hdenro_det',obj,'ONCLICK') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}


function hdenro_det_ONCLICK3(obj)
{
	var retVal = "";
	if (preEventCall('hdenro_det',obj,'ONCLICK') == false) {
                return false;
        }
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (postEventCall('hdenro_det',obj,'ONCLICK') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}
