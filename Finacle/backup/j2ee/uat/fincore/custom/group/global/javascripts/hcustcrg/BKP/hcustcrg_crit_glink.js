function printBlock()
{
	writeCustomHeader("hcustcrg_crit");
	with (document){
	//write('<input type="hidden" name="' + subGroupName + '.funcCode" id="funcCode" value="A">');
	write('<input type="hidden" name="' + subGroupName + '.funcCodeDesc" id="funcCodeDesc" value="A">');
	//write('<input type="hidden" name="' + subGroupName + '.nextPage" id="nextPage" >');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT031836") + '</td>');
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
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21" vspace="1" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	//----------------------------------------
	//--FUNCTION CODE
	//----------------------------------------
	write('<tr id="funcCodetr">');
	write('<td class="textlabel" style="height: 25px">' + jspResArr.get("FLT027516") + '<script>setMandatory("Y");</script>' + '</td>');
	write('<td class="textfield">');
	write('<select name="' + subGroupName + '.funcCode" id="funcCode" fmnd="Y" onchange="javascript:return hcustcrg_funcCode_ONCHANGE();" fdt="String" ' + hcustcrgProps.get("funcCode_ENABLED") + ' style="width: 218px">');
	write('<option value="">' + jspResArr.get("FLT034343") + '</option>');
	write('<option value="A">' + jspResArr.get("FLT031840") + '</option>');
	write('<option value="I">' + jspResArr.get("FLT031841") + '</option>');
	write('<option value="M">' + jspResArr.get("FLT031842") + '</option>');
	write('<option value="V">' + jspResArr.get("FLT031843") + '</option>');
	write('<option value="X">' + jspResArr.get("FLT031844") + '</option>');
	write('</select>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textlabel"> </td>');
	write('</td>');
	write('</tr>');
	//----------------------------------------
        //--TYPE
        //----------------------------------------
	write('<tr id="Leveltr">');
	write('<td class="textlabel" style="height: 25px">' + jspResArr.get("FLT007514") + '<script>setMandatory("Y");</script>' + '</td>');
	write('<td class="textfield">');
	write('<select name="' + subGroupName + '.Level" id="Level"  fdt="String" fmnd="Y" ' + hcustcrgProps.get("pymtLevel_ENABLED") + ' onchange="javascript:return Levelchng(this);" style="width: 218px">');
	write('<option value="">' + jspResArr.get("FLT034343") + '</option>');
	write('<option value="C">' + jspResArr.get("FLT017004") + '</option>');
	write('<option value="A">' + jspResArr.get("FLT017005") + '</option>');
	write('<option value="AG">' + jspResArr.get("FLT013004") + '</option>');
	write('</select>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textlabel"> </td>');
	write('</tr>');
	
	//----------------------------------------
        //--CIFID
        //----------------------------------------
	write('<tr id="cifIdtr">');
	write('<td class="textlabel" id="cif" style="height: 25px">' + jspResArr.get("FLT004978") + '<script>setMandatory("N");</script>' + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.cifId" maxlength="15" id="cifId" fmnd="N" fdt="String" onChange="javascript:return hcustcrg_crit_ONCHANGE11(this,\'myframe\',\'CIFID\',\'F\',\'cifId\',\'custName\');"  ' + hcustcrgProps.get("cifId_ENABLED") + '>');
	write('&nbsp;<a target=_self id="sLnk2" href="javascript:showcustid()"><img class="img" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16" height="17" border="0" hotKeyId="search1"></img></a>');
	write('<input class="label" name="'+ subGroupName +'.custName" id="custName"  size=40 maxlength=50 readonly tabindex=-1 disabled>');
	write('</td>');
	write('</tr>');

	//----------------------------------------
        //--ACCT NO
        //----------------------------------------
	write('<tr id="acctnotr">');
	write('<td class="textlabel" id="acct">' + jspResArr.get("FLT004979") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.acctNum" id="acctNum"  onchange="javascript:return hcustcrg_crit_ONCHANGE1(this,this,\'acctDesc\',\'solId\',\'CrncyCode\',true,\'VALACCTID\');" fdt="String" ' + hcustcrgProps.get("acctNum_ENABLED") + '>');
	write('&nbsp;<a target="_self" id="sLnk3" href="JavaScript:showAcct()">');
	write('<IMG src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16" height="17" border=0 hotKeyId="search1"></img></a>&nbsp;');
	write('<input class="label" id="CrncyCode" name="'+subGroupName+'.CrncyCode" fds="Y" size="4" maxlength="3" disabled>');
	write('<input class="label" id="solId" name="'+subGroupName+'.solId" fds="Y" size="5" maxlength="4" disabled>');
	write('<input class="label" id="acctDesc" name="'+subGroupName+'.acctDesc" size="50" border="0" maxlength=30 fds="Y" disabled>');
	write('</td>');
	write('</tr>');

	//----------------------------------------
        //--AGREEMENT
        //----------------------------------------

	write('<tr id="agreemnttr">');
	write('<td class="textlabel" style="height: 15px" >' + jspResArr.get("FLT004980") + ' <script>setMandatory("true")</script>');
	write('</td>');
	write('<td class="textfield" >');
	write('<input name="' + subGroupName + '.EmpId" id="EmpId" onChange="javascript:return fnEmpchange();" type="text" class="textfieldfont" size="25" maxlength="75">');
	write('&nbsp;<a id="sLnk5" href="javascript:staffIdSearcher();">');
	write('<img border="0" height="17" hotKeyId="search4" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('<input class="label" id="SolID" name="' + subGroupName + '.SolID" fds="Y" size="20" maxlength="50" disabled>');
	write('<input class="label" id="EmpName"  name="' + subGroupName + '.EmpName" fds="Y" size="20" maxlength="50" disabled>');
	write('</td>');
	write('</tr>');
	
	
	write('<tr>');
	write('<input type="hidden" name="nextPage" id="nextPage">');
	write('</td>');
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
	write('<input id="Accept" name="Go" type="button" class="button"	onClick="javascript:return hcustcrg_crit_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT004977") + '" hotKeyId="Go">');
        write('<input id="Clear" name="Clear" type="button" class="button" value="' + jspResArr.get("FLT001439") + '"   onClick="javascript:return hcustcrg_crit_ONCLICK3(this);">');

	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{	
	initFocusHandler();
	var ObjForm = document.forms[0];
	pre_ONLOAD('hcustcrg_crit',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();
	document.getElementById('acctnotr').style.display = "none";
	document.getElementById('cifIdtr').style.display = "none";
	document.getElementById('agreemnttr').style.display = "none";
	ObjForm.funcCode.focus();
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

        Levelchng(ObjForm.Level);

	post_ONLOAD('hcustcrg_crit',this);
	
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
	ObjForm.Level.value = Level;
        ObjForm.cifId.value =cifId;
        ObjForm.acctNum.value =acctNum;
        ObjForm.EmpId.value =EmpId;  
	
}


function hcustcrg_crit_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (preEventCall('hcustcrg_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('hcustcrg_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
function hcustcrg_crit_ONCLICK3(obj)
{
        var retVal = "";
        if (preEventCall('hcustcrg_crit',obj,'ONCLICK') == false) {
                return false;
        }
        if ((retVal =  fnClearFields()) == false) {
                return false;
        }
        if (postEventCall('hcustcrg_crit',obj,'ONCLICK') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function hcustcrg_crit_ONCLICK2(obj)
{
	var retVal = "";
	if (preEventCall('hcustcrg_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnClearFields()) == false) {
		return false;
	}
	if (postEventCall('hcustcrg_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hcustcrg_funcCode_ONCHANGE()
{
	if (document.forms[0].funcCode.value !="")
	{
		document.forms[0].Level.value="";
                document.forms[0].cifId.value="";
                document.forms[0].acctNum.value="";
                document.forms[0].EmpId.value="";     	
	}


}
function hcustcrg_siRefNum_ONCHANGE()
{
	//alert(document.forms[0].siRefNum.value);
	
	printdepBlock();	
	return true;
}

function hcustcrg_crit_ONCHANGE1(g,h,f,d,c,b,a)
{
	var retVal = "";
	if(preEventCall("hcustcrg_crit",g,"ONCHANGE")==false){
		return false;
	}
	if((retVal=fnCommonFetchAcctDtls(h,f,d,c,b,a))==false){
		document.forms[0].acctNum.value="";
		document.forms[0].acctNum.facus();
		return false;
	}
	if(postEventCall("hcustcrg_crit",g,"ONCHANGE")==false){
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}


function hcustcrg_crit_ONCHANGE11(f,g,e,c,b,a) {
    var d = "";
    if (preEventCall("hcustcrg_crit", f, "ONCHANGE") == false) {
        return false
    }
    if (preEventCallForLocale("hcustcrg_crit", f, "ONCHANGE") == false) {
        return false
    }
	if((d=sendDataToServer(g,e,c,b,a))==false){
		document.forms[0].cifId.value="";
		document.forms[0].cifId.facus();
		return false
	}
    if (postEventCallForLocale("hcustcrg_crit", f, "ONCHANGE") == false) {
        return false
    }
    if (postEventCall("hcustcrg_crit", f, "ONCHANGE") == false) {
        return false
    }
    return (d == undefined) ? true : d;
}

