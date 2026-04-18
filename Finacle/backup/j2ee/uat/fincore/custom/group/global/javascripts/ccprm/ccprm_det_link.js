<!--	This is getting executing on click of submit and validate button -->

function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
	var chrgType = document.forms[0].chrgType.value;
	if(fnIsNull(chrgType))
	{
		alert("Please Enter Charge Type");
		document.forms[0].chrgType.focus();
		return false;
	}
	if(fnIsNull(document.forms[0].chrgAmt.value) && (chrgType == "F"))
	{
		alert("Please Enter Charge Amount");
		document.forms[0].chrgAmt.focus();
		return false;
	}
        if((!isValidAmt(document.forms[0].chrgAmt)) &&(chrgType == "F"))
        {
                document.forms[0].chrgAmt.focus();
                return false;
        }
	if(fnIsNull(document.forms[0].prcnt.value) &&( chrgType == "P"))
	{
		alert("Please Enter Percentage");
		document.forms[0].prcnt.focus();
		return false;
	}
        if(!isValidAmt(document.forms[0].prcnt) &&( chrgType == "P"))
        {
                document.forms[0].prcnt.focus();
                return false;
        }
        if(((document.forms[0].prcnt.value) > 100) &&(chrgType == "P"))
        {
		alert("Percentage should not be greater than 100");
                document.forms[0].prcnt.focus();
                return false;
	}
	if(fnIsNull(document.forms[0].maxAmt.value) &&( chrgType == "P"))
	{
		alert("Please Enter Maximum Amount");
		document.forms[0].maxAmt.focus();
		return false;
	}
        if(!isValidAmt(document.forms[0].maxAmt) &&( chrgType == "P"))
        {
                document.forms[0].maxAmt.focus();
                return false;
        }
	if(fnIsNull(document.forms[0].minAmt.value) &&( chrgType == "P"))
	{
		alert("Please Enter minimum Amount");
		document.forms[0].minAmt.focus();
		return false;
	}
        if(!isValidAmt(document.forms[0].minAmt) &&( chrgType == "P"))
        {
                document.forms[0].minAmt.focus();
                return false;
        }
        if(((document.forms[0].minAmt.value) >= document.forms[0].maxAmt.value) &&(chrgType == "P"))
        {
		alert("Minimum Amount should not be greater or equal to Maximum Amount");
                document.forms[0].prcnt.focus();
                return false;
	}
	if(fnIsNull(document.forms[0].slabCode.value) &&( chrgType == "S"))
	{
		alert("Please Enter slab Code");
		document.forms[0].slabCode.focus();
		return false;
	}
		return true;
}

function ccprm_det_post_ONLOAD()
{
	if(funcCode =="A" || funcCode =="M" || funcCode =="V" || funcCode =="I" || funcCode =="X" || funcCode =="D")
	{
		document.forms[0].schmCode.disabled = true;
		document.forms[0].crncy.disabled = true;
		document.forms[0].evntId.disabled = true;
		document.forms[0].evntType.disabled = true;
                if(chrgType == "F")
                {
                        hideImage("prcnt row");
                        hideImage("prcnt row1");
                        hideImage("slab row");
                        showImage("Amt row");
                }
                if(chrgType == "P")
                {
                        showImage("prcnt row");
                        showImage("prcnt row1");
                        hideImage("slab row");
                        hideImage("Amt row");
                }
                if(chrgType == "S")
                {
                        hideImage("prcnt row");
                        hideImage("prcnt row1");
                        showImage("slab row");
                        hideImage("Amt row");
                }

	}

	if(funcCode =="V" || funcCode =="I" || funcCode =="X" || funcCode =="D")
	{
	        if(chrgType == "F")
       		{
			document.forms[0].chrgAmt.disabled=true;
			document.forms[0].chrgType.disabled=true;
        	}
        	if(chrgType == "P")
        	{
			document.forms[0].prcnt.disabled=true;
			document.forms[0].minAmt.disabled=true;
			document.forms[0].maxAmt.disabled=true;
			document.forms[0].chrgType.disabled=true;
        	}
        	if(chrgType == "S")
        	{
			document.forms[0].slabCode.disabled=true;
			document.forms[0].chrgType.disabled=true;
			hideImage("sLnk2");
        	}

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
function fnSlabCodeList()
{
        var inputNameValues = "";
        var outputNameValues = "slabCode|desc";
        var scriptName = "ccprmdp007.scr";
        var listHeading = "List Of Table Codes"
        var colHeader = "Table Code| Description";
        var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",true);
}
