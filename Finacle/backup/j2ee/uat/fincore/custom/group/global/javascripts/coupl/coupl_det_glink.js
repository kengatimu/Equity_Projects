function printBlock()
{
	writeCustomHeader("coupl_det");
	with (document){
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
	write('<a href="javascript:showHelpFile(\'coupl_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
	write('</tr>');
	
	/*Drop Down for Function Code*/
	
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026332") +'<font color="red" size="2"> *</font></td>');
	write('<td><select name="' + subGroupName + '.funcCode" id="funcCode" ' + couplProps.get("funcCode_ENABLED") + ' class="textfieldfont" onchange="javascript:f1()">');
	write('<option value="" selected>' + jspResArr.get("FLT026341") + '</option>');
	write('<option value="U">' + jspResArr.get("FLT026347") + '</option>');
	write('<option value="R">' + jspResArr.get("FLT046347") + '</option>');
	write('</select>');
	write('</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('</tr>');

        write('<tr>');
        write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031945") + '</td>');
        write('<td class="textfield">');
        write('<select name="' + subGroupName + '.uplModuleTy" id="uplModuleTy" style="width: 218px" fdt="String" ' + couplProps.get("uplModuleTy_ENABLED") + '>');
        write('<option value="">' + jspResArr.get("FLT026341") + '</option>');
        write('<option value="FIN">' + jspResArr.get("FLT012405") + '</option>');
        write('<option value="MFS">' + jspResArr.get("FLT013286") + '</option>');
        write('<option value="SAF">' + jspResArr.get("FLT713286") + '</option>');
        write('<option value="AML43">' + jspResArr.get("FLT713283") + '</option>');
        write('<option value="BL43">' + jspResArr.get("FLT713293") + '</option>');
        write('<option value="MCGL">' + jspResArr.get("FLT783293") + '</option>');
        write('<option value="MCDD">' + jspResArr.get("FLT787293") + '</option>');
        write('<option value="MCFA">' + jspResArr.get("FLT717293") + '</option>');
        write('<option value="OFAC-SDN">' + jspResArr.get("FLT719293") + '</option>');
        write('<option value="OFAC-ADD">' + jspResArr.get("FLT715293") + '</option>');
        write('<option value="OFAC-ALT">' + jspResArr.get("FLT714293") + '</option>');
        write('<option value="RM-UPLOAD">' + jspResArr.get("FLT716293") + '</option>');
        write('</select>');
        write('</td>');
/*
        write('<td class="columnwidth"></td>');
        write('<td class="textlabel">' + jspResArr.get("FLT031875") + '</td>');
        write('<td class="textfield">');
        write('<input hotKeyId="search3" type="text" class="textfieldfont" name="' + subGroupName + '.TranRemarks" id="TranRemarks" fdt="String" ' + couplProps.get("TranRemarks_ENABLED") + '>');
        write('</td>');
*/
        write('</tr>');

        write('<tr>');
        write('<td class="textlabel">' + jspResArr.get("FLT026331") + '<font color=red size=2>*</font></td>');
        //write('<td><input name="' + subGroupName + '.FileName" id="FileName" ' + couplProps.get("FileName_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="50">');
        //write('</td>');
	write('<td class="textfield"><input type="text" name="' + subGroupName + '.FileName" id="FileName" ' + couplProps.get("FileName_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="100" /></td>');
        write('</tr>');
	/*
	write('<tr>');	
	write('<td class="textlabel">' + jspResArr.get("FLT026331") + '<font color=red size=2>*</font></td>');
	write('<td class="textfield"><input type="file" name="' + subGroupName + '.fileName" id="fileName" ' + couplProps.get("fileName_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="100" /></td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('</tr>');
	*/

	write('</tr>');
	
	write('</td>');
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
	if(document.getElementById("funcCode").value != 'I'){
	write('<div class="ctable">');
        write('<input name="Submit" type="button" class="button" onClick="javascript:return coupl_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	write('<input name="Clear" type="button" class="button" onClick="javascript:return coupl_det_ONCLICK2(this);" id="Clear" value="Clear">');
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
	//ObjForm.funcCode.focus();
	pre_ONLOAD('coupl_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	/*if( sReferralMode =='I' || sReferralMode =='S'){
        		fnDisableFormControls(ObjForm);
	}*/
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}
	//fnPostOnLoad()
	post_ONLOAD('coupl_det',this);
	fnPopulateControlValues();
	ObjForm.funcCode.focus();

}
function post_ONLOAD(obj1,obj2){
    fnPopulateControlValues();
}
function fnValidateData(){
	var ObjForm = document.forms[0];
	return true;
}
function fnPopulateControlValues(){
	var ObjForm = document.forms[0];
	ObjForm.funcCode.value = funccode;
	ObjForm.uplModuleTy.value = uplModuleTy;
	ObjForm.FileName.value = FileName;
}
function coupl_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if(fnIsNull(document.forms[0].funcCode.value)){
		alert("Enter the Function Code");
		document.forms[0].funcCode.focus();
		return false;
	}
	if(fnIsNull(document.forms[0].uplModuleTy.value)){
		alert("Enter the UploadModule Code");
		document.forms[0].uplModuleTy.focus();
		return false;
	}
	if(fnIsNull(document.forms[0].FileName.value)){
		alert("Enter the UploadFile Name");
		document.forms[0].FileName.focus();
		return false;
	}
	/*
	if(document.forms[0].funcCode.value == 'U'){ 
		if(fnIsNull(document.forms[0].uplModuleTy.value)){
			alert("Select Upload Module");
			document.forms[0].uplModuleTy.focus();
			return false;
		}
		if(document.forms[0].fileName.value ==""){
			alert("Please Enter the File Name.");
			document.forms[0].fileName.focus();
			return false;
		}else if(document.forms[0].fileName.value !=""){	
				var file = document.getElementById("fileName").value;
				var fileIndex = file.lastIndexOf("\\");
				var fileName = file.substring(fileIndex+1);
				//alert("File Name : " + fileName);
				if(!fnCheckSpecialChar(fileName)){
					return false;
				}
				var index = file.lastIndexOf(".");
				var ext = file.substring(index+1);
				ext = ext.toUpperCase();
				if(ext != "TXT" && ext != "CSV"){
					alert("Please enter only csv/txt extension file for uploading");
					return false;
				}
		}
		///fnUpload();
	}else{
		if ((retVal = fnValAndSubmit(p1)) == false) {
			return false;
		}
		return (retVal == undefined) ? true : retVal;
		
	}
	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
	var retVal = "";
	*/
	    if (pre_ONCLICK('coupl_crit',obj) == false) {
		return false;
	    }
	    if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	    }
	    if (post_ONCLICK('coupl_crit',obj) == false) {
		return false;
	    }
	    return (retVal == undefined) ? true : retVal;
}

function fnCheckSpecialChar(name){
        returnFlg="true";
        //alert("Customer Name : "+name )
        if (name!="" || name!=null) {
                var string = name;
                for (var i=0;i<string.length;i++)
                {
                        asciiNum = string.charCodeAt(i);
			//alert(i + " " + asciiNum + " " + returnFlg)
                        if ((asciiNum>96 && asciiNum<123) ||(asciiNum>64 && asciiNum<91) || (asciiNum>45 && asciiNum<58)  ){
                                returnFlg="true";   }
                                else {
                                returnFlg="false";
                                break;
                                }
                }
                if (returnFlg == "true"){
                	//alert("Name is correct");
			return true;
                 }
                else {
                	alert("File Name shoud not contain special charecters or space: "+name);
                	//return false;
                }

        }
        return true;
}
function coupl_det_ONCLICK2(obj){
	var retVal = "";
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
function fnUpload(){
	var objForm = document.getElementById("detform");
	objForm.encoding = "multipart/form-data";
	var qrystr ="";
	for (var i = 0;i < objForm.elements.length; i++)
	{
		var locVal = objForm.elements[i].value;
		if(objForm.elements[i].name == "actionCode")
		objForm.elements[i].value = "upload";
		if (locVal != null && locVal.length > 0 && locVal != "" && locVal != " "){
		if(objForm.elements[i].name == "undefined" || (objForm.elements[i].value != null && objForm.elements[i].value == "undefined"))
		continue;
		if(qrystr.length == 0){
			qrystr = objForm.elements[i].name + "=" + objForm.elements[i].value
		}else{
			qrystr = qrystr + "&" + objForm.elements[i].name + "=" + objForm.elements[i].value
		}
	}
	}
	if(qrystr.indexOf("actionCode")==-1){
		qrystr = qrystr + "&actionCode=upload"
	}
	if(qrystr.indexOf("?")==-1 || qrystr.indexOf("?")!=0){
		qrystr = "?" + qrystr
	}
	objForm.action = objForm.action + qrystr
	objForm.submit();
	return true;
}
//custom function
function f1(){
  	if(fn == 'U'){
                enableFields("fileName","uplModuleTy");
        }
        else{
                disableFields("fileName","uplModuleTy");
        }
	f2();
}
function f2(){
        if(document.forms[0].funcCode.value == 'U'){
                hideImage("sLnk2");
                hideImage("sLnk4");
        }else{
                showImage("sLnk2");
                hideImage("sLnk2");
                hideImage("sLnk4");
        }
}
