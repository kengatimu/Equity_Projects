<!------------------------------------------------------------------------------------------------>
<!--    Name            :       bpacop_accept_custom.jsp                                        
<!--    Menu            :       HOAACBP								-->
<!--    Author          :       Priya K                                               
<!--    Description     :       cifId values is being set to get it in details page		-->
<!--    Modification History                                                                    -->
<!--    <Serial No> <Date>          <Author>        <Description>                               -->
<!--    1           10-Jul-2013     Priya K            Original Version                          -->
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

function showDynSearcher(iName,inputFields,outputFields) 
{
	if(mopId == "HOAACBP")
	{
		if (inputFields == "limit_prefix=:limitPrefix|limit_suffix=:limitSuffix|del_flg=N")
		{

			var cifId = document.forms[0].cifId.value;
			if(cifId == "")
			{
				alert("CifId should be entered first before selecting LimitId");
				document.forms[0].cifId.focus();
				

			}
			else
			{
				var inputNameValues = "cifId" + "|" + cifId;
				var outputNames = "limitPrefix|limitSuffix|curr|orgSanctLimit|sanctLimit|drwngPower|liab|delFlg";
				var scrName  = "bpacopdp001.scr";
				var literalNames ="LimitID Prefix|LimitID Suffix|CCY|Original Sanction Limit|Sanction Limit|Drawing Power|Available Amount|Del.";
				var pageTitle ="Limit Liability List";
				//var retVal = fnExecuteScriptForList(inputNameValues,outputNames,scrName,pageTitle,literalNames,"1",true);
				var retVal = appFnExecuteScriptForList(inputNameValues,outputNames,scrName,pageTitle,literalNames,"1",true);
			}
	
		}
		else
		{
			showSearcher(iName,inputFields,outputFields,pWidth,pHeight,"SUBMIT","DETAILS");
		}
	}
}

function bpacop_accept_pre_ONCLICK(obj)
{
        setFieldsToCustomData("cifId");
        return true;

}
</script>
