<!-------------------------------------------------------------------------------------------------------------------------------------------->
<!--Name                : tfcmarginpage_custom.jsp
<!--Description         : This is used to validate from the TDA account in field operative account TOL - 357250
<!--Date						 : 23-07-2013 
<!--Author					  :  Priyansh
<!--Called By			  : None
<!--Calling jsp				 : None
<!--Menu Option         : ODCM
<!--Modification History:
<!--    Version No.           Date                       Author             Description
<!--    -------						  ----------                       -----------        ------------------
<!--     0.1		  23-07-2013			Priyansh			Original version
<!--------------------------------------------------------------------------------------------------------------------------------------------->
<script type="text/javascript">

function tfcmarginpage_pre_ONCHANGE(obj)
{
        if(mopId == "ODCM" )
        {
		if(obj.id == "operativeAcid")
                {
			var operativeAccnt = document.forms[0].operativeAcid.value;
			var typeOfMargin = document.forms[0].marginType.value;
<!--			alert(typeOfMargin);
<!--			alert(operativeAccnt);
			if(typeOfMargin == "L")
			{
				if(operativeAccnt  != "")
				{		 
					var inputNameValues = "operativeAccnt" + "|" +operativeAccnt ;
					var scrName = "getAccountSchmType.scr";
					var outputNames = "paramV1";
					var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
					var ret = retVal.split("|");

					if(ret[1] == "PASS")
					{
						return true;
					}				
				
					if(ret[1] == "FAIL")
					{
						alert("Enter the TDA account for Lien type of Margin");
						return false;
					}
				
					if(ret[0] == "err")
					{
						alert("Enter a valid Account No");
					}
				}
			}
		}
	}
}
function tfcmarginpage_post_ONLOAD()
{
        if(mopId == "ODCM" )
        {
                        var operativeAccnt = document.forms[0].operativeAcid.value;
                        var typeOfMargin = document.forms[0].marginType.value;
                        if(typeOfMargin == "L")
                        {
                                if(operativeAccnt  != "")
                                {
                                        var inputNameValues = "operativeAccnt" + "|" +operativeAccnt ;
                                        var scrName = "getAccountSchmType.scr";
                                        var outputNames = "paramV1";
                                        var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
                                        var ret = retVal.split("|");

                                        if(ret[1] == "PASS")
                                        {
                                                return true;
                                        }

                                        if(ret[1] == "FAIL")
                                        {
                                                alert("Enter the TDA account for Lien type of Margin");
                                                return false;
                                        }

                                        if(ret[0] == "err")
                                        {
                                                alert("Enter a valid Account No");
                                        }
                                }
                        }
        }
}
function tfcmarginpage_pre_TAB_SWITCH(obj)
{
        if(mopId == "ODCM" )
        {
                        var operativeAccnt = document.forms[0].operativeAcid.value;
                        var typeOfMargin = document.forms[0].marginType.value;
                        if(typeOfMargin == "L")
                        {
                                if(operativeAccnt  != "")
                                {
                                        var inputNameValues = "operativeAccnt" + "|" +operativeAccnt ;
                                        var scrName = "getAccountSchmType.scr";
                                        var outputNames = "paramV1";
                                        var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
                                        var ret = retVal.split("|");

                                        if(ret[1] == "PASS")
                                        {
                                                return true;
                                        }

                                        if(ret[1] == "FAIL")
                                        {
                                                alert("Enter the TDA account for Lien type of Margin");
                                                return false;
                                        }

                                        if(ret[0] == "err")
                                        {
                                                alert("Enter a valid Account No");
                                        }
                                }
                        }
        }
}
function tfcmarginpage_pre_ONCLICK(obj)
{
        if(mopId == "ODCM" )
        {
		if(obj.id == "Submit" || obj.id == "Validate")
		{
                        var operativeAccnt = document.forms[0].operativeAcid.value;
                        var typeOfMargin = document.forms[0].marginType.value;
                        if(typeOfMargin == "L")
                        {
                                if(operativeAccnt  != "")
                                {
                                        var inputNameValues = "operativeAccnt" + "|" +operativeAccnt ;
                                        var scrName = "getAccountSchmType.scr";
                                        var outputNames = "paramV1";
                                        var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
                                        var ret = retVal.split("|");

                                        if(ret[1] == "PASS")
                                        {
                                                return true;
                                        }

                                        if(ret[1] == "FAIL")
                                        {
                                                alert("Enter the TDA account for Lien type of Margin");
                                                return false;
                                        }

                                        if(ret[0] == "err")
                                        {
                                                alert("Enter a valid Account No");
                                        }
                                }
                        }
       		} 
	
	}

		if((mopId == "OGM" ) && (funcCode=="R" ))
			{
			  if(obj.id == "Submit" || obj.id == "Validate")
			   {
			  
				document.forms[0].releaseAmt.value=document.forms[0].marginAmt.value;
			   }
			}
}

</script>
