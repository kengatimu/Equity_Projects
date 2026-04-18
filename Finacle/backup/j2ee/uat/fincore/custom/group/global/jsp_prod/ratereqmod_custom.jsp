<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : ratereqmod_custom.jsp 
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 19-12-2013
<!--Author            : Soumya H Pillai
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HRATEREQ 
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--    0.1             13-12-2013      Soumya H Pillai To check whether correct rate code is being entered. 
<!---------------------------------------------------------------------------------------------------------------->
<script language="javascript" src="../Renderer/javascripts/common_functions.js">
</script>
<script>

var oldValue;
function ratereqmod_post_ONLOAD()
{
	   if(document.forms[0].treasuryRefNo.value != ''){
		document.forms[0].custRate.disabled = true;
	   }

           oldValue = document.forms[0].custRate.value;
	   return true;
}


function ratereqmod_ONCHANGE(obj)
{
	if(obj.id=="custRate")
	{
var inputNames = "oldValue|"+oldValue+"|newValue|"+document.forms[0].custRate.value+"|fixedCrncy|"+document.forms[0].ccy1.value+"|varCrncy|"+document.forms[0].ccy2.value+"|rateCode|"+document.forms[0].rateCode.value+"|treasuryExRate|"+document.forms[0].treasuryExRate.value; 
 	var outputNames = "";	
	var scrName     = "rateCustCheck.scr";
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

function ratereqmod_pre_ONCLICK(obj)
{
	//alert(obj.id);
	if ((obj.id=="custRate") || (obj.id=="Submit") || (obj.id=="Validate"))
	{
var inputNames = "oldValue|"+oldValue+"|newValue|"+document.forms[0].custRate.value+"|fixedCrncy|"+document.forms[0].ccy1.value+"|varCrncy|"+document.forms[0].ccy2.value+"|rateCode|"+document.forms[0].rateCode.value+"|treasuryExRate|"+document.forms[0].treasuryExRate.value; 
 	var outputNames = "";	
	var scrName     = "rateCustCheck.scr";
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
