<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : psccreditdet_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 11-07-2013
<!--Author            : cate
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : PSC
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		04-07-2013	CATE		Original version
<!--	0.2		14-08-2013	Kim			
<!---------------------------------------------------------------------------------------------------------------->
<script>

function psccreditdet_pre_ONLOAD()
	{
		
	if(mopId == "PSC")
		{

		setFieldsToCustomData("drPaymentAmt")

			var outputNames    = "output|outVal";
			var drPaymentAmt = document.forms[0].customData.value;
				var retBuff = drPaymentAmt.split("|");
				var output = retBuff[0];
				var value = retBuff[1];
				var a = value;
					//alert(a);
					document.forms[0].customData.value=a;
					//alert(document.forms[0].customData.value);

			getFieldsFromCustomData("drPaymentAmt")
			//alert(document.forms[0].customData.value);		
			document.forms[0].crPaymentAmt.value = document.forms[0].customData.value;	
					}
		
	}



function psccreditdet_post_TAB_SWITCH(obj)
	{

		document.forms[0].sLnk2.enabled=true;

	}

function psccreditdet_post_ONLOAD()
	{
	if(mopId == "PSC")
		{
		document.forms[0].modeOfPayment.value="A";
		document.forms[0].sLnk2.enabled=true;
		document.forms[0].creditAcctId.enabled= true;
		document.forms[0].noOfUnits.enabled= true;
		
		}
	}

	
/*
function psccreditdet_post_ONCHANGE(obj)
	{
		
	if(obj.id == "modeOfPayment")
		{
	    //document.forms[0].modeOfPayment.value="A";
//		document.forms[0].sLnk2.disabled=false;
		
		}	
	}*/

</script>
