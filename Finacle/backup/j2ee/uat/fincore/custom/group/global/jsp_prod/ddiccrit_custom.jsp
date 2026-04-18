<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : ddiccrit_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 20-05-2013
<!--Author            : jane
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HDDIC
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		20-05-2013	jane		Original version
<!---------------------------------------------------------------------------------------------------------------->
<script>
function ddiccrit_pre_ONCLICK(obj)
{
	if((obj.id=="Submit") || (obj.id=="Validate"))
	{
		if ((document.forms[0].from_dd_num.value=="") && (document.forms[0].to_dd_num.value=="") && (document.forms[0].issue_from_date.value=="") && (document.forms[0].issue_to_date.value=="") && 
		(document.forms[0].dd_low_amt.value=="") && (document.forms[0].dd_high_amt.value==""))
			{
				alert("AtLeast one filteration criteria should be entered");
				return false;
			}

		if ((document.forms[0].from_dd_num.value!="")||(document.forms[0].to_dd_num.value!=""))
			{
				if ((document.forms[0].issue_from_date.value=="")|| (document.forms[0].issue_to_date.value==""))
				{
					alert("Issue Date From and TO  Should be entered");
					return false;
				}

			}

		if ((document.forms[0].issue_from_date.value!="")||(document.forms[0].issue_to_date.value!=""))
			{
				if ((document.forms[0].dd_low_amt.value=="")|| (document.forms[0].dd_high_amt.value==""))
				{
					alert("DD Amt low and DD amt High  Should be entered");
					return false;
				}

			}

		if ((document.forms[0].dd_low_amt.value!="")||(document.forms[0].dd_high_amt.value!=""))
			{
				if ((document.forms[0].issue_from_date.value=="")|| (document.forms[0].issue_to_date.value==""))
				{
					alert("Issue Date From and TO  Should be entered");
					return false;
				}

			}
	}

}

</script>

