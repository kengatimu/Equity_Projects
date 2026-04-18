<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : clsch_details_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 30-07-2013
<!--Author            : jane
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HOAACCL
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		30-07-2013	jane		Original version
<!---------------------------------------------------------------------------------------------------------------->
<script>
function clsch_details_post_ONLOAD(obj)
	{
			if (mopId=="HOAACCL")
			{
		document.forms[0].repRateCode.disabled = true;
				
			}
	}
function clsch_details_pre_ONCLICK(obj)
	{
		if (mopId == "HOAACCL")
			{		
				if((obj.id=="Submit") || (obj.id=="Validate"))
				{
					if (document.forms[0].loanPerdMths.value=="")
					{
					alert("Enter loan period");
					document.forms[0].loanPerdMths.focus();
					return false;
					}

				}
			}

//kim start -(361658)

		if(mopId == "HOAACCL" || mopId == "HOAACMCL" || mopId == "HACMCL")
			{
				if(obj.id=="Submit" || obj.id=="Validate")
					{
						if (document.forms[0].repMthd.value=="D")
						{
							var radioButtons = document.getElementsByName('hldInOperAcctFlg');
							radioButtons[0].checked = false;
							radioButtons[1].checked = true;
						}
						//mandatorise.
							var retVal = ""
							if ((retVal =  checkMandatoryFields()) == false)
								{
								  return false;
								}
					}			return true;
			}
	}

//kim End -(361658)

function clsch_details_pre_TAB_SWITCH(obj)
	{
		if (mopId=="HOAACCL")
			{
					if (document.forms[0].loanPerdMths.value=="")
					{
					
					alert("Enter loan period");
					document.forms[0].loanPerdMths.focus();
					return false;
					}
			}

//kim start -(361658)

		if(mopId == "HOAACCL" || mopId == "HOAACMCL" || mopId == "HACMCL")
			{
				if (document.forms[0].repMthd.value=="D")
					{
						var radioButtons = document.getElementsByName('hldInOperAcctFlg');
						radioButtons[0].checked = false;
						radioButtons[1].checked = true;
					}
						//mandatorise.
							var retVal = ""
							if ((retVal =  checkMandatoryFields()) == false)
								{
								  return false;
								}
								return true;
			}

	}


/**************************************************************************************
Function Name   :   fnCheckMandatoryFields()
Description     :   This function is called to check mandatory fields
**************************************************************************************/

function checkMandatoryFields()
{
       var ObjForm = document.forms[0];

			if(fnIsNull(ObjForm.operacct.value))
			{
					alert("Enter Operative A/c. ID");
					ObjForm.operacct.focus();
					return false;
			}

}

//Kim End -(361658)

</script>








