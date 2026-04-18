function printBlockPg1Sec1() 
{
	writeCustomHeader("cprofiledet1");
	with (document){
//	write('<input type="hidden" name="' + subGroupName + '.cmmSubmitCallMode" id="cmmSubmitCallMode" fdt="String" ' + cprofileProps.get("cmmSubmitCallMode_ENABLED") + '>');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FSC909815") + '</td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT006657") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + displayFuncCode + '</label>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT002136") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + cifId + '</label>');
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
	write('<a href="javascript:showHelpFile(\'cprofiledet011_help.htm\');" id="hlpLnk0">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21" vspace="1" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	//1
   write('<tr id="cprofilecprofiledet01Row1">');
    write('<td class="textlabel">' + jspResArr.get("FLT901187") + '<script>setMandatory("Y");</script></td>');    
	write('<td class="textfield">');
    write('<input type="text" name="' + subGroupName + '.custid" id="custid" class="textfieldfont"  onChange="javascript:return cprofiledet01_ONCHANGE(this);"  onBlur="javascript:return cprofiledet01_ONBLUR(this);"  fdt="String" ' + cprofileProps.get("custid_ENABLED") + ' maxlength="30 " hotKeyId="" >&nbsp;');
    
	write('</td>');
	///write('</tr>');
	
    ////write('<tr id="cprofilecprofiledet01Row2">');
    write('<td class="textlabel">' + jspResArr.get("FTH901212") + '<script>setMandatory("Y");</script></td>');    
	write('<td class="textfield">');
    write('<input type="date" name="' + subGroupName + '.bodDate" id="bodDate" class="textfieldfont"  onChange="javascript:return cprofiledet01_ONCHANGE(this);"  onBlur="javascript:return cprofiledet01_ONBLUR(this);"  fdt="String" ' + cprofileProps.get("bodDate_ENABLED") + ' maxlength="30 " hotKeyId="" >&nbsp;');
    
	write('</td>');
	write('</tr>');
		//2
   write('<tr id="cprofilecprofiledet01Row2">');
    write('<td class="textlabel">' + jspResArr.get("FLT909813") + '<script>setMandatory("Y");</script></td>');    
	write('<td class="textfield">');
    write('<input type="text" name="' + subGroupName + '.branchid" id="branchid" class="textfieldfont"  onChange="javascript:return cprofiledet01_ONCHANGE(this);"  onBlur="javascript:return cprofiledet01_ONBLUR(this);"  fdt="String" ' + cprofileProps.get("branchid_ENABLED") + ' maxlength="30 " hotKeyId="" >&nbsp;');
    
	write('</td>');
	///write('</tr>');
	
    ////write('<tr id="cprofilecprofiledet01Row2">');
    write('<td class="textlabel">' + jspResArr.get("FLT909814") + '<script>setMandatory("Y");</script></td>');    
	write('<td class="textfield">');
    write('<input type="text" name="' + subGroupName + '.schmcode" id="schmcode" class="textfieldfont"  onChange="javascript:return cprofiledet01_ONCHANGE(this);"  onBlur="javascript:return cprofiledet01_ONBLUR(this);"  fdt="String" ' + cprofileProps.get("schmcode_ENABLED") + ' maxlength="30 " hotKeyId="" >&nbsp;');
    
	write('</td>');
	write('</tr>');
	
		//3
   write('<tr id="cprofilecprofiledet01Row3">');
    write('<td class="textlabel">' + jspResArr.get("FLT909948") + '<script>setMandatory("Y");</script></td>');    
	write('<td class="textfield">');
    write('<input type="text" name="' + subGroupName + '.acctcurr" id="acctcurr" class="textfieldfont"  onChange="javascript:return cprofiledet01_ONCHANGE(this);"  onBlur="javascript:return cprofiledet01_ONBLUR(this);"  fdt="String" ' + cprofileProps.get("acctcurr_ENABLED") + ' maxlength="30 " hotKeyId="" >&nbsp;');
    
	write('</td>');
	///write('</tr>');
	
    ////write('<tr id="cprofilecprofiledet01Row2">');
    write('<td class="textlabel">' + jspResArr.get("FLT011782") + '<script>setMandatory("Y");</script></td>');    
	write('<td class="textfield">');
    write('<input type="text" name="' + subGroupName + '.acctname" id="acctname" class="textfieldfont"  onChange="javascript:return cprofiledet01_ONCHANGE(this);"  onBlur="javascript:return cprofiledet01_ONBLUR(this);"  fdt="String" ' + cprofileProps.get("acctname_ENABLED") + ' maxlength="30 " hotKeyId="" >&nbsp;');
    
	write('</td>');
	write('</tr>');
		//4
   write('<tr id="cprofilecprofiledet01Row4">');
    write('<td class="textlabel">' + jspResArr.get("FLT008147") + '<script>setMandatory("Y");</script></td>');    
	write('<td class="textfield">');
    write('<input type="text" name="' + subGroupName + '.mode_of_oper_code" id="mode_of_oper_code" class="textfieldfont"  onChange="javascript:return cprofiledet01_ONCHANGE(this);"  onBlur="javascript:return cprofiledet01_ONBLUR(this);"  fdt="String" ' + cprofileProps.get("mode_of_oper_code_ENABLED") + ' maxlength="30 " hotKeyId="" >&nbsp;');
    
	write('</td>');
	///write('</tr>');
	
    ////write('<tr id="cprofilecprofiledet01Row2">');
    write('<td class="textlabel">' + jspResArr.get("FLT008148") + '<script>setMandatory("Y");</script></td>');    
	write('<td class="textfield">');
    write('<input type="text" name="' + subGroupName + '.riskProfile" id="riskProfile" class="textfieldfont"  onChange="javascript:return cprofiledet01_ONCHANGE(this);"  onBlur="javascript:return cprofiledet01_ONBLUR(this);"  fdt="String" ' + cprofileProps.get("riskProfile_ENABLED") + ' maxlength="30 " hotKeyId="" >&nbsp;');
    
	write('</td>');
	write('</tr>');
	
	write('</tr>');
	//5
    ////write('<tr id="cprofilecprofiledet01Row5">');
    write('<td class="textlabel">' + jspResArr.get("FLT008146") + '<script>setMandatory("Y");</script></td>');    
	write('<td class="textfield">');
    //write('<input type="button" name="' + subGroupName + '.vriskprofile" id="vriskprofile" class="button"  onChange="javascript:return cprofiledet01_ONCHANGE(this);"  onBlur="javascript:return cprofiledet01_ONBLUR(this);"  fdt="String" ' + cprofileProps.get("vriskprofile_ENABLED") + ' maxlength="30 " hotKeyId="" >&nbsp;');
	
	write('<input type="button" class="button" id="vriskprofile" value="'+jspResArr.get("FLT013157")+ '" onClick="alert("Validating");javascript:showCustomerRiskProfile();javascript:return doRefSubmit(this);) ;" hotKeyId="Submit" >');
    
	write('</td>');
	write('</tr>');
	
		//6
   write('<tr id="cprofilecprofiledet01Row6">');
    write('<td class="textlabel">' + jspResArr.get("FLT008145") + '<script>setMandatory("Y");</script></td>');    
	write('<td class="textfield">');
    
write('<select name="' + subGroupName + '.suspendCif" id="suspendCif" class="listboxfont"  onChange="javascript:return cprofiledet01_ONCHANGE(this);"  onBlur="javascript:return cprofiledet01_ONBLUR(this);"  fdt="String" ' + cprofileProps.get("createAcct_ENABLED") + ' >');
write('<option value="">' + jspResArr.get("FLT008143") + '</option>');
write('<option value="Y" >' + jspResArr.get("FLT008144") + '</option>');
write('<option value="N" >' + jspResArr.get("FLT008141") + '</option>');
write('</select>');
write('</td>');
	///write('</tr>');
	
    ////write('<tr id="cprofilecprofiledet01Row2">');
    write('<td class="textlabel">' + jspResArr.get("FLT012353") + '<script>setMandatory("Y");</script></td>');    
    write('<td class="textfield">');
write('<select name="' + subGroupName + '.createAcct" id="createAcct" class="listboxfont"  onChange="javascript:return cprofiledet01_ONCHANGE(this);"  onBlur="javascript:return cprofiledet01_ONBLUR(this);"  fdt="String" ' + cprofileProps.get("createAcct_ENABLED") + ' >');
write('<option value="">' + jspResArr.get("FLT008143") + '</option>');
write('<option value="Y" >' + jspResArr.get("FLT008144") + '</option>');
write('<option value="N" >' + jspResArr.get("FLT008141") + '</option>');
write('</select>');
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
	write('<input type="button" class="button" id="Submit" value="'+jspResArr.get("FLT000193")+ '" onClick="alert("HELLOEVERYONE");javascript:showTimeZoneAlert();javascript:return doRefSubmit(this);) ;" hotKeyId="Submit" >');
	}
	writeRefFooter();
	write('<input type="button" class="button" id="_BackRef_" value="'+jspResArr.get("FLT001721")+ '" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	if(funcCode !='I'){
	write('<div class="ctable">');
	write('<input id="Submit" name="Submit" type="button" class="button"	onClick="javascript:return cprofiledet01_ONCLICKSUBMIT(this,this);"" value="' + jspResArr.get("FLT000193") + '" hotKeyId="Submit">');
	write('<input id="Validate" name="Validate" type="button" class="button" value="' + jspResArr.get("FLT000194") + '"	onClick="javascript:return cprofiledet01_ONCLICKVALIDATE(this,this);"" hotKeyId="Validate">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="' + jspResArr.get("FLT001721") + '"	onClick="javascript:return cprofiledet01_ONCLICKCANCEL(this,this.id);"" hotKeyId="Cancel">');
	}else{
	write('<div class="ctable">');
	write('<input class="button" type="button" id="Back" value="'+jspResArr.get("FLT026526")+ '" onClick="javascript:return doSubmit(this.id)" hotKeyId="Ok">');
	}
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}


	function fnOnLoad()
	{
	var ObjForm = document.forms[0];

	initFocusHandler();

	pre_ONLOAD('cprofiledet01',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	fnAssignDateOnLoad(ObjForm);

    if(funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='U' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
	    fnDisableFormDataControls('V',ObjForm,0);
	    hideAnchors();
    }
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}
	//ObjForm.funcCode.focus();
	post_ONLOAD('cprofiledet01',this);
}

	
function cprofiledet01_ONCLICKSUBMIT(obj,p1)
{
	var ObjForm = document.forms[0];
	var retVal = "";

		var acctname=ObjForm.acctname.value;
		
		var inputNameValues = "acctname|"+acctname 
		
		var outputNameValues = "";
		var scriptName = "cprofile_frontEndValidation.scr";
		var retVal = appFnExecuteScript(inputNameValues , outputNameValues , scriptName ,false);
		var ret = retVal.split("|");
		var ret1 = ret[1]
	
	if (preEventCall('cprofiledet1',obj,'ONCLICK') == false) {
		return false;
	}
	if ((retVal = fnFrontEndEvents_ONCLICK(obj)) == false) {
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cprofiledet1',obj,'ONCLICK') == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function fnPopulateControlValues()
{
	var ObjForm = document.forms[0];

	ObjForm.custid.value = custid;
	ObjForm.bodDate.value = bodDate;
	ObjForm.branchid.value = branchid;
	ObjForm.schmcode.value = schmcode;
	ObjForm.acctcurr.value = acctcurr;
	ObjForm.acctname.value = acctname;
	ObjForm.mode_of_oper_code.value = mode_of_oper_code;
	ObjForm.riskProfile.value = riskProfile;
	ObjForm.vriskprofile.value = vriskprofile;
	ObjForm.suspendCif.value = suspendCif;
	ObjForm.createAcct.value = createAcct;

	fnCheckControls();
}

function fnCheckControls()
{
	var ObjForm = document.forms[0];

}
function cprofiledet01_ONBLURDATE(obj,p1,p2)
{
	var retVal = "";
	if (preEventCall('cprofiledet01',obj,'ONBLUR') == false) {
		return false;
	}
	if ((retVal = onBlurFormatDate(p1)) == false) {
		return false;
	}
	if ((retVal = fnAssignDateOnEnter(p2)) == false) {
		return false;
	}
	if ((retVal = fnFrontEndEvents_ONBLUR(obj)) == false) {
		return false;
	}
	if (postEventCall('cprofiledet01',obj,'ONBLUR') == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
	



function cprofiledet01_ONCLICKVALIDATE(obj,p1)
{
	var retVal = "";
	if (preEventCall('cprofiledet01',obj,'ONCLICK') == false) {
		return false;
	}
	if ((retVal = fnFrontEndEvents_ONCLICK(obj)) == false) {
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cprofiledet01',obj,'ONCLICK') == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cprofiledet01_ONCLICKCANCEL(obj,p1)
{
	var retVal = "";
	if (preEventCall('cprofiledet01',obj,'ONCLICK') == false) {
		return false;
	}
	if ((retVal = fnFrontEndEvents_ONCLICK(obj)) == false) {
		return false;
	}
	if ((retVal =  doSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cprofiledet01',obj,'ONCLICK') == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cprofiledet01_ONCHANGE(obj)
{
	var retVal = "";
	if (preEventCall('cprofiledet01',obj,'ONCHANGE') == false) {
		return false;
	}
	if ((retVal = fnFrontEndEvents_ONCHANGE(obj)) == false) {
		return false;
	}
	if (postEventCall('cprofiledet01',obj,'ONCHANGE') == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cprofiledet01_ONBLUR(obj)
{
	var retVal = "";
	if (preEventCall('cprofiledet01',obj,'ONBLUR') == false) {
		return false;
	}
	if ((retVal = fnFrontEndEvents_ONBLUR(obj)) == false) {
		return false;
	}
	if (postEventCall('cprofiledet01',obj,'ONBLUR') == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cprofiledet01_ONCLICK(obj)
{
	var retVal = "";
	if (preEventCall('cprofiledet01',obj,'ONCLICK') == false) {
		return false;
	}
	if ((retVal = fnFrontEndEvents_ONCLICK(obj)) == false) {
		return false;
	}
	if (postEventCall('cprofiledet01',obj,'ONCLICK') == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function writeFrequencyType(){
	with(document) {
	write('<OPTION VALUE="">'+jspResArr.get("FLT012410")+'</OPTION>');
	write('<OPTION VALUE="D">'+jspResArr.get("FLT012545")+'</OPTION>');
	write('<OPTION VALUE="F">'+jspResArr.get("FLT012652")+'</OPTION>');
	write('<OPTION VALUE="H">'+jspResArr.get("FLT012691")+'</OPTION>');
	write('<OPTION VALUE="M">'+jspResArr.get("FLT012353")+'</OPTION>');
	write('<OPTION VALUE="Q">'+jspResArr.get("FLT012856")+'</OPTION>');
	write('<OPTION VALUE="W">'+jspResArr.get("FLT013183")+'</OPTION>');
	write('<OPTION VALUE="Y">'+jspResArr.get("FLT012404")+'</OPTION>');
	}
}

function writeWeekNumber(){
	with(document) {
	write('<OPTION selected VALUE="">'+jspResArr.get("FLT013174")+'</OPTION>');
	write('<OPTION VALUE="1">'+jspResArr.get("FLT011775")+'</OPTION>');
	write('<OPTION VALUE="2">'+jspResArr.get("FLT011794")+'</OPTION>');
	write('<OPTION VALUE="3">'+jspResArr.get("FLT011812")+'</OPTION>');
	write('<OPTION VALUE="4">'+jspResArr.get("FLT011829")+'</OPTION>');
	write('<OPTION VALUE="L">'+jspResArr.get("FLT012233")+'</OPTION>');
	write('<OPTION VALUE="M">'+jspResArr.get("FLT012345")+'</OPTION>');
	}
}

function writeWeekDay(){
	with(document) {
	write('<OPTION selected VALUE="">'+jspResArr.get("FLT012488")+'</OPTION>');
	write('<OPTION VALUE="1">'+jspResArr.get("FLT011782")+'</OPTION>');
	write('<OPTION VALUE="2">'+jspResArr.get("FLT011798")+'</OPTION>');
	write('<OPTION VALUE="3">'+jspResArr.get("FLT011817")+'</OPTION>');
	write('<OPTION VALUE="4">'+jspResArr.get("FLT011832")+'</OPTION>');
	write('<OPTION VALUE="5">'+jspResArr.get("FLT011845")+'</OPTION>');
	write('<OPTION VALUE="6">'+jspResArr.get("FLT011858")+'</OPTION>');
	write('<OPTION VALUE="7">'+jspResArr.get("FLT011870")+'</OPTION>');
	}
}

function writeFreDates(){
	with(document) {
	write('<OPTION VALUE="">'+jspResArr.get("FLT000205")+'</OPTION>');
	write('<OPTION VALUE="1">'+jspResArr.get("FLT011753")+'</OPTION>');
	write('<OPTION VALUE="2">'+jspResArr.get("FLT011754")+'</OPTION>');
	write('<OPTION VALUE="3">'+jspResArr.get("FLT011756")+'</OPTION>');
	write('<OPTION VALUE="4">'+jspResArr.get("FLT011757")+'</OPTION>');
	write('<OPTION VALUE="5">'+jspResArr.get("FLT011758")+'</OPTION>');
	write('<OPTION VALUE="6">'+jspResArr.get("FLT011759")+'</OPTION>');
	write('<OPTION VALUE="7">'+jspResArr.get("FLT011760")+'</OPTION>');
	write('<OPTION VALUE="8">'+jspResArr.get("FLT011761")+'</OPTION>');
	write('<OPTION VALUE="9">'+jspResArr.get("FLT011762")+'</OPTION>');
	write('<OPTION VALUE="10">'+jspResArr.get("FLT009410")+'</OPTION>');
	write('<OPTION VALUE="11">'+jspResArr.get("FLT009411")+'</OPTION>');
	write('<OPTION VALUE="12">'+jspResArr.get("FLT009412")+'</OPTION>');
	write('<OPTION VALUE="13">'+jspResArr.get("FLT009413")+'</OPTION>');
	write('<OPTION VALUE="14">'+jspResArr.get("FLT009414")+'</OPTION>');
	write('<OPTION VALUE="15">'+jspResArr.get("FLT009415")+'</OPTION>');
	write('<OPTION VALUE="16">'+jspResArr.get("FLT009709")+'</OPTION>');
	write('<OPTION VALUE="17">'+jspResArr.get("FLT009710")+'</OPTION>');
	write('<OPTION VALUE="18">'+jspResArr.get("FLT009711")+'</OPTION>');
	write('<OPTION VALUE="19">'+jspResArr.get("FLT009712")+'</OPTION>');
	write('<OPTION VALUE="20">'+jspResArr.get("FLT004108")+'</OPTION>');
	write('<OPTION VALUE="21">'+jspResArr.get("FLT004114")+'</OPTION>');
	write('<OPTION VALUE="22">'+jspResArr.get("FLT009713")+'</OPTION>');
	write('<OPTION VALUE="23">'+jspResArr.get("FLT009714")+'</OPTION>');
	write('<OPTION VALUE="24">'+jspResArr.get("FLT009715")+'</OPTION>');
	write('<OPTION VALUE="25">'+jspResArr.get("FLT009716")+'</OPTION>');
	write('<OPTION VALUE="26">'+jspResArr.get("FLT009717")+'</OPTION>');
	write('<OPTION VALUE="27">'+jspResArr.get("FLT009718")+'</OPTION>');
	write('<OPTION VALUE="28">'+jspResArr.get("FLT009719")+'</OPTION>');
	write('<OPTION VALUE="29">'+jspResArr.get("FLT009720")+'</OPTION>');
	write('<OPTION VALUE="30">'+jspResArr.get("FLT004115")+'</OPTION>');
	write('<OPTION VALUE="31">'+jspResArr.get("FLT009721")+'</OPTION>');
	}
}

function writeNewActionHoliday(){
	with(document) {
	write('<OPTION VALUE="">'+jspResArr.get("FLT012689")+'</OPTION>');
	write('<OPTION VALUE="N">'+jspResArr.get("FLT012721")+'</OPTION>');
	write('<OPTION VALUE="P">'+jspResArr.get("FLT012845")+'</OPTION>');
	write('<OPTION VALUE="S">'+jspResArr.get("FLT013007")+'</OPTION>');
	write('<OPTION VALUE="E">'+jspResArr.get("FLT019024")+'</OPTION>');
	}
}

function writeNewActionHoliday(){
	with(document) {
	write('<OPTION VALUE="">'+jspResArr.get("FLT012689")+'</OPTION>');
	write('<OPTION VALUE="N">'+jspResArr.get("FLT012721")+'</OPTION>');
	write('<OPTION VALUE="P">'+jspResArr.get("FLT012845")+'</OPTION>');
	write('<OPTION VALUE="S">'+jspResArr.get("FLT013007")+'</OPTION>');
	write('<OPTION VALUE="E">'+jspResArr.get("FLT019024")+'</OPTION>');
	}
}

function writeFrequencyCalendarBase(){
	with(document) {
	write('<OPTION VALUE="">'+jspResArr.get("FLT012410")+'</OPTION>');
	write('<OPTION VALUE="00">'+jspResArr.get("FLT019695")+'</OPTION>');
	write('<OPTION VALUE="01">'+jspResArr.get("FLT019696")+'</OPTION>');
	}
}
