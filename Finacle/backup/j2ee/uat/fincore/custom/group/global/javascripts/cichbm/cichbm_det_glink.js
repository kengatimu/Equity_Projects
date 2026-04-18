function printBlock()
{
	writeCustomHeader("cichbm_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">Inhouse Cheque Book Maintenance</td>');
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
	write('<a href="javascript:showHelpFile(\'cichbm_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
	write('</tr>');
	write('<tr>');
    write('<td class="textlabel">' + jspResArr.get("FLT026332") + '<font color="red" size="2"> *</font></td>');
    write('<td><select name="' + subGroupName + '.funcCode" id="funcCode" ' + cichbmProps.get("funcCode_ENABLED") + ' class="textfieldfont">');
    write('<option value ="" selected>' + jspResArr.get("FLT000005") + '</option>');
    write('<option value="D">' + jspResArr.get("FLT000006") + '</option>');
    write('<option value="S">' + jspResArr.get("FLT000009") + '</option>');
    write('<option value="I">' + jspResArr.get("FLT000010") + '</option>');
    write('</select>');
    write('</td>');
    write('<td>&nbsp;</td>');
    write('<td>&nbsp;</td>');
    write('<td>&nbsp;</td>');
    write('</tr>');
	
	
    write('<tr>');
    write('<td class="textlabel">' + jspResArr.get("FLT026333") +'<font color=red size=2>*</font></td>');
    write('<td><input name="' + subGroupName + '.foracid" id="foracid" ' + cichbmProps.get("foracid_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" onChange= "javascript:fnOnchange();" >');
    write('<a href="javascript:fnshowAccountIdList(document.forms[0].foracid);" id="foracid">');
    write('<img id="benfList1" width="16" height="17" border="0"  hotKeyId="search1" src="../Renderer/images/search_icon.gif"></img></a>');
    write('</td>');
    write('<td>&nbsp;</td>');
    write('<td>&nbsp;</td>');
    write('<td>&nbsp;</td>');
    write('</tr>');
	
	write('<tr>');
    write('<td class="textlabel">' + jspResArr.get("FLT026334") + '<font color=red size=2>*</font></td>');
    write('<td><input name="' + subGroupName + '.instrNo" id="instrNo" ' + cichbmProps.get("instrNo_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
    write('&nbsp;<a target="_self" id="sLnk3" href="JavaScript:getInstrTypeList(document.forms[0].instrNo,document.forms[0].instrNo.value,\'ctrl\',\'F\')">');    
write('<IMG src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border=0 hotKeyId="search3"></IMG></a>');
    write('</td>');
    write('</tr>');
	
	write('<tr>');
    write('<td class="textlabel">' + jspResArr.get("FLT026335") + '<font color=red size=2>*</font></td>');
    write('<td><input name="' + subGroupName + '.bgChqNo" id="bgChqNo" ' + cichbmProps.get("bgChqNo_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
    write('</td>');
    write('</tr>');
	
	write('<tr>');
    write('<td class="textlabel">' + jspResArr.get("FLT026336") + '<font color=red size=2>*</font></td>');
    write('<td><input name="' + subGroupName + '.noOfLeav" id="noOfLeav" ' + cichbmProps.get("noOfLeav_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
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
	write('<input name="Submit" type="button" class="button" onClick="javascript:return cichbm_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	write('<input name="Clear" type="button" class="button" onClick="javascript:return cichbm_det_ONCLICK2(this);" id="Clear" value="Clear">');
	}
	else{
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

	pre_ONLOAD('cichbm_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

//	if(funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='U' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
//		fnDisableFormControls(ObjForm);
//	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}


//	fnPostOnLoad()
	post_ONLOAD('cichbm_det',this);
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
    ObjForm.instrNo.value =instrNo ;
    ObjForm.bgChqNo.value = bgChqNo;
	ObjForm.noOfLeav.value =noOfLeav ;
}


function cichbm_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (pre_ONCLICK('cichbm_det',obj) == false) { 
		return false;
	}
	if(isNaN(document.forms[0].bgChqNo.value) )
    {
    	alert("Please Enter a valid begin  Cheque Number");
        document.forms[0].bgChqNo.focus();
        return false;
    }
    if(isNaN(document.forms[0].noOfLeav.value) )
    {
    	alert("Please Enter a valid Number for No of Leaves");
        document.forms[0].noOfLeav.focus();
        return false;
    }
	if(document.forms[0].funcCode.value == "I" ){	
   		if(fnIsNull(document.forms[0].foracid.value) )
    	{
    		alert("Please Enter a valid Account Number" );
			document.forms[0].foracid.focus();
       		return false;
    	}
    	if(fnIsNull(document.forms[0].instrNo.value) )
   		{
    		alert("Please Enter a valid Instrument Type");
       		document.forms[0].instrNo.focus();
        	return false;
    	}
	
		if(document.forms[0].funcCode.value == "I") {
		var instNo  = document.forms[0].instrNo.value;
        var forAcid = document.forms[0].foracid.value;
        var inputNameValues = "instNo" +"|" +instNo + "|" + "forAcid" + "|" + forAcid ;
        var outputNames = "status|reqid|acctNum|numofchb|numofchqlvs|reqdate|reqst";
        var scrName     = "ichqbookmaintdp002.scr";
        var title  = "List of Cheque Books";
        var literalNames="Bgn chq No|Leaves|Issue Date|P|U|S|D";
        var hyperLnks   = "8";
        var retVal = fnExecuteScriptForList(inputNameValues, outputNames, scrName, title, literalNames, hyperLnks, true);
        var retVal = "";
      	cichbm_det_ONCLICK2(document.forms[0].Clear);
		}
	}
	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cichbm_det_ONCLICK2(obj)
{
	var retVal = "";
	if (pre_ONCLICK('cichbm_det',obj) == false) { 
		return false;
	}
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (post_ONCLICK('cichbm_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function fnshowAccountIdList(obj){
    showAccountIdList(obj,null,null,'F');
	fnOnchange();
}

function fnCustSearcher() {
	showSolId(document.forms[0].solID,'ctrl','F',document.forms[0].solIdDesc);
}
function fnOnchange() {
        var inputNameValues = "acctNum|"+document.forms[0].foracid.value;
        var outputNames     = "";
        var scrName         = "formatacctdp001.scr";
        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret1 = retVal.split("|");
        if(ret1[0] == "MSG" )
        {
                alert(ret1[1]);
        }
}
