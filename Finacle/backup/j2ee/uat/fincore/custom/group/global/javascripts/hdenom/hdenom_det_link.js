<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
		if (!fnCustomValidation())
		{
			return false;
		}
		return true;
}




<!-- This function is added for formatting a particular MRH Row -->

function formatRowValue(Obj, colNumber) {

      return Obj;

       }


<!-- This function is added for formatting a particular MRH Row -->

function fnValidateForm(obj){
	objForm = document.forms[0];

	return true;

}

function fnCustomValidation()
{
	var inpObj;
	var inpCoinObj;
	var inpNoteObj;
	var emptyCoinFlag;
	var emptyNoteFlag;

	//----------------------------------------------------------------------------------
	// Validation for Number and the decimal places allowed.
	//----------------------------------------------------------------------------------
	emptyCoinFlag=true;
	emptyNoteFlag=true;
	for(idx=1;idx<=15;idx++)
	{
		var indexValue = idx.toString();
		if (indexValue.length != 2)
		{
			indexValue = "0" + indexValue;
		}
		inpObj = document.getElementById("NoteDenom" + indexValue);
		if (inpObj.value != "")
		{
			emptyNoteFlag = false;

			if (!fnValidateAmount(inpObj.value,0))
			{
				inpObj.focus();
				return false;
			}
		}

		inpObj = document.getElementById("CoinDenom" + indexValue);
		if (inpObj.value != "")
		{
			emptyCoinFlag = false;
			if (!fnValidateAmount(inpObj.value,decimalPointAllow))
			{
				inpObj.focus();
				return false;
			}
		}
	}
	if(emptyNoteFlag==true)
	{
		alert("Note Denomination cannot be empty!!!");
		return false;
	}
	if(emptyCoinFlag==true)
	{
		alert("Coin Denomination cannot be empty!!!");
		return false;
	}
	//----------------------------------------------------------------------------------
	// Validation for duplicate Note/Coin denomination fields.
	//----------------------------------------------------------------------------------
	for(i=1;i<=14;i++)
	{
		var iValue = i.toString();
		if (iValue.length != 2)
		{
			iValue = "0" + iValue;
		}
		inpCoinObj = document.getElementById("CoinDenom" + iValue);
		inpNoteObj = document.getElementById("NoteDenom" + iValue);
		for(j=i+1;j<=15;j++)
		{
			var jValue = j.toString();
			if (jValue.length != 2)
			{
				jValue = "0" + jValue;
			}
			inpObj = document.getElementById("CoinDenom" + jValue);
			if (inpCoinObj.value!="" && inpObj.value!="")
			{
				if(parseFloat(inpCoinObj.value)==parseFloat(inpObj.value))
				{
					alert("Duplicate coin denomination found!!!");
					inpObj.focus();
					return false;
				}
			}

			inpObj = document.getElementById("NoteDenom" + jValue);
			if (inpNoteObj.value!="" && inpObj.value!="")
			{
				if(parseInt(inpNoteObj.value)==parseInt(inpObj.value))
				{
					alert("Duplicate note denomination found!!!");
					inpObj.focus();
					return false;
				}
			}
		}
	}
	return true;
}



