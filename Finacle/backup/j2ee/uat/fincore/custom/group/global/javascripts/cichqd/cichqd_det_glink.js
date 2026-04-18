function printBlock()
{
	writeCustomHeader("cichqd_det");
        document.write('<input type="hidden" id="frmDate" fdt="fdate" fmnd="Y"  mneb1="N" vFldId="frmDate_ui" name="' + subGroupName + '.frmDate">');
        document.write('<input type="hidden" id="toDate" fdt="fdate" fmnd="Y"  mneb1="N" vFldId="toDate_ui" name="' + subGroupName + '.toDate">');
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">Inhouse Cheque Book Request Maintenance</td>');
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
	write('<a href="javascript:showHelpFile(\'cichqd_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026332") + '<font color=red size=2>*</font></td>');
	write('<td><input type="text" class="textfieldfont" id="frmdate_ui"" name="' + subGroupName + '.frmdate_ui" fdt="uidate" mnebl="false" fmnd="Y"  fblk="defaultFblk1" hotKeyId="calender1" onBlur = "javascript:validateDateOnBlur(this,this,this);">');
	write('<a id="frmDateImg" href="javascript:openDate(document.forms[0].frmdate_ui,BODDate)">');
	write('<img width="24" height="19" src="../images/INFENG/calender.gif" align="absmiddle" border="0" alt="Date picker" style="cursor:hand"></a>');
	write('<div style="position:absolute;"></div>');
	write('</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026333") + '<font color=red size=2>*</font></td>');
	write('<td><input type="text" class="textfieldfont" id="toDate_ui"" name="' + subGroupName + '.toDate_ui" fdt="uidate" mnebl="false" fmnd="Y"  fblk="defaultFblk1" hotKeyId="calender1" onBlur = "javascript:validateDateOnBlur(this,this,this);">');
	write('<a id="frmDateImg" href="javascript:openDate(document.forms[0].toDate_ui,BODDate)">');
	write('<img width="24" height="19" src="../images/INFENG/calender.gif" align="absmiddle" border="0" alt="Date picker" style="cursor:hand"></a>');
	write('<div style="position:absolute;"></div>');
	write('</td>');
	write('</tr>');
	
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026334") +'<font color=red size=2>*</font></td>');
	write('<td><input name="' + subGroupName + '.duplicate" id="duplicate" ' + cichqdProps.get("duplicate_ENABLED") + ' type="radio" value = "Y" ONCLICK="javascript:fnOnclickRadio()">Yes<input name="' + subGroupName +'.duplicate" id="duplicate" ' + cichqdProps.get("duplicate_ENABLED") + ' type="radio" value = "N" ONCLICK="javascript:fnOnclickRadio()">No');
    write('</td>');
    write('</tr>');

	
	
	write('<tr>');
    write('<td class="textlabel">' + jspResArr.get("FLT026335") +'<font color=red size=2>*</font></td>');
    write('<td><input name="' + subGroupName + '.dnldID" id="dnldID" ' + cichqdProps.get("dnldID_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
    write('<a target=_self id="sLnk4" href="javascript:fnCustSearcherold(document.forms[0].dnldID)"><img class="img" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search4"></img></a>');
    write('</td>');

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
	write('<div class="ctable">');
        write('<input name="Submit" type="button" class="button" onClick="javascript:return cichqd_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
        write('<input name="Clear" type="button" class="button" onClick="javascript:return cichqd_det_ONCLICK2(this);" id="Clear" value="Clear">');

	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function


function fnOnLoad()
{
	var ObjForm = document.forms[0];

	pre_ONLOAD('cichqd_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

//	if(funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='U' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
//		fnDisableFormControls(ObjForm);
//	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}


//	fnPostOnLoad()
	post_ONLOAD('cichqd_det',this);
//	document.forms[0].userID.disabled = true;
	element = document.getElementsByName("duplicate");
	if(element[1].checked) {
	document.forms[0].dnldID.disabled=true;
	document.getElementById('sLnk4').style.visibility="hidden";
	}
	else
	{
	 document.forms[0].dnldID.disabled=false;
	 document.getElementById('sLnk4').style.visibility="visible";
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

	ObjForm.frmdate_ui.value = frmdate_ui;
	ObjForm.toDate_ui.value = toDate_ui;
	ObjForm.duplicate.value = duplicate;
	ObjForm.dnldID.value = dnldID;
	element = document.forms[0].duplicate;
	if(duplicate == "Y") {
                element[0].checked=true;
        }
        else {
                element[1].checked=true;
        }

}


function cichqd_det_ONCLICK1(obj,p1)
{
/*	var retVal = "";
	if (pre_ONCLICK('cichqd_det',obj) == false) { 
		return false;
	}
*/
	if(fnIsNull(document.forms[0].frmdate_ui.value)) {
                alert("Enter the Start Date");
                document.forms[0].frmdate_ui.focus();
                return false;
    }
	if(fnIsNull(document.forms[0].toDate_ui.value)) {
                alert("Enter the End Date");
                document.forms[0].toDate_ui.focus();
                return false;
    }

	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}
	/*
	var frm = document.forms[0];
       frm.actionCode.value = "Submit";
       enableFormElements();
       hideAnchors();
       disableButtons();
       frm.submit();
	*/
	if (post_ONCLICK('cichqd_det',obj) == false) { 
	return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cichqd_det_ONCLICK2(obj)
{
	var retVal = "";
/*
	if (pre_ONCLICK('cichqd_det',obj) == false) { 
		return false;
	}
*/
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
/*
	if (post_ONCLICK('cichqd_det',obj) == false) { 
		return false;
	}
*/
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
function fnOnclickRadio(){
element = document.getElementsByName("duplicate");
if(element[1].checked) {
document.forms[0].dnldID.disabled=true;
document.forms[0].dnldID.value="";
document.getElementById('sLnk4').style.visibility="hidden";
}
else
{
document.forms[0].dnldID.disabled=false;
document.getElementById('sLnk4').style.visibility="visible";
}
}
