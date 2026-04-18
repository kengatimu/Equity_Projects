function printBlock()
{
	writeCustomHeader("cpmod_Crit");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading"> CPARAM MODULE MAINTENANCE</td>');
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
	write('<td class="textlabel">' + jspResArr.get("FAT000703") + '</td>');
	write('<td class="textfield">');
	//write('<select name="' + subGroupName + '.funcCode" id="funcCode" ' + cpmodProps.get("funcCode_ENABLED") + '   style="width: 111px"' +' onChange="javascript:return cpmod_Crit_ONCHANGE2(this);"">');
	write('<select name="' + subGroupName + '.funcCode" id="funcCode" ' + cpmodProps.get("funcCode_ENABLED") + '   style="width: 111px">');
	write('<option selected="selected" value="S">' + jspResArr.get("FLT012410") + '</option>');
	write('<option value="A">' + jspResArr.get("FAT000733") + '</option>');
	write('<option value="I">' + jspResArr.get("FAT000737") + '</option>');
	write('<option value="M">' + jspResArr.get("FAT000734") + '</option>');
	write('<option value="D">' + jspResArr.get("FAT000736") + '</option>');
	write('<option value="V">' + jspResArr.get("FVL000041") + '</option>');
	write('<option value="X">' + jspResArr.get("FVL000002") + '</option>');
	write('</select>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel" style="width: 112px">' + jspResArr.get("FLT001938") + '</td>');
	write('<td class="textfield">');
		write('<input style="text-transform:none" type="text" name="' + subGroupName + '.moduleId" id="moduleId" ' + cpmodProps.get("moduleId_ENABLED") + ' maxlength="30">');
	var code=getQuerystring('funcCode');
	if(code!='')
	{
		funcCode=code;
	}
	if(funcCode!='A')
	{
		write('<a href="javascript:showModuleList()">');
		write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
		write('</a>');
	}
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
	write('<div class="ctable">');
	write('<input id="Accept" name="Go" type="button" class="button"	onClick="javascript:return cpmod_Crit_ONCLICK1(this,this);"" value="Go" hotKeyId="Go">');
	write('<input id="Clear" name="Clear" type="button" class="button" value="Clear"	onClick="javascript:return cpmod_Crit_ONCLICK2(this);"">');
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function showModuleList()
{
	 
      var ObjForm = document.forms[0]; 
      var inputNameValues = "funcCode|"+ObjForm.funcCode.value+"|moduleId|"+ObjForm.moduleId.value;
      var outputNameValues = "moduleId|module_desc";
      var scriptName = "cpmod_module_list.scr";
      var listHeading = "Module List";
      var colHeader = "Module ID|Module Description";
      
      var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",true);
}

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	pre_ONLOAD('cpmod_Crit',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('cpmod_Crit',this);
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
	//ObjForm.moduleId.value = moduleId;
}


function cpmod_Crit_ONCLICK1(obj,p1)
{
	
	var retVal = "";
	if(document.forms[0].funcCode.value==''||document.forms[0].funcCode.value=='S'){
		alert("Select function");
		document.forms[0].funcCode.focus();
		return false;
	}
	if(document.forms[0].moduleId.value==''){
		alert("module Id is a mandatory field");
		document.forms[0].moduleId.focus();
		return false;
	}
	if (preEventCall('cpmod_Crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cpmod_Crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cpmod_Crit_ONCLICK2(obj)
{
	var retVal = "";
	if (preEventCall('cpmod_Crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnClearFields()) == false) {
		return false;
	}
	if (postEventCall('cpmod_Crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cpmod_Crit_ONCHANGE2(obj)
{
	var retVal = "";
	if (preEventCall('cpmod_Crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = setUI()) == false) {
		return false;
	}
	if (postEventCall('cpmod_Crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function setUI()
{
	var code=getQuerystring('funcCode');
	var url=location.href;
	ind=url.indexOf("?");
	var index=url.indexOf("funcCode");
	if(index!=-1)
	{
		url=url.substr(0,index-1);
	}
	if(document.forms[0].funcCode.value=='A' || code=='A')
	{
		if(ind==-1)
		{		
			url=url+"?";
			location.replace(url+"&funcCode="+document.forms[0].funcCode.value);			
		}
		else
		{
			//var aurl=url.substr(0,ind+1);		
			location.replace(url+"&funcCode="+document.forms[0].funcCode.value);
			
		}
	
	}
	else
	{
		document.forms[0].moduleId.value='';
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

