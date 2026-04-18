function printBlock()
{
    writeCustomHeader("cbwyorm_crit");
    with (document){
    write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
    write('<tr>');
    write('<td>');
    write('<table border="0" cellspacing="0" cellpadding="0">');
    write('<tr>');
    write('<td class="page-heading">E-BANKING SWIFT TABLE MAINTENANCE</td>');
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
    write('<a href="javascript:showHelpFile(\'cbwyorm_crit_help.htm\');" id="sLnk1">');
    write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
    write('</tr>');
    write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026332") + '<font color="red" size="2"> *</font></td>');
	write('<td><select name="' + subGroupName + '.funcCode" id="funcCode" ' + cbwyormProps.get("funcCode_ENABLED") + ' class="textfieldfont" " onchange="javascript:fnDisableFields(this)">');
	write('<option value="" selected>' + jspResArr.get("FLT026333") + '</option>');
	write('<option value="U">' + jspResArr.get("FLT026334") + '</option>');
	write('<option value="M">' + jspResArr.get("FLT026335") + '</option>');
	write('<option value="I">' + jspResArr.get("FLT026336") + '</option>');
	write('<option value="D">' + jspResArr.get("FLT026337") + '</option>');
	write('</select>');
	write('</td>');
	write('</tr>');
	
    write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026338") + '<font color="red" size="2"> *</font></td>'); 
    write('<td><input name="' + subGroupName + '.srlNum" id="srlNum" ' + cbwyormProps.get("srlNum_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" onchange="javascript:fnOnchange()">');
	write('<a href="javascript:fnshowsrlNumList();" id="srlNum" >');
	write('<img id ="imgser" hotKeyId="search1" src="../Renderer/images/search_icon.gif" width="16" height="17" border="0"></img>');
	write('</a>');
	write('</td>');
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
    } 
} 

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
    write('<input name="Accept" type="button" class="button" onClick="javascript:return cbwyorm_crit_ONCLICK1(this,this);" id="Accept" value="Submit" hmtKeyId="Submit">');
    write('<input name="Clear" type="button" class="button" onClick="javascript:return cbwyorm_crit_ONCLICK2(this);" id="Clear" value="Clear">');
    writeFooter();
    write('</div>');
    }
    }
}

function fnshowsrlNumList(){
	
	var inputNameValues = "";
	var outputNames = "srlNum|free1";
	var scrName     = "bwyormmn002.scr";
	var title  = "List Of Bills Lodged From E-banking"
	var literalNames="E-banking Req ID|Lodged Bill ID";
	var hyperLnks   = "1";
	var retVal = fnExecuteScriptForList(inputNameValues, outputNames, scrName, title, literalNames, hyperLnks, true);
}

function fnOnLoad()
{
    var ObjForm = document.forms[0];

	pre_ONLOAD('cbwyorm_crit',this);

    var funcName = "this."+"locfnOnLoad";
    if(eval(funcName) != undefined){
        eval(funcName).call(this);
    }

    fnPopulateControlValues();

//    if(funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='U' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
  //      fnDisableFormControls(ObjForm);
   // }
    fnPopUpExceptionWindow(ObjForm.actionCode);
    if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
        checkCustErrExecNextStep(Message);
    }

    
    //fnPostOnLoad()
    post_ONLOAD('cbwyorm_crit',this);
}

function fnValidateData()
{
    var ObjForm = document.forms[0];

    return true;
}

function fnPopulateControlValues() 
{
    var ObjForm = document.forms[0];
	
	return true;
}


function cbwyorm_crit_ONCLICK1(obj,p1)
{
    var retVal = "";

	if(fnIsNull(document.forms[0].funcCode.value)) {
	alert("Enter the Function Code");
	document.forms[0].funcCode.focus();
	return false;
	}
	if((document.forms[0].funcCode.value != 'U') && (document.forms[0].srlNum.value == "")) {
	alert("Serial Number Should be entered");
	document.forms[0].srlNum.focus();
	return false;
	}


	if(document.forms[0].srlNum.value != "" ) {
                                        
       var srlNum1         = document.forms[0].srlNum.value;
	var     inputNameValues   =  "serial|"+srlNum1;
       var     outputNames       = "";
       var     scrName           = "bwyormdp001.scr";
       var     retVal            = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
       var ret = retVal.split("|");
       if (ret[0] == "stat")
        {
               alert("Enter a valid Serial Number");
		return false;
        }
	    
       }
if (pre_ONCLICK('cbwyorm_crit',obj) == false) { 
        return false;
    }
    if ((retVal = fnValAndSubmit(p1)) == false) {
        return false;
    }
    if (post_ONCLICK('cbwyorm_crit',obj) == false) { 
        return false;
    }
    return (retVal == undefined) ? true : retVal;
}

function cbwyorm_crit_ONCLICK2(obj)
{
    var retVal = "";
    
   
    if ((retVal = fnClearFields()) == false) {
        return false;
    }
  
    if (post_ONCLICK('cbwyorm_crit',obj) == false) { 
        return false;
    }
    
    return (retVal == undefined) ? true : retVal;
 }

function fnDisableFields() {
	if(document.forms[0].funcCode.value == 'U'){
		document.forms[0].srlNum.disabled = true;
		document.getElementById('imgser').style.visibility = "hidden";
	}
	if((document.forms[0].funcCode.value == 'M') || (document.forms[0].funcCode.value == 'I') || (document.forms[0].funcCode.value == 'D')){
		document.forms[0].srlNum.disabled = false;
		document.getElementById('imgser').style.visibility = "visible";
	}
}
