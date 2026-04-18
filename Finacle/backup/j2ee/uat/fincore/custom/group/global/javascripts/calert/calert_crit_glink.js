function printBlock()
{
	writeCustomHeader("calert_crit");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	//write('<td class="page-heading">' + jspResArr.get("FLT031877") + '</td>');
	write('<td class="page-heading">'+menuTitle+'</td>');
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
	write('<td class="textlabel" style="height: 25px">' + jspResArr.get("FLT006657") + '</td>');
	write('<td class="textfield">');
	write('<select name="' + subGroupName + '.funcCode" id="funcCode" style="width: 218px" onchange="javascript:return funcCodeOnchange();" fdt="String" ' + calertProps.get("funcCode_ENABLED") + '>');
	write('<option value="">' + jspResArr.get("FLT031311") + '</option>');
	write('<option value="R">' + jspResArr.get("FLT012900") + '</option>');
	write('<option value="M">' + jspResArr.get("FLT012350") + '</option>');
	write('<option value="V">' + jspResArr.get("FLT013170") + '</option>');
	write('<option value="X">' + jspResArr.get("FLT033219") + '</option>');
	write('<option value="I">' + jspResArr.get("FLT034011") + '</option>');
	write('</select>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfield"> </td>');
	write('</tr>');

	write('<tr>');
        write('<td class="textlabel">' + jspResArr.get("FLT031874") + ' </td>');
        //write('<td class="textlabel">' + jspResArr.get("FLT031874") + '<script>setMandatory("Y");</script></td>');
        write('<td class="textfield">');
        write('<input  class="textfieldfont" type="text" disabled name="' + subGroupName + '.cifId" id="cifId" ' + calertProps.get("cifId_ENABLED") + ' maxlength="16" size="25">');
        //write('&nbsp; <a target="_self" href="javascript:fnShowCifIDList()" id="sLnk3">');
        //write('<img hotKeyId="search1" src="../Renderer/images/INFENG/search_icon.gif" border="0" name="ImgCustId">');
        //write('</a>');
        write('</td>');
        write('</tr>');
///rec2
        write('<tr>');
        write('<td class="textlabel">' + jspResArr.get("FLT031859") + '<script>setMandatory("Y");</script></td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.accNo" id="accNo" ' + calertProps.get("accNo_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldfont" size="24" maxlength="16" onChange="javascript:return calert_det_ONCHANGE1(this);">&nbsp;');
        write('&nbsp;<a id="drAcctNumImg" href="javascript:getAcctIdList1()">');
        write('<img border="0" alt="Search List" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        write('</a>&nbsp;');
        write('<a id="customExplode1"  target="_self" href="JavaScript:fnExplodeBalanceDetails(document.forms[0].accNo)">');
        write('<img class="img" onmouseover="this.style.cursor=\'hand\';"  onmouseout=" this.style.cursor=\'default\';" src="../Renderer/images/'+applangcode+'/explode.gif" width="16" height="16" border="0" alt="Balance Details" width="24" height="20" onClick=""></img>');
        write('</a>');
        write('&nbsp;<a id="drAcctNumSigImg" href="javascript:showFinacleSignature();">');
        write('<img src="../Renderer/images/' + applangcode + '/sig_new1.gif" alt="' + jspResArr.get("FLT000716") + '" width="16" height="16" border="0"></a>');
        write('</td>');
        write('<td class="textlabel">');
        write('<input name="' + subGroupName + '.drAcctNumEntityId" id="drAcctNumEntityId" ' + calertProps.get("drAcctNumEntityId_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="4" maxlength="8" >&nbsp;');
        write('<input name="' + subGroupName + '.drAcctNumSolId" id="drAcctNumSolId" ' + calertProps.get("drAcctNumSolId_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="4" maxlength="8" >&nbsp;');
        write('<input name="' + subGroupName + '.drAcctNumCcy" id="drAcctNumCcy" ' + calertProps.get("drAcctNumCcy_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="2" maxlength="3" >');
        write('</td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.drAcctName" id="drAcctName" ' + calertProps.get("drAcctName_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="40" maxlength="80" >');
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
	write('<input id="Accept" name="Go" type="button" class="button"	onClick="javascript:return calert_crit_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT004977") + '" hotKeyId="Go">');
	write('<input id="Clear" name="Clear" type="button" class="button" value="' + jspResArr.get("FLT001439") + '"	onClick="javascript:return calert_crit_ONCLICK2(this);"">');
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad(){
	var ObjForm = document.forms[0];
	document.forms[0].funcCode.focus();
	if((document.forms[0].funcCode.value == "R") || (document.forms[0].funcCode.value == "")){
		hideImage("sLnk5");
		showImage("sLnk4");
		hideImage("sLnk6");
		showImage("sLnk2");
	}else{
		hideImage("sLnk4");
		showImage("sLnk5");
		hideImage("sLnk2");
		showImage("sLnk6");
	}

	initFocusHandler();

	pre_ONLOAD('calert_crit',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}
	post_ONLOAD('calert_crit',this);
}
function fnCheckMandatoryFields(){
	var ObjForm = document.forms[0];
	return true;
}
function fnPopulateControlValues(){
	var ObjForm = document.forms[0];
	ObjForm.funcCode.value = funcCode;
	ObjForm.cifId.value = cifId;
	ObjForm.accNo.value = accNo;
	ObjForm.acctName.value = acctName;
}
function calert_crit_ONCLICK1(obj,p1){
	var retVal = "";
	if (preEventCall('calert_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('calert_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
function calert_crit_ONCLICK2(obj){
	var retVal = "";
	if (preEventCall('calert_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnClearFields()) == false) {
		return false;
	}
	if (postEventCall('calert_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
function calert_crit_ONCHANGE11(g, h, f, d, c, b, a) {
    var e = "";
    if (preEventCall("calert_crit", g, "ONCHANGE") == false) {
        return false
    }
    if (preEventCallForLocale("calert_crit", g, "ONCHANGE") == false) {
        return false
    }
    if ((e = fnCommonFetchAcctDtls(h, f, d, c, b, a)) == false) {
        return false
    }
    if (postEventCallForLocale("calert_crit", g, "ONCHANGE") == false) {
        return false
    }
    if (postEventCall("calert_crit", g, "ONCHANGE") == false) {
        return false
    }
    return (e == undefined) ? true : e
}
function custom_cifId(){
        showCustId(document.forms[0].cifId,'ctrl','F',document.forms[0].cifName);
}
function fnShowCifIDList(funcCode){
   var url = "../arjspmorph/"+applangcode+"/get_cust_id.jsp?wReturn="+document.forms[0].cifId.id+"&wReturnDesc=NULL&preceedence=F&selVerifiedFlg=N";
        if ("Microsoft Internet Explorer" == browser_name){
            var retVal = popModalWindowVar(url,"cifId",55,35,55,32);
            if (retVal != null && retVal != undefined ){
                var liarrBufArray = retVal.split("|");
                document.forms[0].cifId.value = liarrBufArray[0];
            }
        }else{
            popModalWindowMozillaFrame(url,"CifId");
        }
}
function calert_det_ONCHANGE1(obj){
        var retVal = "";
        if (preEventCall('calert_det',obj,'ONCHANGE') == false) {
                return false;
        }
        if ((retVal = fnGetDrAcctDetails()) == false) {
                return false;
        }
        if (postEventCall('calert_det',obj,'ONCHANGE') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}
function fnGetDrAcctDetails(){
        var ObjForm = document.forms[0];
        var drAcctNum = ObjForm.accNo.value;
        if(!fnIsNull(drAcctNum)){
                fnGetAcctDetails1();
        }else{
                fnClearAcctDetails1();
        }
        return true;
}
function fnGetAcctDetails1(){
        var ObjForm = document.forms[0];
        fnEnableAcctDetails1();
        var drAcctNum = ObjForm.accNo.value;
        var inputNameValues = "acctNum|"+drAcctNum;
        var outputNames = "errorFlg|errorMsg|acctNumEntityId|acctNumSolId|acctNumCcy|acctName|acctNum|cifIdForSig";
        var scriptName = "ebAlertAcctGet.scr"
        var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
        var token = retVal.split("|");
        if(token != undefined){
                var errorFlg = token[1];
                var errorMsg = token[3];
                var drAcctNumEntityId = token[5];
                var drAcctNumSolId = token[7];
                var drAcctNumCcy = token[9];
                var drAcctName = token[11];
                var drAcctNum = token[13];
                var drCifId = token[15];
                if(errorFlg == "Y"){
                        alert(errorMsg);
                        fnClearAcctDetails1();
                        setFieldFocus(ObjForm.drAcctNum);
                        return false;

                }else{
                        ObjForm.drAcctNumEntityId.value = drAcctNumEntityId;
                        ObjForm.drAcctNumSolId.value = drAcctNumSolId;
                        ObjForm.drAcctNumCcy.value = drAcctNumCcy;
                        ObjForm.drAcctName.value = drAcctName;
                        ObjForm.accNo.value = drAcctNum;
                        ObjForm.cifId.value = drCifId;

                }
        }
        return true;
}
function fnClearAcctDetails1(){
        var ObjForm = document.forms[0];
        ObjForm.drAcctNumEntityId.value = "";
        ObjForm.drAcctNumSolId.value = "";
        ObjForm.drAcctNumCcy.value = "";
        ObjForm.drAcctName.value = "";
}
function getAcctIdList1() {
        var ObjForm = document.forms[0];
        showAccountIdList(ObjForm.accNo,null,null,'F');
        var drAcctNum = ObjForm.accNo.value;
        if(!fnIsNull(drAcctNum)){
                fnGetAcctDetails1();
        }
}
function fnEnableAcctDetails1(){
        var ObjForm = document.forms[0];
        ObjForm.drAcctNumEntityId.disabled = false;
        ObjForm.drAcctNumSolId.disabled = false;
        ObjForm.drAcctNumCcy.disabled = false;
        ObjForm.drAcctName.disabled = false;
}

function fnDisableAcctDetails1(){
        var ObjForm = document.forms[0];
        ObjForm.drAcctNumEntityId.disabled = true;
        ObjForm.drAcctNumSolId.disabled = true;
        ObjForm.drAcctNumCcy.disabled = true;
        ObjForm.drAcctName.disabled = true;
}

