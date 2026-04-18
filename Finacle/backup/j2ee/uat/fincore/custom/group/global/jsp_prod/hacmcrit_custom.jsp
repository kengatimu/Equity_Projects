<!--------------------------------------------------------------------------------------------------------------->
<!--description         : Memo pad.
<!--Date                : 22-05-2013
<!--Author              : Prakash
<!--Called By           : None
<!--Calling  Jsp        : None
<!--Menu Option         : HACI
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------           -----------        ------------------
<!--     0.1            22-05-2013           Prakash           Original version
<!---------------------------------------------------------------------------------------------------------------->
<%@include file="formatAcct.jsp" %>
<script language="javascript">
function fnAccountIDList(funcCode)
{
   if(funcCode.value  == "V" || funcCode.value  == "X")
   {
      var funcCode = funcCode.value;
          showVerfyPendList("GAM",funcCode,"M",OPERATIVE_ACCT,"M","F",document.forms[0].acctNo,"","");
   }
   else
   {
        showAccountIdList(document.forms[0].acctNo,document.forms[0].solId,document.forms[0].acctDesc,'F',document.forms[0].crncyCode);
   }
        memoPad();
}

function memoPad()
{
        var acctNumber = document.forms[0].acctNo.value ;
        var inputNameValues = "acctNum|"+acctNumber;
        var outputNames     = "";
        var scrName         = "formatacctdp001.scr";
        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret1 = retVal.split("|");
        if(ret1[0] == "MSG" )
	{
                alert(ret1[1]);
        }
}

function hacmcrit_pre_ONCLICK(btn)
{
	if (btn.id == 'Accept' && mopId == "HACM") 
	{
		
		if(document.forms[0].mode.value  == "V")
		{
			//alert ("verify");
			//alert(profileId);
			var acctNumber = document.forms[0].acctNo.value ;
			//var inputNameValues = "acctNum|"+acctNumber;
			var funcCode = document.forms[0].mode.value;
			var inputNameValues = "acctNum|"+acctNumber + "|funCode|" + funcCode;
			var outputNames     = "";
			var scrName         = "cdaamn002.scr";
			var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
			var ret1 = retVal.split("|");
			//alert(ret1);
			if(ret1[0] == "MSG" )
			{
				alert("Account To be Verified from CDAA Menu");
				return false;
				
			}	
			if(ret1[0] == "MSG1" ){
				alert("User WorkClass not allowed to verify this account. Workclass 150 or 200");
				return false;
				
			}	


			if ((profileId=="55") || (profileId=="54"))
			//if (profileId=="55")
			{
					//alert(profileId);
					

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

				if ((a=="080")||(a=="081")||(a=="082")||(a=="083")||(a=="150")||(a=="198")||(a=="200"))
				{
				}
				else
				{
					alert("Verification not allowed.Workclass 150,200,080,081,082,083")
					return false;
				}
			}
		}
	}
}


</script>
