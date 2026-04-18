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
	//alert("2");
	//alert(tranType);
	//alert(funcCode);
	//alert("payeeAcctId :"+ payeeAcctId);
	//alert("ddAmtCrncyCode :" +ddAmtCrncyCode);
	//alert("tranId: "+tranId);
	//alert("ddAcctId :"+ddAcctId);
	//alert("ddAmt :" + ddAmt);
	//alert("totChrgAmt :"+totChrgAmt);
	//alert("totChrgCrncyCode"+totChrgCrncyCode);
	//alert("svsTranId :"+svsTranId);
	//alert("tranId: "+trnId);
	//alert(trnId);
	//alert("ddAcctNum"+ddAcctNum);
	//alert("ddCrncyCode"+ddCrncyCode);
	
	//alert("refundAcctNum"+refundAcctNum);
	//alert("refundCrncyCode"+refundCrncyCode);
	//alert(trnId);
	 var tranId = trnId;
		if(funcCode == "A")
			tranId = "";

	
	var crAcctId = "5454";
	var tranSubType = "CR";
	//alert("crAcctId" +crAcctId);
	//alert("cashCrncyCode"  + cashCrncyCode);
	//alert("cashAmt "+cashAmt);
	
	
	

	var retVal = cust_fndenompopup(funcCode,tranType,tranSubType,ddAcctNum,ddAmtCrncyCode,ddAmt,"C",bodDate,tranId,"P","Y","");
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

function ddcdet_pre_ONCLICK(obj)
{
//alert("in pre on click");
//alert("cashmode" +cashMode);

        if(obj.id=="Save" || obj.id=="Post" || obj.id=="OK" || obj.id=="Submit")
        {
		//alert("Inside IF");
		//alert("funcode " +funcCode);

		//alert(tranType);
		frm = document.forms[0];

		if(tranType == "C" && (funcCode =="C" || funcCode =="P"))
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


