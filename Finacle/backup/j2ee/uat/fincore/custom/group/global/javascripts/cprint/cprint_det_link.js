<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
		if(document.forms[0].prIntrst.value=='')
		{
			alert("Please Enter the Interest");
			document.forms[0].prIntrst.focus();
			return false;
		}
		if(!isValidAmt(document.forms[0].prIntrst))
		{
			document.forms[0].prIntrst.focus();
			return false;
		}
		return true;
}

function cprint_det_ONCLICK3(obj){
        if(obj.id == 'Cancel')
        {
                document.forms[0].reset();
                doSubmit("clear");
                return false;
        }
  return true;
}

function cprint_det_post_ONLOAD()
{
if(funcCode =='A' || funcCode =='M' || funcCode =='I' || funcCode =='V' || funcCode =='X' || funcCode =='D')
{
	document.forms[0].roleId.disabled = true;
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
                        alert("Invalid percentage");
                        obj.focus();
                        //obj.value = "";
                        return false;
                        }
                if (amt==""){
                        errflag="1";
                        alert("Invalid percentage");
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
                        alert("percentage cannot be less or equal to 0");
                        obj.focus();
                        //obj.value = "";
                        return false;
                }
                if (amt >100){
                        errflag="1";
                        alert("Percentage cannot be greater than 100");
                        obj.focus();
                        //obj.value = "";
                        return false;
                }

			if((amt.length >17)||(isNaN(amt))){
                        errflag="1";
                        alert("Invalid percentage");
                        obj.focus();
                        //obj.value = "";
                        return false;
                }
                index =amt.indexOf(DEF_DECIMAL_SEPARATOR);
                if(index > 14){
                        errflag="1";
                        alert("Invalid percentage");
                        obj.focus();
                        //obj.value = "";
                        return false;
                                }
                if((index== -1)&&(amt.length > 14)){
                        errflag="1";
                        alert("Invalid percentage");
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