/*function fnCustomValidation()
{
	//note denom 01
	if (document.forms[0].noteDenom01.value !="")
	{
		if ((isNaN(document.forms[0].noteDenom01.value)) || ((document.forms[0].noteDenom01.value) < 0))
		{
			alert("Enter a numeric value.");
			document.forms[0].noteDenom01.focus();
			return false;
		}
		if (parseFloat(document.forms[0].noteDenom01.value) == 0)
		{
			alert("Enter number greater than zero.");
			document.forms[0].noteDenom01.focus();
			return false;
		}
	}
	//note denom 02
	if (document.forms[0].noteDenom02.value !="")
	{
		if ((isNaN(document.forms[0].noteDenom02.value)) || ((document.forms[0].noteDenom02.value) < 0))
		{
			alert("Enter a numeric value.");
			document.forms[0].noteDenom02.focus();
			return false;
		}
		if (parseFloat(document.forms[0].noteDenom02.value) == 0)
		{
			alert("Enter number greater than zero.");
			document.forms[0].noteDenom02.focus();
			return false;
		}
	}
	//note denom 03
	if (document.forms[0].noteDenom03.value !="")
	{
		if ((isNaN(document.forms[0].noteDenom03.value)) || ((document.forms[0].noteDenom03.value) < 0))
		{
			alert("Enter a numeric value.");
			document.forms[0].noteDenom03.focus();
			return false;
		}
		if (parseFloat(document.forms[0].noteDenom03.value) == 0)
		{
			alert("Enter number greater than zero.");
			document.forms[0].noteDenom03.focus();
			return false;
		}
	}
	//note denom 04
	if (document.forms[0].noteDenom04.value !="")
	{
		if ((isNaN(document.forms[0].noteDenom04.value)) || ((document.forms[0].noteDenom04.value) < 0))
		{
			alert("Enter a numeric value.");
			document.forms[0].noteDenom04.focus();
			return false;
		}
		if (parseFloat(document.forms[0].noteDenom04.value) == 0)
		{
			alert("Enter number greater than zero.");
			document.forms[0].noteDenom04.focus();
			return false;
		}
	}
	//note denom 05
	if (document.forms[0].noteDenom05.value !="")
	{
		if ((isNaN(document.forms[0].noteDenom05.value)) || ((document.forms[0].noteDenom05.value) < 0))
		{
			alert("Enter a numeric value.");
			document.forms[0].noteDenom05.focus();
			return false;
		}
		if (parseFloat(document.forms[0].noteDenom05.value) == 0)
		{
			alert("Enter number greater than zero.");
			document.forms[0].noteDenom05.focus();
			return false;
		}
	}
	//note denom 06
	if (document.forms[0].noteDenom06.value !="")
	{
		if ((isNaN(document.forms[0].noteDenom06.value)) || ((document.forms[0].noteDenom06.value) < 0))
		{
			alert("Enter a numeric value.");
			document.forms[0].noteDenom06.focus();
			return false;
		}
		if (parseFloat(document.forms[0].noteDenom06.value) == 0)
		{
			alert("Enter number greater than zero.");
			document.forms[0].noteDenom06.focus();
			return false;
		}
	}
	//note denom 07
	if (document.forms[0].noteDenom07.value !="")
	{
		if ((isNaN(document.forms[0].noteDenom07.value)) || ((document.forms[0].noteDenom07.value) < 0))
		{
			alert("Enter a numeric value.");
			document.forms[0].noteDenom07.focus();
			return false;
		}
		if (parseFloat(document.forms[0].noteDenom07.value) == 0)
		{
			alert("Enter number greater than zero.");
			document.forms[0].noteDenom07.focus();
			return false;
		}
	}
	//note denom 08
	if (document.forms[0].noteDenom08.value !="")
	{
		if ((isNaN(document.forms[0].noteDenom08.value)) || ((document.forms[0].noteDenom08.value) < 0))
		{
			alert("Enter a numeric value.");
			document.forms[0].noteDenom09.focus();
			return false;
		}
		if (parseFloat(document.forms[0].noteDenom08.value) == 0)
		{
			alert("Enter number greater than zero.");
			document.forms[0].noteDenom09.focus();
			return false;
		}
	}
	//note denom 09
	if (document.forms[0].noteDenom09.value !="")
	{
		if ((isNaN(document.forms[0].noteDenom09.value)) || ((document.forms[0].noteDenom09.value) < 0))
		{
			alert("Enter a numeric value.");
			document.forms[0].noteDenom09.focus();
			return false;
		}
		if (parseFloat(document.forms[0].noteDenom09.value) == 0)
		{
			alert("Enter number greater than zero.");
			document.forms[0].noteDenom09.focus();
			return false;
		}
	}
	//note denom 10
	if (document.forms[0].noteDenom10.value !="")
	{
		if ((isNaN(document.forms[0].noteDenom10.value)) || ((document.forms[0].noteDenom10.value) < 0))
		{
			alert("Enter a numeric value.");
			document.forms[0].noteDenom10.focus();
			return false;
		}
		if (parseFloat(document.forms[0].noteDenom10.value) == 0)
		{
			alert("Enter number greater than zero.");
			document.forms[0].noteDenom10.focus();
			return false;
		}
	}
	//note denom 11
	if (document.forms[0].noteDenom11.value !="")
	{
		if ((isNaN(document.forms[0].noteDenom11.value)) || ((document.forms[0].noteDenom11.value) < 0))
		{
			alert("Enter a numeric value.");
			document.forms[0].noteDenom11.focus();
			return false;
		}
		if (parseFloat(document.forms[0].noteDenom11.value) == 0)
		{
			alert("Enter number greater than zero.");
			document.forms[0].noteDenom11.focus();
			return false;
		}
	}
	//note denom 12
	if (document.forms[0].noteDenom12.value !="")
	{
		if ((isNaN(document.forms[0].noteDenom12.value)) || ((document.forms[0].noteDenom12.value) < 0))
		{
			alert("Enter a numeric value.");
			document.forms[0].noteDenom12.focus();
			return false;
		}
		if (parseFloat(document.forms[0].noteDenom12.value) == 0)
		{
			alert("Enter number greater than zero.");
			document.forms[0].noteDenom12.focus();
			return false;
		}
	}
	//note denom 13
	if (document.forms[0].noteDenom13.value !="")
	{
		if ((isNaN(document.forms[0].noteDenom13.value)) || ((document.forms[0].noteDenom13.value) < 0))
		{
			alert("Enter a numeric value.");
			document.forms[0].noteDenom13.focus();
			return false;
		}
		if (parseFloat(document.forms[0].noteDenom13.value) == 0)
		{
			alert("Enter number greater than zero.");
			document.forms[0].noteDenom13.focus();
			return false;
		}
	}
	//note denom 14
	if (document.forms[0].noteDenom14.value !="")
	{
		if ((isNaN(document.forms[0].noteDenom14.value)) || ((document.forms[0].noteDenom14.value) < 0))
		{
			alert("Enter a numeric value.");
			document.forms[0].noteDenom14.focus();
			return false;
		}
		if (parseFloat(document.forms[0].noteDenom14.value) == 0)
		{
			alert("Enter number greater than zero.");
			document.forms[0].noteDenom14.focus();
			return false;
		}
	}
	//note denom 15
	if (document.forms[0].noteDenom15.value !="")
	{
		if ((isNaN(document.forms[0].noteDenom15.value)) || ((document.forms[0].noteDenom15.value) < 0))
		{
			alert("Enter a numeric value.");
			document.forms[0].noteDenom15.focus();
			return false;
		}
		if (parseFloat(document.forms[0].noteDenom15.value) == 0)
		{
			alert("Enter number greater than zero.");
			document.forms[0].noteDenom15.focus();
			return false;
		}
	}
	return true;
}*/





function isInteger(number) 
{
    var count;
    for (count = 0; count < number.length; count++) 
    {
        // Check that current character is number.
        var char = number.charAt(count);
        if (((char < '0') || (char > '9'))) 
        	return false;
    }
    // All characters are numbers.
    return true;
}
