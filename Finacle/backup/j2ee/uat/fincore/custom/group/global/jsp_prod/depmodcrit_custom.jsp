<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : depmodcrit_custom.jsp 
<!--Description       : This jsp is used to populate default interest rate
<!--Date              : 16-10-2013
<!--Author            : Vijaya V
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HDEPMOD
<!--Modification History:
<!--	Version No.				Date			Author		Description
<!-- 	-----------	------		----------		---------------		------------
<!--	0.1						16-10-2013		Vijaya V		Original version
<!---------------------------------------------------------------------------------------------------------------->
<script type="text/javascript">

function depmodcrit_pre_ONCLICK(obj)
{
	if(mopId == "HDEPMOD")
	{
		if( (obj.id == "Accept"))
		{
			getIntRate();
		}
	}
}


function getIntRate()
{
	var objForm = document.forms[0];
	var crncyCode		= objForm.crncyCode.value;
	var schmCode		= objForm.schmCode.value;
	var depAmt			= objForm.depAmt.value;
	depAmt 			= depAmt.replace(new RegExp(',','g'),"");
	var depPerdMths	= objForm.depPerdMths.value;
	var depPerdDays	= objForm.depPerdDays.value;
	var depDate		= objForm.depDate.value;

	if ( crncyCode != "" && schmCode != "" && depAmt != "" && depDate != "" && (depPerdMths != "" || depPerdDays != ""))
	{
		var inputNameValues	= "crncyCode|"+crncyCode+"|schmCode|"+schmCode+"|depAmt|"+depAmt+"|depPerdMths|"+depPerdMths+"|depPerdDays|"+depPerdDays+"|depDate|"+depDate;
		var outputNames		= "intRate";
		var scrName		= "depmodmn001.scr";
		var retVal		= appFnExecuteScript(inputNameValues, outputNames, scrName, true)
	}
}


</script>

