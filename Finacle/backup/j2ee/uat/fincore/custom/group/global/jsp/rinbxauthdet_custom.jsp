<!--------------------------------------------------------------------------------------------------------------------------------------------------------------------->
<!--Name                : rinbxauthdet_custom.jsp
<!--Description         : To perform biometric validation 
<!--Date			 	: 07-01-2014 
<!--Author				: Venki 
<!--Called By			: None
<!--Calling jsp			: None
<!--Menu Option         : HRINBX
<!--Modification History:
<!--    Version No.           Date                       Author             Description
<!--    -------				  ----------                 -----------        ------------------
<!--	1.0					  07-01-2014				 Venki		
<!--	1.1					  16-10-2024				 Irungu					
<!------------------------------------------------------------------------------------------------------------------------------------------------->
<%@ include file="../commonInclude.jsp" %>
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<arjsp:init groupName="rinbx" isEntryPoint="false" />
<%
	String s_RefId      =   (String)ARJspCurr.getInputWithGroup("refId", null);

%>
<script>
function rinbxauthdet_pre_ONCLICK(obj)
{
      var vRefId = "<%=s_RefId%>";
      alert(vRefId);

	if(obj.id == "AUTH_ACTION")
	{
		alert("XXF");
		//if(obj.name == "Approve")
		//{
		//	alert("YYY");
			//return  doLocalBioMetricVal();							
		//}

		if(obj.name == "Approve")
		{
			alert("AAA");


			//alert(document.forms[0].refId.value);	
			if (profileId == 43) 
			{
				alert("ZZZ");
				var dco = vRefId;
				var input = "dco|" + dco;
				var outputNames = "paramV1";
				var scrName = "b_roleidvalidate.scr";
				var retVal = appFnExecuteScript(input, outputNames, scrName, false);
				var ret = retVal.split("|");
				if (ret[1] == "PASS") 
				{
					//return true;
			     		return  doLocalBioMetricVal(); 
				}
				else
				if (ret[1] == "FAIL") 
				{
					alert("Limit Exceeded. Not Allowed");
					return false;
				}
			}
			if (profileId != 43) 
			{
			      return  doLocalBioMetricVal();
			}
			
		}
	}
}

function doLocalBioMetricVal()
{
	var retVal4Menu = "";
	retVal4Menu = isBioValReq4Menu(mopId);
	if(retVal4Menu == true)
	{
		return getFieldforBioAndCallBio(mopId);
	}
	return true;
}
</script>
