function printBlock()
{
	writeCustomHeader("cslnpp_det");
	document.write('<input type="hidden" id="salDate" fdt="fdate" fmnd="Y"  mneb1="N" vFldId="salDate_ui" name="' + subGroupName + '.salDate">');
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">STAFF LOAN RECOVERIES PRE-PROCESSOR</td>');
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
	write('<a href="javascript:showHelpFile(\'cslnpp_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026332") +'<font color=red size=2>*</font></td>');
	write('<td class="textfield"><select name="' + subGroupName + '.funcCode" id="funcCode" class="listboxfont">');
	write('<option value="" >' + jspResArr.get("FLT026341") + '</option>');
    write('<option value="P" selected>' + jspResArr.get("FLT026342") + '</option>');
    write('</select>');
    write('</td>');
    write('<td>&nbsp;</td>');
    write('<td>&nbsp;</td>');
    write('<td>&nbsp;</td>');
	write('</tr>');
	write('<tr>');	
	write('<td class="textlabel">' + jspResArr.get("FLT026333") +'<font color=red size=2>*</font></td>');
	write('<td><input name="' + subGroupName + '.setId" id="setId" ' + cslnppProps.get("setId_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" disabled="true" >');

//	write('<a target=_self id="sLnk1" href="javascript:showSetList(document.forms[0].setId,\'ctrl\',\'F\',\' \' )"><img class="img" src="../Renderer/images/'+ applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search9"></img></a>');
	write('<br>');	
	write('</td>');
    write('<td>&nbsp;</td>');
    write('<td>&nbsp;</td>');
    write('<td>&nbsp;</td>');
	write('</tr>');		
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026334") +'<font color=red size=2>*</font></td>');
	write('<td><input type="text" class="textfieldfont" id="salDate_ui" name="' + subGroupName + '.salDate_ui" fdt="uidate" mnebl="false" fmnd="Y"  fblk="defaultFblk1" hotKeyId="calender1" onBlur = "javascript:validateDateOnBlur(this,this,this);" disabled="true">');
//	write('<a id="salDateImg" href="javascript:openDate(document.forms[0].salDate_ui,BODDate)">');
//	write('<img width="24" height="19" src="../images/INFENG/calender.gif" align="absmiddle" border="0" alt="Date picker" style="cursor:hand"></a>');
	write('<div style="position:absolute;"></div>');
	write('</td>');
    write('<td>&nbsp;</td>');
    write('<td>&nbsp;</td>');
    write('<td>&nbsp;</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026335") +'<font color=red size=2>*</font></td>');
	write('<td><input name="' + subGroupName + '.remrks" id="remrks" ' + cslnppProps.get("remrks_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16">');
	write('</td>');
    write('<td>&nbsp;</td>');
    write('<td>&nbsp;</td>');
    write('<td>&nbsp;</td>');
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
	if(funcCode =='P'){
	write('<div class="ctable">');
	write('<input name="Submit" type="button" class="button" onClick="javascript:return cslnpp_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	write('<input name="Clear" type="button" class="button" onClick="javascript:return cslnpp_det_ONCLICK2(this);" id="Clear" value="Clear">');
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

	pre_ONLOAD('cslnpp_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	if(funcCode !='P' || sReferralMode =='I' || sReferralMode =='S'){
		fnDisableFormControls(ObjForm);
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}


//	fnPostOnLoad()
	post_ONLOAD('cslnpp_det',this);

}

function fnValidateData()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];
	ObjForm.setId.value = headCtxSol;
	ObjForm.salDate_ui.value = BODDate;
	ObjForm.salDate.value  = BODDate;
	
	ObjForm.remrks.value = remrks;
}


function cslnpp_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (pre_ONCLICK('cslnpp_det',obj) == false) { 
		return false;
	}
	if(fnIsNull(document.forms[0].funcCode.value)){
		alert("Enter the Function Code");
		document.forms[0].funcCode.focus();
		return false;

	}
	
	if(fnIsNull(document.forms[0].setId.value)) {
                alert("Enter Set Id ");
                document.forms[0].setId.focus();
                return false;
    }


	if(fnIsNull(document.forms[0].remrks.value)) {
		alert("Enter the valid Reamarks");
		document.forms[0].remrks.focus();
		return false;
	}
	
	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}
	
		var frm = document.forms[0];
       frm.actionCode.value = "Submit";
       enableFormElements();
      // hGideAnchors();
       disableButtons();
       frm.submit();


	if (post_ONCLICK('cslnpp_det',obj) == false) { 
	return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cslnpp_det_ONCLICK2(obj)
{
	var retVal = "";
	if (pre_ONCLICK('cslnpp_det',obj) == false) { 
		return false;
	}
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (post_ONCLICK('cslnpp_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function validateDateOnBlur(obj,p1,p2)
{
    var retVal = "";

    if ((retVal = onBlurFormatDate(p1)) == false) {
        return false;
    }
    if ((retVal = fnAssignDateOnEnter(p2)) == false) {
        return false;
    }

    return (retVal == undefined) ? true : retVal;
}

