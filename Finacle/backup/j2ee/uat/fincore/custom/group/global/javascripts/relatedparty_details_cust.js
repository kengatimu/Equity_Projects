/*This Custom JS file is written as a part of CIF Core Integration 10.0
Functionality:This script disables address related fields if cif_id is
given else it enables the address related fields in related party tab 
This is not given as the part of Base Product, this is a costomization script */

/*---------------------------------------------------------------------------------------------------------------->
<!--Name                : relatedparty_details_cust.js 
<!--Description         : This jsp is used to populate default values in case of Add Mode
<!--Date                : 04-07-2013
<!--Author              :  
<!--Called By           : None    
<!--Calling jsp         : None
<!--Menu Option         : HOAACLA
<!--Modification History:
<!--	Version No.	      	Date		         Author		Description
<!--	-------        		----------        	-----------	------------------
<!--	 0.1														
<!--	 0.2				04-07-2013			Kalvin		Modified for TO:356371
<!--														in line nos:22-78
<!---------------------------------------------------------------------------------------------------------------->*/

/*---------------------Code added as a part of TO:356371---------------------------*/
/*Logic: Check is introduced as part of CR to make CIFID e */
/*		 mandatory if the relation typ is Guarantor        */
/*----------------------------------------------------------*/
function relatedparty_details_pre_ONCLICK(obj) 
{
	
	if((obj.id !="Cancel") &&(mopId == "HOAACLA"))
	{
		if(sMode=="A")
		{
			
			var relnType=document.forms[0].relnType.value;
			//alert(relnType);

			if (relnType=="G")
			{
				if (fnIsNull(document.forms[0].cifId.value))
				{
					alert("Cifid is mandantory if Relation Type is guarantor");
					document.forms[0].cifId.focus();
					return false;
					
				}
				else 
				{
					return true;

				}
				
			}
					
					
					
		}
	}
}

function relatedparty_details_pre_TAB_SWITCH()
{
	var relnType=document.forms[0].relnType.value;
			//alert(relnType);

			if (relnType=="G")
			{
				if (fnIsNull(document.forms[0].cifId.value))
				{
				
					alert("Cifid is mandantory if Relation Type is guarantor");
					document.forms[0].cifId.focus();
					return false;
					
				}
				else 
				{
					return true;

				}
				
			}
}
					
	

/*---------------------End of Code added as a part of TO:356371---------------------------*/

var cifID = document.forms[0].cifId;

function relatedparty_details_post_ONLOAD()
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

function relatedparty_details_ONBLUR(cifId)
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
	   hideImage("sLnk10");
	   hideImage("sLnk4");
	   hideImage("sLnk5");
	   hideImage("sLnk6");
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
	   showImage("sLnk10");
	   showImage("sLnk4");
	   showImage("sLnk5");
	   showImage("sLnk6");
}	   

