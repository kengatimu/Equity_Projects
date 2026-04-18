<!-- This is getting executing on click of submit and validate button -->
		function fnValidateData() {
			if (!fnCheckMandatoryFields())
			{
				return false;
			}
			return true;
		}
		function fnCheckMandatoryFields() {
			var objForm = document.forms[0];
			var temp1 = getRadioValue(objForm.fieldType);
			if(temp1 == "")
			{
				alert ("Select option: RIB/Account No.");
				return false;
			}
			
			var fieldValue=objForm.ibanOrAcct.value.replace(/\s/g,'');
			objForm.ibanOrAcct.value = fieldValue;
			
				if(objForm.ibanOrAcct.value=="")
				{
					if(temp1 == "IBAN")
					{
						alert ("Enter the RIB Number");
						objForm.ibanOrAcct.focus();
						return false;
					}
				if(temp1 == "foracid")
					{
						alert ("Enter the Account Number");
						objForm.ibanOrAcct.focus();
						return false;
					}
			}
			return true;
		}