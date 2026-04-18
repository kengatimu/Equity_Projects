function printBlock()
{
	writeCustomHeader("cchqi_det");
	with (document){
	write('<input type="hidden" id="reqdate" fdt="fdate" mneb1="N" fmnd="Y"  vFldId="reqdate_ui" name="' + subGroupName + '.reqdate">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">CHEQUE BOOK INQUIRY MENU</td>');
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
	write('<a href="javascript:showHelpFile(\'cchqi_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026332") +'</td>');
	write('<td><input hotKeyId="search1" name="' + subGroupName + '.solID" id="solID"  type="text" class="textfieldfont" size="25" maxlength="16">');
	write('<a target=_self href="javascript:fnCustSearcher(); " id="solIdList">');
	write('<img id="benfList1" width="16" height="17" border="0"  hotKeyId="search1" src="../Renderer/images/search_icon.gif"></img></a>');
	write('<input name="' + subGroupName + '.solIdDesc" id="solIdDesc"  type="text" class="label" size="25" maxlength="16">');
	write('</td>');
	write('</tr>');		
	write('<tr>');
	write('<td class="textlabel">Date<font color="red" size="2"> *</font></td>');
	write('<td><input hotKeyId="calender1" fdt="uidate" fmnd="Y"  mnebl="false" name="' + subGroupName + '.reqdate_ui" id="reqdate_ui"  type="text" class="textfieldfont" size="25" maxlength="16">');
	write('<a id="dateImg" href="javascript:openDate(document.forms[0].reqdate_ui,BODDate)">');
    write('<img width="24" height="19" src="../images/INFENG/calender.gif" align="absmiddle" border="0" alt="Date picker" style="cursor:hand"></a>');
	write('</td>');
	write('</tr>');	
    write('<tr>');
    write('<td class="textlabel">' + jspResArr.get("FLT026333") +'<font color=red size=2>*</font></td>');
    write('<td><input hotKeyId="search2" name="' + subGroupName + '.foracid" id="foracid" ' + cchqiProps.get("foracid_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16"  onchange="javascript:fnOnchange();">');
    write('<a target=_self href="javascript:fnshowAccountIdList(document.forms[0].foracid);" id="foracid">');
    write('<img id="benfList1" width="16" height="17" border="0"  hotKeyId="search2" src="../Renderer/images/search_icon.gif"></img></a>');
    write('</td>');
    write('<td>&nbsp;</td>');
    write('<td>&nbsp;</td>');
    write('<td>&nbsp;</td>');
    write('</tr>');
	
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026334") + '</td>');
	write('<td><select  name="' + subGroupName + '.status" id="status" ' + cchqiProps.get("status_ENABLED") + ' class="textfieldfont" >');
	write('<option value=""selected>' + jspResArr.get("FLT000005") + '</option>');
        write('<option value="E">' + jspResArr.get("FLT000006") + '</option>');
        write('<option value="A">' + jspResArr.get("FLT000007") + '</option>');
        write('<option value="D">' + jspResArr.get("FLT000008") + '</option>');
        write('<option value="S">' + jspResArr.get("FLT000009") + '</option>');
        write('</select>');
	write('</td>');
	write('</tr>');

	write('<tr>');
	//write('<td> Press <Submit> to download the Cheque Book Request for the day </td>');
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
	write('<input name="Submit" type="button" class="button" onClick="javascript:return cchqi_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	write('<input name="Clear" type="button" class="button" onClick="javascript:return cchqi_det_ONCLICK2(this);" id="Clear" value="Clear">');
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

	pre_ONLOAD('cchqi_det',this);

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


//	fnPostOnLoad()
	post_ONLOAD('cchqi_det',this);
}
function fnOnchange() {
	var inputNameValues = "acctNum|"+document.forms[0].foracid.value;
        var outputNames     = "";
        var scrName         = "formatacctdp001.scr";
        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret1 = retVal.split("|");
        if(ret1[0] == "MSG" )
        {
                alert(ret1[1]);
        }

        var foracid = document.forms[0].foracid.value.toUpperCase();
        inputNameValues             = "acctNum|"+foracid
        outputNames                 = ""
        scrName                             = "cichqidp002.scr";
        retVal                              = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        ret                                 = retVal.split("|");
        var msg                                 = ret[0];
        if(msg == "RESULT_MSG"){
                alert(ret[1]);
                document.forms[0].foracid.focus();
                document.forms[0].foracid.value = ""
                return false;
        }
}

function fnValidateData()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];
	ObjForm.solID.value = headCtxSol;
	ObjForm.reqdate_ui.value = reqdate_ui;
	ObjForm.reqdate.value = reqdate;
	ObjForm.foracid.value = foracid;
	ObjForm.status.value = status;
}


function cchqi_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (pre_ONCLICK('cchqi_det',obj) == false) { 
	return false;
	}
	
	if(fnIsNull(document.forms[0].solID.value)) {
        alert("Enter the SolID");
        document.forms[0].solID.focus();
        return false;
    }


	
	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}

	if (post_ONCLICK('cchqi_det',obj) == false) { 
	return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cchqi_det_ONCLICK2(obj)
{
	var retVal = "";
	if (pre_ONCLICK('cchqi_det',obj) == false) { 
		return false;
	}
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (post_ONCLICK('cchqi_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function fnshowAccountIdList(obj){
    showAccountIdList(obj,null,null,'F');
        fnOnchange();
}


function fnCustSearcher() {
	showSolId(document.forms[0].solID,'ctrl','F',document.forms[0].solIdDesc);
}
