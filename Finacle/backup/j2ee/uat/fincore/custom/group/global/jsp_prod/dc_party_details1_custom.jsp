<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : dc_party_details1.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 15-07-2013
<!--Author            : GEORGE
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : ODCM
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		15-07-2013	GEORGE		Original version
<!--	0.2		16-07-2013	JANE		modification
<!---------------------------------------------------------------------------------------------------------------->
<script>
function dc_party_details1_post_ONLOAD(obj)
	{
		

	document.forms[0].appPartyId.disabled = true;
	document.forms[0].advPartyId.disabled = true;
    document.forms[0].issuePartyId.disabled = true;
	//alert("identifier");

//Defaulting Address type kate
  if(document.forms[0].issueBank.value != "")
		 {
      document.forms[0].issuingBankAddType.value = "A";
		 }
	}


	function dc_party_details1_ONCHANGE(obj)
	{
		if (obj.id=="issueName")
		{
			if ((document.forms[0].issueBank.value == "") && (document.forms[0].issueName.value != ""))
			{
				document.forms[0].issuingBankAddType.value = "D";
			}
		}
	}


function dc_party_details1_pre_ONCLICK(obj)

	{
		
	 if((obj.id=="Submit") || (obj.id=="Validate"))
				{
				if(document.forms[0].advBic.value != "")
					{
					//alert("identifier");
					document.forms[0].AdvisingbankAddType.value="A";
					}
				}
	}

</script>
