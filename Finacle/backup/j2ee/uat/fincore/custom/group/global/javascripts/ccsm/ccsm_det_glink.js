function printBlock()
{
	writeCustomHeader("ccsm_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">Customer Segmentation Maintenance</td>');
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
	write('<a href="javascript:showHelpFile(\'ccsm_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
	write('</tr>');

	write('<tr>');
		write('<td class="textlabel">' + jspResArr.get("FLT026332") + '<font color="red" size="2"> *</font></td>');
		write('<td><select name="' + subGroupName + '.funCode" id="funCode" ' + ccsmProps.get("funCode_ENABLED") + ' class="textfieldfont" " onchange="javascript:return funcCodeOnchange()">'); 
	    //write('<td><select name="' + subGroupName + '.funCode" id="funCode" ' + ccsmProps.get("funCode_ENABLED") + ' class="textfieldfont" " onchange="javascript:fnDisableFields(this)">');
		write('<option value= ""selected>' + jspResArr.get("FLT026344") + '</option>');
		write('<option value="U">' + jspResArr.get("FLT026342") + '</option>');
		write('<option value="V">' + jspResArr.get("FLT026343") + '</option>');
		write('</select>');	
	write('</tr>');
	
	write('<tr>');
	write('</tr>');
	
	write("<tr id='uploadrow'>");
		write('<td class="textlabel">' + jspResArr.get("FLT026334") +'<font color=red size=2>*</font></td>');
		write('<td><input name="' + subGroupName + '.uploadFileName" id="uploadFileName" ' + ccsmProps.get("uploadFileName_ENABLED") + ' type="file" class="textfieldfont" size="50" maxlength="100" >');

	write("</tr>");
	

	write("<tr id='refcode'>");
		write('<td class="textlabel">' + jspResArr.get("FLT026333") +'</td>');
		write('<td><input name="' + subGroupName + '.refnumber" id="refnumber" ' + ccsmProps.get("refnumber_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
		//write('<a href="javascript:fnCustSearcher1(); " id="chargeCodeList">');
		write('<a href="javascript:fnCustSearcher1(); " id="refCodeList">');
		write('<img id="benfList1" width="16" height="17" border="0"  hotKeyId="search1" src="../Renderer/images/search_icon.gif"></img> </a>');
		write('</td>');
	write("</tr>");  

  

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
	if(funCode !='I'){
	write('<div class="ctable">');
	write('<input name="Submit" type="button" class="button" onClick="javascript:return ccsm_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	//write('<input name="Clear" type="button" class="button" onClick="javascript:return ccsm_det_ONCLICK2(this);" id="Clear" value="Clear">');
	}else{
	write('&nbsp;<input class="button" type="button" id="Back" value="OK" onClick="javascript:return doSubmit(this.id)" hotKeyId="Ok">');
	}
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function


function fnCustSearcher12(){
var inputNameValues = "refnumber";
var outputNames = "refnumber|entryuser|entrydate";
var scrName     = "ccsmref.scr";
var title  = "UNVERIFIED CODES";
var literalNames="REF CODE|ENTRY USER|ENTRY DATE";
var hyperLnks   = "1";
var retVal = fnExecuteScriptForList(inputNameValues, outputNames, scrName, title, literalNames, hyperLnks, true);
var retVal = "";
}


function fnCustSearcher1(){
		var inputNameValues = "refnumber| "
		var outputNameValues = "refnumber|entryuser|entrydate";
		var scriptName     = "ccsmref.scr";
		var listHeading  = "UNVERIFIED CODES";
		var colHeader="REF CODE|ENTRY USER|ENTRY DATE";
		var hyperLnks   = "1";
		var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",true);
		var ObjForm = document.forms[0];
		var targetEntity = ObjForm.targetEntity.value;

}


function fnOnLoad()
{
	var ObjForm = document.forms[0];
	hideImage("refcode");
	pre_ONLOAD('ccsm_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

/*

	if(funCode =='V' || funCode =='U'){
		fnDisableFormControls(ObjForm);

	}
*/
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}


//	fnPostOnLoad()
	post_ONLOAD('ccsm_det',this);
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
	ObjForm.refnumber.value = refnumber;
	ObjForm.uploadFileName.value = uploadFileName;
}




function ccsm_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (pre_ONCLICK('ccsm_det',obj) == false) { 
		return false;
	}
	//alert("Kindly make sure the file is verified before upload")
	//Cust start
	 var retVal = "";
	if(fnIsNull(document.forms[0].funCode.value))
        {
			alert("Enter the Function Code");
			document.forms[0].funCode.focus();
			return false;
        }




	//alert(document.forms[0].funCode.value)
	
	if(document.forms[0].funCode.value =="U")
	{
		if(document.forms[0].uploadFileName.value =="")
		{
			alert("Please Enter the File Name.");
			document.forms[0].uploadFileName.focus();
			return false;
		}
		if(document.forms[0].uploadFileName.value !="")
		{

				var file = document.getElementById("uploadFileName").value;
				var fileIndex = file.lastIndexOf("\\");
				var uploadFileName = file.substring(fileIndex+1);
				//alert("File Name : " + uploadFileName);
				if(!fnCheckSpecialChar(uploadFileName)){
					return false;
				}

				var index = file.lastIndexOf(".");
				var ext = file.substring(index+1);
				ext = ext.toUpperCase();
				if(ext != "CSV"){
					alert("Please enter only csv extension file for uploading");
					return false;
				}
		}
		fnUpload();
	}	
	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}

	if (post_ONCLICK('ccsm_det',obj) == false) { 
	return false;
	}
	return (retVal == undefined) ? true : retVal;
	

	//Cust End
}

function fnCheckSpecialChar(name)
{

        //alert("checking For Special Chars ");
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
                        return false;
                }

        }
        return true;
}

function fnUpload() {
    var objForm = document.getElementById("detform");
    objForm.encoding = "multipart/form-data";
    var qrystr = "";
    for (var i = 0; i < objForm.elements.length; i++) {
        var locVal = objForm.elements[i].value;
        if (objForm.elements[i].name == "actionCode")
            objForm.elements[i].value = "upload";
        if (locVal != null && locVal.length > 0 && locVal != "" && locVal != " ") {
            if (objForm.elements[i].name == "undefined" || (objForm.elements[i].value != null && objForm.elements[i].value == "undefined"))
                continue;
            if (qrystr.length == 0) {
                qrystr = objForm.elements[i].name + "=" + objForm.elements[i].value
            } else {
                qrystr = qrystr + "&" + objForm.elements[i].name + "=" + objForm.elements[i].value
            }
        }
    }
    if (qrystr.indexOf("actionCode") == -1) {
        qrystr = qrystr + "&actionCode=upload"
    }
    if (qrystr.indexOf("?") == -1 || qrystr.indexOf("?") != 0) {
        qrystr = "?" + qrystr
    }
    objForm.action = objForm.action + qrystr
    objForm.submit();
    return true;
}


function ccsm_det_ONCLICK2(obj)
{
	var retVal = "";
	if (pre_ONCLICK('ccsm_det',obj) == false) { 
		return false;
	}
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (post_ONCLICK('ccsm_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function fnshowAccountIdList(obj){
    showAccountIdList(obj,null,null,'F');
//	fnCustValidate();
}


//function ti disable fileupload on verify


function funcCodeOnchange(){
	//var ObjForm = document.forms[0];

	var funcode = document.forms[0].funCode.value;
	//alert(funcode);
	if(funcode == "U"){
		hideImage("refcode");
		showImage("uploadrow");
	}

	if(funcode == "V"){
		showImage("refcode");
		hideImage("uploadrow");
	}
}