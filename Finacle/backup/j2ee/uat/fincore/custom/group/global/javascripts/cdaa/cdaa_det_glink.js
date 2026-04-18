function printBlock()
{
	writeCustomHeader("cdaa_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">Dormant Account Activation</td>');
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
	write('<a href="javascript:showHelpFile(\'cdaa_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026332") +'<font color=red size=2>*</font></td>');
	write('<td class="textfield"><select name="' + subGroupName + '.funcCode" id="funcCode" class="listboxfont">');
	write('<option value="" selected>' + jspResArr.get("FLT026341") + '</option>');
    write('<option value="A">' + jspResArr.get("FLT026342") + '</option>');
	write('<option value="V">' + jspResArr.get("FLT026343") + '</option>');
	write('<option value="X">' + jspResArr.get("FLT026344") + '</option>');
    write('</select>');
    write('</td>');
    write('<td>&nbsp;</td>');
    write('<td>&nbsp;</td>');
    write('<td>&nbsp;</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026333") +'<font color=red size=2>*</font></td>');
	write('<td><input name="' + subGroupName + '.foracid" id="foracid" ' + cdaaProps.get("foracid_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" onChange="javascript:fnCustValidate();" >');
	write('<a href="javascript:fnshowAccountIdList(document.forms[0].foracid);" id="actNoList">');
	write('<img id="benfList1" width="16" height="17" border="0"  hotKeyId="search1" src="../Renderer/images/search_icon.gif"></img></a>');
	//jane
	write('&nbsp;<input name="' + subGroupName + '.acctname" id="acctname" ' + cdaaProps.get("acctname_ENABLED") + ' type="text" disabled="true" class="label onChange="javascript:fnname(foracid);">');
	//
	write('</td>');
    write('<td>&nbsp;</td>');
    write('<td>&nbsp;</td>');
    write('<td>&nbsp;</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026334") + '</td>');
	write('<td><input name="' + subGroupName + '.currsts" id="currsts" ' + cdaaProps.get("currsts_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="1" >');
	write('</td>');
    write('<td>&nbsp;</td>');
    write('<td>&nbsp;</td>');
    write('<td>&nbsp;</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026335") + '</td>');
	write('<td><input name="' + subGroupName + '.newsts" id="newsts" ' + cdaaProps.get("newsts_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" value="A" >');
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
	if(funcCode =='A'){
	write('<div class="ctable">');
	write('<input name="Submit" type="button" class="button" onClick="javascript:return cdaa_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	write('<input name="Clear" type="button" class="button" onClick="javascript:return cdaa_det_ONCLICK2(this);" id="Clear" value="Clear">');
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

	pre_ONLOAD('cdaa_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	if(funcCode !='A' || sReferralMode =='I' || sReferralMode =='S'){
		fnDisableFormControls(ObjForm);
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}


//	fnPostOnLoad()
	post_ONLOAD('cdaa_det',this);
		//if (funcCode =='X')
		//{
		//document.forms[0].newsts.disabled = true;
		//document.forms[0].newsts.value = "D";
		//}
	document.forms[0].newsts.disabled = true;
	document.forms[0].newsts.value = "A";
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
	ObjForm.foracid.value = foracid;
	ObjForm.currsts.value = currsts;
}


function cdaa_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (pre_ONCLICK('cdaa_det',obj) == false) { 
		return false;
	}
	if(fnIsNull(document.forms[0].foracid.value)) {
                alert("Enter Account Number ");
                document.forms[0].foracid.focus();
                return false;
    }
	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (post_ONCLICK('cdaa_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cdaa_det_ONCLICK2(obj)
{
	var retVal = "";
	if (pre_ONCLICK('cdaa_det',obj) == false) { 
		return false;
	}
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (post_ONCLICK('cdaa_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
function fnshowAccountIdList(obj){
    showAccountIdList(obj,null,null,'F');
	fnCustValidate();
	fnname();
	memoPad();
}

function fnCustValidate(){
	 memoPad();
	if(fnIsNull(document.forms[0].foracid.value)){
		document.forms[0].currsts.value = "";
	}


	if(document.forms[0].foracid.value != "") {
		memoPad();
		var inputNameValues    = "acctNo|"+document.forms[0].foracid.value;
		var outputNames     = "actext|status";
		var scrName         = "acctValscript.scr";
		var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
		var ret = retVal.split("|");
	
		if( ret[1] == 'C' ) {
			alert("Invalid Account Number-Account is either not Dormant or not a Savings or Current Account");
			document.forms[0].currsts.value = "";
			document.forms[0].foracid.focus();
        	return false;
		}
		else {
			document.forms[0].currsts.value = ret[3];
		}
		memoPad();
	}
	else {
		return true;
	}
		fnname();
}
function memoPad(){
	        var acctNumber = document.forms[0].foracid.value ;
	        var inputNameValues = "acctNum|"+acctNumber ;
	        var outputNames     = "";
	        var scrName         = "formatacctdp001.scr";
	        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
	        var ret1 = retVal.split("|");
	        if(ret1[0] == "MSG" ){
			                alert(ret1[1]);
			        }
}

function fnname(obj)
{
	var dco=document.forms[0].foracid.value;
	var input      = "dco|"+dco;
	var outputNames    = "output|outVal";
	var scrName     =   "b_acctname.scr";
	var retVal = appFnExecuteScript(input,outputNames,scrName,false);
	var retBuff = retVal.split("|");
	var output = retBuff[0];
	var value = retBuff[1];
	var a = value;
			//alert(a);

	document.forms[0].acctname.value=a;

}