function printBlock()
{
	writeCustomHeader("cbwf_det");
	with (document){
	write('<input type="hidden" id="RecVerifyType" name="' + subGroupName + '.RecVerifyType">');
write('<input type="hidden" id="custDob" fdt="fdate" mneb1="N" vFldId="custDob_ui" name="' + subGroupName + '.custDob">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">'+menuTitle+'</td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT006657") + '</td>');
	funcCodeDesc = "";
	if(funcCode == "A"){
		funcCodeDesc = "Add";
	}
	if(funcCode == "M"){
		funcCodeDesc = "Modify";
	}
	if(funcCode == "I"){
		funcCodeDesc = "Inquire";
	}
	if(funcCode == "X"){
		funcCodeDesc = "Cancel";
	}
	if(funcCode == "V"){
		funcCodeDesc = "Verify";
	}
	if(funcCode == "D"){
		funcCodeDesc = "Delete";
	}
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + funcCodeDesc + '</label>');
	write('</td>');
	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfielddisplaylabel"> </td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT131874") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + idType + '</label>');
	write('</td>');
	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT131859") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + UniqIdNum + '</label>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('<br />');
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
	write('<a href="javascript:showHelpFile(\'det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="17" height="17" vspace="1" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
////////////////
	write('<tr valign="middle" class="subhdrbg">');
	write('<td colspan="3" class="subhdr">' + jspResArr.get("FLT031878") + '</td>');
	write('<td colspan="3" align="right" valign="middle">&nbsp;&nbsp;</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031874") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.custId" id="custId" readonly fdt="String" ' + cbwfProps.get("custId_ENABLED") + '>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT147999") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.custName" id="custName"  fdt="String" ' + cbwfProps.get("custName_ENABLED") + '>');
	write('</td>');
	write('</tr>');
////////////////
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031879") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.custBranch" id="custBranch" readonly fdt="String" ' + cbwfProps.get("custBranch_ENABLED") + '>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT003837") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.custConst" id="custConst" readonly fdt="String" ' + cbwfProps.get("custConst_ENABLED") + '>');
	write('</td>');
	write('</tr>');
////////////////
	write('<tr>');
        write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT131879") + '</td>');
        //write('<td class="textfield"><input id="custDob_ui" name="' + subGroupName + '.custDob_ui" hotKeyId="calender1" ' +cbwfProps.get("custDob_ENABLED") + ' type="text" class="textfieldfont" maxlength="10" fmnd="Y" mnebl="false" fmb="N" fdt="uidate" fblk="defaultFblk1" onBlur="javascript:return cbwf_det_ONBLUR1(this,this,this);">');
        write('<td class="textfield"><input id="custDob_ui" name="' + subGroupName + '.custDob_ui" hotKeyId="calender1" ' +cbwfProps.get("custDob_ENABLED") + ' type="text" class="textfieldfont" maxlength="10" fmnd="Y" mnebl="false" fmb="N" fdt="uidate" fblk="defaultFblk1" >');
        write('&nbsp;   <a id="sLnk1" href="javascript:openDate(document.forms[0].custDob_ui,BODDate)">');
        write('<img width="24" height="19" src="../images/' + applangcode + '/calender.gif" align="absmiddle" border="0" alt="Date picker" class="img" hotKeyId="calender1"></a>');
        write('</td>');
        write('<td class="columnwidth"> </td>');
        write('<td class="textlabel">' + jspResArr.get("FLT103837") + '</td>');
        write('<td class="textfield">');
        write('<input type="text" class="textfieldfont" name="' + subGroupName + '.custCntyOrg" id="custCntyOrg"  fdt="String" ' + cbwfProps.get("custCntyOrg_ENABLED") + '>');
        write('</td>');
        write('</tr>');
////////////////
	write('<tr valign="middle" class="subhdrbg">');
	write('<td colspan="3" class="subhdr">' + jspResArr.get("FLT031942") + '</td>');
	write('<td colspan="3" align="right" valign="middle">&nbsp;&nbsp;</td>');
	write('</tr>');
////////////////
	write('<tr>');
        write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031945") + '</td>');
        write('<td class="textfield">');
        write('<select name="' + subGroupName + '.blackReason" id="blackReason" style="width: 218px" fdt="String" ' + cbwfProps.get("blackReason_ENABLED") + '>');
        write('<option value="">' + jspResArr.get("FLT031311") + '</option>');
        write('<option value="FR">' + jspResArr.get("FLT012405") + '</option>');
        write('<option value="TE">' + jspResArr.get("FLT013286") + '</option>');
        write('<option value="CO">' + jspResArr.get("FLT013287") + '</option>');
        write('<option value="ML">' + jspResArr.get("FLT013288") + '</option>');
        write('<option value="TR">' + jspResArr.get("FLT013289") + '</option>');
        write('<option value="TF">' + jspResArr.get("FLT013290") + '</option>');
        write('<option value="GG">' + jspResArr.get("FLT013291") + '</option>');
        write('<option value="PR">' + jspResArr.get("FLT013292") + '</option>');
        write('<option value="OC">' + jspResArr.get("FLT013293") + '</option>');
        write('<option value="VC">' + jspResArr.get("FLT613293") + '</option>');
        write('<option value="OP">' + jspResArr.get("FLT713293") + '</option>');
        write('<option value="UL">' + jspResArr.get("FLT713243") + '</option>');
        write('<option value="PS">' + jspResArr.get("FLT793243") + '</option>');
        write('</select>');
        write('</td>');
        write('<td class="columnwidth"></td>');
        write('<td class="textlabel">' + jspResArr.get("FLT031946") + '</td>');
        write('<td class="textfield">');
        //write('<input type="text" class="textfieldfont" name="' + subGroupName + '.evideNce" id="evideNce" style="TEXT-ALIGN:right" fdt="String" ' + cbwfProps.get("evideNce_ENABLED") + '>');
        write('<select name="' + subGroupName + '.evideNce" id="evideNce" style="width: 218px" fdt="String" ' + cbwfProps.get("evideNce_ENABLED") + '>');
        write('<option value="">' + jspResArr.get("FLT031311") + '</option>');
        write('<option value="WC">' + jspResArr.get("FLT531946") + '</option>');
        write('<option value="GP">' + jspResArr.get("FLT551946") + '</option>');
        write('<option value="CO">' + jspResArr.get("FLT651946") + '</option>');
        write('<option value="BI">' + jspResArr.get("FLT651846") + '</option>');
        write('<option value="OS">' + jspResArr.get("FLT651849") + '</option>');
        write('</td>');
        write('</tr>');
////////////////
	write('<tr>');
        write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT013294") + '</td>');
        write('<td class="textfield">');
        write('<select name="' + subGroupName + '.WatchList" id="WatchList" style="width: 218px" fdt="String" ' + cbwfProps.get("WatchList_ENABLED") + '>');
        write('<option value="">' + jspResArr.get("FLT013298") + '</option>');
        write('<option value="B">' + jspResArr.get("FLT013295") + '</option>');
        write('<option value="W">' + jspResArr.get("FLT013296") + '</option>');
        write('</select>');
        write('</td>');
        write('<td class="columnwidth"></td>');
        write('<td class="textlabel">' + jspResArr.get("FLT013297") + '</td>');
        write('<td class="textfield">');
        write('<input type="text" class="textfieldfont" name="' + subGroupName + '.WatchListReson" id="WatchListReson" style="TEXT-ALIGN:right" fdt="String" ' + cbwfProps.get("WatchListReson_ENABLED") + '>');
        write('</td>');
        write('</tr>');
////////////////


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
	write('<input type="button" class="Button" id="_BackRef_" value="'+jspResArr.get("FLT001721")+ '" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	if(funcCode !='I'){
	write('<div class="ctable">');
	write('<input id="Submit" name="Submit" type="button" class="button"	onClick="javascript:return cbwf_det_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT000193") + '" hotKeyId="Submit">');
	write('<input id="Validate" name="Validate" type="button" class="button" value="' + jspResArr.get("FLT000194") + '" onClick="javascript:return cbwf_det_ONCLICK2(this,this);"" hotKeyId="Validate">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="' + jspResArr.get("FLT001721") + '"	onClick="javascript:return cbwf_det_ONCLICK3(this,this.id);"" hotKeyId="Cancel">');
	}else{
	write('<div class="ctable">');
	write('<input class="button" type="button" id="Back" value="'+jspResArr.get("FLT026526")+ '" onClick="javascript:return doSubmit(this.id)" hotKeyId="Ok">');
	}
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	initFocusHandler();

	pre_ONLOAD('cbwf_det',this);

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

	document.forms[0].chrgAcc.focus();

	post_ONLOAD('cbwf_det',this);
}

function fnCheckMandatoryFields(){
	var ObjForm = document.forms[0];
	return true;
}
function fnPopulateControlValues(){ 
	var ObjForm = document.forms[0];
        ObjForm.custId.value = custId;
        ObjForm.custName.value = custName;
        ObjForm.custBranch.value = custBranch;
        ObjForm.custConst.value = custConst;
        ObjForm.custDob.value = custDob;
        ObjForm.custDob_ui.value = custDob;
        ObjForm.custCntyOrg.value = custCntyOrg;
        ObjForm.blackReason.value = blackReason;
        ObjForm.evideNce.value = evideNce;
        ObjForm.WatchList.value = WatchList;
        ObjForm.WatchListReson.value = WatchListReson;
	ObjForm.RecVerifyType.value = RecVerifyType;
}
function cbwf_det_ONCLICK1(obj,p1){
	var retVal = "";
	if (preEventCall('cbwf_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cbwf_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
function cbwf_det_ONCLICK2(obj,p1)
{
	var retVal = "";
	if (preEventCall('cbwf_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cbwf_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
function cbwf_det_ONCLICK3(obj,p1)
{
	var retVal = "";
	if (preEventCall('cbwf_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  doSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cbwf_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

