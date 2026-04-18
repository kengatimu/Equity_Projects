function printBlock()
{
	writeCustomHeader("ccommnt_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT033459") + '</td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT006657") + '</td>');
	write('<td class="textfielddisplaylabel"> '  + fnGetFunctionCodeDesc(funcCode) +  '</td>');
	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfielddisplaylabel"> </td>');
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
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT033469") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.commCode" id="commCode"  fdt="String" ' + ccommntProps.get("commCode_ENABLED") + ' style="width: 175px;">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT033470") + ' <script>setMandatory("Y");</script></td>');
	write('<td class="textfield" rowspan="2">');
	write('<textarea class="textfieldfont" name="' + subGroupName + '.commDesc" id="commDesc"  fdt="String" ' + ccommntProps.get("commDesc_ENABLED") + '  style="width: 200px;"></textarea>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT033491") + ' <script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<input hotKeyId="search1" type="text" class="textfieldfont" name="' + subGroupName + '.commCrncy" id="commCrncy"  fdt="String" ' + ccommntProps.get("commCrncy_ENABLED") + ' maxlength="3"  onBlur="javascript:return validateCurrency(this);"  style="width: 40px;">');
	write('  <a  id ="sLnk2" href="javascript:getRefCrncyList()">');
	write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="15">');
	write('</a>');
	write('  <input type="text" class="textfieldfont" name="' + subGroupName + '.commAmt" id="commAmt"  fdt="String" ' + ccommntProps.get("commAmt_ENABLED") + ' maxlength="23" style="width: 114px;">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfield">  </td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT033492") + '  <script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.commVat" id="commVat"  fdt="String" ' + ccommntProps.get("commVat_ENABLED") + ' maxlength="23" style="width: 175px;">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT026527") + ' <script>setMandatory("Y");</script></td>');
	write('<td class="textfield" rowspan="2">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.placeHolder" id="placeHolder"  fdt="String" ' + ccommntProps.get("placeHolder_ENABLED") + ' maxlength="23" style="width: 175px;"  onChange="javascript:return validatePlaceHolder(this);" >');
	write('   <a id="sLnk3" href="javascript:showBacid(document.forms[0].placeHolder,\'ctrl\',\'F\',document.forms[0].placeHldrDesc)">');
	write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="15">');
	write('</a>');
	write('   <input id="placeHldrDesc" name="' + subGroupName + '.placeHldrDesc" type="text" disabled="true" class="label" size="25" maxlength="25" fdt="default" fblk="blk" fds="Y">');
	write('</td>');
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
	write('<input type="button" class="Button" id="_BackRef_" value="'+jspResArr.get("FLT001721")+ '" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	if(funcCode !='I'){
	write('<div class="ctable">');
	write('<input id="Submit" name="Submit" type="button" class="button"	onClick="javascript:return ccommnt_det_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT000193") + '" hotKeyId="Submit">');
	write('<input id="Validate" name="Validate" type="button" class="button" value="' + jspResArr.get("FLT000194") + '"	onClick="javascript:return ccommnt_det_ONCLICK2(this,this);"" hotKeyId="Validate">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="' + jspResArr.get("FLT001721") + '"	onClick="javascript:return ccommnt_det_ONCLICK3(this,this.id);"" hotKeyId="Cancel">');
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

	pre_ONLOAD('ccommnt_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	if(funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='R' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
		fnDisableFormDataControls('V',ObjForm,0);
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('ccommnt_det',this);
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	ObjForm.commCode.value = commCode;
	ObjForm.commDesc.value = commDesc;
	ObjForm.commCrncy.value = commCrncy;
	ObjForm.commAmt.value = commAmt;
	ObjForm.commVat.value = commVat;
	ObjForm.commCode.readOnly=true;
	ObjForm.placeHolder.value = placeHolder;
	ObjForm.placeHldrDesc.value = placeHldrDesc;
}


function ccommnt_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (preEventCall('ccommnt_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('ccommnt_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ccommnt_det_ONCLICK2(obj,p1)
{
	var retVal = "";
	if (preEventCall('ccommnt_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('ccommnt_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ccommnt_det_ONCLICK3(obj,p1)
{
	var retVal = "";
	if (preEventCall('ccommnt_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  doSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('ccommnt_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
