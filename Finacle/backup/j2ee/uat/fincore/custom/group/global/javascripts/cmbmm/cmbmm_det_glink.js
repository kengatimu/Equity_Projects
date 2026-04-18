function printBlock()
{
	writeCustomHeader("cmbmm_det");
	document.write('<input type="hidden" id="date" fdt="fdate" fmnd="Y"  mneb1="N" vFldId="date_ui" name="' + subGroupName + '.date">');
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">Mobile Branch Maintenance</td>');
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
	write('<a href="javascript:showHelpFile(\'cmbmm_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026332") +'<font color="red" size="2"> *</font></td>');
        write('<td><select name="' + subGroupName + '.funcCode" id="funcCode" ' + cmbmmProps.get("funcCode_ENABLED") + ' class="textfieldfont" " onchange="javascript:fnDisableFields(this)">');
	write('<option value="" selected>' + jspResArr.get("FLT026341") + '</option>');
    write('<option value="B">' + jspResArr.get("FLT026342") + '</option>');
    write('<option value="U">' + jspResArr.get("FLT026343") + '</option>');
    write('</select>');
    write('</td>');
	write('</tr>');

    write('<tr>');
    write('<td class="textlabel">' + jspResArr.get("FLT026333") + '<font color="red" size="2"> *</font></td>'); 
    write('<td><input name="' + subGroupName + '.solId" id="solId" ' + cmbmmProps.get("solId_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16">');
	write('<a target=_self id="sLnk1" href="javascript:showSolId(document.forms[0].solId,\'ctrl\',\'F\',document.forms[0].solIdDesc)"><img class="img" src="../Renderer/images/'+ applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search1"></img></a>')
	write('<input name="' + subGroupName + '.solIdDesc" id="solIdDesc" type="text" size="25" maxlength="16" readonly disabled class="label" >');
    write('</td>');
    write('</tr>');

    write('<tr>');
    write('<td class="textlabel">' + jspResArr.get("FLT026334") + '<font color="red" size="2"> *</font></td>'); 
    write('<td><input name="' + subGroupName + '.schmCode" id="schmCode" ' + cmbmmProps.get("schmCode_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16">');
    write('<a target=_self id="sLnk4" href="javascript:fnCustSearcher(document.forms[0].schmCode,document.forms[0].schmDesc)"><img class="img" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search4"></img></a>');
    write('<input name="' + subGroupName + '.schmDesc" id="schmDesc" type="text" size="25" maxlength="16" readonly disabled class="label" >');
	write('</td>');
    write('</tr>');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026335") + '<font color="red" size="2"> *</font></td>');
	write('<td><input type="text" class="textfieldfont" id="date_ui"" name="' + subGroupName + '.date_ui" fdt="uidate" mnebl="false" fmnd="Y"  fblk="defaultFblk1" hotKeyId="calender1" onBlur = "javascript:validateDateOnBlur(this,this,this);">');
	write('<a id="frmDateImg" href="javascript:openDate(document.forms[0].date_ui,BODDate)">');
	write('<img width="24" height="19" src="../images/INFENG/calender.gif" align="absmiddle" border="0" alt="Date picker" style="cursor:hand"></a>');
	write('<div style="position:absolute;"></div>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	
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
	write('<input name="Submit" type="button" class="button" onClick="javascript:return cmbmm_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	write('<input name="Clear" type="button" class="button" onClick="javascript:return cmbmm_det_ONCLICK2(this);" id="Clear" value="Clear">');
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

	pre_ONLOAD('cmbmm_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}
        
        fnPopulateControlValues();

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

//	fnPostOnLoad()
	post_ONLOAD('cmbmm_det',this);
}

function post_ONLOAD(obj1,obj2)
{
    fnPopulateControlValues();
}

function fnValidateData()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];
	
	ObjForm.funcCode.value = funccode;
	ObjForm.solId.value = vsolid;
	ObjForm.schmCode.value = schmcode;
	ObjForm.date_ui.value = BODDate;
	ObjForm.date.value = BODDate;
}


function cmbmm_det_ONCLICK1(obj,p1)
{
	var retVal = "";
 
        if(fnIsNull(document.forms[0].funcCode.value)) {
                alert("Enter the Function Code");
                document.forms[0].funcCode.focus();
                return false;
    }

	
	if(fnIsNull(document.forms[0].solId.value)) {
                alert("Enter the Sol ID");
                document.forms[0].solId.focus();
                return false;
    }
	
	if(fnIsNull(document.forms[0].schmCode.value)) {
                alert("Enter the Scheme Code");
                document.forms[0].schmCode.focus();
                return false;
    }
	if (pre_ONCLICK('cmbmm_det',obj) == false) { 
        return false;
    }


	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}

	if (post_ONCLICK('cmbmm_det',obj) == false) { 
	return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cmbmm_det_ONCLICK2(obj)
{
	var retVal = "";
	if (pre_ONCLICK('cmbmm_det',obj) == false) { 
		return false;
	}
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (post_ONCLICK('cmbmm_det',obj) == false) { 
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

function fnCustSearcher()
{
        var inputNameValues = "";
        var outputNames = "schmCode|schmDesc";
        var scrName     = "cmbmmdp001.scr";
        var title       = "Scheme Code under SBA Scheme Type";
        var literalNames= "Scheme Code" + "|" + "Scheme Description";
        var hyperLnks   = "1";
        var retVal = fnExecuteScriptForList(inputNameValues, outputNames, scrName, title, literalNames, hyperLnks, true);
        var ret = retVal.split("|");
        var msg = ret[1];

        if(msg == "SBA")
        {
                document.forms[0].schmCode.value ="";
                document.forms[0].schmDesc.value ="";
                return false;
        }
}

