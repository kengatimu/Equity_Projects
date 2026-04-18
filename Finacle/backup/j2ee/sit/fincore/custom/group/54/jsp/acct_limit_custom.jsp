<!--------------------------------------------------------------------------------------------------------------->
<!--Name                : Common-custom.jsp 
<!--Description         :
<!--Date                : 25-05-2024
<!--Author              : Levin
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : Common Template 
<!--Modification History:
<!--    Version No.           Date                       Author                 Description
<!--    -------         ----------                       -----------        ------------------
<!--     0.1            25-05-2024                       Levin Ngoga           Original version
<!---------------------------------------------------------------------------------------------------------------->
<%@ page import="com.infy.bbu.jsputil.*,FABProcess.*,FABCommon.*,FABInquiry.*,java.util.*, java.lang.*,finbranchUtil.*"%>
<%@ page import="fabclasses.*,FabServer.*,com.infy.bbu.*,applcommon.*" %> 
<%@ include file="../../../javascripts/core_signature.js" %>

<script language="javascript" src="../../javascripts/common_functions.js" ></script>
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js"></script>
<script language="javascript">


function acct_limit_pre_ONLOAD(){
if (profileId == 54)
	{
		if (mopId == "HOAACSB" || mopId == "HOAACCA")
		{
			if ((btn.id == "Submit") || (btn.id == "Validate")) 
			{
				var chkcodes = document.forms[0].chkmiscodes;
	 			if (!chkcodes.checked) 
				{
					document.getElementById("miscodes").click();
					//chkcodes.click();
                			alert("Enter Tertiary RMID in the MISC Codes TAB");
					return false;
         			}
			}
		}

	}

        return true;
}


</script>