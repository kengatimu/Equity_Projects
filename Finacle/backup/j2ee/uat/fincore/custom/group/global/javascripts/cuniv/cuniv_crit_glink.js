function printBlock()
{
    writeCustomHeader("cuniv_crit");
    with (document){
    write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
    write('<tr>');
    write('<td>');
    write('<table border="0" cellspacing="0" cellpadding="0">');
    write('<tr>');
    write('<td class="page-heading">Student and Biller Details Acceptance</td>');
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
    write('<a href="javascript:showHelpFile(\'cuniv_crit_help.htm\');" id="sLnk1">');
    write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
    write('</td>');
    write('<td>&nbsp;</td>');
    write('<td>&nbsp;</td>');
    write('<td>&nbsp;</td>');
    write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026332") + '<font color="red" size="2">*</font></td>');
	write('<td><select name="' + subGroupName + '.funcCode" id="funcCode" ' + cunivProps.get("funcCode_ENABLED") + ' class="textfieldfont" >');
	write('<option value="" selected>' + jspResArr.get("FLT026333") + '</option>');
  	write('<option value="A">' + jspResArr.get("FLT026334") + '</option>');
    if(bankId == "54")
    {
    	write('<option value="B">' + jspResArr.get("FLT026336") + '</option>');
       	write('<option value="M">' + jspResArr.get("FLT026337") + '</option>');
       	write('<option value="D">' + jspResArr.get("FLT026335") + '</option>');
     }
     else
     {
    	if((bankId == "56") ||(bankId == "50") ||(bankId == "11"))
    	{
			write('<option value="B">' + jspResArr.get("FLT026336") + '</option>');
       		write('<option value="D">' + jspResArr.get("FLT026335") + '</option>');
			write('<option value="M">' + jspResArr.get("FLT026337") + '</option>');
		}
    }
	write('</select>');
	write('</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
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
	write('<input type="button" class="Button" id="Submit" value="SUBMIT" onClick="javascript:return doRefSubmit(this);" hotKeyId="Submit" >');
	}
	writeRefFooter();
	write('<input type="button" class="Button" id="_BackRef_" value="CANCEL" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	write('<div class="ctable">');
	write('<input type="button" name="Accept" value="Go" class="button" id="Accept" onClick="javascript:return cuniv_crit_ONCLICK2(this,this);" hotKeyId="Go">');
	write('<input type="button" name="Clear" value="Clear" class="button" id="Clear" onClick="javascript:return cuniv_crit_ONCLICK3(this);">');
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function


function fnOnLoad()
{
	var ObjForm = document.forms[0];

    pre_ONLOAD('cuniv_crit',this);

    var funcName = "this."+"locfnOnLoad";
    if(eval(funcName) != undefined){
        eval(funcName).call(this);
    }

    if( sReferralMode =='I' || sReferralMode =='S'){
		fnDisableFormControls(ObjForm);
    }
    fnPopUpExceptionWindow(ObjForm.actionCode);
    if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
        checkCustErrExecNextStep(Message);
    }

    
    //fnPostOnLoad()
    post_ONLOAD('cuniv_crit',this);
    fnPopulateControlValues();
	ObjForm.funcCode.focus();
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

function cuniv_crit_ONCLICK2(obj,p1)
{
	if(document.forms[0].funcCode.value==""){
		alert("Enter the Function");
	return false;
	}
	var retVal = "";
	if (pre_ONCLICK('cuniv_crit',obj) == false) { 
		return false;
	}
	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (post_ONCLICK('cuniv_crit',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cuniv_crit_ONCLICK3(obj)
{
	var retVal = "";
	if (pre_ONCLICK('cuniv_crit',obj) == false) { 
		return false;
	}
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (post_ONCLICK('cuniv_crit',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
