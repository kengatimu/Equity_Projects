<!------------------------------------------------------------------------------------------------>
<!--    Name            :       tfc_limit_details_custom.jsp                                        
<!--    Menu            :       OGM                                                       
<!--    Author          :       Priya K                                               
<!--    Description     :       custom searcher to get displayed for limit id when limit tab is visited         -->
<!--    Modification History                                                                    -->
<!--    <Serial No> <Date>          <Author>        <Description>                               -->
<!--    1           10-Jul-2013     Priya K            Original Version                            -->
<!--    1           12-Aug-2013     Priyansh            Modified Version TOL:364604              -->
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
	if( (mopId == "OGM") || (mopId == "IGM") || (mopId == "ODCM") || (mopId == "IDCM") || (mopId == "MNTFWC"))
	{
		if (inputFields == "limit_prefix=:limitIdPrefix|limit_suffix=:limitIdSuffix")
		{

			var cifId = document.forms[0].customData.value;
			var cifIdTemp =cifId.split("|");
			var cifId =cifIdTemp[2];
			var inputNameValues = "cifId" + "|" + cifId;
			var outputNames = "limitIdPrefix|limitIdSuffix|curr|orgSanctLimit|sanctLimit|drwngPower|delFlg";
			var scrName  = "tfclimitdp001.scr";
			var literalNames ="LimitID Prefix|LimitID Suffix|CCY|Original Sanction Limit|Sanction Limit|Drawing Power|Del.";
			var pageTitle ="Limit Liability List";
			var retVal = fnExecuteScriptForList(inputNameValues,outputNames,scrName,pageTitle,literalNames,"1",true);
	
		}
		else
		{
			showSearcher(iName,inputFields,outputFields,pWidth,pHeight,"SUBMIT","DETAILS");
		}
	}
}

function pre_ONLOAD(obj)
{
	if((mopId == "OGM") || (mopId == "IGM") || (mopId == "ODCM") || (mopId == "IDCM") || (mopId == "MNTFWC"))
	{
	getFieldsFromCustomData("cifId");
	var cifId = document.forms[0].customData.value;
	}
	return true;
}
</script>
