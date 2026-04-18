function printBlock()
{
	writeCustomHeader("cfreval_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	if(funcCode == 'A')
	{
		write('<td class="page-heading">Reval Table Maintenance in Add Mode</td>');
		funcDis="Add";
	}
	else if(funcCode == 'M')
    {
        write('<td class="page-heading">Reval Table Maintenance in Modify Mode</td>');
	funcDis="Modify";
    }
	else if(funcCode == 'I')
    {
        write('<td class="page-heading">Reval Table Maintenance in Inquire Mode</td>');
	funcDis="Inquire";
    }
	else if(funcCode == "D")
    {
        write('<td class="page-heading">Reval Table Maintenance in Delete Mode</td>');
	funcDis="Delete";
    }
	write('</tr>');
	write('<tr>');
    write('<td class="textlabel">Function </td>');
    write('<td class="textfielddisplaylabel">'+funcCode+' - '+funcDis+'</td>');
    write('</tr>')
    write('<tr>');
    write('<td class="textlabel">Crncy Code</td>');
    write('<td class="textfielddisplaylabel">'+currCode+'</td>');
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
	write('<a href="javascript:showHelpFile(\'cfreval_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
	write('</tr>');

	write('<tr>');
	if(funcCode == "A" || funcCode == "M")
	{
		write('<td class="textlabel">' + jspResArr.get("FLT026334") + '</td>');
		write('<td><input name="' + subGroupName + '.rateCode" id="rateCode" ' + cfrevalProps.get("rateCode_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
		write('<a href="javascript:getRateCodeList();" id="rateCodeList">');
		write('<img id="benfList1" width="16" height="17" border="0"  hotKeyId="search1" src="../Renderer/images/search_icon.gif"></img></a>');		
		write('</td>');
	}
	else
	{
		write('<td class="textlabel">' + jspResArr.get("FLT026334") + '</td>');
        write('<td><input name="' + subGroupName + '.rateCode" id="rateCode" ' + cfrevalProps.get("rateCode_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	}
	write('</tr>');

	write('<tr>');
	if(funcCode == "A" || funcCode == "M")
	{
		write('<td class="textlabel">' + jspResArr.get("FLT026335") + '</td>');
		write('<td><input name="' + subGroupName + '.pnlAccnt" id="pnlAccnt" ' + cfrevalProps.get("pnlAccnt_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
		write('<a href="javascript:fnshowAccountIdList(document.forms[0].pnlAccnt);" id="actNoList">');
    	write('<img id="benfList1" width="16" height="17" border="0"  hotKeyId="search1" src="../Renderer/images/search_icon.gif"></img></a>');	
		write('</td>');
	}
	else
	{
		write('<td class="textlabel">' + jspResArr.get("FLT026335") + '</td>');
        write('<td><input name="' + subGroupName + '.pnlAccnt" id="pnlAccnt" ' + cfrevalProps.get("pnlAccnt_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
		write('</td>');
	}
		write('</tr>');

	write('<tr>');
	if(funcCode == "A" || funcCode == "M")
    {
		write('<td class="textlabel">' + jspResArr.get("FLT026336") + '</td>');
		write('<td><input name="' + subGroupName + '.homeCyAccnt" id="homeCyAccnt" ' + cfrevalProps.get("homeCyAccnt_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
		write('<a href="javascript:fnshowAccountIdList(document.forms[0].homeCyAccnt);" id="actNoList">');
    	write('<img id="benfList1" width="16" height="17" border="0"  hotKeyId="search1" src="../Renderer/images/search_icon.gif"></img></a>');
		write('</td>');
	}
	else
	{
		write('<td class="textlabel">' + jspResArr.get("FLT026336") + '</td>');
		write('<td><input name="' + subGroupName + '.homeCyAccnt" id="homeCyAccnt" ' + cfrevalProps.get("homeCyAccnt_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
		 write('</td>');
	}
	write('</tr>');

    write('<tr>');
	 if(funcCode == "A" || funcCode == "M")
    {
		write('<td class="textlabel">' + jspResArr.get("FLT026337") + '</td>');
		write('<td><input name="' + subGroupName + '.foreignCyAccnt" id="foreignCyAccnt" ' + cfrevalProps.get("foreignCyAccnt_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
		write('<a href="javascript:fnshowAccountIdList(document.forms[0].foreignCyAccnt);" id="actNoList">');
    	write('<img id="benfList1" width="16" height="17" border="0"  hotKeyId="search1" src="../Renderer/images/search_icon.gif"></img></a>');
		write('</td>');
	}
	else
	{
		write('<td class="textlabel">' + jspResArr.get("FLT026337") + '</td>');
        write('<td><input name="' + subGroupName + '.foreignCyAccnt" id="foreignCyAccnt" ' + cfrevalProps.get("foreignCyAccnt_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
		write('</td>');
	}
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
	write('<input type="button" class="Button" id="Submit" value="Go" onClick="javascript:return doRefSubmit(this);" hotKeyId="Submit" >');
	}
	writeRefFooter();
	write('<input type="button" class="Button" id="_BackRef_" value="CANCEL" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	if(funcCode !='I'){
	write('<div class="ctable">');
	write('<input name="Submit" type="button" class="button" onClick="javascript:return cfreval_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	//write('<input name="Clear" type="button" class="button" onClick="javascript:return cfreval_det_ONCLICK2(this);" id="Clear" value="Clear">');
	write('<input name="Cancel" type="button" class="button" onClick="javascript:return cfreval_det_ONCLICK2(this);" id="Clear" value="Cancel">');
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

	pre_ONLOAD('cfreval_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	if(funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='U' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
		fnDisableFormControls(ObjForm);
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}


//	fnPostOnLoad()
	post_ONLOAD('cfreval_det',this);
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
	ObjForm.rateCode.value = rateCode;
	ObjForm.pnlAccnt.value = pnlAccnt;
	ObjForm.homeCyAccnt.value = homeCyAccnt;
	ObjForm.foreignCyAccnt.value = foreignCyAccnt;
	return true;
}


function cfreval_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if(funcCode == "A" || funcCode == "M")
	{
		if(fnIsNull(document.forms[0].rateCode.value))
		{
			alert("Enter Rate Code");
			document.forms[0].rateCode.focus();
			return false;
		}
   		if(fnIsNull(document.forms[0].pnlAccnt.value)) 
    	{
       		alert("Enter the Pnl Account Number");
       		document.forms[0].pnlAccnt.focus();
       		return false;
    	}
		if(fnIsNull(document.forms[0].homeCyAccnt.value))
        {
            alert("Enter the Home Ccy Account Number");
            document.forms[0].homeCyAccnt.focus();
            return false;
        }
		if(fnIsNull(document.forms[0].foreignCyAccnt.value))
        {
            alert("Enter the Foreign Ccy Account Number");
            document.forms[0].foreignCyAccnt.focus();
            return false;
        }
	}
//	if (pre_ONCLICK('cfreval_det',obj) == false) { 
//		return false;
//	}


	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}

//	if (post_ONCLICK('cfreval_det',obj) == false) { 
//	return false;
//	}
	return (retVal == undefined) ? true : retVal;

}

function cfreval_det_ONCLICK2(obj)
{
	var retVal = "";
	if (pre_ONCLICK('cfreval_det',obj) == false) { 
		return false;
	}
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (post_ONCLICK('cfreval_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
function cfreval_det_ONCLICK3(obj)
{
	var retVal = "";

	if ((retVal = fnClearFields()) == false) {
        return false;
    	}
//	if (pre_ONCLICK('cfreval_det',obj) == false) { 
//		return false;
//	}
//	if ((retVal = doSubmit()) == false) {
//		return false;
//	}
//	if (post_ONCLICK('cfreval_det',obj) == false) { 
//		return false;
//	}
	return (retVal == undefined) ? true : retVal;
}

function fnshowAccountIdList(obj){
    showAccountIdList(obj,null,null,'F');
	fnCustValidate();
}

function getRateCodeList(){
	showRefCode(document.forms[0].rateCode,'67','N','B');
}
