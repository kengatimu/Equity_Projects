function printBlock()
{
	writeCustomHeader("pklink_det");
	with (document){
		write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
		write('<tr>');
		write('<td>');
		write('<table border="0" cellspacing="0" cellpadding="0">');
		write('<tr>');
		write('<td class="page-heading">Package-Customer Linkage Menu</td>');
		write('</tr>');
		write('</table>');
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
		write('<td colspan="5" align="right">');
		write('<table border="0" cellspacing="0" cellpadding="0">');
		write('<tr>');
		write('<td align="right">');
		write('<a href="javascript:showHelpFile(\'pklink_det_help.htm\');" id="sLnk1">');
		write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21" vspace="1" border="0" />');
		write('</a>');
		write('</td>');
		write('</tr>');
		write('</table>');
		write('</td>');
		write('</tr>');
		write('<tr>');
		write('<tr>');


		//Function Code
		write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT000611") + '<script>setMandatory("Y");</script></td>');
		write('<td class="textfield">');
		write('<select name="' + subGroupName + '.funcCode" id="funcCode"  fdt="String" OnChange="javascript:return fnFuncCode(this);" ' + pklinkProps.get("funcCode_ENABLED") + ' class="listboxfont">');
		write('<option value="">' + jspResArr.get("FLT000612") + '</option>');
		write('<option value="A">' + jspResArr.get("FLT000613") + '</option>');
		write('<option value="V">' + jspResArr.get("FLT000621") + '</option>');
		write('<option value="I">' + jspResArr.get("FLT000622") + '</option>');
		write('<option value="X">' + jspResArr.get("FLT000631") + '</option>');
		write('<option value="D">' + jspResArr.get("FLT000633") + '</option>');
		write('</select>');
		write('</td>');
		write('</tr>');

		//Customer Id
		write('<td class="textlabel">' + jspResArr.get("FLT100621") + '<script>setMandatory("Y");</script></td>');
		write('<td class="textfield">');
		write('<input hotKeyId="search3" type="text" class="textfieldfont" name="' + subGroupName + '.cifId" id="cifId"  "maxlength="9" fdt="cifid" onchange="javascript:return pklink_det_ONCHANGE6(this,\'myframe\',\'CIFID\',\'F\',\'cifId\',\'custName\');" ' + pklinkProps.get("cifId_ENABLED") + ' ">');
		write('&nbsp; <a id="sLnk3" href="javascript:showCustSearcher();">');
		write('<img border="0" height="17" hotKeyId="search3" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
		write('</a>');
		write('<input class="label" id="custName" name="' + subGroupName + '.custName" size="50" border="0" maxlength=30 fds="Y" disabled></td>');
		write('</td>');
		write('</tr>');

		//Package Code
		write('<td class="textlabel">' + jspResArr.get("FLT100620") + '<script>setMandatory("Y");</script></td>');
		write('<td class="textfield">');
		write('<input name="' + subGroupName + '.packageCode" id="packageCode" type="text" fdt="String" class="textfieldfont" hotKeyId="search2" onChange="javascript:return packagecode();" size="21" maxlength="5">');
		write('&nbsp; <a id="sLnk2" href="javascript:packageCodSearcher()">');
		write('<img border="0" height="17" id="packageCode" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
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
				write('<input type="button" class="Button" id="Submit" value="Submit" onClick="javascript:return fnValidateData();doRefSubmit(this);" hotKeyId="Submit" >');
			}
			writeRefFooter();
			write('<input type="button" class="Button" id="_BackRef_" value="Cancel" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
			write('</div>');
		}else{
			write('<div class="ctable">');
			write('<input type="button" class="Button" id="Submit" value="Submit" onClick="javascript:if( fnValidateData() ) { doRefSubmit(this); }" hotKeyId="Submit" >');
			write('<input id="Clear" name="Clear" type="button" class="button" value="' + jspResArr.get("FLT001439") + '"   onClick="javascript:return pklink_det_ONCLICK3(this);">');
			writeFooter();
			write('</div>');
		}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	pre_ONLOAD('pklink_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('pklink_det',this);
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];
	if (fnIsNull(ObjForm.funcCode.value))
	{
		alert("function Code Cannot be left blank");
		ObjForm.funcCode.focus();
		return false;
	}
	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];
	ObjForm.funcCode.value = funcCode;
	ObjForm.cifId.value = cifId;
	ObjForm.custName.value = custName;
	ObjForm.packageCode.value = packageCode;
}

function fnValidateData()
{
	var retVal = "";

	if (!fnCheckMandatoryFields()) {
		return false;
	}
	return true;
}
function pklink_crit_ONCLICK2(obj)
{
	var retVal = "";
	if (preEventCall('pklink_crit',obj,'ONCLICK') == false) {
		return false;
	}
	if ((retVal =  fnClearFields()) == false) {
		return false;
	}
	if (postEventCall('pklink_crit',obj,'ONCLICK') == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function pklink_det_ONCLICK3(obj)
{
	var retVal = "";
	if (preEventCall('pklink_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnClearFields()) == false) {
		return false;
	}
	if (postEventCall('pklink_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
function pklink_det_ONBLUR1(obj,p1,p2)
{
	var retVal = "";
	if (preEventCall('pklink_det',obj,'ONBLUR') == false) {
		return false;
	}
	if ((retVal = onBlurFormatDate(p1)) == false) {
		return false;
	}
	if ((retVal = fnAssignDateOnEnter(p2)) == false) {
		return false;
	}
	if (postEventCall('pklink_det',obj,'ONBLUR') == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;

}

