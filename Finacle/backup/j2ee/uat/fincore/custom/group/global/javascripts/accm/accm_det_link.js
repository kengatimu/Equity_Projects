/*---------------------------------------------------------------------------------------------------------------->
<!--Name                : accm_det_link.js 
<!--Description         : This is the details page link file for accm menu
<!--Date                : 04-07-2013
<!--Author              :  
<!--Called By           : None    
<!--Calling jsp         : None
<!--Menu Option         : ACCM
<!--Modification History:
<!--	Version No.	      	Date		         Author		Description
<!--	-------        		----------        	-----------	------------------
<!--	 0.1														
<!--	 0.2				31-07-2013			Kalvin		Modified for TO:361667
<!--														in line nos:91-102
<!---------------------------------------------------------------------------------------------------------------->*/
<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
		return true;
}

function fnFetchCharges(contractAmt,acctNo){
	var input = "contractAmt|"+contractAmt+"|"+"acctNo|"+acctNo;
	var scrName  = "accmdp016.scr";
    var output   = "charges";
    var retVal = appFnExecuteScript(input,output,scrName,false);
	if (retVal != null)
    {
        var j=retVal.split("|");
       document.forms[0].charges.value = j[1];
    }
}
function fnFetchReasonCode(){
	var ObjForm = document.forms[0];
	var inputNameValues = "funcCode|" + ObjForm.funcCode.value;
	var outputNameValues = "resCode|resValue";
	var scriptName = "accmdp018.scr";
	var listHeading = "Reason Code";
	var colHeader = "Reason ";
	var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",false);
	if(retVal == undefined)
	{
        ObjForm.remarks.value.value = "";
	}
	else{
        var value = retVal.split("|");
        ObjForm.remarks.value = value[1];
	}

}

function fnGetFunctionCodeDesc(funcCode){
        switch(funcCode){
                case 'A': return "Add New Contract ";
                case 'M': return "Modify New Contract  ";
                case 'X': return "Cancel New Contract ";
                case 'T': return "Terminate Contract ";
                case 'V': return "Verify ";
                case 'I': return "Inquire Contract ";
                case 'E': return "Enhance/Extend Contract";
                case 'Z': return "Modify Enhance/Extend Contract";
                default : return funcCode;
        }

}

function accm_det_post_ONLOAD(){
		
	if (funcCode=="A" ||funcCode=="M" || funcCode =="E" || funcCode=="Z" || funcCode == "I")
	{
		hideImage("terminateResRow");
		document.forms[0].remarks.readOnly = true;
	}
	
	if(funcCode =="V" || funcCode =="X"){
			if(document.forms[0].remarks.value =="") 
		{
			hideImage("terminateResRow");
		}
	}
	/*--------CHANGE MADE FOR TO:361667------------------------------------*/
	if (funcCode =="A" || funcCode =="T" || funcCode =="I" || funcCode =="E")
	{
		hideImage("creDate");
		hideImage("creDateValue");
	}
	else
	{
		showImage("creDate");
		showImage("creDateValue");
	}
	/*--------END OF CHANGE MADE FOR TO:361667----------------------------*/
	if(funcCode =="T") 
	{
		document.forms[0].contrctAmt.readOnly = true;
		document.forms[0].contractPeriod.readOnly = true;
	}

}


function fnFormatAmt()
{
	var obj = document.forms[0];
	var format = "MILLION";
	if(document.forms[0].contrctAmt.value !="")
    {
				newformatAmt(format, obj.contrctAmt, obj.crncyCode.value, 'N'); 
	}
	var contractAmt = obj.contrctAmt.value;
	var cAmt = parseFloat(contractAmt.replace(/\,/g, ''));
	if(cAmt !="")
    {
                if((isNaN(cAmt)) || ((cAmt) < 0))
                {
                        alert("Enter a numeric value or a valid amount.");
                        document.forms[0].contrctAmt.value="";
                        document.forms[0].contrctAmt.focus();
                        return false;
                }
                var amtInFloat =parseFloat(cAmt);
                amtInFloat = amtInFloat.toFixed(2);
                document.forms[0].contrctAmt.value = amtInFloat;
                if (amtInFloat == 0)
                {
                        alert("Enter Contract amount greater than zero.");
                        document.forms[0].contrctAmt.value="";
                        document.forms[0].contrctAmt.focus();
                        return false;
                }
  
		}
}


