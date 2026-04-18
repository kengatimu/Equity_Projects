function printBlock()
{
	writeCustomHeader("cpcm_crit");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT000000") + '</td>');
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
	write('<a href="javascript:showHelpFile(\'cpcm_crit_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21" vspace="1" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');

	//Field 1 Function
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT000001") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<select name="' + subGroupName + '.funcCode" id="funcCode"   fdt="String" ' + cpcmProps.get("funcCode_ENABLED") + ' class="listboxfont" >');
	write('<option value="">'  + jspResArr.get("FLT000002") + '</option>');
	write('<option value="A">' + jspResArr.get("FLT000003") + '</option>');
	write('<option value="M">' + jspResArr.get("FLT000004") + '</option>');
	write('<option value="V">' + jspResArr.get("FLT000005") + '</option>');
	write('<option value="X">' + jspResArr.get("FLT000006") + '</option>');
	write('<option value="I">' + jspResArr.get("FLT000007") + '</option>');
	write('</select>');
	write('</td>');
        write('<td class="columnwidth">&nbsp;</td>');

	//Preferential level
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT000011") + '<script>setMandatory("Y");</script></td>');
        write('<td class="textfield">');
        write('<select name="' + subGroupName + '.preferentialLevel" id="preferentialLevel" OnChange="javascript: return fnFuncCode(this);" fdt="String" ' + cpcmProps.get("preferentialLevel_ENABLED") + ' class="listboxfont" >');
        write('<option value="">'  + jspResArr.get("FLT000012") + '</option>');
        write('<option value="A">' + jspResArr.get("FLT000013") + '</option>');
        write('<option value="C">' + jspResArr.get("FLT000014") + '</option>');
        write('<option value="AG">' + jspResArr.get("FLT000015") + '</option>');
        write('<option value="S">' + jspResArr.get("FLT000016") + '</option>');
        write('<option value="B">' + jspResArr.get("FLT000017") + '</option>');
//	write('<option value="B">' + jspResArr.get("FLT100016") + '</option>');
        write('</select>');
        write('</td>');
	write("</tr>");

	//Field 2 ACCOUNT ID
	write('<tr id="B">');
	write('<td class="textlabel">' + jspResArr.get("FLT000008") + '<script>setMandatory("Y");</script></td>');
        write('<td class="textfield">');
        write('<input type="text" class="textfieldfont" hotKeyId="search2" id="acctId" name="' + subGroupName + '.acctId" onchange="javascript:return fnPopAccountDet();"  size="21" fdt="accountid" maxlength="16">');
        write('&nbsp;<a id="sLnk2" href="javascript:acctIdSearcher();">');
        write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search2"></a>');
        write('<br />');
        write('<input class="label" id="acctCrncyCode" name="' + subGroupName + '.acctCrncyCode" fds="Y" size="4" maxlength="3" disabled>');
        write('<input class="label" id="solId" name="' + subGroupName + '.solId" fds="Y" size="10" maxlength="8" disabled>');
        write('<input name="' + subGroupName + '.acctName" align="left" id="acctName"  type="text" disabled="true" class="label" size="40" maxlength="100" fdt="default" fblk="defaultFblk1" fds="Y">');
        write('</td>');
        write("</tr>");
	
	//CIF ID
	write('<tr id="C">');
	write('<td class="textlabel">' + jspResArr.get("FLT000009") + '<script>setMandatory("Y");</script></td>');
        write('<td class="textfield">');
        write('<input hotKeyId="search3" type="text" class="textfieldfont" name="' + subGroupName + '.custId" id="custId"  "maxlength="9" fdt="cifid" onchange="javascript:return bhp_crit_ONCHANGE6(this,\'myframe\',\'CIFID\',\'F\',\'custId\',\'custName\');" ' + cpcmProps.get("custId_ENABLED") + ' ">');
        write('&nbsp; <a id="sLnk3" href="javascript:custIdSearcher(document.forms[0].custId);">');
        write('<img border="0" height="17" hotKeyId="search3" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        write('</a>');
        write('<input class="label" id="custName" name="' + subGroupName + '.custName" size="50" border="0" maxlength=30 fds="Y" disabled></td>');
        write('</td>');
        write('</tr>');

	//Agreement Code
	write('<tr id="D">');
	write('<td class="textlabel">' + jspResArr.get("FLT000010") + '<script>setMandatory("Y");</script></td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.empId" id="empId" type="text" fdt="String" class="textfieldfont" hotKeyId="search2" onChange="javascript:return fnGetEmpList();" size="21" maxlength="16">');
        write('&nbsp; <a id="sLnk4" href="javascript:fnGetEmpList()">');
        write('<img border="0" height="17" id="empId" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        write('&nbsp;<input class="label" id="empName" name="' + subGroupName + '.empName" size="30" border="0" maxlength=30 fds="Y" disabled>');
	write('</td>');
        write('</tr>');

	//Customer Type
	write('<tr id="E">');	
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT000018") + '<script>setMandatory("Y");</script></td>');
        write('<td class="textfield">');
        write('<select name="' + subGroupName + '.customerType" id="customerType"  fdt="String" ' + cpcmProps.get("customerType_ENABLED") + ' class="listboxfont" >');
        write('<option value="">'  + jspResArr.get("FLT000019") + '</option>');
        write('<option value="R">' + jspResArr.get("FLT000020") + '</option>');
        write('<option value="C">' + jspResArr.get("FLT000021") + '</option>');
	write('</select>');
        write('</td>');
        write("</tr>");

	//Segmentation Level
	write('<tr id="F">');
        write('<td class="textlabel">' + jspResArr.get("FLT100010") + '<script>setMandatory("Y");</script></td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.segmentationLevel" id="segmentationLevel" type="text" fdt="String" class="textfieldfont" hotKeyId="search2" onChange="javascript:return segmentationLevel();" size="21" maxlength="16">');
        write('&nbsp; <a id="sLnk4" href="javascript:segmentationLevelSearcher()">');
        write('<img border="0" height="17" id="segmentationLevel" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        write('&nbsp;<input class="label" id="segmentationDesc" name="' + subGroupName + '.segmentationDesc" size="30" border="0" maxlength=30 fds="Y" disabled>');
	write('</td>');
        write('</tr>');

        write('<tr>');
        write('<td class="textlabel">'+jspResArr.get("FLT200117")+'<script>setMandatory("Y");<\/script></td>');
        write('<td class="textfield"><input onBlur="javascript:return custom_ONBLUR(\'cpcmcrit\',this);" type="text" class="textfieldfont" fmnd="Y" fmb="Y" fdt="string" fblk="fblk1" fds="N" name="'+subGroupName+'.evtType" id="evtType" size="7" maxlength="5" '+cpcmProps.get("evtType_ENABLED")+' hotKeyId="search1">');
        write('&nbsp;<a target="_self" id="sLnk2" href="javascript:fnShowEventType()">');
        write('<img border="0" height="17" id="evtType" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        write('<input class="label" id="evtTypeDesc" name="' + subGroupName + '.evtTypeDesc" size="30" border="0" maxlength=30 fds="Y" disabled></td>');
        write('</td>');

        write('<td class="columnwidth">&nbsp;</td>');

        write('<td class="textlabel">'+jspResArr.get("FLT200118")+'<script>setMandatory("Y");<\/script></td>');
        write('<td class="textfield"><input onChange="javascript:return custom_ONCHANGE(\'cpcmcrit\',this);" onBlur="javascript:return custom_ONBLUR(\'cpcmcrit\',this);" type="text" class="textfieldfont" fmnd="Y" name="'+subGroupName+'.evtId" id="evtId" size="27" maxlength="25" '+cpcmProps.get("evtId_ENABLED")+' hotKeyId="search2">');
        write('&nbsp;<a target="_self" id="sLnk6" href="Javascript:fnShowEvtIDList()">');
        write('<img border="0" height="17" id="evtType" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
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
	write('<div class="ctable">');
	write('<input id="Accept" name="Go" type="button" class="button"	onClick="javascript:return cpcm_crit_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT004977") + '" hotKeyId="Go">');
	write('<input id="Clear" name="Clear" type="button" class="button" value="' + jspResArr.get("FLT001439") + '"	onClick="javascript:return cpcm_crit_ONCLICK2(this);"">');
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	initFocusHandler();

	pre_ONLOAD('cpcm_crit',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}
	ObjForm.funcCode.focus();
	post_ONLOAD('cpcm_crit',this);
}

function fnCheckMandatoryFields()
{
	var objForm = document.forms[0];

/*	if(fnIsNull(objForm.funcCode.value))
	{
		objForm.funcCode.focus();
		return false;
	}

	if(fnIsNull(objForm.acctId.value))
	{
		objForm.acctId.focus();
		return false;
	}*/

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	ObjForm.funcCode.value      = funcCode;
	ObjForm.acctId.value        = acctId;
	ObjForm.acctCrncyCode.value = acctCrncyCode;
	ObjForm.solId.value         = solId;
	ObjForm.acctName.value      = acctName;
	ObjForm.custId.value 	    = custId;
	ObjForm.preferentialLevel.value = preferentialLevel;
	ObjForm.custName.value        = custName;
	ObjForm.empId.value        = empId;
	ObjForm.empName.value        = empName;
	ObjForm.segmentationLevel.value        = segmentationLevel;
	ObjForm.segmentationDesc.value        = segmentationDesc;	
	//ObjForm.customerType.value        = customerType;
        ObjForm.evtType.value   = evtType;
        ObjForm.evtTypeDesc.value = evtTypeDesc;
	ObjForm.evtId.value             = evtId;
}

function cpcm_crit_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (preEventCall('cpcm_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cpcm_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cpcm_crit_ONCLICK2(obj)
{
	var retVal = "";
	if (preEventCall('cpcm_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnClearFields()) == false) {
		return false;
	}
	if (postEventCall('cpcm_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

