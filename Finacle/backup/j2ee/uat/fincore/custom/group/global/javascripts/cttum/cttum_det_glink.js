function printBlock()
{
	writeCustomHeader("cttum_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">'+menuTitle+' </td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td class="textfielddisplaylabel"> </td>');
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
	write('<a href="javascript:showHelpFile(\'uituplddet_help.htm\');">');
	write('<img align="right" class="img" border="0" src="../Renderer/images/' + applangcode + '/help.gif" hotKeyId="finHelp">');
	write('</img></a>'); 
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');


	var workclass=USER_MENU_ID.substring(9, 12);

	write('<tr>');
	write('<td class="textlabel" style="height: 25px">' + jspResArr.get("FLT006657") + '</td>');
	write('<td class="textfield">');
	write('<select name="' + subGroupName + '.funcCode" id="funcCode" style="width: 218px"  fdt="String" ' + cttumProps.get("funcCode_ENABLED") + '>');
	write('<option value="">' + jspResArr.get("FLT031311") + '</option>');
	write('<option value="I">' + jspResArr.get("FLT012901") + '</option>');
	if ((workclass=="146"))
	{
	write('<option value="U">' + jspResArr.get("FLT012900") + '</option>');
	}
	if ((workclass=="152")||(workclass=="260"))
	{
	write('<option value="V">' + jspResArr.get("FLT012902") + '</option>');
	}
	write('</select>');
	write('</td>');
	write('<td>');
	write('<td class="textlabel">' + jspResArr.get("FLT021699") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<input type="file" class="normal textfieldfont" fdt="lcase" name="' + subGroupName + '.fileName" id="fileName" >');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfield"> </td>');
	write('</tr>');

    // Batch ID
    write('<tr>');
    write('<td class="textlabel">' + jspResArr.get("FLT031312") + '<script>setMandatory("Y");</script></td>');
    write('<td class="textfield">');
    write('<input type="text" name="' + subGroupName + '.batchId" id="batchId" style="width: 218px; border: 1px solid #000;" size="50" maxlength="50" class="label">');
    write('</td>');
    write('<td class="columnwidth"> </td>');
    write('<td class="textlabel"> </td>');
    write('<td class="textfield"> </td>');
    write('</tr>');
        
    //

	write('<tr>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfield"> </td>');
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
	//if (sReferralMode == 'S'){
	//write('<input type="button" class="Button" id="Submit" value="Submit" onClick="javascript:return doRefSubmit(this);" hotKeyId="Submit" >');
	//}
	writeRefFooter();
	write('<input type="button" class="Button" id="_BackRef_" value="Clear" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	if(funcCode !='I'){
	write('<div class="ctable">');
	write('<input id="Upload" type="button" name="Submit" value="Upload" class="button" onClick="javascript:return cttum_det_ONCLICK1(this,this);"" hotKeyId="Submit">');
	//write('<input id="Submit" name="Submit" type="button" class="button"	onClick="javascript:return cttum_det_ONCLICK1(this,this);"" value="Submit" hotKeyId="Submit">');
	//write('<input id="Validate" name="Validate" type="button" class="button" value="Validate"	onClick="javascript:return cttum_det_ONCLICK2(this,this);"" hotKeyId="Validate">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="Clear"	onClick="javascript:return cttum_det_ONCLICK3(this,this.id);"" hotKeyId="Cancel">');
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
	document.forms[0].funcCode.focus();
	pre_ONLOAD('cttum_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	ObjForm.fileName.value = fileName;
	ObjForm.batchId.value = batchId;
}


function cttum_det_ONCLICK1(obj,p1)
{

        if(document.forms[0].funcCode.value == 'U')
	{
		var retVal = "";
		if(fnIsNull(document.forms[0].funcCode.value))
		{
			alert("Enter the Function Code");
			document.forms[0].funcCode.focus();
			return false;
		}
		if(document.forms[0].fileName.value =="")
		{
			alert("Please Enter the File Name.");
			document.forms[0].fileName.focus();
			return false;
		}
		if(document.forms[0].fileName.value !="")
		{

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
		fnUpload();
	}
	else
	{

		if(fnIsNull(document.forms[0].batchId.value))
		{
			alert("Enter the batchId");
			document.forms[0].batchId.focus();
			return false;
				
		}
		else
		{
			// alert(document.forms[0].batchId.value);
			var batchId= document.forms[0].batchId.value;
			// var inputNameValues = batchId;
			// var outputNames     = "";
			// var scrName         = "cttumGo.scr";
			// var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
			// 	
			// var ret = retVal.split("|");
			
			// if(ret[0] =="ERROR" && ret[1] !="")
			// {
			// 	alert(ret[1]);
			// 	document.getElementById("funcCode").focus();
			// 	return false;
			// }
			// if(ret[0] =="EMPLOYER"){
			// 	document.getElementById("employer").value = ret[1];
			// 	document.getElementById("amount").value = ret[3];
			// 	document.getElementById("score").value = ret[5];
			// 	document.getElementById("period").value = ret[7];
			// 	document.getElementById("employer").disabled =true;
			// }
			// return true;
		}

	 }
		if ((retVal = fnValAndSubmit(p1)) == false) {
			return false;
		}
		return (retVal == undefined) ? true : retVal;

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
if(objForm.elements[i].name == "undefined" || (objForm.elements[i].value != null && objForm.elements[i].value == "undefined")
)
continue;
if(qrystr.length == 0)
{
qrystr = objForm.elements[i].name + "=" + objForm.elements[i].value
}
else
{
qrystr = qrystr + "&" + objForm.elements[i].name + "=" + objForm.elements[i].value
}
}
}
if(qrystr.indexOf("actionCode")==-1)
{
qrystr = qrystr + "&actionCode=upload"
}
if(qrystr.indexOf("?")==-1 || qrystr.indexOf("?")!=0)
{
qrystr = "?" + qrystr
}
objForm.action = objForm.action + qrystr
objForm.submit();
return true;

}
function cttum_det_ONCLICK2(obj,p1)
{
	var retVal = "";
	if (preEventCall('cttum_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValidateData(p1)) == false) {
		return false;
	}
	if (postEventCall('cttum_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
function cttum_det_ONCLICK3(obj,p1)
{
	var retVal = "";
	if (preEventCall('cttum_det',obj,'ONCLICK') == false) { 
		return false;
	}
	 if ((retVal =  fnClearFields()) == false) {
                return false;
        }

	if ((retVal =  doSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cttum_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
