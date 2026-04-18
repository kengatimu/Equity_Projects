/*This Custom JS file is written as a part of CIF Core Integration 10.0
Functionality:This script disables address related fields if cif_id is
given else it enables the address related fields in related party tab
This is not given as the part of Base Product, this is a costomization script */

var cifID = document.forms[0].customerId;

function turelatedparty_details_post_ONLOAD()
{
        if(cifID.value != '')
	{
	    disableAddrFields();
	}
	else if((sMode != "V") && (sMode != "X") && (sMode != "I"))
	{
	   enableAddrFields();
	}
}

function turelatedparty_details_ONBLUR(customerId)
{

  	if(cifID.value != '' )
  	{
  	   disableAddrFields();
   	}
  	else if((sMode != "V") && (sMode != "X") && (sMode != "I"))
  	{
  	   enableAddrFields();
   	}
}

function disableAddrFields()
{
		document.forms[0].custTitle.readOnly = true;
		document.forms[0].customerName.readOnly = true;
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
	   hideImage("sLnk5");
	   hideImage("sLnk7");
	   hideImage("sLnk8");
	   hideImage("sLnk9");
}

function enableAddrFields()
{
		document.forms[0].custTitle.readOnly = false;
		document.forms[0].customerName.readOnly = false;
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
	   showImage("sLnk5");
	   showImage("sLnk7");
	   showImage("sLnk8");
	   showImage("sLnk9");
}





