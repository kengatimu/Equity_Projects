<%@ page import="fabclasses.*,FabServer.*,com.infy.bbu.*,applcommon.*" %>
<%@ page import="com.infy.bbu.jsputil.*,FABProcess.*,FABCommon.*,FABInquiry.*,java.util.*, java.lang.*,finbranchUtil.*"%>

<%
	FABCommon.SecurityInfo70 securityInfo = (FABCommon.SecurityInfo70)session.getAttribute("FinUserInfo");
	if(null == securityInfo)
	{
		securityInfo = (FABCommon.SecurityInfo70)session.getAttribute("UserInfo");
	}
	String homeSol  = (String)((securityInfo.homeSolId));
%>

<script type="text/javascript">
function showCifId(obj,ctrlOrMorph,inPreceedence,objDesc,delFlg,srchCrit,targetBankId)

function custdeticrit__post_ONCHANGE(obj)
{
//setFieldsToCustomData("tempForacid");
	memoPad();
}


function memoPad(){
	        var cifId= document.forms[0].cifId.value ;
	        var inputNameValues = "cifId|"+cifId;
	        var outputNames     = "";
	        var scrName         = "formatcifdp001.scr";
	        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
	        var ret1 = retVal.split("|");
	        if(ret1[0] == "MSG" ){
			                alert(ret1[1]);
			        }
}
</script>


