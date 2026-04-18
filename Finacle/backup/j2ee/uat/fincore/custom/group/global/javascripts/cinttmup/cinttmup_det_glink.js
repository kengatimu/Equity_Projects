function printBlock()
{
	writeCustomHeader("cinttmup_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading"> BULK INTEREST DATA UPLOAD </td>');
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
	write('<a href="javascript:showHelpFile(\'cinttmup_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
	write('</tr>');
	
	/*Drop Down for Function Code*/
	
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026332") +'<font color="red" size="2"> *</font></td>');
	write('<td><select name="' + subGroupName + '.funcCode" id="funcCode" ' + cinttmupProps.get("funcCode_ENABLED") + ' class="textfieldfont" onchange="javascript:f1()">');
	write('<option value="" selected>' + jspResArr.get("FLT026341") + '</option>');
	//write('<option value="A">' + jspResArr.get("FLT026342") + '</option>');
	//write('<option value="M">' + jspResArr.get("FLT026343") + '</option>');
	//write('<option value="Z">' + jspResArr.get("FLT026344") + '</option>');
	//write('<option value="I">' + jspResArr.get("FLT026345") + '</option>');
	write('<option value="U">' + jspResArr.get("FLT026347") + '</option>');
	write('<option value="V">' + jspResArr.get("FLT026346") + '</option>');
	
	write('</select>');
	write('</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('</tr>');
	
	/*Text Field for Single Entry*/	 
	//write('<tr>');
        //write('<td class="textlabel">' + jspResArr.get("FLT026333") + '<font color=red size=2>*</font></td>');
	//write('<td><input name="' + subGroupName + '.foracid" id="foracid" ' + cinttmupProps.get("foracid_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" onBlur="javascript:return cinttmup_ONBLUR12(this);"  onchange="javascript:return cinttmup_ONCHANGE1(this,this,\'acctName\',\'acctSolId\',\'acctCrncy\',true,\'VALCUSTACCTID\');">');
 	//write('<a id="sLnk2" target=_self href="javascript:fnshowAccountIdList(document.forms[0].foracid);" >');
	//write('<img id="benfList1" width="16" height="17" border="0"  hotKeyId="search1" src="../Renderer/images/search_icon.gif"></img></a>');
	//write('<input type="text" name="acctCrncy" id="acctCrncy" size="3" maxlength="3"  class="label" readonly="readonly" disabled>');
	//write('<input type="text" name="acctSolId" id="acctSolId" size="8" maxlength="8"  class="label" readonly="readonly" disabled>');
	//write('<input type="text" name="acctName" id="acctName"  size="50" maxlength="50" class="label" readonly="readonly" disabled>');

	//write('<br>');
	//write('</td>');
	//write('<td>&nbsp;</td>');
	//write('<td>&nbsp;</td>');
	//write('<td>&nbsp;</td>');
	//write('</tr>');
	
	//write('<tr>');
	//write('<td class="textlabel">' + jspResArr.get("FLT026334") + '</td>');
	//write('<td><input name="' + subGroupName + '.employer" id="employer" ' + cinttmupProps.get("employer_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	//write('<a target=_self id="sLnk4" href="javascript:fnCustEmployerSearcher(document.forms[0].employer,document.forms[0].empName)" ><img class="img" src="../Renderer/images/'+ applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search4"></img></a>');
	//write('<input name="' + subGroupName + '.empName" id="empName" type="text" size="50" maxlength="50" readonly disabled class="label" >');

	//write('</td>');
	//write('<td>&nbsp;</td>');
	//write('<td>&nbsp;</td>');
	//write('<td>&nbsp;</td>');
	//write('</tr>');
	
	//write('<tr>');
	//write('<td class="textlabel">' + jspResArr.get("FLT026335") + '<font color=red size=2>*</font></td>');
	//write('<td><input name="' + subGroupName + '.amount" id="amount" ' + cinttmupProps.get("amount_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" onBlur="javascript:valAmount();">');
	//write('</td>');
	//write('<td>&nbsp;</td>');
	//write('<td>&nbsp;</td>');
	//write('<td>&nbsp;</td>');
	//write('</tr>');

	//write('<tr>');
	//write('<td class="textlabel">' + jspResArr.get("FLT026336") + '<font color=red size=2>*</font></td>');
	//write('<td><input name="' + subGroupName + '.score" id="score" ' + cinttmupProps.get("score_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" onBlur="javascript:valScore();">');
	//'wrhite('</td>');
	//write('<td>&nbsp;</td>');
	//write('<td>&nbsp;</td>');
	//write('<td>&nbsp;</td>');
	//write('</tr>');

	//write('<tr>');
	//write('<td class="textlabel">' + jspResArr.get("FLT026337") + '<font color=red size=2>*</font></td>');
	//write('<td><input name="' + subGroupName + '.period" id="period" ' + cinttmupProps.get("period_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" onBlur="javascript:valPeriod();">');
	//write('</td>');
	//write('<td>&nbsp;</td>');
	//write('<td>&nbsp;</td>');
	//write('<td>&nbsp;</td>');
	//write('</tr>');
	//write('<tr>');
	
	/*Text Field for Upload Entry*/
		write('<tr>');	
	write('<td class="textlabel">' + jspResArr.get("FLT026331") + '<font color=red size=2>*</font></td>');
	write('<td class="textfield"><input type="file" name="' + subGroupName + '.fileName" id="fileName" ' + cinttmupProps.get("fileName_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="100" /></td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	
	write('<td class="textlabel">' + jspResArr.get("FLT026337") + '<font color=red size=2>*</font></td>');
	write('<td class="textfield"><input type="text" name="' + subGroupName + '.vfileName" id="vfileName" ' + cinttmupProps.get("vfileName_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="100" />');
	 write('<a id="sLnk3" target=_self href="Javascript:fnvFileList()">');
	 write('<img class="img" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search1"></img>');
	 write('</a>');
		write('</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	
	write('</tr>');
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
        write('<input name="Submit" type="button" class="button" onClick="javascript:return cinttmup_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	write('<input name="Clear" type="button" class="button" onClick="javascript:return cinttmup_det_ONCLICK2(this);" id="Clear" value="Clear">');
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
	pre_ONLOAD('cinttmup_det',this);

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
	post_ONLOAD('cinttmup_det',this);
	fnPopulateControlValues();
	ObjForm.funcCode.focus();

}
function post_ONLOAD(obj1,obj2)
{
    fnPopulateControlValues();
}

function fnValidateData()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];
	
	ObjForm.funcCode.value = funccode;
	 
}

function cinttmup_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if(fnIsNull(document.forms[0].funcCode.value)) 
	{
		alert("Enter the Function Code");
		document.forms[0].funcCode.focus();
		return false;
	}
	alert(document.forms[0].funcCode.value)

	if(document.forms[0].funcCode.value == "U")
	{ 
		if(document.forms[0].fileName.value =="")
		{
			alert("Please Enter the File Name.");
			document.forms[0].period.focus();
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
		
		fnUpload();
	}

	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}

	return (retVal == undefined) ? true : retVal;
}

function fnCheckSpecialChar(name){

        //alert("checking For Special Chars ");
        returnFlg="true";
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

function cinttmup_det_ONCLICK2(obj)
{
	var retVal = "";
	/*if (pre_ONCLICK('cinttmup_det',obj) == false) { 
		return false;
	}*/
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	/*if (post_ONCLICK('cinttmup_det',obj) == false) { 
		return false;
	}*/
	return (retVal == undefined) ? true : retVal;
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


function funcOnchange()
{
        objForm = document.forms[0];
        
}

//custom function
function f1()
{
	f2();
	
	var fn = document.getElementById("funcCode").value;
	if(fn == 'U')
	{
		enableFields("fileName");
		disableFields("vfileName");
	}
	 
	else if(fn == 'V' || fn == 'Z' || fn == 'I' )
	{
		enableFields("vfileName")	
		disableFields("fileName");
	}
	 
	funcOnchange();
}

function f2()
{
        if(document.forms[0].funcCode.value == 'U')
        {
                hideImage("sLnk2");
                hideImage("sLnk4");
				hideImage("sLnk3");
		//fnFnCodeValidate();
        }
        else
        {
                showImage("sLnk2");
				showImage("sLnk3");
        }
}

function fnvFileList()
{

    var inputNameValues = "filename|funcCode";
    var outputNames = "vfileName|uploadby";
    var scrName = "fetchcinttmupFile.scr";
    var title = "UNVERIFIED UPLOAD INTEREST FILES";
    var literalNames = "FILE NAME|UPLOADED BY";
    var hyperLnks = "1";
    var retVal = fnExecuteScriptForList(inputNameValues, outputNames, scrName, title, literalNames, hyperLnks, true);
    var ret1 = retVal.split("|");
}

 
 
//-----------------------------------Modified for TOL 369221---------------------------
function fnFnCodeValidate(){
		var fn = document.getElementById("funcCode").value;
		var inputNameValues = "funcCode|" + fn;
		var outputNames     = "";
		var scrName         = "cinttmupdp007.scr";
		var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
			

		if(retVal != undefined)
	{
	
        var value = retVal.split("|");
		if(value[0] =="STATUS" && value[1] =="F"){
				alert("only users belonging to SOL '000' can upload ");
				document.getElementById("funcCode").value ="";
				return false;
			}
	}
}
//-----------------------------------Modified for TOL 369221---------------------------
