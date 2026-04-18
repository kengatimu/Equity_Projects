<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : simcriteria_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder. 
<!--Date              : 07-03-2013
<!--Author            : Divya
<!--Called By         : 
<!--Calling jsp       : None
<!--Menu Option       : HSIM,HSSIM
<!--Modification History:
<!--    Version No.              Date           Author                          Description
<!--    ---------               ----------      ---------------                     --------------------
<!--     0.1                    07-03-2013      Divya                                Original version
<!--     0.2                    27-03-2013      Farhan                               Added the format Acct jsp
<!--	 0.3					13-05-2013	Chandrasekhar			     function was added
<!------------------------------------------------------------------------------------------------------------>
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>

<script type ="text/javascript">
function simcriteria_ONCHANGE(obj)
{
	if(mopId == "HSIM"){
		setFieldsToCustomData("funcCode");
	}
}
function simcriteria_pre_ONCLICK(obj)
{
	if(mopId == "HSIM"){
		setFieldsToCustomData("funcCode");
	}
	//alert(document.forms[0].funcCode.value);
	
	//alert("fvalue" +fvalue);
	//alert("obj" +obj.id);
	//alert("func" +funcCode);
	//alert(siSrlNo);
	//if(fvalue != "" && obj.id == "Accept" && funcCode != "I"){
		fvalue = document.forms[0].funcCode.value;

	//Edwin.Z begin

	if (profileId ==54)
	{

		if(obj.id == "Accept" && fvalue != "I"){
							
			if ((fvalue == "A")||(fvalue == "M")||(fvalue == "C")||(fvalue == "D"))
			{
					var dco=userId;
					var input      = "dco|"+dco;
					var outputNames    = "output|outVal";
					var scrName     =   "b_workclass.scr";
					var retVal = appFnExecuteScript(input,outputNames,scrName,false);
					var retBuff = retVal.split("|");
					var output = retBuff[0];
					var value = retBuff[1];
					var a = value;
					//alert(a);

				if ((a=="070")||(a=="110")||(a=="116")||(a=="150")||(a=="200")||(a=="201")||(a=="071")||(a=="650"))
				{
				}
				else
				{			
					alert("Only Workclass 070,071,110,116,150,200,650... allowed for fxn A,M,C,D");				
					return false;
				}
			}			

			if (fvalue == "V")
			{				
				var dco=userId;
				var input      = "dco|"+dco;
				var outputNames    = "output|outVal";
				var scrName     =   "b_workclass.scr";
				var retVal = appFnExecuteScript(input,outputNames,scrName,false);
				var retBuff = retVal.split("|");
				var output = retBuff[0];
				var value = retBuff[1];
				var a = value;
				//alert(a);

				if ((a=="110")||(a=="116")||(a=="150")||(a=="200")||(a=="201")||(a=="650"))
				{
				}
				else
				{			
					alert("Only Workclass 110,116,150,200,650... allowed for verification");
					return false;
				}
			}				
		}
	}
	else
	{
	//Edwin.Z end

		if(obj.id == "Accept" && fvalue != "I"){
		//	alert("verification");
		//	alert("func" +funcCode);
			var inputNameValues = "";
			var outputNames     = "status";
			var scrName         = "siexvaldp001.scr";
			var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
			var ret = retVal.split("|");
			//alert(ret[0]);
			//alert(ret[1]);

			if(ret[0] == "Error") {
				alert(ret[1]);
				return false;
			}

			if( ret[1] == "Y" )
			{
				alert("Can only Inquire from Branch...Contact H/O Clearing");
				return false;
			}
		}
	}	
}
</script>

<%@include file="formatAcct.jsp" %>
