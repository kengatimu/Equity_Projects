/*-----------------------------------------------------------------------------------------
    NAME            :   bpapddet_custom_link.js
    Module Code     :   DENOM
    Menu Option     :   HDDMI

    Modification History:
    ====================
    Serial No.      DATE            Author               Description
--------------------------------------------------------------------------------------------*/


function ddmidet_pre_ONCLICK(obj)
{
	//if(purTranType == "C" && (funcCode == "A" || funcCode == "I" || funcCode == "M" || funcCode == "P" || funcCode == "D"))
	if(purTranType == "C" && (funcCode == "I" || funcCode == "P" ))	
	{
		if(obj.id=="chkdelFlg")
		delClick = true;
		
		if(obj.id=="Submit"||obj.id=="Go"||obj.id=="Ok")
		{
			frm = document.forms[0];
			frm.Event.value = (funcCode=="P")?"P":"E";
                        var out = fnDenomscreen();
                        if(out==false)
                                return false;
                        setFieldsToCustomData("DenomEntered","DenomCount","Event");
			return true ;
		}
	}	

	
}




function fnDenomscreen()
{

if(funcCode == "A")
 tranId = "";

var tranSubType = "CR";
var tempFuncCode = "";
                        if(funcCode == "P")
                        {
                                tempFuncCode = "A";
                        }
                        if(funcCode == "I")
                        {
                                tempFuncCode = "I";
                        }


var tranType = purTranType;
var crAcctId = ddAcctId;
var cashCrncyCode = purCrncyCode;
var cashmt =  parseFloat(totDDAmt) + parseFloat(totFeeAmt);
var cashAmt = cashmt.toString();

	if(commCrCrncy == cashCrncyCode) 
	{
		var retVal = cust_fndenompopup(tempFuncCode,tranType,tranSubType,crAcctId,cashCrncyCode,cashAmt,"C",BODDate,tranId,"P","Y","");
	}
	else
	{
		if(totFeeAmt != 0) 
		{
			var crAcctId1 = crAcctId + "@" + crAcctId;
			var cashCrncyCode1 = cashCrncyCode + "@" + commCrCrncy;
			var cashAmt1 = totDDAmt + "@" + totFeeAmt;
			var partTranType1 = "C" + "@" + "C"
			var retVal = cust_fndenompopup(tempFuncCode,tranType,tranSubType,crAcctId1,cashCrncyCode1,cashAmt1,partTranType1,BODDate,tranId,"P","Y","");
		}	
		else
		{	
			var retVal = cust_fndenompopup(tempFuncCode,tranType,tranSubType,crAcctId,cashCrncyCode,cashAmt,"C",BODDate,tranId,"P","Y","");	
		}	
	}
	if(retVal=="DISABLED") 
		return true;
			
	//if(funcCode=="I"||funcCode=="P"||funcCode=="D"||funcCode=="V")
	if(funcCode=="I")  
	{
		frm.DenomEntered.value="Y";
		return true;    
	}
			
	if(retVal=="cancel"||retVal==false||retVal=="undefined" ) 
		return false;
	
	if(retVal==true) 
		return true;
			
	var flag = retVal.split("|");
	if(flag[0]=="N")
		return false;
	else
		frm.DenomEntered.value="Y";
	
	if(retVal!=null)
	{
		frm.DenomEntered.value="Y";
		frm.DenomCount.value=retVal;
	}
	return true;
}

