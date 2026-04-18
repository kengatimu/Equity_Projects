function printBlock()
{
	writeCustomHeader("coclg_det");
	document.write('<input type="hidden" id="date" fdt="fdate" fmnd="Y"  mneb1="N" vFldId="date_ui" name="' + subGroupName + '.date">');
	with (document){
	write('<input type="hidden" id="mode" fdt="fmode" mneb1="N" vFldId="mode_ui" name="' + subGroupName + '.mode">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading"> Outward Clearing File </td>');
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
	write('<a href="javascript:showHelpFile(\'coclg_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
	write('</tr>');

        write('<tr>');
        write('<td class="textlabel">' + jspResArr.get("FLT026339") +'</td>');
        write('<td><input name="' + subGroupName + '.printp" id="printp" ' + coclgProps.get("printp_ENABLED") + ' type="text" class="textfieldfont" size="10" maxlength="10" disabled="true">');  
	write('<input name="' + subGroupName + '.printio" id="printio" type="text" size="25" maxlength="16"  readonly disabled class="label"  >');
	document.forms[0].printio.value=" Print";
        write('</td>');
        write('</tr>');

        write('<tr>');
        write('<td class="textlabel">' + jspResArr.get("FLT026338") + '<font color="red" size="2"> *</font></td>');
        write('<td><input name="' + subGroupName + '.setId" id="setId"  type="text" class="textfieldfont" size="25" maxlength="16">');
        write('<a target_self id="sLnk1" href="javascript:showSetList(document.forms[0].setId,\'ctrl\',\'F\',document.forms[0].setIdDesc)">');
        write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search1"></a>');
	write('<input name="' + subGroupName + '.setIdDesc" id="setIdDesc" type="text" size="25" maxlength="16" readonly disabled class="label" >');
	write('</td>');
	write('</tr>');

        write('<td class="textlabel">' + jspResArr.get("FLT026332") + '<font color="red" size="2"> *</font></td>');
	write('<td><select name="' + subGroupName + '.funcCode" id="funcCode" ' + coclgProps.get("funcCode_ENABLED") + ' class="textfieldfont" onchange="javascript:fnOnchange()">');
        write('<option value="" selected>' + jspResArr.get("FLT026336") + '</option>');
        write('<option value="OCLG">' + jspResArr.get("FLT026334") + '</option>');
	if(bankId != "11"){
        	write('<option value="OCLG2">' + jspResArr.get("FLT026335") + '</option>');
	}
        write('</select>');
        write('</td>');
        write('</tr>');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026333") +'<font color="red" size="2"> *</font></td>');
	write('<td><input name="' + subGroupName + '.zoneCode" id="zoneCode" ' + coclgProps.get("zoneCode_ENABLED") + ' type="text" class="textfieldfont" size="10" maxlength="10" onload="javascript:fnOnchange()">');
	write('&nbsp;<a target="_self" id="sLnk2" href="javascript:localShowClgZoneCode(document.forms[0].zoneCode,document.forms[0].mode)">');
    	write('<IMG src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border=0 hotKeyId="search1"></a>');	
	write('</td>');
	write('</tr>');
	write('</td>');
	write('</tr>');

	write('<tr>');
        write('<td class="textlabel">' + jspResArr.get("FLT026337") + '<font color="red" size="2"> *</font></td>');
        write('<td><input type="text" class="textfieldfont" id="date_ui"" name="' + subGroupName + '.date_ui" fdt="uidate" mnebl="false" fmnd="Y"  fblk="defaultFblk1" hotKeyId="calender1" onBlur = "javascript:validateDateOnBlur(this,this,this);">');
        write('<a id="frmDateImg" href="javascript:openDate(document.forms[0].date_ui,BODDate)">');
        write('<img width="24" height="19" src="../images/INFENG/calender.gif" align="absmiddle" border="0" alt="Date picker" style="cursor:hand"></a>');
        write('<div style="position:absolute;"></div>');
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
        write('<input name="Submit" type="button" class="button" onClick="javascript:return coclg_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
        write('<input name="Clear" type="button" class="button" onClick="javascript:return coclg_det_ONCLICK2(this);" id="Clear" value="Clear">');

	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];
	document.forms[0].printp.value="P";

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}
	fnPopulateControlValues();

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}
	var inputNameValues   = "opt" + "|" + "stId" ;
	var outputNames         = "setVal";
	fnPrintInvoke(inputNameValues,outputNames);
}

