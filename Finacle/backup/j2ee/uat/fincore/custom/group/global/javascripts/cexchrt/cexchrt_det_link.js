<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
                if(document.forms[0].txmrgnAmt.value=='')
                {
                        alert("Please Enter Transfer Margin Amount");
                        document.forms[0].txmrgnAmt.focus();
                        return false;
                }
        	if(!isValidAmt(document.forms[0].txmrgnAmt))
        	{
               		 document.forms[0].txmrgnAmt.focus();
               		 return false;
        	}
                if(document.forms[0].cashmrgnAmt.value=='')
                {
                        alert("Please Enter Cash Margin Amount");
                        document.forms[0].cashmrgnAmt.focus();
                        return false;
                }
        	if(!isValidAmt(document.forms[0].cashmrgnAmt))
        	{
               		 document.forms[0].cashmrgnAmt.focus();
               		 return false;
        	}
                if(document.forms[0].rate.value=='')
                {
                        alert("Please Enter Rate");
                        document.forms[0].rate.focus();
                        return false;
                }

		return true;
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

function cexchrt_det_pre_ONLOAD()
{
	if((funcCode != "A") && (funcCode != "M"))
	{
		document.forms[0].txmrgnAmt.disbaled=true;
		document.forms[0].cashmrgnAmt.disbaled=true;
		document.forms[0].rate.disbaled=true;
	}
return true;
}
