/*This Custom JS file is written as a part of CIF Core Integration 10.0
Functionality:This script disables address related fields if cif_id is
given else it enables the address related fields in related party tab 
This is not given as the part of Base Product, this is a costomization script */

var cifID = document.forms[0].mastcifId;
var corpcifID = document.forms[0].corpRepCifId;

function relatedparty_det_post_ONLOAD()
{
    if (funcCode !='V' && funcCode !='X' && funcCode !='I')
    {
  		if(cifID.value != '')
		{
	    	disableAddrFields();
		}
		else 
		{
	   		enableAddrFields();
		}
	}
}

function relatedparty_det_ONBLUR(mastcifId)
{
     
   	if(cifID.value != '' && mastcifId.id == "mastcifId")
  	{
  	   disableAddrFields();
   	}
  	else if(cifID.value == ''  && mastcifId.id == "mastcifId")
  	{
  	   enableAddrFields();
   	}
	if(corpcifID.value != '' && mastcifId.id == "corpRepCifId")
    {
        enableFields("addressType");
        showImage("sLnk9");
    }
    else if(corpcifID.value == '' && mastcifId.id == "corpRepCifId")
    {
        disableFields("addressType");
        hideImage("sLnk9");
    }
}

function disableAddrFields()
{
	document.forms[0].custTitle.readOnly = true;
	document.forms[0].custName.readOnly = true;
	document.forms[0].custAddrLine1.readOnly = true;
	document.forms[0].custAddrLine2.readOnly = true;
	document.forms[0].custAddrLine3.readOnly = true;
	document.forms[0].custCityCode.readOnly = true;
	document.forms[0].custStateCode.readOnly = true;
	document.forms[0].custCntryCode.readOnly = true;
	document.forms[0].custPostalCode.readOnly = true;
	document.forms[0].custPhNum.readOnly = true;
	document.forms[0].custTelexNum.readOnly = true;
	document.forms[0].custFaxNum.readOnly = true;
	document.forms[0].custEmailId.readOnly = true;
	if(document.forms[0].custTitle.value != '')
	{
	   hideImage("sLnk8");
	   hideImage("sLnk12");
	}
}

function enableAddrFields()
{
	document.forms[0].custTitle.readOnly = false;
	document.forms[0].custName.readOnly = false;
	document.forms[0].custAddrLine1.readOnly = false;
	document.forms[0].custAddrLine2.readOnly = false;
	document.forms[0].custAddrLine3.readOnly = false;
	document.forms[0].custCityCode.readOnly = false;
	document.forms[0].custStateCode.readOnly = false;
	document.forms[0].custCntryCode.readOnly = false;
	document.forms[0].custPostalCode.readOnly = false;
	document.forms[0].custPhNum.readOnly = false;
	document.forms[0].custTelexNum.readOnly = false;
	document.forms[0].custFaxNum.readOnly = false;
	document.forms[0].custEmailId.readOnly = false;
	showImage("sLnk8");
	showImage("sLnk12");
	document.forms[0].custTitle.value = "";
	document.forms[0].custName.value = "";
	document.forms[0].addressType.value = "";
	document.forms[0].custAddrLine1.value = "";
	document.forms[0].custAddrLine2.value = "";
	document.forms[0].custAddrLine3.value = "";
	document.forms[0].custCityCode.value = "";
	document.forms[0].cityName.value ="";
	document.forms[0].custStateCode.value = "";
	document.forms[0].stateName.value = "";
	document.forms[0].custCntryCode.value = "";
	document.forms[0].cntryName.value = "";
	document.forms[0].custPostalCode.value = "";
	document.forms[0].custPhNum.value = "";
	document.forms[0].custTelexNum.value = "";
	document.forms[0].custFaxNum.value = "";
	document.forms[0].custEmailId.value = "";
}	
	   
	   
 	
  
