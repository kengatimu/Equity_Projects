/*-----------------------------------------------------------------------------------------
    NAME            :   gchrggendet_custom_link.js
    Module Code     :   DENOM
    Menu Option     :   HGCHRG

    Modification History:
    ====================
    Serial No.      DATE            Author               Description
--------------------------------------------------------------------------------------------*/

function gchrggendet_pre_ONCLICK(obj)
{

	if(fnValidateForm("Submit"))
	{
		frm = document.forms[0];	
	
		if(obj.id=="Submit")
		{	
			if(tranType=="C")
			{
				var pTranType;

				if (tranSubType=="CR")
				{
					pTranType = "C";
				}
				else
				{
					pTranType = "D";
				}
				var retVal = cust_fndenompopup("A",tranType,tranSubType,drAcctId,ActDrCrncy,frm.actAmtChrgDrCrncy.value,pTranType,tranDate,tranId,"P","Y","N");

				if(retVal=="cancel"||retVal==false||retVal=="undefined")
				{
					return false;

				}
				if(retVal==true)
				{
					frm.DenomEntered.value="Y";
					frm.DenomCount.value="1";
					frm.Event.value=(sMode=="V")?"P":"E";	
					setCustomFieldValue("DenomEntered","DenomCount","Event");
					return true;
				}
					var flag = retVal.split("|");

				if(flag[0]=="N")
				{
					return false;
				}
				else
					frm.DenomEntered.value="Y";
				if(retVal!=null)
				{
					frm.DenomEntered.value="Y";
					frm.DenomCount.value=retVal;
					frm.Event.value=(sMode=="V")?"P":"E";	
					setCustomFieldValue("DenomEntered","DenomCount","Event");

				}
			}
			return true;
				
		}
	}
}


