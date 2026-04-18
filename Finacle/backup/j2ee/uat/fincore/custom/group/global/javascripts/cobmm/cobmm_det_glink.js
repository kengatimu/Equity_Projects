function printBlock()
{
	writeCustomHeader("cobmm_det");
	document.write('<input type="hidden" id="frmDate" fdt="fdate" fmnd="Y"  mneb1="N" vFldId="frmDate_ui" name="' + subGroupName + '.frmDate">');
	document.write('<input type="hidden" id="toDate" fdt="fdate" fmnd="Y"  mneb1="N" vFldId="toDate_ui" name="' + subGroupName + '.toDate">');
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">Offline Branch Maintenance</td>');
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
	write('<a href="javascript:showHelpFile(\'cobmm_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026332") +'<font color=red size=2>*</font></td>');
	write('<td><select name="' + subGroupName + '.funcCode" id="funcCode" ' + cobmmProps.get("funcCode_ENABLED") + ' class="textfieldfont" " onchange="javascript:fnDisableFields(this)">');	
	write('<option value ="" selected>' + jspResArr.get("FLT026341") + '</option>');
    write('<option value="B">' + jspResArr.get("FLT026342") + '</option>');
    write('<option value="U">' + jspResArr.get("FLT026343") + '</option>');
    write('</select>');
    write('</td>');
	write('</tr>');
	write('<tr>');	
	write('<td class="textlabel">' + jspResArr.get("FLT026333") +'<font color=red size=2>*</font></td>');
	write('<td><input name="' + subGroupName + '.solId" id="solId" ' + cobmmProps.get("solId_ENABLED") +' type="text" class="textfieldfont" size="25" maxlength="16">');
	write('<a target=_self id="sLnk1" href="javascript:showSolId(document.forms[0].solId,\'ctrl\',\'F\',document.forms[0].solIdDesc)"><img class="img" src="../Renderer/images/'+ applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search9"></img></a>')
	write('<input name="' + subGroupName + '.solIdDesc" id="solIdDesc" type="text" size="25" maxlength="16" readonly disabled class="label" >');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026334") + '<font color=red size=2>*</font></td>');
	write('<td><input type="text" class="textfieldfont" id="frmDate_ui"" name="' + subGroupName + '.frmDate_ui" fdt="uidate" mnebl="false" fmnd="Y"  fblk="defaultFblk1" hotKeyId="calender1"  onBlur = "javascript:validateDateOnBlur(this,this,this);" readonly>');
	//write('<a id="frmDateImg" href="javascript:openDate(document.forms[0].frmDate_ui,BODDate)">');
	//write('<img width="24" height="19" src="../images/INFENG/calender.gif" align="absmiddle" border="0" alt="Date picker" style="cursor:hand"></a>');
	write('<div style="position:absolute;"></div>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026335") + '<font color=red size=2>*</font></td>');
//	write('<td><input name="'+subGroupName + '.toDate" id="toDate" ' + cobmmProps.get("toDate_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16">');
	write('<td><input type="text" class="textfieldfont" id="toDate_ui"" name="' + subGroupName + '.toDate_ui" fdt="uidate" mnebl="false" fmnd="Y"  fblk2="defaultFblk2" hotKeyId1="calender2" onBlur = "javascript:validateDateOnBlur(this,this,this)" href="javascript:openDate(document.forms[0].frmDate_ui,BODDate)">');
    write('<a id="toDateImg" href="javascript:openDate(document.forms[0].toDate_ui,BODDate)">');
    write('<img width="24" height="19" src="../images/INFENG/calender.gif" align="absmiddle" border="0" alt="Date picker" style="cursor:hand"></a>');
  	write('<div style="position:absolute;"></div>');
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
	write('<input name="Submit" type="button" class="button" onClick="javascript:return cobmm_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	write('<input name="Clear" type="button" class="button" onClick="javascript:return cobmm_det_ONCLICK2(this);" id="Clear" value="Clear">');
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

	pre_ONLOAD('cobmm_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	if( sReferralMode =='I' || sReferralMode =='S'){
		fnDisableFormControls(ObjForm);
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}


//	fnPostOnLoad()
	post_ONLOAD('cobmm_det',this);
//	document.forms[0].userID.disabled = true;
}

function fnValidateData()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];
	ObjForm.funcCode.value = funcCode;
	ObjForm.solId.value = solId;
	ObjForm.frmDate_ui.value = BODDate;
	ObjForm.frmDate.value = BODDate;
	ObjForm.toDate_ui.value = toDate;
	ObjForm.toDate.value = toDate;
}


function cobmm_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (pre_ONCLICK('cobmm_det',obj) == false) { 
		return false;
	}


	if((document.forms[0].funcCode.value == "")) {
                alert("Select the Function Code");
                document.forms[0].funcCode.focus();
                return false;
    }

	
	if(fnIsNull(document.forms[0].solId.value)) {
                alert("Enter the SolID");
                document.forms[0].solId.focus();
                return false;
    }
	
	if(fnIsNull(document.forms[0].toDate_ui.value)) {
                alert("Enter the to date");
                document.forms[0].toDate_ui.focus();
                return false;
    }


	if(fnIsNull(document.forms[0].solId.value)) {
                alert("Enter the SolID");
                document.forms[0].solId.focus();
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
	if (post_ONCLICK('cobmm_det',obj) == false) { 
	return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cobmm_det_ONCLICK2(obj)
{
	var retVal = "";
	if (pre_ONCLICK('cobmm_det',obj) == false) { 
		return false;
	}
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (post_ONCLICK('cobmm_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function openDate(obj,inpDate)
{
    var date = "";
    if(inpDate == null)
        inpDate = '';
        /* Date selector enhancement:Start */
    var objName = String(obj.name);
    hidObj = document.getElementsByName(objName);

    var i = (obj.fmult == "Y")?obj.recNum:0;
    var hidVal = hidObj[i].value;

    if((calbase == "01")&&(hidVal != null)&&(hidVal != "")&&(hidVal != "undefined"))
        {
            if(!chkHijriMapping(hidVal))
            {
                    alert(finbranchResArr.get("FAT002843"));
                    return;
            }
        }

        hidVal = (!fnIsValidContextDate(hidObj[i]))?inpDate:hidVal;

        date = popCalendarModalWindowVar("../arjspmorph/"+applangcode+"/date.jsp?txtDate="+obj.id+"&date="+inpDate+"&dateVal="+hidVal+"&calbase="+calbase,"Calendar",225
,160,15,12);
        /* Date selector enhancement:End  */

        if(date != null)
        {
            //set the value to ui and hidden fields.
        obj.value = fnConvertToUIDate(date);
        fnAssignDateOnEnter(obj);

                /*changes for the ticket 246672*/
            fnSetFocusForDate(obj);
        }
}

//This function validates date, when the focus goes out of the date field
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

