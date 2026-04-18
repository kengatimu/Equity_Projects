function printBlock()
{
	writeCustomHeader("cieclg_crit");
	with (document){
	write('<input type="hidden" name="nextPage" id="nextPage">');
	write('<input type="hidden" id="zoneDate" fdt="fdate" mneb1="N" vFldId="zoneDate_ui" name="' + subGroupName + '.zoneDate">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td>');
	write('<h1 class="page-heading">Inter Entity Clearing Maintenance</h1>');
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
	write('<select name="' + subGroupName + '.funcCode" id="funcCode" ' + cieclgProps.get("funcCode_ENABLED") + ' class="listboxfont" onChange="javascript: fnOnChangeFuncCode();">');
	write('<option value="">' + jspResArr.get("FLT021247") + '</option>');
	write('<option value="A">' + jspResArr.get("FLT021248") + '</option>');
	write('<option value="D">' + jspResArr.get("FLT021249") + '</option>');
	//write('<option value="G">' + jspResArr.get("FLT021250") + '</option>');
	write('<option value="I">' + jspResArr.get("FLT021251") + '</option>');
	write('<option value="M">' + jspResArr.get("FLT021252") + '</option>');
	write('<option value="R">' + jspResArr.get("FLT021253") + '</option>');
	write('<option value="V">' + jspResArr.get("FLT021254") + '</option>');
	write('<option value="O">' + jspResArr.get("FLT021255") + '</option>');
	write('</select>');
	write('</td>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT021243") + '</td>');
        write('<td class="textfield">');
        write('<input  maxlength="10" hotKeyId="calender1"  type="text" class="textfieldfont" fdt="uidate"  mnebl="false" onBlur="javascript:return cieclg_crit_ONBLUR1(this,this,this);" name="' + subGroupName + '.zoneDate_ui" id="zoneDate_ui" >');
        write('&nbsp;<a  href="javascript:openDate(document.forms[0].zoneDate_ui,BODDate)"   id="sLnk2"><img align="absmiddle" alt="Date picker" border="0" height="19"  hotKeyId="calender1" src="../Renderer/images/'+applangcode+'/calender.gif" width="24" class="img" >');
        write('</a>');
        write('</td>');
	write('</tr>');

	write('<tr>');
        write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT021244") + '<script>setMandatory("Y");</script></td>');
        write('<td class="textfield">');
        write('<input maxlength="10" type="text" class="textfieldfont" name="' + subGroupName + '.zoneCode" id="zoneCode" ' + cieclgProps.get("zoneCode_ENABLED") + '>');
	write('&nbsp;<a id="sLnk12" href=\'JavaScript:fnShowZoneCode(document.forms[0].zoneDate,document.forms[0].zoneCode,"' + contextSolId + '");\'>');
        write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" alt="Search list" hotKeyId="search5"></a>');
        write('</td>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT021245") + '</td>');
        write('<td class="textfield">');
        write('<input maxlength="9" type="text" class="textfieldfont" name="' + subGroupName + '.setNum" id="setNum" ' + cieclgProps.get("setNum_ENABLED") + ' onChange="javascript: cieclg_crit_ONCHANGE1(this);">');
	write('&nbsp;<a id="setNumImg" target=_self href="Javascript:fnShowSetNumList();">');
        write('<img border="0" height="17" hotKeyId="search2" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        write('</a>');
        write('</td>');
        write('</tr>');
        
        
        
        
        //added--ubp
        write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT007661") + '</td>');
	write('<td class="textfield">');
	write('<input type="radio" name="' + subGroupName + '.billPayYes" id="billPayYes"  ' + cieclgProps.get("billPayYes_ENABLED") + ' value="Y" onclick="javascript:return cieclg_crit_ONCLICK3(this);">Yes');
	write('<input type="radio" name="' + subGroupName + '.billPayYes" id="billPayYes"  ' + cieclgProps.get("billPayYes_ENABLED") + ' value="N" checked="checked" onclick="javascript:return cieclg_crit_ONCLICK4(this);">No');
	write('</td>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT007530") + '</td>');
	write('<td class="textfield">');
	write('<input hotKeyId="search3" type="text" class="textfieldfont" name="' + subGroupName + '.billerId" id="billerId" ' + cieclgProps.get("billerId_ENABLED") + ' onBlur="javascript:return cieclg_crit_ONBLUR2(this);" maxlength="10">&nbsp;');
	write('<a href="javascript:fnBillerId()" id="billerIdSerch">');
	write('<img border="0" height="17" hotKeyId="search3" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('</td>');
        write('</tr>');
        
        
        write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT031859") + '</td>');
	write('<td class="textfield">');
	write('<input hotKeyId="search4" type="text" class="textfieldfont" name="' + subGroupName + '.typOfServ" id="typOfServ" ' + cieclgProps.get("typOfServ_ENABLED") + '>&nbsp;');
	write('<a href="javascript:fnTypOfServ()" id="typOfServiceSerchr">');
	write('<img border="0" height="17" hotKeyId="search4" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.valType" id="valType" ' + cieclgProps.get("valType_ENABLED") + ' readonly="readonly" style="visibility: hidden; width: 0px">');
	write('</td>');
	write('<td class="textlabel"></td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.billerCode" id="billerCode" ' + cieclgProps.get("billerCode_ENABLED") + ' readonly="readonly" style="visibility: hidden; width: 0px" />');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.critCrAcctNum" id="critCrAcctNum" ' + cieclgProps.get("critCrAcctNum_ENABLED") + ' readonly="readonly" style="visibility: hidden; width: 0px" />');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.critCrAcctBnkId" id="critCrAcctBnkId" ' + cieclgProps.get("critCrAcctBnkId_ENABLED") + ' readonly="readonly" style="visibility: hidden; width: 0px" />');
	write('</td>');
        write('</tr>');
        
        //added ubp
	
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
	write('<input id="Accept" name="Go" type="button" class="button" onClick="javascript:return cieclg_crit_ONCLICK1(this,this);"" value="Go" hotKeyId="Go">');
	write('<input id="Clear" name="Clear" type="button" class="button" value="Clear" onClick="javascript:return cieclg_crit_ONCLICK2(this);"">');
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	pre_ONLOAD('cieclg_crit',this);

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
	post_ONLOAD('cieclg_crit',this);
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
	ObjForm.zoneCode.value = zoneCode;
	ObjForm.zoneDate.value = zoneDate;
	ObjForm.setNum.value = setNum;
	//ubp added-start
	ObjForm.billPayYes.value = billPayYes;
	ObjForm.valType.value = valType;
	ObjForm.billerCode.value = billerCode;
	ObjForm.billerId.value = billerId;
	ObjForm.typOfServ.value = typOfServ;
	ObjForm.critCrAcctNum.value = critCrAcctNum;
	ObjForm.critCrAcctBnkId.value = critCrAcctBnkId;
	
	//ubp added-end
	fnCheckControls();
}
function fnCheckControls()
{
        var ObjForm = document.forms[0];
	checkRadio(ObjForm.billPayYes,billPayYes);
        fnSetCheckboxCtrl(ObjForm);
}


function cieclg_crit_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (preEventCall('cieclg_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cieclg_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cieclg_crit_ONCLICK2(obj)
{
	var retVal = "";
	if (preEventCall('cieclg_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnClearFields()) == false) {
		return false;
	}
	if (postEventCall('cieclg_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cieclg_crit_ONBLUR1(obj,p1,p2)
{
        var retVal = "";
        if (preEventCall('cieclg_crit',obj,'ONBLUR') == false) {
                return false;
        }
        if ((retVal = onBlurFormatDate(p1)) == false) {
                return false;
        }
        if ((retVal = fnAssignDateOnEnter(p2)) == false) {
                return false;
        }
        if (postEventCall('cieclg_crit',obj,'ONBLUR') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}
//Added ubp-start
function cieclg_crit_ONCLICK3(obj)
{
	var retVal = "";
	if (preEventCall('cieclg_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnOnClickBillPay()) == false) {
		return false;
	}
	if (postEventCall('cieclg_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
function cieclg_crit_ONCLICK4(obj)
{
	var retVal = "";
	if (preEventCall('cieclg_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnOnClickBillPay()) == false) {
		return false;
	}
	if (postEventCall('cieclg_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cieclg_crit_ONBLUR2(obj)
{
	
	var retVal = "";
	if (preEventCall('cieclg_crit',obj,'ONBLUR') == false) { 
		return false;
	}
	if ((retVal = fnOnblurBillerId()) == false) {
		return false;
	}
	if (postEventCall('cieclg_crit',obj,'ONBLUR') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cieclg_crit_ONCHANGE1(obj)
{
	var retVal = "";
	if (preEventCall('cieclg_crit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = fnOnChangeSetNum()) == false) {
		return false;
	}
	if (postEventCall('cieclg_crit',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
////Added ubp-end
