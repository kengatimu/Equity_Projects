function printBlock()
{
	writeCustomHeader("rtgsupld_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading"> RTGS UPLOAD MENU </td>');
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
	write('<a href="javascript:showHelpFile(\'rtgsupld_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
	write('</tr>');
	
	/*Drop Down for Function Code*/


	var workclass=USER_MENU_ID.substring(9, 12);
    // alert(workclass);
	//alert(profileId);

	
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026332") +'<font color="red" size="2"> *</font></td>');
	write('<td><select name="' + subGroupName + '.funcCode" id="funcCode" ' + rtgsupldProps.get("funcCode_ENABLED") + ' class="textfieldfont" onchange="javascript:f1()">');
	write('<option value="" selected>' + jspResArr.get("FLT026341") + '</option>');
	//write('<option value="A">' + jspResArr.get("FLT026342") + '</option>');
	//write('<option value="M">' + jspResArr.get("FLT026343") + '</option>');
	//write('<option value="Z">' + jspResArr.get("FLT026344") + '</option>');
	//write('<option value="I">' + jspResArr.get("FLT026345") + '</option>');
	//write('<option value="V">' + jspResArr.get("FLT026346") + '</option>');
	write('<option value="IU">' + jspResArr.get("FLT026348") + '</option>');

	if ((workclass=="152")||(workclass=="260"))
	{
	write('<option value="VU">' + jspResArr.get("FLT026349") + '</option>');
	}
	if (workclass=="146")
	{
	write('<option value="U">' + jspResArr.get("FLT026347") + '</option>');
	}	
	
	write('</select>');
	write('</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('</tr>');
	
	/*Text Field for Single Entry*/	 
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026333") + '<font color=red size=2>*</font></td>');
	write('<td><input name="' + subGroupName + '.foracid" id="foracid" ' + rtgsupldProps.get("foracid_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" onBlur="javascript:return rtgsupld_ONBLUR12(this);"  onchange="javascript:return rtgsupld_ONCHANGE1(this,this,\'acctName\',\'acctSolId\',\'acctCrncy\',true,\'VALCUSTACCTID\');">');
 	write('<a id="sLnk2" target=_self href="javascript:fnshowAccountIdList(document.forms[0].foracid);" >');
	write('<img id="benfList1" width="16" height="17" border="0"  hotKeyId="search1" src="../Renderer/images/search_icon.gif"></img></a>');
	write('<input type="text" name="acctCrncy" id="acctCrncy" size="3" maxlength="3"  class="label" readonly="readonly" disabled>');
	write('<input type="text" name="acctSolId" id="acctSolId" size="8" maxlength="8"  class="label" readonly="readonly" disabled>');
	write('<input type="text" name="acctName" id="acctName"  size="50" maxlength="50" class="label" readonly="readonly" disabled>');

	write('<br>');
	write('</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('</tr>');
	
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026334") + '</td>');
	write('<td><input name="' + subGroupName + '.employer" id="employer" ' + rtgsupldProps.get("employer_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	write('<a target=_self id="sLnk4" href="javascript:fnCustEmployerSearcher(document.forms[0].employer,document.forms[0].empName)" ><img class="img" src="../Renderer/images/'+ applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search4"></img></a>');
	write('<input name="' + subGroupName + '.empName" id="empName" type="text" size="50" maxlength="50" readonly disabled class="label" >');

	write('</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('</tr>');
	
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026335") + '<font color=red size=2>*</font></td>');
	write('<td><input name="' + subGroupName + '.amount" id="amount" ' + rtgsupldProps.get("amount_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" onBlur="javascript:valAmount();">');
	write('</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026336") + '<font color=red size=2>*</font></td>');
	write('<td><input name="' + subGroupName + '.score" id="score" ' + rtgsupldProps.get("score_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" onBlur="javascript:valScore();">');
	write('</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026337") + '<font color=red size=2>*</font></td>');
	write('<td><input name="' + subGroupName + '.period" id="period" ' + rtgsupldProps.get("period_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" onBlur="javascript:valPeriod();">');
	write('</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('</tr>');
	write('<tr>');
	
	/*Text Field for Upload Entry*/
	write('<tr>');	
	write('<td class="textlabel">' + jspResArr.get("FLT026331") + '<font color=red size=2>*</font></td>');
	write('<td class="textfield"><input type="file" name="' + subGroupName + '.fileName" id="fileName" ' + rtgsupldProps.get("fileName_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="100" /></td>');
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
        write('<input name="Submit" type="button" class="button" onClick="javascript:return rtgsupld_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	write('<input name="Clear" type="button" class="button" onClick="javascript:return rtgsupld_det_ONCLICK2(this);" id="Clear" value="Clear">');
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
	pre_ONLOAD('rtgsupld_det',this);

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
	post_ONLOAD('rtgsupld_det',this);
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
	ObjForm.foracid.value = foracid;
	ObjForm.employer.value = employer;
	ObjForm.amount.value = amount;
	ObjForm.score.value = score;
	ObjForm.period.value = period;
}

function rtgsupld_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if(fnIsNull(document.forms[0].funcCode.value)) 
	{
		alert("Enter the Function Code");
		document.forms[0].funcCode.focus();
		return false;
	}
	if(document.forms[0].funcCode.value == 'U' || document.forms[0].funcCode.value == 'VU' || document.forms[0].funcCode.value == 'IU')
	{ 

		if(document.forms[0].fileName.value =="")
		{
			alert("Please Enter the File Name.");
			document.forms[0].period.focus();
			return false;
		}
		else if(document.forms[0].fileName.value !="")
		{	
				
				var file = document.getElementById("fileName").value;
				var fileIndex = file.lastIndexOf("\\");
				var fileName = file.substring(fileIndex+1);
				//alert("File Name : " + fileName);
				if(!fnCheckSpecialChar(fileName))
				{
					return false;
				}
				
				var index = file.lastIndexOf(".");
				var ext = file.substring(index+1);
				ext = ext.toUpperCase();
				if(ext != "TXT" && ext != "CSV")
				{
					alert("Please enter only csv/txt extension file for uploading");
					return false;
				}
		}
		
		fnUpload();
		

	}
	else
	{
		
		
		if(fnIsNull(document.forms[0].foracid.value)) 
		{
			alert("Enter the Account Number");
			document.forms[0].foracid.focus();
			return false;
    		}
	
	//	if(fnIsNull(document.forms[0].employer.value)) 
	//	{
	//		alert("Enter the Employer");
	//			document.forms[0].employer.focus();
	//			return false;
	  //  		}
	
		if(fnIsNull(document.forms[0].amount.value)) 
		{
			alert("Enter the Amount");
			document.forms[0].amount.focus();
			return false;
    		}
		
	//	if(fnIsNull(document.forms[0].score.value)) 
	//	{
	//			alert("Enter the Score");
	//		document.forms[0].score.focus();
		//	return false;
	//	}
	
		if(fnIsNull(document.forms[0].period.value)) 
		{
			alert("Enter the Period");
			document.forms[0].period.focus();
			return false;
		}
		
		
		
	}

	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}

	return (retVal == undefined) ? true : retVal;
}

function fnCheckSpecialChar(name){

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

function rtgsupld_det_ONCLICK2(obj)
{
	var retVal = "";
	/*if (pre_ONCLICK('rtgsupld_det',obj) == false) { 
		return false;
	}*/
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	/*if (post_ONCLICK('rtgsupld_det',obj) == false) { 
		return false;
	}*/
	return (retVal == undefined) ? true : retVal;
}



function fnshowAccountIdList(obj){
	var objForm = document.forms[0];
	showAccountIdListt(objForm.foracid,objForm.acctSolId,objForm.acctName,'F',objForm.acctCrncy,'','','');

	//showAccountIdList(obj,null,null,'F');
	//fnCustValidate();
}
function showAccountIdListt(acctObj,solId,acctName,inPreceedence,currDesc,defCrncyCode,defSchemeCode,defSchemeType,defSolId,defCifId,defGLSubHead,defOwnership,defShortName,defAcctLbl,defPartn,doAutoSubmit,defMasterAcctId,searchLang,targetBankId,dispBankIDFldFlg)
{
/* Function modified to add input parameters to default in Account Id Criteria.
If these are not supplied, the list would continue working as before.
Note that the arguments.length <5 should be modified with care. */

        var sUrl = "";
        var preceedence = 'B';
        var strCrncyCode = "";
        var strSchemeCode = "";
        var strSchemeType = "";
        var strSolId = "";
        var strCifId = "";
        var strsearchLang = "";
        var strGLSubHead = "";
        var strOwnership = "";
        var strShortName = "";
        var strAcctLbl = "";
        var strPartn = "";
        var strSubmit = "";
        var strTargetBankId = "";
        var acctIdVal = "";

/* Assigning default if passed */
        if(acctObj.value != ""){acctIdVal = acctObj.value;}
        if(targetBankId  == undefined){ strTargetBankId  = "";} else {strTargetBankId  = targetBankId.value;}
    if(defCrncyCode  == undefined){ strCrncyCode  = "";} else { strCrncyCode  = defCrncyCode;}
    if(defSchemeCode == undefined){ strSchemeCode = "";} else { strSchemeCode = defSchemeCode;}
    if(defSchemeType == undefined){ strSchemeType = "";} else { strSchemeType = defSchemeType;}
    if(defSolId      == undefined){ strSolId      = "";} else { strSolId      = defSolId;}
    if(defCifId     == undefined){ strCifId     = "";} else { strCifId     = defCifId;}
    if(searchLang     == undefined){ strsearchLang = "";} else { strsearchLang = searchLang;}
    if(defGLSubHead  == undefined){ strGLSubHead  = "";} else { strGLSubHead  = defGLSubHead;}
    if(defOwnership  == undefined){ strOwnership  = "";} else { strOwnership  = defOwnership;}
//    if(defShortName  != undefined){ strShortName  = defShortName;}
    if(defAcctLbl    == undefined){ strAcctLbl  = "";} else { strAcctLbl  = defAcctLbl;}
    if(defPartn      == undefined){ strPartn = "";} else { strPartn = defPartn;}
        if(defMasterAcctId  == undefined){ strMasterAcctId  = "";} else { strMasterAcctId  = defMasterAcctId;}
        if(doAutoSubmit  == undefined){ strSubmit = "";} else { strSubmit = doAutoSubmit;}

    if(arguments.length > 3)
    {
        preceedence = inPreceedence;
    }
        if (arguments.length < 5)
        {
                sUrl = "../arjspmorph/"+applangcode+"/search_accountId.jsp?wReturn="+acctObj.id+"&wReturnCrncy=NULL&wReturnSol=NULL&wReturnAcct=NULL&preceedence="+preceedence+"&defCrncyCode="+escape(strCrncyCode)+"&defSchemeCode="+escape(strSchemeCode)+"&defSchemeType="+escape(strSchemeType)+"&defSolId="+escape(strSolId)+"&defCifId="+escape(strCifId)+"&searchLang="+escape(strsearchLang)+"&defGLSubHead="+escape(strGLSubHead)+"&defOwnership="+strOwnership+"&defOwnership="+strOwnership+"&defShortName="+escape(strShortName)+"&defAcctLbl="+strAcctLbl+"&defPartn="+strPartn+"&defMasterAcctId="+escape(strMasterAcctId)+"&targetBankId="+escape(strTargetBankId)+"&dispBankIDFldFlg="+dispBankIDFldFlg+"&defacctIdVal="+acctIdVal+"&doAutoSubmit="+strSubmit;
        }else
        {
                sUrl = "../arjspmorph/"+applangcode+"/search_accountId.jsp?wReturn="+acctObj.id+"&wReturnCrncy="+currDesc.id+"&wReturnSol="+solId.id+"&wReturnAcct="+acctName.id+"&preceedence="+preceedence+"&defCrncyCode="+escape(strCrncyCode)+"&defSchemeCode="+escape(strSchemeCode)+"&defSchemeType="+escape(strSchemeType)+"&defSolId="+escape(strSolId)+"&defCifId="+escape(strCifId)+"&searchLang="+escape(strsearchLang)+"&defGLSubHead="+escape(strGLSubHead)+"&defOwnership="+strOwnership+"&defShortName="+escape(strShortName)+"&defAcctLbl="+escape(strAcctLbl)+"&defPartn="+strPartn+"&defMasterAcctId="+escape(strMasterAcctId)+"&targetBankId="+escape(strTargetBankId)+"&dispBankIDFldFlg="+dispBankIDFldFlg+"&defacctIdVal="+acctIdVal+"&doAutoSubmit="+strSubmit;
        }

                if ("Microsoft Internet Explorer" == browser_name)
                {
                     var retVal = popModalWindow(sUrl,"");
                if (retVal != null && retVal != undefined )
                {
                        //Array for taking the values after splitting the value with "|".
                        var liarrBufArray = retVal.split("|");

                if(acctObj!=null) acctObj.value = liarrBufArray[0];
                        if(currDesc!=null) currDesc.value = liarrBufArray[1];
                        if(solId!=null) solId.value = liarrBufArray[2];
                        if(acctName!=null) acctName.value = liarrBufArray[3];
						autopopulate(acctObj.value);
                }
                }else{
                            popModalWindowMozillaFrame(sUrl,"");
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

//custom function
function f1()
{
	f2();
	
	var fn = document.getElementById("funcCode").value;
	if(fn == 'U' || fn == 'IU'  || fn == 'VU')
	{
		enableFields("fileName");
		disableFields("foracid","employer","amount","score","period");
	}
	else if(fn == 'M')
	{	
		enableFields("foracid","employer","amount","period");
		//disableFields("score","fileName");
		disableFields("fileName");
	}
	else if(fn == 'V' || fn == 'Z' || fn == 'I' )
	{
		enableFields("foracid")	
		disableFields("employer","amount","score","period","fileName");
	}
	else
	{	
		enableFields("foracid","employer","amount","score","period");
		disableFields("fileName");
	}
	funcOnchange();
}

function f2()
{
        if(document.forms[0].funcCode.value == 'U' || document.forms[0].funcCode.value == 'VU' || document.forms[0].funcCode.value == 'IU')
        {
                hideImage("sLnk2");
                hideImage("sLnk4");
		//fnFnCodeValidate();
        }
        else
        {
                showImage("sLnk2");
        }
}

function rtgsupld_ONBLUR12(obj)
{
	if(document.forms[0].funcCode.value == 'M' || document.forms[0].funcCode.value == 'V' || document.forms[0].funcCode.value == 'Z' || document.forms[0].funcCode.value == 'I')
	{
		var foracid = document.getElementById("foracid").value;
		if(document.forms[0].foracid.value != "")
		{	
			autopopulate(foracid);
		}
	}
	return true;
}
function autopopulate(obj)
{
	var foracid = obj;
	var funcCode = document.forms[0].funcCode.value;
	if(funcCode != 'A')
	{
		var inputNameValues = "foracid|"+foracid + "|" + "funcCode|" + document.forms[0].funcCode.value;
		var outputNames     = "";
		var scrName         = "rtgsuplddp005.scr";
		var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
			
		var ret = retVal.split("|");
		if(ret[0] =="ERROR" && ret[1] !="")
		{
			alert(ret[1]);
			document.getElementById("funcCode").focus();
			return false;
		}
		if(ret[0] =="EMPLOYER"){
			document.getElementById("employer").value = ret[1];
			document.getElementById("amount").value = ret[3];
			document.getElementById("score").value = ret[5];
			document.getElementById("period").value = ret[7];
			document.getElementById("employer").disabled =true;
		}
		return true;
	}
}

function valAmount()
{
	if(isNaN(document.getElementById("amount").value))
	{
		alert("Enter the Valid Amount Code");
		document.forms[0].amount.focus();
		return false;
	}
}
function valScore()
{
	if(document.getElementById("score").value != ""){
		if(isNaN(document.getElementById("score").value))
		{
			alert("Enter the Valid Score Code");
			document.forms[0].score.focus();
			return false;
		}		
	}
}
function valPeriod()
{
	if(isNaN(document.getElementById("period").value))
	{
		alert("Enter the Valid Period Code");
		document.forms[0].period.focus();
		return false;
	}
}
function fnCustEmployerSearcher(){
        var inputNameValues = "";
       var outputNames = "employer|empName";
        var scrName     = "rtgsuplddp006.scr";
        var title       = "Employer Code and Employer Name";
        var literalNames= "Employer Code" + "|" + "Employer Name";
        var hyperLnks   = "1";
        var retVal = fnExecuteScriptForList(inputNameValues, outputNames, scrName, title, literalNames, hyperLnks, true);
}

function rtgsupld_ONCHANGE1(obj,p1,p2,p3,p4,p5,p6)
{
	if ((retVal = fetchAcctDtls(p1,p2,p3,p4,p5,p6)) == false)
	{
                return false;
        }

}

function fetchAcctDtls(acctObj, acctName, acctSol, acctCrncy, isError, fType){
        if((retVal=fnCommonFetchAcctDtls(acctObj,acctName,acctSol,acctCrncy,isError,"VALCUSTACCTID"))==false)
        {
                return false;
        }
}

function funcOnchange()
{
        objForm = document.forms[0];
        objForm.acctCrncy.value = "" ;
        objForm.acctSolId.value = "" ;
        objForm.acctName.value = "" ;
        objForm.foracid.value = "" ;
        objForm.employer.value = "" ;
        objForm.amount.value = "" ;
        objForm.score.value = "" ;
        objForm.period.value = "" ;
}
//-----------------------------------Modified for TOL 369221---------------------------
function fnFnCodeValidate(){
		var fn = document.getElementById("funcCode").value;
		var inputNameValues = "funcCode|" + fn;
		var outputNames     = "";
		var scrName         = "rtgsuplddp007.scr";
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
