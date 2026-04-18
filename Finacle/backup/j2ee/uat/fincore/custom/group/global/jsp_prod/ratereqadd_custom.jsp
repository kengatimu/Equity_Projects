<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : ratereqadd_custom.jsp 
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 13-12-2013
<!--Author            : Soumya H Pillai
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HRATEREQ 
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--    0.1             13-12-2013      Soumya H Pillai Modified to check whether correct rate code is being entered. 
<!---------------------------------------------------------------------------------------------------------------->
<script language="javascript" src="../Renderer/javascripts/common_functions.js">
</script>
<script>
function ratereqadd_pre_ONCLICK(obj)
{
	
	if(obj.id=="Validate")
	{
	   if(document.forms[0].rateCode.value != "")
	   {
		if(document.forms[0].purchaseSaleRadio[0].checked == true)
		{
			var len = document.forms[0].rateCode.value.length;
			len = parseInt(len) -1;
			if(document.forms[0].rateCode.value.charAt(len).toUpperCase()!= "B")
			{	
				alert("Please enter the proper rate code for Purchase");
				return false;
			}
	
		}
		if(document.forms[0].purchaseSaleRadio[1].checked == true)
		{	
	      		var len = document.forms[0].rateCode.value.length;
                     	len = parseInt(len) -1;
			if(document.forms[0].rateCode.value.charAt(len).toUpperCase()!= "S")
			{
				alert("Please enter the proper rate code for Sale");
				return false;
			}
		}
	   }	
	}

	if ((obj.id=="custRate") || (obj.id=="Submit") || (obj.id=="Validate"))
	{
	var inputNames = "oldValue|"+oldValue+"|newValue|"+document.forms[0].custRate.value+"|fixedCrncy|"+document.forms[0].ccy1.value+"|varCrncy|"+document.forms[0].ccy2.value+"|rateCode|"+document.forms[0].rateCode.value+"|treasuryExRate|"+document.forms[0].treasuryExRate.value; 
 	var outputNames = "";	
	var scrName     = "rateCustCheckadd.scr";
	var retVal      = appFnExecuteScript(inputNames,outputNames,scrName,false);
	var strMesg     = retVal.split("|");
	if(strMesg[1]=='N')
			{
				alert("Convertion Rate Out Of Range.....Cannot Proceed!");
				document.forms[0].custRate.focus();
				return false;
			}
	if(strMesg[1]=='E')
                        {
                                alert("RateCode setup is not present.");
								document.forms[0].custRate.focus();
                                return false;
       			} 
	}
}

var oldValue;
function ratereqadd_post_ONLOAD()
{
	    if(document.forms[0].treasuryRefNo.value != ''){
		document.forms[0].custRate.disabled = true;
	   }

           oldValue = document.forms[0].custRate.value;
	   return true;
}


function ratereqadd_ONCHANGE(obj)
{
	if(obj.id=="custRate")
	{
	var inputNames = "oldValue|"+oldValue+"|newValue|"+document.forms[0].custRate.value+"|fixedCrncy|"+document.forms[0].ccy1.value+"|varCrncy|"+document.forms[0].ccy2.value+"|rateCode|"+document.forms[0].rateCode.value+"|treasuryExRate|"+document.forms[0].treasuryExRate.value; 
 	var outputNames = "";	
	var scrName     = "rateCustCheckadd.scr";
	var retVal      = appFnExecuteScript(inputNames,outputNames,scrName,false);
	var strMesg     = retVal.split("|");
	if(strMesg[1]=='N')
			{
				alert("Convertion Rate Out Of Range.....Cannot Proceed!");
				document.forms[0].custRate.focus();
				return false;
			}
	if(strMesg[1]=='E')
                        {
                                alert("RateCode setup is not present.");
								document.forms[0].custRate.focus();
                                return false;
       			} 
	}

}

</script>
