function printBlock()
{
	writeCustomHeader("cchqm_det2");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">Cheque Book Maintenance</td>');
	write('</tr>');
	write('</table>');
	write('<br />');
	write('<!-- DETAILSBLOCK-BEGIN -->');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td valign="top">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableborder">');
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
/*
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT006657") + '</td>');
	write('<td class="textfield">');
	write('<select name="' + subGroupName + '.funCode" id="funCode"  fdt="String" ' + cchqmProps.get("funCode_ENABLED") + '   style="width: 161px;" OnChange="javascript:fnOnChange();">');
	 write('<option value="">---Select---</option>');
	write('<option value="U">' + jspResArr.get("FLT032041") + '</option>');
	write('<option value="D">' + jspResArr.get("FLT032042") + '</option>');
	write('</select>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel" id="down">' + jspResArr.get("FLT007695") + '</td>');
	write('<td class="textfield">');
	write('<input type="text"  class="textfieldfont" name="' + subGroupName + '.download" id="download"  fdt="String" ' + cchqmProps.get("download_ENABLED") + ' style="width: 162px;" OnChange="javascript:fnreqchng();">');
write('<a target=_self id="sLnk2" href="javascript:fnCustSearcherold(document.forms[0].requestId)" onClick="javascript:return searchVal(this.id);">');
write('<img class="img" hotKeyId="search2" id="imgser" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search4"></img></a>');
	write('</td>');
	write('</tr>');
*/
	write('<tr>');
	write('<div>');
		write('<br>');
	write('<td class="textlabel" style="height: 15px" id="up">File to Upload</td>');
	write('</div>');
	write('<td class="textfield">');
	write('<div>');
	//write('<br>');
//	write('<input type="file" class="textfieldfont" name="' + subGroupName + '.upload" id="upload"  fdt="String" ' + cchqmProps.get("upload_ENABLED") + ' style="width: 161px;">');
	write('<input type="file" class="textfieldfont" name="' + subGroupName + '.upfile" id="upfile"  fdt="String" ' + cchqmProps.get("upfile_ENABLED") + ' style="width: 161px;">');
	write('</div>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
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
	write('<input type="button" class="Button" id="Upload" value="'+jspResArr.get("FLT000193")+ '" onClick="javascript:return doRefSubmit(this);" hotKeyId="Submit" >');
	}
	writeRefFooter();
	write('<input type="button" class="Button" id="_BackRef_" value="'+jspResArr.get("FLT001721")+ '" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	if(funcCode !='I')
	{
		write('<div class="ctable">');
		write('<input id="Upload" name="Upload" type="button" class="button"	onClick="javascript:return cchqm_det2_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT000193") + '" hotKeyId="Submit">');
		//write('<input id="Validate" name="Validate" type="button" class="button" value="' + jspResArr.get("FLT000194") + '"	onClick="javascript:return cchqm_det2_ONCLICK2(this,this);"" hotKeyId="Validate">');
		write('<input id="Cancel" name="Cancel" type="button" class="button" value="' + jspResArr.get("FLT001721") + '"	onClick="javascript:return cchqm_det2_ONCLICK3(this,this.id);"" hotKeyId="Cancel">');
	}
	else
	{
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

	pre_ONLOAD('cchqm_det2',this);

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

	post_ONLOAD('cchqm_det2',this);
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	//ObjForm.funCode.value = funCode;
	//ObjForm.download.value = download;
	ObjForm.upfile.value = upfile;
}


function cchqm_det2_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (preEventCall('cchqm_det2',obj,'ONCLICK') == false) { 
		return false;
	}
	fnUpload();

	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cchqm_det2',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cchqm_det2_ONCLICK2(obj,p1)
{
	var retVal = "";
	if (preEventCall('cchqm_det2',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cchqm_det2',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cchqm_det2_ONCLICK3(obj,p1)
{
	var retVal = "";
	if (preEventCall('cchqm_det2',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  doSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cchqm_det2',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
function fnCustSearcherold()
{
        var funCode = document.forms[0].funCode.value;
         if(funCode != "" ){
                var inputNameValues     = "funCode|"+funCode;
                var outputNames         = "download|acctID|reqStatus";
                var scrName             = "cchquddp002.scr";
                var title               = "LIST OF REQUEST ID";
                var literalNames        = "REQUEST ID|ACCOUNT NO|REQUEST STATUS";
                var hyperLnks           = "1";
                var retVal              = fnExecuteScriptForList(inputNameValues, outputNames, scrName, title, literalNames, hyperLnks, true);
        }
}

function searchVal(obj){
        var funCode = document.forms[0].funCode.value;
        if(funCode==""){
                alert("Please select the function Code");
                return false;
        }
        return true;
}
function fnreqchng()
{
	var reqnum=document.forms[0].download.value;
        var input      = "reqnum|"+reqnum;
        var outputNames    = "";
        var scrName     =   "reqnum_val.scr";
        var retVal = appFnExecuteScript(input,outputNames,scrName,false);
        var retBuff = retVal.split("|");
        var errFlg = retBuff[1];
        var errMsg = retBuff[3];
        var reqnum = retBuff[5];
        if(errFlg == "Y")
        {
                alert(errMsg);
                return false;
        }
        else
        {
                document.forms[0].download.value=reqnum;
                return true;
        }
}

function fnUpload()
{
	var objForm = document.getElementById("detform");
	objForm.encoding = "multipart/form-data";
	var qrystr ="";
	for (var i = 0;i < objForm.elements.length; i++)
	{
		var locVal = objForm.elements[i].value;
		if(objForm.elements[i].name == "actionCode")
			objForm.elements[i].value = "upload";
		if (locVal != null && locVal.length > 0 && locVal != "" && locVal != " ")
		{
			if(objForm.elements[i].name == "undefined" || (objForm.elements[i].value != null && objForm.elements[i].value == "undefined"))
			continue;
			if(qrystr.length == 0)
			{
				qrystr = objForm.elements[i].name + "=" + objForm.elements[i].value;
			}
			else
			{
				qrystr = qrystr + "&" + objForm.elements[i].name + "=" + objForm.elements[i].value;
			}
		}
	}
	if(qrystr.indexOf("actionCode")==-1)
	{
		qrystr = qrystr + "&actionCode=upload&binaryMode=Y";
	}
	if(qrystr.indexOf("?")==-1 || qrystr.indexOf("?")!=0)
	{
		qrystr = "?" + qrystr;
	}
	objForm.action = objForm.action + qrystr
	objForm.submit();
	return true;

}
