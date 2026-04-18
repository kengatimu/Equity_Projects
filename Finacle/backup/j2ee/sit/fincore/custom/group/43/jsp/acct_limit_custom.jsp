<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : acct_limit_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 18-07-2013
<!--Author            : george
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HOAACLA
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		17-07-2013	george		Original version
<!--    0.2		07-08-2013      Priya K 	360143 Changes incorporated
<!---------------------------------------------------------------------------------------------------------------->

<%@ page import="com.infy.bbu.jsputil.*" %>
<%@ page import="com.infy.finbranch.groups.*"%>
<%@ page import="java.util.*" %>
<%@ page import="com.infy.bbu.jsputil.*,FABProcess.*,FABCommon.*,FABInquiry.*,java.util.*, java.lang.*"%>
<%@ include file="../../commonInclude.jsp" %>
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<%
   ContextManager ARJspCurr =(ContextManager)session.getAttribute("CustomARJspCurr");
        String sGroupName = ARJspCurr.getCurrentGroup();
        SecurityInfo70 securityInfo = (SecurityInfo70)session.getAttribute("FinUserInfo");
        String schmCode = (String)ARJspCurr.getInput(sGroupName+".schmCode", "");

%>

<script language="javascript" src="../../../javascripts/common_functions.js" > </script>
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>
<script language="javascript">
function showDynSearcher(iName,inputFields,outputFields) 
{
	if(mopId == "HOAACBP")
	{
		if (inputFields == "limit_prefix=:limitIdPrefix|limit_suffix=:limitIdSuffix|del_flg=N")
		{
			var cifId = document.forms[0].customData.value;
			var cifIdTemp =cifId.split("|");
			var len = cifIdTemp.length;
			for(var i=0;i<len;i++)
			{
				if((cifIdTemp[i] == "~bpacop_accept"))
				{	
					var cifId =cifIdTemp[i+1];
				}
			}
			var inputNameValues = "cifId" + "|" + cifId;
			var outputNames = "limitIdPrefix|limitIdSuffix|curr|orgSanctLimit|sanctLimit|drwngPower|liab|delFlg";
			var scrName  = "tfclimitdp001.scr";
			var literalNames ="LimitID Prefix|LimitID Suffix|CCY|Original Sanction Limit|Sanction Limit|Drawing Power|Available Amount|Del.";
			var pageTitle ="Limit Liability List";
			var retVal = fnExecuteScriptForList(inputNameValues,outputNames,scrName,pageTitle,literalNames,"1",true);
	
		}
		else
		{
			showSearcher(iName,inputFields,outputFields,null,null,"SUBMIT","DETAILS");
		}
	}
	else
	{
		showSearcher(iName,inputFields,outputFields,null,null,"SUBMIT","DETAILS");
	}
}
function pre_ONLOAD(obj)
{
	if(mopId == "HOAACBP")
	{
		getFieldsFromCustomData("cifId");
		var cifId = document.forms[0].customData.value;
	}
	return true;
}

//jane start 355717
function post_ONLOAD(obj)
{
	if((mopId == "HOAACLA")||(mopId == "HOAACCL")||(mopId == "HOAACMCL")||(mopId == "HOAACMLA"))
	{
		var radioButtons = document.getElementsByName('acctRecalledFlg');
		radioButtons[1].disabled = true;
        radioButtons[0].disabled = true;
		if (document.forms[0].drawingPowerInd.value == "")
			{
			document.forms[0].drawingPowerInd.value ="E";
			}
	}
	if(mopId == "HOAACOD" || mopId == "HOAACMOD")
	{
		if(document.forms[0].drawingPowerInd.value == "")
		{
			var schmCode = '<%=schmCode%>';
                	var inputNameValues =  "schmCode|"+schmCode;

                	var outputNames = "";

                	var scrName = "crlineschmval.scr";

                	var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);

                	var result = retVal.split("|");
               		var crlineFlg   = result[1];
               		var disbschmFlg   = result[3];
                	if(crlineFlg != "Y")
                	{
				document.forms[0].drawingPowerInd.value ="E";	
			}
		}
	}

}
//jane end 355717

function acct_limit_pre_TAB_SWITCH(obj)
{
	if((mopId == "HOAACLA")||(mopId == "HOAACCL")||(mopId == "HOAACMCL")||(mopId == "HOAACMLA")||(mopId == "HACMCL")||(mopId == "HACMLA"))
	{
		if(sMode=="A")
		{	
				if (document.forms[0].securityDesc.value == "")
				{
					alert("PLEASE ENTER SECURITY DESCRIPTION");
					document.forms[0].securityDesc.focus();
					return false;
				}

				if (document.forms[0].sanctDate.value == "")
                                {
                                        alert("PLEASE ENTER SANCTION DATE");
                                        document.forms[0].sanctDate.focus();
                                        return false;
                                }

                                if (document.forms[0].sanctionLevelCode.value == "")
                                {
                                        alert("PLEASE ENTER SANCTION LEVEL CODE");
                                        document.forms[0].sanctionLevelCode.focus();
                                        return false;
                                }

                                if (document.forms[0].sanctionAuthCode.value == "")
                                {
                                        alert("PLEASE ENTER SANCTION AUTHORITY");
                                        document.forms[0].sanctionAuthCode.focus();
                                        return false;
                                }

                                if (document.forms[0].sanctionRefNum.value == "")
                                {
                                        alert("PLEASE ENTER SANCTION LIMTI REFERENCE NUMBER");
                                        document.forms[0].sanctionRefNum.focus();
                                        return false;
                                }

		}

	}

}

//Added steps for making sanction fields mandatory
function acct_limit_pre_ONCLICK(obj)
{
	if((mopId == "HOAACLA")||(mopId == "HOAACCL")||(mopId == "HOAACMCL")||(mopId == "HOAACMLA")||(mopId == "HACMCL")||(mopId == "HACMLA"))
	{
		if((obj.id == "Submit") || (obj.id == "Validate"))
		{
			if(sMode=="A")
			{

				if (document.forms[0].securityDesc.value == "")
                                {
                                        alert("PLEASE ENTER SECURITY DESCRIPTION");
                                        document.forms[0].securityDesc.focus();
                                        return false;
                                }

	
                                if (document.forms[0].sanctDate.value == "")
                                {
                                        alert("PLEASE ENTER SANCTION DATE");
                                        document.forms[0].sanctDate.focus();
                                        return false;
                                }

                                if (document.forms[0].sanctionLevelCode.value == "")
                                {
                                        alert("PLEASE ENTER SANCTION LEVEL CODE");
                                        document.forms[0].sanctionLevelCode.focus();
                                        return false;
                                }

                                if (document.forms[0].sanctionAuthCode.value == "")
                                {
                                        alert("PLEASE ENTER SANCTION AUTHORITY");
                                        document.forms[0].sanctionAuthCode.focus();
                                        return false;
                                }

                                if (document.forms[0].sanctionRefNum.value == "")
                                {
                                        alert("PLEASE ENTER SANCTION LIMTI REFERENCE NUMBER");
                                        document.forms[0].sanctionRefNum.focus();
                                        return false;
                                }
			}
		}

	}

}

</script>








