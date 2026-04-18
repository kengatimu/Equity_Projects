<!-------------------------------------------------------------------------------------------------------------->
<!--Name                : inttmgendet_custom.jsp
<!--Description         : This is used to disable cust pref and Default the start date
<!--Date                : 11-05-2017 
<!--Author              : Jane
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HINTTM
<!--Modification History:
<!--    Version No.           Date                       Author                 Description
<!--    -------         ----------                       -----------        ------------------
<!--     0.1            11-05-2017                       Jane          Original version
<!---------------------------------------------------------------------------------------------------------------->

<script type="text/javascript">

function inttmgendet_pre_ONLOAD(obj)
{	
	if (mopId == "HINTTM")
	{
		document.forms[0].custPrefIntCr.disabled=true;
		document.forms[0].custPrefIntDr.disabled=true;

		
		
			var input      = "";
            var outputNames    = "output|outVal";
            var scrName     =   "b_workclass.scr";
            var retVal = fnExecuteScript(input,outputNames,scrName,false);
            var retBuff = retVal.split("|");
            var output = retBuff[0];
            var value = retBuff[1];
            var a = value;
			//alert(a);
			if ((a!= 600)&& (a!= 650)&& (a!= 999) && (a!= 152)&&(a!= 260))
			{
				startDate=BODDate;
				disableFields("startDate");
			}


	}

}

</script>