function fnValidateData()
{
	var ObjForm = document.forms[0];
	return true;
}

function fnshowAccountIdList(obj){
	showAccountIdList(obj,null,null,'F');
	fnCustValidate();
}

function coclg_det_ONCLICK1(obj,p1)
{
	if(fnIsNull(document.forms[0].funcCode.value)) {
       	        alert("Select an Option");
       	        document.forms[0].funcCode.focus();
       	        return false;
    	}

	if(fnIsNull(document.forms[0].setId.value)) {
                alert("Enter the Set Id");
                document.forms[0].setId.focus();
                return false;
	}
	if(fnIsNull(document.forms[0].zoneCode.value)) {
                alert("Enter the Zone Code");
                document.forms[0].zoneCode.focus();
                return false;
	}
        if(fnIsNull(document.forms[0].date_ui.value)) {
                alert("Enter the Zone Date");
                document.forms[0].date_ui.focus();
                return false;
	}
	
	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (post_ONCLICK('coclg_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];
	ObjForm.funcCode.value	=funcCode;
	ObjForm.zoneCode.value = zoneCode;
	if(date_ui == ""){
		ObjForm.date_ui.value = BODDate;
	}
	else
	{
		ObjForm.date_ui.value = date_ui;
	}
	ObjForm.setId.value = setId;
	return true; 
}

function coclg_det_ONCLICK2(obj)
{
	var retVal = "";
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function localShowClgZoneCode(objZoneCode, objFnCode)
{
	var showDelRecFlg = ""; 
	switch(objFnCode.value)
	{
		case 'D':
		case 'M':
		showDelRecFlg = "N";
		break;
		case 'U':
		showDelRecFlg = "Y";
		break;
	}
	showClgZoneCode(objZoneCode, 'ctrl', 'F', 'NULL', showDelRecFlg);
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

function fnCustSearcher() {
        showSolId(document.forms[0].solId,'ctrl','F',document.forms[0].solIdDesc);
 }

function fnOnchange() {
        if(bankId == "11"){
                if(document.forms[0].funcCode.value!=null) {
                        document.forms[0].funcCode.disabled = true;
                }
        }

	if(document.forms[0].funcCode.value=="OCLG"){
		var inputNameValues   = "opt" + "|" + "funCd" +"|"+ "moduleName" +"|"+ "CLEARING" +"|"+ "parameterId"+ "|" + "OCLGRPT_ZONE" ;
		var outputNames         = "parameterVal";
		fnPrintInvoke(inputNameValues,outputNames);
	}
	if(document.forms[0].funcCode.value=="OCLG2"){
       		var inputNameValues   = "opt" + "|" + "funCd" +"|"+ "moduleName" +"|"+ "CLEARING" +"|"+ "parameterId"+ "|" + "OCLGRPT_ZONE1";
		var outputNames         = "parameterVal";
		fnPrintInvoke(inputNameValues,outputNames);
	}
 }

function fnPrintInvoke(inputNameValues,outputNames){
	var scrName             = "oclgrptmn002.scr";
        var retVal              = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret                 = retVal.split("|");
        var msg                 = ret[0];
	if(msg=='Err'){
        	alert("C_CPARAM table not set");
	}
	if(msg=='parameterVal'){
        	var cZoneCode =ret[1];
        	document.forms[0].zoneCode.value=cZoneCode;
	}
	if(msg=='setVal'){
		var cSetId =ret[1];
		if(document.forms[0].setId.value == ""){
			document.forms[0].setId.value=cSetId;
		}
	}
}
