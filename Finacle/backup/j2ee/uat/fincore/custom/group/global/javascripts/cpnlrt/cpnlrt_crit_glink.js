function printBlock()
{
	writeCustomHeader("cpnlrt_crit");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT033791") + '</td>');
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
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT033107") + ' <script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<select name="' + subGroupName + '.funcCode" id="funcCode"  fdt="String" ' + cpnlrtProps.get("funcCode_ENABLED") + '   style="width: 126px;">');
	write('<option value="">' + jspResArr.get("FLT033456") + '</option>');
	write('<option value="A">' + jspResArr.get("FLT014584") + '</option>');
	write('<option value="I">' + jspResArr.get("FLT034011") + '</option>');
	write('<option value="M">' + jspResArr.get("FLT012350") + '</option>');
	write('<option value="V">' + jspResArr.get("FLT013170") + '</option>');
	write('<option value="D">' + jspResArr.get("FLT013171") + '</option>');
	write('<option value="U">' + jspResArr.get("FLT013172") + '</option>');
	write('<option value="X">' + jspResArr.get("FLT033219") + '</option>');
	write('</select>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfield"> </td>');
	write('</tr>');
	write('<tr></tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT033792") + ' <script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<select name="' + subGroupName + '.levelType" id="levelType"  fdt="String" ' + cpnlrtProps.get("levelType_ENABLED") + '  onChange="javascript: fnShowLevelId();" style="width: 126px;">');
	write('<option value="">' + jspResArr.get("FLT033456") + '</option>');
	write('<option value="A">' + jspResArr.get("FLT011927") + '</option>');
	write('<option value="C">' + jspResArr.get("FLT023325") + '</option>');
	write('<option value="S">' + jspResArr.get("FLT033800") + '</option>');
	write('</select>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel" id="levelIdCol1">' + jspResArr.get("FLT033799") + '  <script>setMandatory("Y");</script></td>');
	write('<td class="textfield" id="levelIdCol2">');
	write('<a id="sLnk2" href="javascript:getLevelIdList()">');
	write('<input hotKeyId="search1" type="text" class="textfieldfont" name="' + subGroupName + '.levelId" id="levelId"  fdt="String" ' + cpnlrtProps.get("levelId_ENABLED") + ' finName="input23411" onChange="javascript: fnValidateLevelId();" style="width: 140px;">');
	write('  <img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('&nbsp;&nbsp;<a id="sLnk3" href="javascript:showAcctDetails()">');
    write('<img src="../Renderer/images/' + applangcode + '/explode.gif" alt="Balance Details" width="16" height="16" border="0" explodeId="explode1"></a>');
	write('</td>');
	write('</tr>');
	write('<tr></tr>');
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
	write('<input id="Accept" name="Go" type="button" class="button"	onClick="javascript:return cpnlrt_crit_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT004977") + '" hotKeyId="Go">');
	write('<input id="Clear" name="Clear" type="button" class="button" value="' + jspResArr.get("FLT001439") + '"	onClick="javascript:return cpnlrt_crit_ONCLICK2(this);"">');
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	initFocusHandler();

	pre_ONLOAD('cpnlrt_crit',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}
	
	post_ONLOAD('cpnlrt_crit',this);
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
	ObjForm.levelType.value = levelType;
	ObjForm.levelId.value = levelId;
	hideImage("sLnk3");
	if(ObjForm.levelType.value == ""){
		hideImage("levelIdCol1");
		hideImage("levelIdCol2");
		hideImage("sLnk3");
	}
	else 
	{
		switch (levelType){
			case 'A':
				var colName = "Account Id:";
				showImage("sLnk3");
				break;
			case 'C':
				var colName = "CIF Id:";
				break;
			case 'S':
				var colName = "Scheme Code:";
				break;
			default:
				var colName = "Level Id:";
		}
		showImage("levelIdCol1");
		document.getElementById('levelIdCol1').innerHTML = colName;
		showImage("levelIdCol2");
	} 
}

function cpnlrt_crit_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (preEventCall('cpnlrt_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cpnlrt_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cpnlrt_crit_ONCLICK2(obj)
{
	var retVal = "";
	if (preEventCall('cpnlrt_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  customClearFields()) == false) {
		return false;
	}
	if ((retVal =  fnClearFields()) == false) {
		return false;
	}
	if (postEventCall('cpnlrt_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

