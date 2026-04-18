<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : todmdet_custom.jsp 
<!--Description         : Default papulation for permitted user id
<!--Date                : 02-02-2013
<!--Author              : B Bharath Reddy
<!--Called By           : None    
<!--Calling jsp         : None
<!--Menu Option         : HLASPAY
<!--Modification History:
<!--	Version No.	      Date		         Author 	       	Description
<!--	-------        	----------        		 -----------        ------------------
<!--     0.1	    	10-03-2013	        	 Bharath Reddy B        Original version
<!---------------------------------------------------------------------------------------------------------------->

<script type="text/javascript">
function post_ONLOAD() 
{		
	if (sLocReferralMode == "" )
	{	
		
		
		var perUsr = document.forms[0].permittedByUsr.value;
		if (perUsr == "" )
		{
			document.forms[0].permittedByUsr.value = userId;	
		}
		appFnExecuteScript("", "rmks", "odchrgcalcmn001.scr", true);

			var dco=userId;
			var input      = "dco|"+dco;
			var outputNames    = "output|outVal";
			var scrName     =   "b_workclass.scr";
			var retVal = appFnExecuteScript(input,outputNames,scrName,false);
			var retBuff = retVal.split("|");
			var output = retBuff[0];
			var value = retBuff[1];
			var a = value;
			alert(a);

			if (a != "310")
			{

		document.forms[0].rmks.disabled = true;
			}
	}
}

function todmdet_pre_ONCLICK(obj)
{
//alert("mopId " + mopId ); 
	//alert(obj.id);
	if (obj.id == 'Submit') 
	{
		//alert(document.forms[0].advanceAmt.value);
		if  (document.forms[0].advanceAmt.value =="")
		 {
			alert ("Please Enter Advance Amount");
		 return false;
		 }
		var advan = parseFloat(removeCommas(document.forms[0].advanceAmt.value));
		//alert(advan);
		//if (advan>1000000)
		if (profileId == 43)
		{
			/*alert("TOD Not allowed Contact Head Credit ");
			document.forms[0].advanceAmt.focus();
			return false;*/
		}
		if (((advan>1000000) && ((profileId == 54)|| (profileId == XX))) || ((advan>10000) && (profileId == 50)))
		{
			var dcco=document.forms[0].advanceAmt.value;
			var input      = "dcco|"+dcco;
			var outputNames    = "output|outVal";
			var outputNames    = "output2|outVal";
			var scrName     =   "b_todmod.scr";
			var retVal = appFnExecuteScript(input,outputNames,scrName,false);
			var retBuff = retVal.split("|");
			var output = retBuff[0];
			var value = retBuff[1];
			var a = value;
			var retBuff = retVal.split("|");
			var output = retBuff[2];
			var value = retBuff[3];
			var b = value;
			var retBuff = retVal.split("|");
			var output = retBuff[4];
			var value = retBuff[5];
			var c = value;
			//alert("a "+a);
			//alert("b "+b);
			//alert("c "+c);
			//if ((c== "54") || (c== "43"))
			if ((c== "54") || (c== "XX"))
			{
				if (a< 310)
				{
					alert("TOD limit above KES. 1,000,000 Contact Credit Admin");
					document.forms[0].advanceAmt.focus();
					return false;
				}
			}
				if (c==50)
				{

					if ((a< "310") && (mopId == "HTM"))
					{
						alert("TOD limit above Rwf. 10,000 Contact Credit Admin");
						document.forms[0].advanceAmt.focus();
						return false;
					}
				}
		}
	}
}
</script>
