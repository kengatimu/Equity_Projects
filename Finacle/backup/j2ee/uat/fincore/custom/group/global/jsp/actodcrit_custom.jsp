<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : actodcrit_custom.jsp 
<!--Description         : This file should generate alert message
<!--Date                : 23-05-2013
<!--Author              : Shilpa
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HACTODI and HACTODM   
<!--Modification History:
<!--    Version No.       Date               Author         Description
<!--    -------         ----------         -----------      ------------------
<!--     0.1            23-05-2013           Shilpa         Original version
<!---------------------------------------------------------------------------------------------------------------->

<%@include file="formatAcct.jsp" %>
<%
	String acctLabel = "A/c. ID";
	String acctIdStr = "acctId";
	String solIdStr = "";
%>
<%@ include file="custsvswindow.jsp" %>
<script language="javascript">

function fnShowAccountIdList(funcCode){
        if(funcCode.value  == "V" || funcCode.value  == "X" )
    {
                var funcCode = funcCode.value;
                //showVerfyPendList("DAT",funcCode,"","","","F",objForm.acctId,objForm.eventType,"");
                showVerfyPendList("DAT",funcCode,"","","","F",objForm.acctId,"","");
     		fnFetchAccountDetails(objForm.acctId,true); 
      } else
    {
       showAccountIdList(objForm.acctId, objForm.acctSol, objForm.acctName, 'F', objForm.acctCrncy);
    }
	   memoPad();
}

function memoPad(){
        var acctNumber = document.forms[0].acctId.value ;
        var inputNameValues = "acctNum|"+acctNumber;
        var outputNames     = "";
        var scrName         = "formatacctdp001.scr";
        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret1 = retVal.split("|");
        if(ret1[0] == "MSG" ){
                alert(ret1[1]);
        }
}

function actodcrit_pre_ONCLICK()
{
	if (document.forms[0].funcCode.value=="M")
	{
			var dco=document.forms[0].acctId.value;
			var input      = "dco|"+dco;
			var outputNames    = "output|outVal";
			var scrName     =   "b_acctsbgrp.scr";
			var retVal = appFnExecuteScript(input,outputNames,scrName,false);
			var retBuff = retVal.split("|");
			var output = retBuff[0];
			var value = retBuff[1];
			var a = value
			var output = retBuff[2];
			var value = retBuff[3];
			var b = value;
			//alert(a);
				//alert(b);
			
			if (a=="SB190")
			{
					alert("Cannot grant tod to a staff account");
					document.forms[0].acctId.focus();
					return false;
			}

			if (b=="Y")
			{
					alert("Cannot grant Tod contact Credit Admin");
					document.forms[0].funcCode.focus();
					return false;
			}




	}

	if (document.forms[0].funcCode.value=="V")
	{
	
		if (profileId=="55")
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
					alert(a);

				if ((a=="100")||(a=="145")||(a=="150")|| (a=="200"))
					{

					}
					else
					{
						alert("Verification not allowed.Workclass 100,145,150,200 ")
						return false;
					}
				}

				if (profileId=="50")
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

				if ((a=="145")||(a=="200"))
					{

					}
					else
					{
						alert("Verification not allowed. Use Workclass 145,200 ")
						return false;
					}
				}

	}
			
}
</script>

