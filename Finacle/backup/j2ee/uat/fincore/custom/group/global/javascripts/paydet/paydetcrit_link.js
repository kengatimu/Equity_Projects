<!--	This is getting executing on click of submit and validate button -->


function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
		if(document.forms[0].funcCode.value == "")
		{
			document.forms[0].funcCode.focus();

			alert("Invalid Func Code");

			return false;

		}

		if(document.forms[0].trantype.value == "")
		{
			document.forms[0].trantype.focus();
			alert("Invalid Tran Type");

			return false;

		}


		if(document.forms[0].funcCode.value != "A")
		{

			if(document.forms[0].Ecstranrefnum.value == "")
			{
			document.forms[0].Ecstranrefnum.focus();
			alert("Invalid Ecstranrefnum");

			return false;

			}

		}

		if(document.forms[0].solid.value == "")
		{
			document.forms[0].solid.focus();
			alert("Invalid sol Id");
			return false;

		}

		if(document.forms[0].paysysid.value.toUpperCase() != "ECS")
		{
			document.forms[0].paysysid.focus();
			alert("Invalid Paysys Id");
			return false;

		}



		return true;
}

