/*-----------------------------------------------------------------------------------------
    NAME            :   ddmpdet_custom_link
    Module Code     :   DENOM
    Menu Option     :   HDDMP

    Modification History:
    ====================
    Serial No.      DATE            Author               Description
--------------------------------------------------------------------------------------------*/

function fnDenomscreen()
{

	if(funcCode == "A")
		tranId = "";
	
	var tranSubType = "CR";
	
	var retVal = cust_fndenompopup(funcCode,vTranType,tranSubType,ddAcctId,ddAcctCrncy,vTotDDAmt,"C",BODDate,tranId,"P","Y","");
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

function ddmpdet_pre_ONCLICK(obj)
{

        if(obj.id=="Save" || obj.id=="Post" || obj.id=="Ok" || obj.id=="Submit")
        {
		frm = document.forms[0];

		if(vTranType == "C" && (funcCode == "A" || funcCode == "P" || funcCode == "I" || funcCode == "M" || funcCode == "D"))
		{
			frm.Event.value = (funcCode=="P")?"P":"E";
			var out = fnDenomscreen();
			if(out==false) 
				return false;
			setFieldsToCustomData("DenomEntered","DenomCount","Event");
		}  
        }
        return true;
}


