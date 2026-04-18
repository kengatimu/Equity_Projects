<!---------------------------------------------------------------------------------------------------------------->
<!--Name              :psccrit_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 04-07-2013
<!--Author            : cate
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : PSC
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		04-07-2013	CATE		Original version
<!--    0.2		26-09-2013	Mohan		Tawarruq Customization code added
<!---------------------------------------------------------------------------------------------------------------->

<script>
function psccrit_pre_ONCLICK(obj)
{
	//alert("am in")
	if(mopId == "PSC")

		{
			var radioButtons = document.getElementsByName('bulkPurchase');
			if (radioButtons[0].checked != true && radioButtons[1].checked == true)
			{
			if(document.forms[0].customData.value == "")
				{
				//document.forms[0].customData.value = "Y";
				}
			}
			
          
		}	
		
	// Tawarruq customization by Mohan
	var ObjForm = document.forms[0];
        var funcCode = ObjForm.funcCode.value;
	if(mopId == "PSC"){
		if((funcCode == "S") || (funcCode == "E")){
			setFieldsToCustomData("purchaseRef","acctId");
		}
	}
}

	</script>
