<!------------------------------------------------------------------------------------------------>
<!--    Name            :       acldpdtl_custom.jsp                                       
<!--    Menu            :       HACLHM                                                      
<!--    Author          :       Pankaj Gaur                                               
<!--    Description     :       custom searcher to get displayed for limit id when limit tab is visited         -->
<!--    Modification History                                                                    -->
<!--    <Serial No> <Date>          <Author>        <Description>                               -->
<!--    1           3-Aug-2013     Pankaj Gaur            Original Version                            -->
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
	//alert("inside show searcher");
	if(mopId == "HACLHM")
	{
		//alert("inside haclhm");
		if (inputFields == "limit_prefix=:limPrefix|limit_suffix=:limSuffix|del_flg=N")
		{
			var acctId=vAcctId;
			var inputNameValues = "acctId" + "|" + acctId;
			var outputNames = "limPrefix|limSuffix|curr|orgSanctLimit|sanctLimit|drwngPower|liab|delFlg";
			var scrName  = "acldlimitdp001.scr";
			var literalNames ="LimitID Prefix|LimitID Suffix|CCY|Original Sanction Limit|Sanction Limit|Drawing Power|Liability|Del.";
			var pageTitle ="Limit Liability List";
			var retVal = fnExecuteScriptForList(inputNameValues,outputNames,scrName,pageTitle,literalNames,"1",true);
		}
	}
}
</script>
