<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : acs_criteria_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 20-05-2013
<!--Author            : charles
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HACS
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		20-05-2013	charles		Original version
<!---------------------------------------------------------------------------------------------------------------->
<script>
//alert("TEST ACS");

function acs_criteria_post_ONLOAD(obj)
{
	//alert("checking for sol_id");
	if (document.forms[0].solId.value=="")
	{
		//alert("checking for sol_id");
		//alert(cxtSol);
		document.forms[0].solId.value=cxtSol;
		//alert("okay assigned");
			//alert("in progress");
			//alert(userId);
			var	dco=userId;
			//alert(dco);
			var input      = "dco|"+dco;
			var outputNames    = "output|outVal";
			var scrName     =   "b_workclass.scr";
			//alert("before script");
		var retVal = appFnExecuteScript(input,outputNames,scrName,false);
		alert("after script");
			var retBuff = retVal.split("|");
			var output = retBuff[0];
			var value = retBuff[1];
			var a = value;
			alert(a);
			//alert("Please continue");

			if (a<999) 
			{
				document.forms[0].solId.disabled=true;
				alert("sol_id disable");
			}
	}
}

function acs_criteria_pre_ONCLICK(obj)
{
	//alert("TEST ACS_TEST");
	//alert(obj.id);
	if((obj.id=="Submit") || (obj.id=="Validate"))
		{
			if (document.forms[0].schmType.value=="")
				{
					alert("Please Enter Scheme Type");
						document.forms[0].schmType.focus();
						return false;
				}else
				{
					if ((document.forms[0].schmType.value=="LAA") && (document.forms[0].acctManager.value==""))
					{
						alert("Please Enter Amanager user Id");
						document.forms[0].acctManager.focus();
						return false;
					}
				}
		}
}

</script>
