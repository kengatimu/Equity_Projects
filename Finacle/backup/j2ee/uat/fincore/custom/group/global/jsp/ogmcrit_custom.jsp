<!------------------------------------------------------------------------------------------------>
<!--    Name            :       ogmcrit_custom.jsp                                        
<!--    Menu            :       OGM                                                       
<!--    Author          :       Priya K                                               
<!--    Description     :       cifId values is being set to get it in details page        -->
<!--    Modification History                                                                    -->
<!--    <Serial No> <Date>          <Author>        <Description>                               -->
<!--    1           10-Jul-2013     Priya K            Original Version                            -->
<!------------------------------------------------------------------------------------------------>

<%@ page import="com.infy.bbu.jsputil.*" %>
<%@ page import="com.infy.finbranch.groups.*"%>
<%@ page import="java.util.*" %>
<%@ page import="com.infy.bbu.jsputil.*,FABProcess.*,FABCommon.*,FABInquiry.*,java.util.*, java.lang.*"%>
<%@ include file="../commonInclude.jsp" %>
<%@ taglib uri="taglib.tld" prefix="arjsp" %>

<script language="javascript" src="../../javascripts/common_functions.js" > </script>
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>
<script language="javascript">

function ogmcrit_pre_ONCLICK(obj)
{
        setFieldsToCustomData("funcCode","cifId");
        //return true;
		//Edwin start
	if (profileId =="56")
	{
		//alert("profileId1");
		if (document.forms[0].cifId.value !="") 
		{	
			var cifId = document.forms[0].cifId.value;
			var inputNameValues =  "cifId|"+ cifId;
			var outputNames     = "";
			var scrName         = "CrmCoreInterfaceCheck.scr";
			var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
			var retBuff = retVal.split("|");
			var output = retBuff[0];
			var value = retBuff[1];
			var a = value;
			if(a == "N")
			{
				alert("Financial Card Number Not Maintained on CIF");
				return false;
			}
		}	
	}
		////edwin end
}
</script>
