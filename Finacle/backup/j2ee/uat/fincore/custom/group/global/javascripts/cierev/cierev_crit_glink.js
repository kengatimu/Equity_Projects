function printBlock()
{
	writeCustomHeader("cierev_crit");
	with (document){
	write('<input type="hidden" name="nextPage" id="nextPage">');
	write('<input type="hidden" id="tranDate" fdt="fdate" mneb1="N" vFldId="tranDate_ui" name="' + subGroupName + '.tranDate">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td>');
	write('<h1 class="page-heading">Inter Entity Transaction Reversal</h1>');
	write('</td>');
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
	write('<tr>');
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
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT021242") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<select name="' + subGroupName + '.funcCode" id="funcCode" ' + cierevProps.get("funcCode_ENABLED") + ' class="listboxfont" onChange="javascript: fnOnChangeFuncCode();">');
	write('<option value="">' + jspResArr.get("FLT021247") + '</option>');
	write('<option value="R">' + jspResArr.get("FLT021248") + '</option>');
	write('<option value="I">' + jspResArr.get("FLT021249") + '</option>');
	write('</select>');
	write('</td>');
	write('<td class="textlabel"></td>');
        write('<td>');
        write('</td>');
	write('</tr>');

	write('<tr id="ieTxnRefNoRow">');
        write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT021264") + '<script>setMandatory("Y");</script></td>');
        write('<td class="textfield">');
        write('<input maxlength="10" type="text" class="textfieldfont" name="' + subGroupName + '.ieTxnRefNo" id="ieTxnRefNo" ' + cierevProps.get("ieTxnRefNo_ENABLED") + '>');
        write('&nbsp;<a id="ieTxnRefNoImg" href="javascript:showInterEntityTxnRefNoList()">');
        write('<img border="0" alt="Search List" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        write('</a>&nbsp;');
        write('</td>');
        write('<td class="columnwidth"> </td>');
        write('<td class="textlabel"> </td>');
        write('<td class="textfield"> </td>');
        write('</tr>');

	/*write('<tr id="tranIdRow">');
        write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT021262") + '<script>setMandatory("Y");</script></td>');
        write('<td class="textfield">');
        write('<input type="text" maxlength="9" class="textfieldfont" name="' + subGroupName + '.tranId" id="tranId" ' + cierevProps.get("tranId_ENABLED") + '>');
	write('&nbsp;<a id="tranIdImg" href="javascript:showInterEntityTranIdList()">');
        write('<img border="0" alt="Search List" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        write('</a>&nbsp;');
        write('</td>');
        write('<td class="columnwidth"> </td>');
        write('<td class="textlabel"> </td>');
        write('<td class="textfield"> </td>');
        write('</tr>');
	*/
	
	write('<tr id="tranDateRow">');
        write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT021263") + '<script>setMandatory("Y");</script></td>');
        write('<td class="textfield">');
        write('<input  maxlength="10" hotKeyId="calender1"  type="text" class="textfieldfont" fdt="uidate"  mnebl="false" onBlur="javascript:return cierev_crit_ONBLUR1(this,this,this);" name="' + subGroupName + '.tranDate_ui" id="tranDate_ui" >');
        write('&nbsp;<a  href="javascript:openDate(document.forms[0].tranDate_ui,BODDate)"   id="sLnk2"><img align="absmiddle" alt="Date picker" border="0" height="19"  hotKeyId="calender1" src="../Renderer/images/'+applangcode+'/calender.gif" width="24" class="img" >');
        write('</a>');
        write('</td>');
        write('<td class="columnwidth"> </td>');
        write('<td class="textlabel"> </td>');
        write('<td class="textfield"> </td>');
        write('</tr>');


	write('</tr>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('<table>');
	write('<tr><td></td></tr>');
	write('</table>');
	write('<!-- DETAILSBLOCK-END -->');
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
	write('<div align="left" class="ctable">');
	write('<input id="Accept" name="Go" type="button" class="button" onClick="javascript:return cierev_crit_ONCLICK1(this,this);"" value="Go" hotKeyId="Go">');
	write('<input id="Clear" name="Clear" type="button" class="button" value="Clear" onClick="javascript:return cierev_crit_ONCLICK2(this);"">');
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	pre_ONLOAD('cierev_crit',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	fnAssignDateOnLoad(ObjForm);

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}
	post_ONLOAD('cierev_crit',this);
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
	ObjForm.tranDate.value = tranDate;
	fnCheckControls();
}
function fnCheckControls()
{
        var ObjForm = document.forms[0];

        fnSetCheckboxCtrl(ObjForm);
}


function cierev_crit_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (preEventCall('cierev_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cierev_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cierev_crit_ONCLICK2(obj)
{
	var retVal = "";
	if (preEventCall('cierev_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnClearFields()) == false) {
		return false;
	}
	if (postEventCall('cierev_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cierev_crit_ONBLUR1(obj,p1,p2)
{
        var retVal = "";
        if (preEventCall('cierev_crit',obj,'ONBLUR') == false) {
                return false;
        }
        if ((retVal = onBlurFormatDate(p1)) == false) {
                return false;
        }
        if ((retVal = fnAssignDateOnEnter(p2)) == false) {
                return false;
        }
        if (postEventCall('cierev_crit',obj,'ONBLUR') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}
