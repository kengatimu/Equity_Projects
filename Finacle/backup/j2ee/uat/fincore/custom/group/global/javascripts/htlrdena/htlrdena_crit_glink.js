function printBlock()
{
	writeCustomHeader("htlrdena_Crit");
	with (document){
	write('<input type="hidden" name="htlrdenm.cashAcctBalance" id="cashAcctBalance" value="123456.00">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT027769") + '</td>');
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
	write('<a href="javascript:showHelpFile(\'htlrdena_crit_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FAT000703") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
//	write('<select name="' + subGroupName + '.funcCode" id="funcCode" ' + htlrdenaProps.get("funcCode_ENABLED") + ' class="listboxfont" style="width: 200px"  onChange="javascript:return fnFuncChnge(this);">');
	write('<select name="' + subGroupName + '.funcCode" id="funcCode" ' + htlrdenaProps.get("funcCode_ENABLED") + ' class="listboxfont" style="width: 200px" >');
	write('<OPTION VALUE="">' + jspResArr.get("FLT012410") + '</OPTION>');
	write('<OPTION VALUE="M">' + jspResArr.get("FLT027766") + '</OPTION>');
	write('<OPTION VALUE="V">' + jspResArr.get("FLT027767") + '</OPTION>');
	write('<OPTION VALUE="I">' + jspResArr.get("FLT027768") + '</OPTION>');
	write('<OPTION VALUE="X">' + jspResArr.get("FLT027575") + '</OPTION>');
	write('</select>');
	write('</td>');
	write('<td class="columnwidth" style="width: 57px"> </td>');
	write('<td class="textlabel" style="width: 102px">' + jspResArr.get("FTT000072") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield" style="width: 225px">');
	write('<input hotKeyId="search1" type="text" class="textfieldfont" name="' + subGroupName + '.crncyCode" id="crncyCode"  fmnd="' + htlrdenaProps.get("crncyCode_MANDATORY") + '" ' + htlrdenaProps.get("crncyCode_ENABLED") + ' style="width: 200px" onChange="javascript:return fnValidCurr();">&nbsp;');
	write('<a id="sLnk17" href="javascript:showCurrencyList(document.forms[0].crncyCode)">');
	write('<img border="0" id = "search1" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT014433") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield" style="width: 288px">');
	write('<input hotKeyId="search2" type="text" class="textfieldfont" name="' + subGroupName + '.tellerId" id="tellerId"  fmnd="' + htlrdenaProps.get("tellerId_MANDATORY") + '" ' + htlrdenaProps.get("tellerId_ENABLED") + ' style="width: 200px" onChange="javascript:return fnValidTellr();">&nbsp;');
	write('<a href="javascript:TellrId()">');
	write('<img border="0" height="17" id = "search2" hotKeyId="search2" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('</td>');
	write('<td class="columnwidth" style="width: 56px"> </td>');
	write('<td class="textlabel" style="width: 124px">' + jspResArr.get("FHP000439") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield" style="width: 245px">');
	write('<input hotKeyId="search3" type="text" class="textfieldfont" name="' + subGroupName + '.solId" id="solId"  fmnd="' + htlrdenaProps.get("solId_MANDATORY") + '" ' + htlrdenaProps.get("solId_ENABLED") + ' style="width: 200px" onChange="javascript:return fnValidSol();">&nbsp;');
	write('<a href="javascript:showSolId(document.forms[0].solId,\'ctrl\',\'F\',document.forms[0].solIdDesc)">');
	write('<img border="0" height="17" id = "search3" hotKeyId="search3" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	 write('<input name="' + subGroupName + '.solIdDesc" id="solIdDesc" ' + htlrdenaProps.get("solIdDesc_ENABLED") + ' type="text" class="label" size="25"  disabled>');
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
	write('<input type="button" class="Button" id="Submit" value="SUBMIT" onClick="javascript:return doRefSubmit(this);" hotKeyId="Submit" >');
	}
	writeRefFooter();
	write('<input type="button" class="Button" id="_BackRef_" value="CANCEL" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	write('<div class="ctable">');
	write('<input id="Accept" name="Go" type="button" class="button" onClick="javascript:return htlrdena_crit_ONCLICK1(this,this);"" value="Go" hotKeyId="Go">');
	write('<input id="Clear" name="Clear" type="button" class="button" value="Clear" onClick="javascript:return fnClearNrorpt();">');
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function
/*
function showModuleList()
{

      var ObjForm = document.forms[0];
      var inputNameValues = "funcCode|"+ObjForm.funcCode.value+"|moduleId|"+ObjForm.moduleId.value;
      var outputNameValues = "moduleId|module_desc";
      var scriptName = "htlrdena_module_list.scr";
      var listHeading = "Module List";
      var colHeader = "Module ID|Module Description";

      var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",true);
}
*/
function fnOnLoad()
{
	var ObjForm = document.forms[0];
	pre_ONLOAD('htlrdena_Crit',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('htlrdena_Crit',this);
	ObjForm.funcCode.focus();
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	if (fnIsNull(ObjForm.crncyCode.value))
	{
		alert(jspErrResArr.get("FAT000924"));
		ObjForm.crncyCode.focus();
		return false;
	}
	if (fnIsNull(ObjForm.tellerId.value))
	{
		alert(jspErrResArr.get("FAT000924"));
		ObjForm.tellerId.focus();
		return false;
	}
	if (fnIsNull(ObjForm.solId.value))
	{
		alert(jspErrResArr.get("FAT000924"));
		ObjForm.solId.focus();
		return false;
	}
	return true;
}

function fnPopulateControlValues()
{
	var ObjForm = document.forms[0];

        ObjForm.funcCode.value = funcCode;
	ObjForm.crncyCode.value = crncyCode;
	ObjForm.tellerId.value = tellerId;
	ObjForm.solId.value = solId;
}


function htlrdena_crit_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (pre_ONCLICK('htlrdena_crit',obj) == false) {
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (post_ONCLICK('htlrdena_crit',obj) == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function htlrdena_crit_ONCLICK2(obj)
{
	var retVal = "";
	if (pre_ONCLICK('htlrdena_crit',obj) == false) {
		return false;
	}
	if ((retVal =  fnClearFields(obj)) == false) {
		return false;
	}
	if (post_ONCLICK('htlrdena_crit',obj) == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}



function htlrdena_crit_pre_ONCLICK(obj)
{
	var ObjForm = document.forms[0];
	if(obj.id == "Accept")
	{
			if(document.forms[0].funcCode.value =="")
			{
				alert("Please enter Function Code");
				document.forms[0].funcCode.focus();
				return false;
			}

			if(document.forms[0].crncyCode.value =="")
			{
				alert("Please enter Currency");
				document.forms[0].crncyCode.focus();
				return false;
			}
			if(document.forms[0].tellerId.value =="")
			{
				alert("Please enter Teller Id");
				document.forms[0].tellerId.focus();
				return false;
			}
			if(document.forms[0].solId.value =="")
			{
				alert("Please enter Sol Id");
				document.forms[0].solId.focus();
				return false;
			}
			fnValidCurr();
			fnValidSol();
			//fnValidTellr();


	}

}

function getQuerystring(key, default_)
{
  if (default_==null) default_="";
  key = key.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
  var regex = new RegExp("[\\?&]"+key+"=([^&#]*)");
  var qs = regex.exec(window.location.href);
  if(qs == null)
    return default_;
  else
    return qs[1];
}

