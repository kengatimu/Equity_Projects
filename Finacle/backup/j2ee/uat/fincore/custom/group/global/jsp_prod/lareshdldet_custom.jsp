<!---------------------------------------------------------------------------------------------------------------->
<!--Name		: lareshdldet_custom.jsp 
<!--Description		: This is to Mandatorise Hlara Reason Codes
<!--Date		: 24-12-2019
<!--Author		: Sospeter 
<!--Called By		: None    
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------           -----------        ------------------
<!---------------------------------------------------------------------------------------------------------------->
<script type="text/javascript">
function lareshdldet_pre_ONCLICK(obj) 
{
	if(obj.id =="Accept"){
			sessionStorage.setItem("rescheduleMethod",document.forms[0].rescheduleMethod.value);
	}
	if ((obj.id == "Accept" ) && (profileId=="50"))
	{
		var funcCode=document.forms[0].funcCode.value;
		alert(funcCode);
		alert(document.forms[0].reasonCode.value);
		if (funcCode == "R")
		{
			 if (document.forms[0].reasonCode.value=="")
			{
				alert("Kindly inpur the reason code");
				return false;
			}
		}
	}
}

function lareshdldet_post_ONLOAD(obj) {
		sessionStorage.setItem("rescheduleMethod","");
}


</script>
