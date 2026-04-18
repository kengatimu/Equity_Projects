function printBlock()
{
	writeCustomHeader("hintrpt_det");
	with (document){
	write('<input type="hidden" id="StartDate" fdt="fdate" mneb1="N" vFldId="StartDate_ui" name="' + subGroupName + '.StartDate">');
	write('<input type="hidden" id="EndDate" fdt="fdate" mneb1="N" vFldId="EndDate_ui" name="' + subGroupName + '.EndDate">');
	write('<input type="hidden" id="TranDate" fdt="fdate" mneb1="N" vFldId="TranDate_ui" name="' + subGroupName + '.TranDate">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT000572") + '</td>');
	write('</tr>');
	write('</table>');
	write('<!-- DETAILSBLOCK-BEGIN -->');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td valign="top">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">');
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
	write('<a href="javascript:showHelpFile(\'hintrpt_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="35" height="17" vspace="1" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT111600") + '<script>setMandatory("Y");</script></td>'); 
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT111601") + '');
	write('<input type="radio" name="' + subGroupName + '.radiobtn" id="radiobtn" ' + hintrptProps.get("radiobtn_ENABLED") + ' value="crit1" onClick="showCritScreen(this)">');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT111602") + '');
	write('<input type="radio" name="' + subGroupName + '.radiobtn" id="radiobtn" ' + hintrptProps.get("radiobtn_ENABLED") + ' value="crit2" onClick="showCritScreen(this)">');
	write('</td>');
	write('</tr>');
	write('<tr>');
    write('<td class="textlabel" id="bacid_label">' + jspResArr.get("FLT111603") + '</td>');
    write('<td class="textfield">');
    write('<input name="' + subGroupName + '.bacid" id="bacid" ' + hintrptProps.get("bacid_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" onChange="fnValueChange(this)">&nbsp;');
    //javascript:showBacid(objForm.placeHldr,\'ctrl\',\'F\',objForm.placeHldrDesc)"><
    write('<a href="javascript:showBacid(document.forms[0].bacid, \'ctrl\',\'F\',document.forms[0].bacidDesc,null);" id="bacid_searcher">');
    write('<img border="0" height="17" hotKeyId="search2" id="bacid_searcher" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('<input name="' + subGroupName + '.bacidDesc" id="bacidDesc" ' + hintrptProps.get("bacidDesc_ENABLED") + ' type="text" size="25" maxlength="25" disabled="true" class="label" fdt="default" fblk="defaultFblk1" fds="Y">&nbsp;');
    write('</td>');
	write('<td class="textlabel" id="glAcctNo_label">' + jspResArr.get("FLT111608") + '</td>');
    write('<td class="textfield">');
    write('<input name="' + subGroupName + '.glAcctNo" id="glAcctNo" ' + hintrptProps.get("glAcctNo_ENABLED") + ' hotKeyId="search2" type="text" class="textfieldfont" size="25" maxlength="20" >&nbsp;');
    write('<a href="javascript:showAccountIdList(document.forms[0].glAcctNo, \'ctrl\',\'F\');" id="bacid_searcher">');
    write('<img border="0" height="17" hotKeyId="search2" id="glAcctNo_searcher" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
    write('</td>');
    write('</tr>');
    write('<tr>');
	write('<td class="textlabel" id="setID_label">' + jspResArr.get("FLT111604") + '</td>');
    write('<td class="textfield">');
    write('<input name="' + subGroupName + '.setID" id="setID" ' + hintrptProps.get("setID_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="8" onChange="fnValueChange(this)">&nbsp;');
    write('<a href="javascript:showSetList(document.forms[0].setID, \'ctrl\',\'F\',document.forms[0].setIDDesc);" id="setID_searcher">');
    write('<img border="0" height="17" hotKeyId="search2" id="setID_searcher" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('<input name="' + subGroupName + '.setIDDesc" id="setIDDesc" ' + hintrptProps.get("setIDDesc_ENABLED") + ' type="text" size="25" maxlength="25" disabled="true" class="label" fdt="default" fblk="defaultFblk1" fds="Y">&nbsp;');
    write('</td>');
	write('<td class="textlabel" id="tranID_label">' + jspResArr.get("FLT111609") + '</td>');
    write('<td class="textfield">');
    write('<input name="' + subGroupName + '.tranID" id="tranID" ' + hintrptProps.get("tranID_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="9" >&nbsp;');
   // write('<a href="javascript:showSetList(document.forms[0].tranID, \'ctrl\',\'F\');" id="tranID_searcher">');
    //write('<img border="0" height="17" hotKeyId="search2" id="tranID_searcher" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
    write('</td>');
	write('</tr>');
	write('<tr>');
    write('<td class="textlabel" id="ccy_label">' + jspResArr.get("FLT111605") + '</td>');
    write('<td class="textfield">');
    write('<input name="' + subGroupName + '.ccy" id="ccy" ' + hintrptProps.get("ccy_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" onChange="fnValueChange(this)">&nbsp;');
    write('<a href="javascript:showCurrency(document.forms[0].ccy, \'ctrl\',\'F\',document.forms[0].ccyDesc);" id="ccy_searcher">');
    write('<img border="0" height="17" hotKeyId="search2" id="ccy_searcher" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('<input name="' + subGroupName + '.ccyDesc" id="ccyDesc" ' + hintrptProps.get("ccyDesc_ENABLED") + ' type="text" size="25" maxlength="3" disabled="true" class="label" fdt="default" fblk="defaultFblk1" fds="Y">&nbsp;');
    write('</td>');
	write('<td class="textlabel" id="TranDate_label">' + jspResArr.get("FLT111610") + '</td>');
    write('<td class="textfield">');
    write('<input  hotKeyId="calender1"  type="text" fdt="uidate" class="textfieldfont"  mnebl="false" onChange="javascript:return hintrpt_det_ONCHANGE1(this,this,this);" name="' + subGroupName + '.TranDate_ui" id="TranDate_ui" maxlength="10">');
    write('<a href="javascript:openDate(document.forms[0].TranDate_ui,BODDate)" id="TranDate_searcher">  <img align="absmiddle" alt="Date picker" border="0" height="19"  hotKeyId="calender1" src="../Renderer/images/'+applangcode+'/calender.gif" width="24" class="img" >');
    write('</a>');
    write('</td>');
	write('</tr>');
	write('<tr>');
    write('<td class="textlabel" id="StartDate_label">' + jspResArr.get("FLT111606") + '</td>');
    write('<td class="textfield">');
    write('<input  hotKeyId="calender1"  type="text" fdt="uidate" class="textfieldfont"  mnebl="false" onBlur="javascript:return hintrpt_det_ONCHANGE1(this,this,this);" name="' + subGroupName + '.StartDate_ui" id="StartDate_ui" maxlength="10">');
    write('<a href="javascript:openDate(document.forms[0].StartDate_ui,BODDate)" id="StartDate_searcher">  <img align="absmiddle" alt="Date picker" border="0" height="19"  hotKeyId="calender1" src="../Renderer/images/'+applangcode+'/calender.gif" width="24" class="img" >');
    write('</a>');
    write('</td>');
    write('</tr>');
    write('<tr>');
    write('<td class="textlabel" id="EndDate_label">' + jspResArr.get("FLT111607") + '</td>');
    write('<td class="textfield">');
    write('<input  hotKeyId="calender2"  type="text" fdt="uidate" class="textfieldfont"  mnebl="false" onBlur="javascript:return hintrpt_det_ONCHANGE1(this,this,this);" name="' + subGroupName + '.EndDate_ui" id="EndDate_ui" maxlength="10">');
    write('<a  href="javascript:openDate(document.forms[0].EndDate_ui,BODDate)" id="EndDate_searcher">  <img align="absmiddle" alt="Date picker" border="0" height="19"  hotKeyId="calender2" src="../Renderer/images/'+applangcode+'/calender.gif" width="24" class="img">');
    write('</a>');
    write('</td>');
    write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px"> </td>');
	write('<td class="textfield"> </td>');
	write('<td class="columnwidth" > </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfield"> </td>');
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
	write('<input type="button" class="Button" id="_BackRef_" value="'+jspResArr.get("FLT000192")+ '" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	if(funcCode !='I'){
	write('<div class="ctable">');
	write('<input id="Submit" name="Submit" type="button" class="button"	onClick="javascript:return hintrpt_det_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT000193") + '" hotKeyId="Submit">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="' + jspResArr.get("FLT000192") + '"	onClick="javascript:return hintrpt_det_ONCLICK3(this,this.id);"" hotKeyId="Cancel">');
	}else{
	write('<div class="ctable">');
	write('<input class="button" type="button" id="Back" value="'+jspResArr.get("FLT001166")+ '" onClick="javascript:return doSubmit(this.id)" hotKeyId="Ok">');
	}
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{

	var ObjForm = document.forms[0];

	pre_ONLOAD('hintrpt_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	if(funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='U' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
		fnDisableFormDataControls('V',ObjForm,0);
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('hintrpt_det',this);
	//alert(RadioValue);
	if(RadioValue=='2')
	{
		document.forms[0].radiobtn[1].checked = true;
		document.getElementById('bacid').style.visibility='hidden';
		document.getElementById('setID').style.visibility='hidden';
		document.getElementById('ccy').style.visibility='hidden';
		document.getElementById('bacidDesc').style.visibility='hidden';
		document.getElementById('setIDDesc').style.visibility='hidden';
		document.getElementById('ccyDesc').style.visibility='hidden';
		document.getElementById('StartDate_ui').style.visibility='hidden';
		document.getElementById('EndDate_ui').style.visibility='hidden';
		document.getElementById('bacid_label').style.visibility='hidden';
		document.getElementById('setID_label').style.visibility='hidden';
		document.getElementById('ccy_label').style.visibility='hidden';
		document.getElementById('StartDate_label').style.visibility='hidden';
		document.getElementById('EndDate_label').style.visibility='hidden';
		document.getElementById('glAcctNo').style.visibility='visible';
		document.getElementById('tranID').style.visibility='visible';
		document.getElementById('TranDate_ui').style.visibility='visible';
		document.getElementById('glAcctNo_label').style.visibility='visible';
		document.getElementById('tranID_label').style.visibility='visible';
		document.getElementById('TranDate_label').style.visibility='visible';
		hideImage("bacid_searcher");
		hideImage("setID_searcher");
		hideImage("ccy_searcher");
		hideImage("StartDate_searcher");
		hideImage("EndDate_searcher");
		showImage("glAcctNo_searcher");
		showImage("tranID_searcher");
		showImage("TranDate_searcher");
	}
	else
	{
		document.forms[0].radiobtn[0].checked = true;
		document.getElementById('bacid').style.visibility='visible';
		document.getElementById('setID').style.visibility='visible';
		document.getElementById('ccy').style.visibility='visible';
		document.getElementById('bacidDesc').style.visibility='visible';
		document.getElementById('setIDDesc').style.visibility='visible';
		document.getElementById('ccyDesc').style.visibility='visible';
		document.getElementById('StartDate_ui').style.visibility='visible';
		document.getElementById('EndDate_ui').style.visibility='visible';
		document.getElementById('bacid_label').style.visibility='visible';
		document.getElementById('setID_label').style.visibility='visible';
		document.getElementById('ccy_label').style.visibility='visible';
		document.getElementById('StartDate_label').style.visibility='visible';
		document.getElementById('EndDate_label').style.visibility='visible';
		document.getElementById('glAcctNo').style.visibility='hidden';
		document.getElementById('tranID').style.visibility='hidden';
		document.getElementById('TranDate_ui').style.visibility='hidden';
		document.getElementById('glAcctNo_label').style.visibility='hidden';
		document.getElementById('tranID_label').style.visibility='hidden';
		document.getElementById('TranDate_label').style.visibility='hidden';
		showImage("bacid_searcher");
		showImage("setID_searcher");
		showImage("ccy_searcher");
		showImage("StartDate_searcher");
		showImage("EndDate_searcher");
		hideImage("glAcctNo_searcher");
		hideImage("tranID_searcher");
		hideImage("TranDate_searcher");
	}
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];
	if(!(ObjForm.radiobtn[0].checked) && !(ObjForm.radiobtn[1].checked)){
		alert("Please select the Type");
		return false;
	}
	
	if(document.forms[0].radiobtn[0].checked == true)
	{
		if(ObjForm.bacid.value == "" && ObjForm.setID.value == "" &&  ObjForm.ccy.value == "" && ObjForm.StartDate_ui.value == "" && ObjForm.EndDate_ui.value == "")
		{
			alert("Please enter either combination of Account Placeholder,Set id & Currency OR combination of Start date & End date OR both");
			ObjForm.bacid.focus();
			return false;
		}
		if((ObjForm.bacid.value != "" && (ObjForm.setID.value == "" ||  ObjForm.ccy.value == "")) || (ObjForm.setID.value != "" && (ObjForm.bacid.value == "" ||  ObjForm.ccy.value == "")) || (ObjForm.ccy.value != "" && (ObjForm.setID.value == "" ||  ObjForm.bacid.value == "")))
		{
			alert("Please enter either combination of Account Placeholder,Set id & Currency OR combination of Start date & End date OR both");
			ObjForm.bacid.focus();
			return false;
		}
		if((ObjForm.StartDate_ui.value != "" && ObjForm.EndDate_ui.value == "") || (ObjForm.StartDate_ui.value == "" && ObjForm.EndDate_ui.value != ""))
		{
			alert("Start Date and End Date are co-mandatory");
			ObjForm.StartDate_ui.focus();
			return false;
		}
	}

	if(document.forms[0].radiobtn[1].checked == true){
		if(ObjForm.glAcctNo.value == "" && ObjForm.tranID.value == "" && ObjForm.TranDate_ui.value == ""){
			alert("Please enter either GL account number OR combination of Tran Id and Tran Date OR both");
			ObjForm.glAcctNo.focus();
			return false;
		}
		if((ObjForm.tranID.value != "" && ObjForm.TranDate_ui.value == "") || (ObjForm.tranID.value == "" && ObjForm.TranDate_ui.value != "")){
			alert("Tran id and tran date are co-mandatory");
			ObjForm.tranID.focus();
			return false;
		}
	}
	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	ObjForm.radiobtn.value = radiobtn;
	ObjForm.bacid.value = bacid;
	ObjForm.bacidDesc.value = bacidDesc;
	ObjForm.setID.value = setID;
	ObjForm.setIDDesc.value = setIDDesc;
	ObjForm.ccy.value = ccy;
	ObjForm.ccyDesc.value = ccyDesc;
	ObjForm.StartDate.value = StartDate;
	ObjForm.EndDate.value = EndDate;
	ObjForm.glAcctNo.value = glAcctNo;
	ObjForm.tranID.value = tranID;
	ObjForm.TranDate.value = TranDate;
	fnCheckControls();

}

function fnCheckControls()
{
	var ObjForm = document.forms[0];

	checkRadio(ObjForm.radiobtn,radiobtn);
}

function hintrpt_det_ONCHANGE1(obj,p1,p2)
{
    var retVal = "";
    if (pre_ONCHANGE('hintrpt_det',obj) == false) {
        return false;
    }
    if ((retVal = onBlurFormatDate(p1)) == false) {
        return false;
    }
    if ((retVal = fnAssignDateOnEnter(p2)) == false) {
        return false;
    }
    if (post_ONCHANGE('hintrpt_det',obj) == false) {
        return false;
    }
    return (retVal == undefined) ? true : retVal;
}

function hintrpt_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (preEventCall('hintrpt_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('hintrpt_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hintrpt_det_ONCLICK3(obj,p1)
{
	var retVal = "";
	var ObjForm = document.forms[0];

	ObjForm.radiobtn[0].checked=false;
	ObjForm.radiobtn[1].checked=false;

	if (preEventCall('hintrpt_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  doSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('hintrpt_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function fnValueChange(obj)
{
	if(obj.id=="bacid")
	{
		document.forms[0].bacidDesc.value="";
	}
	if(obj.id=="setID")
	{
		document.forms[0].setIDDesc.value="";
	}
	if(obj.id=="ccy")
	{
		document.forms[0].ccyDesc.value="";
	}
}
function showCritScreen(obj)	
{
	if(document.forms[0].radiobtn[0].checked == true)
	{
		document.forms[0].bacid.value="";
		document.forms[0].setID.value="";
		document.forms[0].ccy.value="";
		document.forms[0].bacidDesc.value="";
		document.forms[0].setIDDesc.value="";
		document.forms[0].ccyDesc.value="";
		document.forms[0].StartDate.value="";
		document.forms[0].StartDate_ui.value="";
		document.forms[0].EndDate.value="";
		document.forms[0].EndDate_ui.value="";
		document.getElementById('bacid').style.visibility='visible';
		document.getElementById('setID').style.visibility='visible';
		document.getElementById('ccy').style.visibility='visible';
		document.getElementById('bacidDesc').style.visibility='visible';
		document.getElementById('setIDDesc').style.visibility='visible';
		document.getElementById('ccyDesc').style.visibility='visible';
		document.getElementById('StartDate_ui').style.visibility='visible';
		document.getElementById('EndDate_ui').style.visibility='visible';
		document.getElementById('bacid_label').style.visibility='visible';
		document.getElementById('setID_label').style.visibility='visible';
		document.getElementById('ccy_label').style.visibility='visible';
		document.getElementById('StartDate_label').style.visibility='visible';
		document.getElementById('EndDate_label').style.visibility='visible';
		document.getElementById('glAcctNo').style.visibility='hidden';
		document.getElementById('tranID').style.visibility='hidden';
		document.getElementById('TranDate_ui').style.visibility='hidden';
		document.getElementById('glAcctNo_label').style.visibility='hidden';
		document.getElementById('tranID_label').style.visibility='hidden';
		document.getElementById('TranDate_label').style.visibility='hidden';
		showImage("bacid_searcher");
		showImage("setID_searcher");
		showImage("ccy_searcher");
		showImage("StartDate_searcher");
		showImage("EndDate_searcher");
		hideImage("glAcctNo_searcher");
		hideImage("tranID_searcher");
		hideImage("TranDate_searcher");
	}
	else
	{
		if(document.forms[0].radiobtn[1].checked == true)
		{
			document.forms[0].glAcctNo.value="";
			document.forms[0].tranID.value="";
			document.forms[0].TranDate.value="";
			document.forms[0].TranDate_ui.value="";
			document.getElementById('bacid').style.visibility='hidden';
			document.getElementById('setID').style.visibility='hidden';
			document.getElementById('ccy').style.visibility='hidden';
			document.getElementById('bacidDesc').style.visibility='hidden';
			document.getElementById('setIDDesc').style.visibility='hidden';
			document.getElementById('ccyDesc').style.visibility='hidden';
			document.getElementById('StartDate_ui').style.visibility='hidden';
			document.getElementById('EndDate_ui').style.visibility='hidden';
			document.getElementById('bacid_label').style.visibility='hidden';
			document.getElementById('setID_label').style.visibility='hidden';
			document.getElementById('ccy_label').style.visibility='hidden';
			document.getElementById('StartDate_label').style.visibility='hidden';
			document.getElementById('EndDate_label').style.visibility='hidden';
			document.getElementById('glAcctNo').style.visibility='visible';
			document.getElementById('tranID').style.visibility='visible';
			document.getElementById('TranDate_ui').style.visibility='visible';
			document.getElementById('glAcctNo_label').style.visibility='visible';
			document.getElementById('tranID_label').style.visibility='visible';
			document.getElementById('TranDate_label').style.visibility='visible';
			hideImage("bacid_searcher");
			hideImage("setID_searcher");
			hideImage("ccy_searcher");
			hideImage("StartDate_searcher");
			hideImage("EndDate_searcher");
			showImage("glAcctNo_searcher");
			showImage("tranID_searcher");
			showImage("TranDate_searcher");
		}
		else
		{
			alert("Please select the type");
		}
	}
}

