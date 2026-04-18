<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
		return true;
}

function fnCheckMandatoryFields() 
{
	var objForm = document.forms[0];
	
	temp1=objForm.drAcctNum.value;
	temp1=temp1.replace(/\s/g,'');
	objForm.drAcctNum.value = temp1;
	
	if(temp1 == "")
	{
		alert ("Enter the Debit Account Number.");
		objForm.drAcctNum.focus();
		return false;
	} 
	
	temp1=objForm.opAcctNum.value;
	temp1=temp1.replace(/\s/g,'');
	objForm.opAcctNum.value = temp1;

	if(temp1=="")
	{
		alert ("Operative Account Number cannot be blank.");
		return false;
	}
	
	temp1=objForm.PLAcctNum.value;
	temp1=temp1.replace(/\s/g,'');
	objForm.PLAcctNum.value = temp1;

	if(temp1=="")
	{
		alert ("P&L Account Number cannot be blank.");
		return false;
	}
	
	return true;
}


function getAcctIdList() {
	var objForm = document.forms[0];
    showAccountIdList(objForm.drAcctNum,null,null,'F');
	fnGetAccountDetails();
}

function fnGetAccountDetails() {
	var objForm = document.forms[0];
	var	temp1=objForm.drAcctNum.value.replace(/\s/g,'');
	objForm.drAcctNum.value = temp1;
	if(temp1 == "")
	{
		objForm.acctEntityId.value="";
		objForm.acctSolId.value="";
		objForm.acctCrncy.value="";
		objForm.acctName.value="";
		return;
	} 
	var acctNum = objForm.drAcctNum.value;
	var inputNameValues    = "acctNum|"+acctNum;
	var outputNames        = "errorFlg|errorMsg|acctEntityId|acctSolId|acctCrncy|acctName";
	var scrName            = "ctaracodp001.scr";
	var retVal             = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
	var result      = retVal.split("|");
	var errorFlg = result[1];
	var errorMsg = result[3];
	
	if(errorFlg=="Y")
	{
		alert(errorMsg);
		objForm.drAcctNum.value="";
		objForm.acctEntityId.value="";
		objForm.acctSolId.value="";
		objForm.acctCrncy.value="";
		objForm.acctName.value="";
		objForm.opAcctNum.value="";
		objForm.opAcctEntityId.value="";
		objForm.opAcctSolId.value="";
		objForm.opAcctCrncy.value="";
		objForm.opAcctName.value="";
		objForm.PLAcctNum.value="";
		objForm.PLAcctEntityId.value="";
		objForm.PLAcctSolId.value="";
		objForm.PLAcctCrncy.value="";
		objForm.PLAcctName.value="";
		objForm.IntrstAmt.value="";
		objForm.drAcctNum.focus();
		return false;
	}  
	else
	{
		if((errorMsg != "") || (errorMsg != " "))
		{
                	alert(errorMsg);
		}
		objForm.acctEntityId.value=result[5];
		objForm.acctSolId.value=result[7];
		objForm.acctCrncy.value=result[9];
		objForm.acctName.value=result[11];
		objForm.drAcctNum.value=result[13];
		objForm.opAcctEntityId.value=result[15];
		objForm.opAcctSolId.value=result[17];
		objForm.opAcctCrncy.value=result[19];
		objForm.opAcctName.value=result[21];
		objForm.opAcctNum.value=result[23];
		objForm.PLAcctEntityId.value=result[25];
		objForm.PLAcctSolId.value=result[27];
		objForm.PLAcctCrncy.value=result[29];
		objForm.PLAcctName.value=result[31];
		objForm.PLAcctNum.value=result[33];
		objForm.IntrstAmt.value=result[35];
		
	}
	return true;
}

