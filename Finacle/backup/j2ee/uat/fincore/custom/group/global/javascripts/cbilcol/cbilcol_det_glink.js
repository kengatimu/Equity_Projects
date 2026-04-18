function printBlock()
{
    writeCustomHeader("cbilcol_det");
    with (document){
    write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
    write('<tr>');
    write('<td>');
    write('<table border="0" cellspacing="0" cellpadding="0">');
    write('<tr>');
    write('<td class="page-heading">BILL COLLECTION TRANSACTION</td>');
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
    write('<a href="javascript:showHelpFile(\'cbilcol_det_help.htm\');" id="sLnk1">');
    write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
    write('</tr>');

    write('<tr>');
    write('<td class="textlabel">' + jspResArr.get("FLT022001") + '</td>');
    write('<td><input name="' + subGroupName + '.reportTo" id="reportTo" ' + cbilcolProps.get("reportTo_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" disabled>');
    write('</td>');
    write('</tr>');

    write('<tr>');
    write('<td class="textlabel">' + jspResArr.get("FLT022002") + '</td>');
    write('<td><input name="' + subGroupName + '.tranSubType" id="tranSubType" ' + cbilcolProps.get("tranSubType_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" disabled>');
    write('</td>');
    write('</tr>');

    write('<tr>');
    write('<td class="textlabel">' + jspResArr.get("FLT022003") + '<font color="red" size="2"> *</font></td>');
    write('<td><input name="' + subGroupName + '.upldFileName" id="upldFileName" ' + cbilcolProps.get("upldFileName_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
    write('</td>');
    write('</tr>');

    write('<tr>');
    write('<td class="textlabel">' + jspResArr.get("FLT022004") + '<font color="red" size="2"> *</font></td>');
    write('<td><input name="' + subGroupName + '.testMode" id="testMode" ' + cbilcolProps.get("testMode_ENABLED") + ' type="radio" value = "Y">Yes<input name="' + subGroupName + '.testMode" id="testMode" ' + cbilcolProps.get("testMode_ENABLED") + ' type="radio" value = "N">No');
	write('</td>');
    write('</tr>');

    write('<tr>');
    write('<td class="textlabel">' + jspResArr.get("FLT022005") + '<font color="red" size="2"> *</font></td>');
    write('<td><input name="' + subGroupName + '.tranRmks" id="tranRmks" ' + cbilcolProps.get("tranRmks_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
    write('</td>');
    write('</tr>');

    write('<tr>');
    write('<td class="textlabel">' + jspResArr.get("FLT022006") + '</td>');
    write('<td><input name="' + subGroupName + '.renInputFile" id="renInputFile" ' + cbilcolProps.get("renInputFile_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" disabled value = "Y">');
    write('</td>');
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
    if(funcCode !='I'){
    write('<div class="ctable">');
    write('<input name="Submit" type="button" class="button" onClick="javascript:return cbilcol_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
    write('<input name="Clear" type="button" class="button" onClick="javascript:return cbilcol_det_ONCLICK2(this);" id="Clear" value="Clear">');
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

    pre_ONLOAD('cbilcol_det',this);

   // fnPostOnLoad()
    post_ONLOAD('cbilcol_det',this);

	fnPopulateControlValues();
}

function post_ONLOAD(obj1,obj2)
{
    document.forms[0].reportTo.value="MANAGER";
    document.forms[0].tranSubType.value="CI";
  /*  document.forms[0].tranRmks.value="Equiloan Loan Recoveries"; */
}

function fnValidateData()
{
    var ObjForm = document.forms[0];

    return true;
}

function fnPopulateControlValues() 
{
    var ObjForm = document.forms[0];

    ObjForm.upldFileName.value = upldFileName;
    element = ObjForm.testMode
	if(testMode=="Y") 
	{
		element[0].checked=true;
	}
	else
	{
		element[1].checked=true;
	}

    ObjForm.tranRmks.value = tranRmks;
    ObjForm.renInputFile.value = renInputFile;
}


function cbilcol_det_ONCLICK1(obj,p1)
{
    var retVal = "";

 
 
/*
    if(fnIsNull(document.forms[0].upldFileName.value)) 
    {
        alert("Enter the upldFileName");
        document.forms[0].upldFileName.focus();
        return false;
    }
    
    

    if(fnIsNull(document.forms[0].testMode.value)) 
    {
        alert("Enter the testMode");
        document.forms[0].testMode.focus();
        return false;
    }
    
    
    var testModVal = document.forms[0].testMode.value; 
    if(testModVal =='Y' || testModVal =='N' || testModVal =='y' || testModVal =='n')
    {
        retVal =true;
    }
    else
    {
        alert("Valid Value For Test is (Y/N)");
        document.forms[0].testMode.focus();
        return false;
    }
*/

    if ((retVal = fnValAndSubmit(p1)) == false) 
    {
        return false;
    }
    return (retVal == undefined) ? true : retVal;
}

function cbilcol_det_ONCLICK2(obj)
{
    var retVal = "";
   
    
    if ((retVal = fnClearFields()) == false) {
        return false;
    }
    return (retVal == undefined) ? true : retVal;
}

function fnCustSearcher(){
    var inputNameValues = "";
    var outputNames = "upldFileName";
    var scrName     = "eqlaauplddp001.scr";
    var title  = "Filenames";
    var literalNames="File Name|Description";
    var hyperLnks   = "1";
    var retVal = fnExecuteScriptForList(inputNameValues, outputNames, scrName, title, literalNames, hyperLnks, true);
}
