function printBlock()
{
    writeCustomHeader("cicrm_crit");
    with (document){
    write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
    write('<tr>');
    write('<td>');
    write('<table border="0" cellspacing="0" cellpadding="0">');
    write('<tr>');
    write('<td class="page-heading">Inward Clearing Instrument Reject Menu</td>');
    write('</tr>');
    write('</table>');
    write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
    write('<tr>');
    write('<td valign="top">');
    write('<table width="100%" border="0" cellpadding="0" cellspacing="0">');
    write('<tr>');
    write('<td class="activetab3" width="100%"></td>');
    write('</tr>');
    write('</table>');
    write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">');
    write('<tr>');
    write('<td>');
    write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
    write('<tr>');
    write('<td>');
    write('<table width="100%" border="0" cellspacing="0" cellpadding="0" class="innertabletop">');
    write('<tr>');
    write('<a href="javascript:showHelpFile(\'cicrm_crit_help.htm\');" id="sLnk1">');
    write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
    write('</tr>');
    write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026332") + '<font color="red" size="2"> *</font></td>');
	//write('<td><select name="' + subGroupName + '.funcCode" id="funcCode" ' + cicrmProps.get("funcCode_ENABLED") + ' class="textfieldfont" " onchange="javascript:fnDisableFields(this)">');
	write('<td><select name="' + subGroupName + '.funcCode" id="funcCode" ' + cicrmProps.get("funcCode_ENABLED") + ' class="textfieldfont" >');
	write('<option value="" selected>' + jspResArr.get("FLT026333") + '</option>');
	write('<option value="R">' + jspResArr.get("FLT026334") + '</option>');
	write('</select>');
	write('</td>');
	write('</tr>');

 write('<tr>');
    write('<td class="textlabel">' + jspResArr.get("FLT026337") + '</td>');
    write('<td><input name="' + subGroupName + '.foracid" id="foracid" ' + cicrmProps.get("foracid_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16">');
	write('<a href="javascript:fnshowAccountIdList(document.forms[0].foracid);" id="sLnk2" >');
	write('<img hotKeyId="search1" src="../Renderer/images/search_icon.gif" width="16" height="17" border="0"></img>');
	write('</td>');
    write('</tr>');

    write('<tr>');
    write('<td class="textlabel">' + jspResArr.get("FLT026338") + '</td>');
    write('<td><input name="' + subGroupName + '.instNo" id="instNo" ' + cicrmProps.get("instNo_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16">');
	write('</td>');
    write('</tr>');
    write('<tr>');
    write('<td class="textlabel">' + jspResArr.get("FLT026339") + '</td>');
    write('<td><input name="' + subGroupName + '.instAmt" id="instAmt" ' + cicrmProps.get("instAmt_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16">');
	write('</td>');
    write('</tr>');
    write('</table></td>');
    write('</tr>');
    write('</table></td>');
    write('</tr>');
    write('</table></td>');
    write('</tr>');
    write('</table></td>');
    write('</tr>');
    write('</table>');
    } 
}
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
	write('<input type="button" name="Accept" value="Go" class="button" id="Accept" onClick="javascript:return cicrm_crit_ONCLICK1(this,this);" hotKeyId="Go">');
	write('<input type="button" name="Clear" value="Clear" class="button" id="Clear" onClick="javascript:return cicrm_crit_ONCLICK2(this);">');
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
    var ObjForm = document.forms[0];

    pre_ONLOAD('cicrm_crit',this);

    var funcName = "this."+"locfnOnLoad";
    if(eval(funcName) != undefined){
    eval(funcName).call(this);
    }

    fnPopulateControlValues();

    //if(funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='U' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
     //   fnDisableFormControls(ObjForm);
    //}
    fnPopUpExceptionWindow(ObjForm.actionCode);
    if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
        checkCustErrExecNextStep(Message);
    }
    //fnPostOnLoad()
    post_ONLOAD('cicrm_crit',this);
}

function fnValidateData()
{
    var ObjForm = document.forms[0];
    return true;
}

function fnPopulateControlValues() 
{
    var ObjForm = document.forms[0];
	ObjForm.instAmt.value=instAmt;
	ObjForm.foracid.value = foracid;
	ObjForm.instNo.value = instNo;
	ObjForm.funcCode.value = funcCode;

}


function cicrm_crit_ONCLICK1(obj,p1)
{
    var retVal = "";
	if(fnIsNull(document.forms[0].funcCode.value)) {
	alert("Enter the Function Code");
	document.forms[0].funcCode.focus();
	return false;
	}
	if(fnIsNull(document.forms[0].foracid.value)) {
	alert("Account Number Should be entered");
	document.forms[0].foracid.focus();
	return false;
	}
    if(fnIsNull(document.forms[0].instNo.value)) {
	alert("Instrument Number Should be entered");
	document.forms[0].instNo.focus();
	return false;
	}
    if(fnIsNull(document.forms[0].instAmt.value)) {
	alert("Instrument Amount Should be entered");
	document.forms[0].instAmt.focus();
	return false;
    }
    if(isNaN(document.forms[0].instAmt.value)) {
	alert("Enter valid Instrument Amount");
	document.forms[0].instAmt.focus();
	return false;
	}
	if (pre_ONCLICK('cicrm_crit',obj) == false) { 
        return false;
    }
    if ((retVal = fnValAndSubmit(p1)) == false) {
        return false;
    }
    if (post_ONCLICK('cicrm_crit',obj) == false) { 
        return false;
    }
    return (retVal == undefined) ? true : retVal;
}

function cicrm_crit_ONCLICK2(obj)
{
    var retVal = "";
    
    if (pre_ONCLICK('cicrm_crit',obj) == false) { 
        return false;
    }
   
    if ((retVal = fnClearFields()) == false) {
        return false;
    }
  
    if (post_ONCLICK('cicrm_crit',obj) == false) { 
        return false;
    }
    
    return (retVal == undefined) ? true : retVal;
 }



function fnshowAccountIdList(obj){

        showAccountIdList(obj,null,null,'F');
}
function fnOnchange() {
        var foracid = document.forms[0].foracid.value.toUpperCase();
        var inputNameValues             = "acctNum|"+foracid
        var outputNames                 = ""
        var scrName                             = "cecsmimn01.scr";
        var retVal                              = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret                                 = retVal.split("|");
        var msg                                 = ret[0];
        if(msg == "RESULT_MSG"){
                alert(ret[1]);
                document.forms[0].foracid.value = ""
                return false;
        }
}

