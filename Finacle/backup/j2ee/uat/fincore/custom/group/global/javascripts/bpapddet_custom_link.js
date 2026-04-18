/*-----------------------------------------------------------------------------------------
    NAME            :   bpapddet_custom_link.js
    Module Code     :   DENOM
    Menu Option     :   HBPAD

    Modification History:
    ====================
    Serial No.      DATE            Author               Description
--------------------------------------------------------------------------------------------*/
function fnDenomscreen()
{
	if(funcCode == "A")
		tranId = "";
var tranType = "";

if(cashMode == "Y")
{
   tranType="C";
}
var crAcctId = "5454";
var tranSubType = "CR";

	var retVal = cust_fndenompopup(funcCode,tranType,tranSubType,crAcctId,cashCrncyCode,cashAmt,"C",BODDate,tranId,"P","Y","");
	if(retVal=="DISABLED") 
		return true;
			
	if(funcCode=="I"||funcCode=="P"||funcCode=="D"||funcCode=="V")  
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

function bpapddet_pre_ONCLICK(obj)
{

        if(obj.id=="Save" || obj.id=="Post" || obj.id=="OK" || obj.id=="Submit")
        {
		frm = document.forms[0];

		if(cashMode == "Y")
		{
			frm.Event.value = (obj.id=='Post'||obj.id=='Submit')?"P":"E";
			var out = fnDenomscreen();
			if(out==false) 
				return false;
			setFieldsToCustomData("DenomEntered","DenomCount","Event");
		}  
        }
        return true;
}


