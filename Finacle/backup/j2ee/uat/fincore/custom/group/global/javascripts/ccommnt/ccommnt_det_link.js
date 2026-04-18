<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
		return true;
}

function fnCheckMandatoryFields() {
	var objForm = document.forms[0];
	var temp1=objForm.commCrncy.value.replace(/\s/g,'');
	objForm.commCrncy.value = temp1;
	if(temp1 == "")
	{
		alert ("Enter the Currency Code.");
		objForm.commCrncy.focus();
		return false;
	} 
	
	temp1=objForm.commDesc.value.replace(/\s/g,'');
	//objForm.commDesc.value = temp1;
	if(temp1 == "")
	{
		alert ("Enter the Commission Description.");
		objForm.commDesc.focus();
		return false;
	} 
	
	temp1=objForm.commAmt.value;
	if(temp1==""){
		alert ("Enter the Commission Amount.");
		objForm.commAmt.focus();
		return false;
	}
	if(!isValidAmt(objForm.commAmt))
	{
		objForm.commAmt.focus();
		return false;
	} 
	
	temp1=objForm.commVat.value;
	if(temp1==""){
		alert ("Enter the VAT Rate.");
		objForm.commVat.focus();
		return false;
	}
	if(!isValidAmt(objForm.commVat))
	{
		objForm.commVat.focus();
		return false;
	} 
	if(objForm.commVat.value>100)
	{
		alert("The VAT Percentage cannot be >100");
		objForm.commVat.focus();
		return false;
	}
	
	objForm.placeHolder.value=objForm.placeHolder.value.replace(/\s/g,'');
	if(objForm.placeHolder.value == "")
	{
		alert("Enter the Placeholder.");
		objForm.placeHolder.focus();
		return false;
	}
	return true;
}

function fnGetFunctionCodeDesc(funcCode) {
    switch (funcCode) {
        case 'A':
            return "Add";
        case 'I':
		hideImage("sLnk2"); 
            return "Inquire";
        case 'M':
            return "Modify";
        case 'V':
		hideImage("sLnk2"); 
            return "Verify";
        case 'X':
		hideImage("sLnk2"); 
            return "Cancel";
		case 'D':
		hideImage("sLnk2"); 
            return "Delete";
        default:
            return funcCode;
    }
}

function validateCurrency(){
	var ObjForm = document.forms[0];
	var commCrncy = ObjForm.commCrncy.value;
	if(commCrncy!=''){
		
		var inputNameValues = "commCrncy|" + commCrncy;
		var outputNames = "";
		var scrName = "commntValCrncy.scr";
		var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
		var ret1 = retVal.split("|");
		//alert("ret1: "+ret1);
		if (ret1[1] == "Y"){
			alert(ret1[3]);
			ObjForm.commCrncy.value = "";
			ObjForm.commCrncy.focus(); 
		}
		else{
			ObjForm.commAmt.focus();
		}
	}
	
}

function validatePlaceHolder(){
	var ObjForm = document.forms[0];
	ObjForm.placeHolder.value=ObjForm.placeHolder.value.replace(/\s/g,'');
	var placeHldr = ObjForm.placeHolder.value;
	if(placeHldr!=''){
		var inputNameValues = "placeHldr|" + placeHldr;
		var outputNames = "errFlag|errMsg|placeHldrDesc";
		var scrName = "commntValPlaceHldr.scr";
		var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
		var ret1 = retVal.split("|");
		if (ret1[1] == "Y"){
			alert(ret1[3]);
			ObjForm.placeHolder.value = "";
			ObjForm.placeHldrDesc.value = "";
			ObjForm.placeHolder.focus(); 
		}
		else{
			ObjForm.placeHldrDesc.value = ret1[5];
		}
	}
}

function getRefCrncyList(){
        var ObjForm = document.forms[0];
        var oldValue = ObjForm.commCrncy.value;
        var retVal = popModalWindow("../arjspmorph/"+applangcode+"/get_currency.jsp?wReturn=commCrncy&Currency="+oldValue,"CurrencyList")
;
        if (retVal != null) {
                var j = retVal.split("|");
                ObjForm.commCrncy.value = j[0];
                ObjForm.commAmt.focus();
        }
}

function isValidAmt(obj){
       
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
                        //obj.value = "";
                        return false;
                        }
                if (amt==""){
                        errflag="1";
                        alert("Invalid Amount");
                        obj.focus();
                        //obj.value = "";
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
                        //obj.value = "";
                        return false;
                }
                if((amt.length >17)||(isNaN(amt))){
                        errflag="1";
                        alert("Invalid Amount");
                        obj.focus();
                        //obj.value = "";
                        return false;
                }
                index =amt.indexOf(DEF_DECIMAL_SEPARATOR);
                if(index > 14){
                        errflag="1";
                        alert("Invalid Amount");
                        obj.focus();
                        //obj.value = "";
                        return false;
				}
                if((index== -1)&&(amt.length > 14)){
                        errflag="1";
                        alert("Invalid Amount");
                        obj.focus();
                        //obj.value = "";
                        return false;
                }
                if(errflag=="1"){
                        return false;
                }
                obj.value = fieldValue;
                return true;
        }
}

