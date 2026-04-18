/*---------------------------------------------------------------------------------------------------------------->
<!--Name                : accm_det1_link.js 
<!--Description         : This is the details page link file for accm menu
<!--Date                : 04-07-2013
<!--Author              :  
<!--Called By           : None    
<!--Calling jsp         : None
<!--Menu Option         : ACCM
<!--Modification History:
<!--	Version No.	      	Date		         Author		Description
<!--	-------        		----------        	-----------	------------------
<!--	 0.1						23-8-2013			Kalvin		created for TO:361667									
<!--	 0.2			
<!--														
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

function accm_det1_post_ONLOAD(){
	//alert ("TRnig")
		//alert(funcCode)
		
	if (funcCode=="A" ||funcCode=="M" || funcCode =="E" || funcCode=="Z" || funcCode == "I")
	{
		hideImage("terminateResRow");
	}
	
	if(funcCode =="V" || funcCode =="X"){
		//alert("in verify")
		//alert(document.forms[0].remarks.value)
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

}

function fnFormatAmt()
{
if(document.forms[0].contrctAmt.value !="")
        {
                if((isNaN(document.forms[0].contrctAmt.value)) || ((document.forms[0].contrctAmt.value) < 0))
                {
                        alert("Enter a numeric value or a valid amount.");
                        document.forms[0].contrctAmt.value="";
                        document.forms[0].contrctAmt.focus();
                        return false;
                }
                var amtInFloat =parseFloat(document.forms[0].contrctAmt.value);
                amtInFloat = amtInFloat.toFixed(2);
                document.forms[0].contrctAmt.value = amtInFloat;
                //if (amtInFloat == parseFloat('0.00'))
                if (amtInFloat == 0)
                {
                        alert("Enter Contract amount greater than zero.");
                        document.forms[0].contrctAmt.value="";
                        document.forms[0].contrctAmt.focus();
                        return false;
                }
        }
	}

	function fnShowCntrctHist(index){
		var ObjForm = document.forms[0];
		//alert(reqId[index]);
		//return;
	var inputNameValues = "reqId|" + reqId[index];
var outputNameValues = "reqType|reqAmount|reqPeriod|apprvdAmt|apprvdPerd|status|rmrks|charge|cretUser|cretDate|verfdUser|verfdDate";

	var scriptName = "accmdp024.scr";
	var listHeading = "HISTORY DETAILS";
	var colHeader = "REQUEST TYPE|REQUESTED AMOUNT|REQUESTED PERIOD|APPROVED AMOUNT|APPROVED PERIOD|STATUS|REMARKS|CHARGE COLLECTED|CREATED BY|CREATED DATE|VERIFIED BY|VERIFIED DATE ";
	var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"24",false);

		if(retVal != undefined)
	{
	
        var value = retVal.split("|");
		//alert(value);
	
	}
	}


