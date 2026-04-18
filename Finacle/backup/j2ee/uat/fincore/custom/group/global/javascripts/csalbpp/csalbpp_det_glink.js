function printBlock()
{
	writeCustomHeader("csalbpp_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">SALARY BATCH PROOF MENU</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="page-heading">Salary Upload Maintenance</td>');
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
	write('<a href="javascript:showHelpFile(\'csalbpp_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
	write('</tr>');

	write('<tr>');
       write('<td class="textlabel">' + jspResArr.get("FLT026332") + '<font color="red" size="2"> *</font></td>');
      write('<td><select name="' + subGroupName + '.funCode" id="funCode" ' + csalbppProps.get("funCode_ENABLED") + ' class="textfieldfont">'); 
//	write('<td><select name="' + subGroupName + '.funCode" id="funCode" ' + csalbppProps.get("funCode_ENABLED") + ' class="textfieldfont" " onchange="javascript:fnDisableFields(this)">');
       write('<option value= ""selected>' + jspResArr.get("FLT026344") + '</option>');
       write('<option value="P">' + jspResArr.get("FLT026342") + '</option>');
       write('<option value="U">' + jspResArr.get("FLT026343") + '</option>');
       write('</select>');
	
	

	write('<td class="textlabel">' + jspResArr.get("FLT026333") +'</td>');
	write('<td><input name="' + subGroupName + '.empID" id="empID" ' + csalbppProps.get("empID_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	write('<a href="javascript:fnCustSearcher1(); " id="chargeCodeList">');
        write('<img id="benfList1" width="16" height="17" border="0"  hotKeyId="search1" src="../Renderer/images/search_icon.gif"></img> </a>');
	write('</td>');
	write('</tr>');
	
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026334") +'<font color=red size=2>*</font></td>');
	write('<td><input name="' + subGroupName + '.fileName" id="fileName" ' + csalbppProps.get("fileName_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	write('</td>');

	

	write('<td class="textlabel">' + jspResArr.get("FLT026335") +'<font color=red size=2>*</font></td>');
	write('<td><input name="' + subGroupName + '.nameMismatch" id="nameMismatch" ' + csalbppProps.get("nameMismatch_ENABLED") + ' type="radio" value = "Y">Yes<input name="' + subGroupName + '.nameMismatch" id="nameMismatch" ' + csalbppProps.get("nameMismatch_ENABLED") + ' type="radio" value = "N">No');
	write('</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026336") +'<font color=red size=2>*</font></td>');
	write('<td><input name="' + subGroupName + '.foracid" id="foracid" ' + csalbppProps.get("foracid_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" onChange= "javascript:fnCustValidate();" >');
	write('<a href="javascript:fnshowAccountIdList(document.forms[0].foracid);" id="foracid">');
	write('<img id="benfList1" width="16" height="17" border="0"  hotKeyId="search1" src="../Renderer/images/search_icon.gif"></img></a>');
	write('</td>');

	
	

	write('<td class="textlabel">' + jspResArr.get("FLT026337") +'<font color=red size=2>*</font></td>');
	write('<td><input name="' + subGroupName + '.upldType" id="upldType" ' + csalbppProps.get("upldType_ENABLED") + ' type="radio" value = "S">SALARY<input name="' + subGroupName + '.upldType" id="upldType" ' + csalbppProps.get("upldType_ENABLED") + ' type="radio" value = "B">BILL');
	//write('<td><input name="' + subGroupName + '.test" id="test" ' + csalbppProps.get("test_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	write('</td>');
	write('</tr>');
	
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026338") +'<font color=red size=2>*</font></td>');
	write('<td><input name="' + subGroupName + '.placeLien" id="placeLien" ' + csalbppProps.get("placeLien_ENABLED") + ' type="radio" value = "Y">Yes<input name="' + subGroupName + '.placeLien" id="placeLien" ' + csalbppProps.get("placeLien_ENABLED") + ' type="radio" value = "N">No');
	write('</td>');

	
	
	write('<td class="textlabel">' + jspResArr.get("FLT026339") +'<font color=red size=2>*</font></td>');
	write('<td><input name="' + subGroupName + '.testMode" id="testMode" ' + csalbppProps.get("testMode_ENABLED") + ' type="radio" value = "Y">Yes<input name="' + subGroupName + '.testMode" id="testMode" ' + csalbppProps.get("testMode_ENABLED") + ' type="radio" value = "N">No');
	write('</td>');
	write('</tr>');
	
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026340") +'<font color=red size=2>*</font></td>');
	write('<td><input name="' + subGroupName + '.reName" id="reName" ' + csalbppProps.get("reName_ENABLED") + ' type="radio" value = "Y">Yes<input name="' + subGroupName + '.reName" id="reName" ' + csalbppProps.get("reName_ENABLED") + ' type="radio" value = "N">No');
	write('</td>');
	
	

	write('<td class="textlabel">' + jspResArr.get("FLT026341") +'<font color=red size=2>*</font></td>');
	write('<td><input name="' + subGroupName + '.chargecode" id="chargecode" ' + csalbppProps.get("chargecode_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	 write('<a href="javascript:fnCustSearcher(); " id="chargecode">');
        write('<img id="benfList1" width="16" height="17" border="0"  hotKeyId="search1" src="../Renderer/images/search_icon.gif"></img> </a>');
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
	if(funCode !='I'){
	write('<div class="ctable">');
	write('<input name="Submit" type="button" class="button" onClick="javascript:return csalbpp_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	write('<input name="Clear" type="button" class="button" onClick="javascript:return csalbpp_det_ONCLICK2(this);" id="Clear" value="Clear">');
	}else{
	write('&nbsp;<input class="button" type="button" id="Back" value="OK" onClick="javascript:return doSubmit(this.id)" hotKeyId="Ok">');
	}
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnCustSearcher(){
var inputNameValues = "";
var outputNames = "chargecode|refDesc";
var scrName     = "saluplddp003.scr";
var title  = "LIST OF CHARGE CODES";
var literalNames="CHARGE CODE|CHARGE DESC ";
var hyperLnks   = "1";
var retVal = fnExecuteScriptForList(inputNameValues, outputNames, scrName, title, literalNames, hyperLnks, true);
var retVal = "";
}

function fnCustSearcher1(){
var inputNameValues = "empID";
var outputNames = "empID|empName";
var scrName     = "saluplddp004.scr";
var title  = "LIST OF EMPLOYES";
var literalNames="EMPLOYEE  ID|EMPLOYEE NAME";
var hyperLnks   = "1";
var retVal = fnExecuteScriptForList(inputNameValues, outputNames, scrName, title, literalNames, hyperLnks, true);
var retVal = "";
}



function fnOnLoad()
{
	var ObjForm = document.forms[0];

	pre_ONLOAD('csalbpp_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();
/*

	if(funCode =='V' || funCode =='I' || funCode =='D' || funCode =='U' ||  funCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
		fnDisableFormControls(ObjForm);

	}
*/
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}


//	fnPostOnLoad()
	post_ONLOAD('csalbpp_det',this);
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
	ObjForm.funCode.value = funCode;
	ObjForm.empID.value = empID;
	ObjForm.fileName.value = fileName;
	ObjForm.nameMismatch.value = nameMismatch;
	ObjForm.foracid.value = foracid;
	ObjForm.upldType.value = upldType;
	ObjForm.placeLien.value = placeLien;
	ObjForm.testMode.value = testMode;
	ObjForm.reName.value = reName;
	ObjForm.chargecode.value = chargecode;
	element1 = document.forms[0].nameMismatch;
	element2 = document.forms[0].placeLien;
	element3 = document.forms[0].testMode;
	element4 = document.forms[0].reName;
        if(nameMismatch == "Y") {
                element1[0].checked=true;
        }
        else {
                element1[1].checked=true;
        }
        if(placeLien == "Y") {
                element2[0].checked=true;
        }
        else {
                element2[1].checked=true;
        }
        if(testMode == "Y") {
                element3[0].checked=true;
        }
        else {
                element3[1].checked=true;
        }
        if(reName == "Y") {
                element4[0].checked=true;
        }
        else {
                element4[1].checked=true;
        }
	
        return true;

}


function csalbpp_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (pre_ONCLICK('csalbpp_det',obj) == false) { 
		return false;
	}


	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}

	if (post_ONCLICK('csalbpp_det',obj) == false) { 
	return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function csalbpp_det_ONCLICK2(obj)
{
	var retVal = "";
	if (pre_ONCLICK('csalbpp_det',obj) == false) { 
		return false;
	}
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (post_ONCLICK('csalbpp_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function fnshowAccountIdList(obj){
    showAccountIdList(obj,null,null,'F');
//	fnCustValidate();
}