function post_ONLOAD()
{
	document.forms[0].PLAcctNum.disbaled = true;
}
/*
function fnGetCreditAcctNum(){
	var objForm = document.forms[0];
	var commCode = objForm.commCode.value;
	var inputNameValues    = "acctType|COMMISSION"+"|commCode|"+commCode;
	var outputNames        = "errorFlg|errorMsg|opAcctNum|opAcctEntityId|opAcctSolId|opAcctCrncy|opAcctName";
	var scrName            = "ctaracodp002.scr";
	var retVal             = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
	var result      = retVal.split("|");
	var errorFlg = result[1];
	var errorMsg = result[3];
	
	if(errorFlg=="Y"){
		alert(errorMsg);
		objForm.opAcctNum.value="";
		objForm.opAcctEntityId.value="";
		objForm.opAcctSolId.value="";
		objForm.opAcctCrncy.value="";
		objForm.opAcctName.value="";
		return false;
	} 
	else{
		objForm.opAcctNum.value=result[5];
		objForm.opAcctEntityId.value=result[7];
		objForm.opAcctSolId.value=result[9];
		objForm.opAcctCrncy.value=result[11];
		objForm.opAcctName.value=result[13];
	}	
	fnGetTaxAcctNum();
	return true;
}

function fnGetTaxAcctNum(){
	var objForm = document.forms[0];
	
	var inputNameValues    = "acctType|TAX";
	var outputNames        = "errorFlg|errorMsg|opAcctNum|opAcctEntityId|opAcctSolId|opAcctCrncy|opAcctName";
	var scrName            = "compay004.scr";
	var retVal             = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
	var result      = retVal.split("|");
	var errorFlg = result[1];
	var errorMsg = result[3];
	
	if(errorFlg=="Y"){
		alert(errorMsg);
		objForm.PLAcctNum.value="";
		objForm.PLAcctEntityId.value="";
		objForm.PLAcctSolId.value="";
		objForm.PLAcctCrncy.value="";
		objForm.PLAcctName.value="";
		return false;
	} 
	else{
		objForm.PLAcctNum.value=result[5];
		objForm.PLAcctEntityId.value=result[7];
		objForm.PLAcctSolId.value=result[9];
		objForm.PLAcctCrncy.value=result[11];
		objForm.PLAcctName.value=result[13];
	}	
	return true;
}*/

function showAcctDetails() {
	var ObjForm = document.forms[0];
	if (fnIsNull(ObjForm.drAcctNum.value)) {
		alert("Enter the Account Number");
		ObjForm.drAcctNum.focus();
		return;
	}
	var sUrl = "../arjspmorph/"+applangcode+"/acctdtls.jsp?acctId="+ObjForm.drAcctNum.value;
	popModalWindow(sUrl,"Acct Details");
}

function showFinacleSignature(a)
{	/* if(SVS_Flag!=undefined&&SVS_Flag=="Y")
	{
		 showSVSSignature(a)
	}
	else
	{ */
		showSVSSignature(a);
		//showCoreSignature()
	//}
}

function fnvalIntrstAmt(obj)
{
        if (obj.value != ''){
                var fieldValue=(obj.value).toUpperCase();
                fieldValue=fieldValue.replace(/\s/g,'');
                fieldValue=fieldValue.replace(",","");
                var errflag=0;

                amt = getAmtInStdFormat(fieldValue);
                if (isNaN(amt)){
                        errflag="1";
                        alert("Invalid Amount");
                        obj.focus();
                        obj.value = "";
                        return false;
                        }
                if (amt==""){
                        errflag="1";
                        alert("Invalid Amount");
                        obj.focus();
                        obj.value = "";
                                                return false;
                        }
                if (amt == 0){
                    obj.value = fieldValue;
                    return true;
                }
                if (amt <= 0){
                        errflag="1";
                        alert("Invalid Amount");
                        obj.focus();
                        obj.value = "";
                        return false;
                }
                if((amt.length >17)||(isNaN(amt))){
                        errflag="1";
                        alert("Invalid Amount");
                        obj.focus();
                        obj.value = "";
                        return false;
                }
                index =amt.indexOf(DEF_DECIMAL_SEPARATOR);

                if(index > 14){
                        errflag="1";
                        alert("Invalid Amount");
                        obj.focus();
                        obj.value = "";
                        return false;
                                }
                if((index== -1)&&(amt.length > 14)){
                        errflag="1";
                        alert("Invalid Amount");
                        obj.focus();
                        obj.value = "";
                        return false;
                }
                if(errflag=="1"){
                        return false;
                }
                obj.value = fieldValue;
                return true;
        }
}

function fnGetAccountDetails1(obj) {
        var objForm = document.forms[0];
        var opactNum=obj.value
        if(opactNum == "")
        {
                objForm.opAcctEntityId.value="";
                objForm.opAcctSolId.value="";
                objForm.opAcctCrncy.value="";
                objForm.opAcctName.value="";
                return;
        }
        var inputNameValues    = "acctNum|"+opactNum;
        var outputNames        = "errorFlg|errorMsg|acctEntityId|acctSolId|acctCrncy|acctName";
        var scrName            = "ctaracodp002.scr";
        var retVal             = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var result      = retVal.split("|");
        var errorFlg = result[1];
        var errorMsg = result[3];

        if(errorFlg=="Y")
        {
                alert(errorMsg);
                objForm.opAcctNum.value="";
                objForm.opAcctEntityId.value="";
                objForm.opAcctSolId.value="";
                objForm.opAcctCrncy.value="";
                objForm.opAcctName.value="";
                return false;
        }
        else
        {
                objForm.opAcctEntityId.value=result[5];
                objForm.opAcctSolId.value=result[7];
                objForm.opAcctCrncy.value=result[9];
                objForm.opAcctName.value=result[11];
                objForm.opAcctNum.value=result[13];
	}
return true;
}

