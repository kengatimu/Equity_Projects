/*-----------------------------------------------------------------------------------------
    NAME            :   tutmdtl_custom_link.js
    Module Code     :   DENOM
    Menu Option     :   HTUTM
    Author          :   Arathilakshmi M
    DATE            :   26-08-2011

    Modification History:
    ====================
    Serial No.      DATE            Author               Description
    1           26-08-2011  Arathilakshmi M				Draft Version
--------------------------------------------------------------------------------------------*/
function fnDenomscreen()
{
	if(funcCode == "A")
		tranId = "";

	var retVal = cust_fndenompopup(funcCode,tranType,tranSubType,frm.crAcctId.value,frm.crAcctCrncy.value,frm.tranAmt.value,"C",tranDate,tranId,"P","Y","");
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

function tutmdtl_pre_ONCLICK(obj)
{

        if(obj.id=="Save" || obj.id=="Post" || obj.id=="OK" || obj.id=="Submit")
        {
		frm = document.forms[0];
		if(tranSubType=="NR"||tranSubType=="CR")
		{
			var amt = removeCommas(frm.tranAmt.value);
			var crncy = frm.crAcctCrncy.value;
			var id = frm.crAcctId.value;

			//out = fnTranmil(amt,crncy,id,funcCode);
			//if(out ==false)
			//	return false;
		}
		if(tranType == "C")
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


