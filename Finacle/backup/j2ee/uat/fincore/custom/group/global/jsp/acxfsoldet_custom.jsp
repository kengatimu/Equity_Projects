<%--
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Source Name           :   acxfsoldet_custom.jsp  
# Title                 :   Custom page for details screen of HACXFSOL 
# Menu Option           :   HACXFSOL 
# Author                :   Divya 
# Date                  :   24-01-2013 
# Description           :   This file used to customize some fields as protected for the menu option
#                       :   HACXFSOL 
# Calling sources       :   schmwrkclassvaldp001.scr
# Called sources        :   NA
#   Modification History
#  <Serial No.>     <Date>     <Author Name>   <Description>
#   0.00a           24-01-2013      Divya           Customization for requirement AcctSchmXfr
#   0.00b           21-06-2013      Saurabh          Signature Added
#   0.00c			   23-07-2013	  Vijaya V			added function disableStatus TOL -359610.
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------
--%>
<%@ page import="FABCommon.SecurityInfo70" %>
<%
	String acctLabel = "A/c. ID";
	String acctIdStr = "xferAcctId";
	String solIdStr = "";
%>
<%@ include file="../commonInclude.jsp" %>
<%@ include file="../../javascripts/core_signature.js" %>

<%
	FABCommon.SecurityInfo70 securityInfo = (FABCommon.SecurityInfo70)session.getAttribute("FinUserInfo");
	if(null == securityInfo) {
			securityInfo = (FABCommon.SecurityInfo70)session.getAttribute("UserInfo");
	}
	String sBODDate = (String)((securityInfo.bodDate).substring(0,10));
%>

<%@include file="formatAcct.jsp" %>
<script type="text/javascript">
a = document.getElementsByTagName("td");
var bodDate = '<%=sBODDate%>';
var tmpStr = "<%=acctLabel%>";
var tmpSignStr = '<a id="sigLnk" href="javascript:fnCustShowSignature();">';
tmpSignStr = tmpSignStr + '<img class="img" title="Signature" src="../Renderer/images/INFENG/sig_new1.gif" width="16" height="18" border="0"></img></a>&nbsp;'

for(i=0;i<a.length;i++)
{
	if(a[i].innerHTML.indexOf(tmpStr) != -1)
	{
		if(a[i+1].innerHTML.indexOf('<INPUT') != -1 && a[i+1].innerHTML.indexOf('<INPUT') == 0) {
			var str = a[i+1].innerHTML;
			var indx = str.indexOf('</A>') + 4;
			a[i+1].innerHTML = str.substr(0,indx) + tmpSignStr + str.substr(indx);
			break;
		}
	}
}

function fnCustShowSignature() {
	tmpAcctObj = document.getElementById("<%=acctIdStr%>");
	if('X'+'<%=solIdStr%>' != 'X') {
	tmpSolObj = document.getElementById("<%=solIdStr%>").value;
	}
	else
	{
	tmpSolObj = ""
	}
	if (fnIsNull(tmpAcctObj.value)) {
		alert("Enter the field.");
		tmpAcctObj.focus();
		return ;
	}
	var data = '?sAcctId='+escape(tmpAcctObj.value)+'&sSolId='+escape(tmpSolObj)+'&sActiveDate='+escape(bodDate)+'&fromAppId='+escape(fromAppId)+'&toMenu='+ mopId.toLowerCase() +'&contextSwitch=Y';
	displaySVSWindow(data);
}
function callbackSVS(data,menu)
{
// for SSO Context Switching
}
</script>

<script type="text/javascript">

function acxfsoldet_pre_ONLOAD(obj)
{
	disableStatus();
}

function acxfsoldet_post_ONLOAD(obj)
{
	disableStatus();
}

function fnFetchAcctDtls()
{
	 if (!fnIsNull(objForm.xferAcctId.value)) 
    clearDescField("xferAcctCrncy","xferAcctSolId","xferAcctName","crncyCodeDesc","custName","schmTypeDesc","schmCodeDesc","glSubHeadDesc");
	var ret = sendDataToServer('myframe','ACXFSOL','F','xferAcctId','xferAcctCrncy|xferAcctSolId|xferAcctName|acctStat|crncyCode|crncyCodeDesc|cifId|schmType|schmCode|glSubHeadCode');
	if(ret){
		disableFields("acctStat","crncyCode","cifId","schmType","schmCode","glSubHeadCode");
		hideImage("sLnk6");
		hideImage("sLnk7");
		hideImage("sLnk11");
		hideImage("sLnk8");
		hideImage("sLnk9");
	}else{
		objForm.xferAcctId.value= "";
		return false;
		}
	var inputNameValues = "acctNum|"+objForm.xferAcctId.value;
        var outputNames     = "";
        var scrName         = "formatacctdp001.scr";
        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret1 = retVal.split("|");
        if(ret1[0] == "MSG" )
        {
                alert(ret1[1]);
        }
}

function disableStatus()
{
	var homeSolId = "<%=(securityInfo.homeSolId)%>"
	var inputNameValues = "";
	var outputNames     = "status";
	var scrName         = "schmwrkclassvaldp001.scr";
	var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
	var ret = retVal.split("|");

	if(ret[1] == "Y" )
	{
		document.forms[0].schmType.disabled = true;
		document.forms[0].schmCode.disabled = true;
		document.getElementById('sLnk8').style.visibility = "hidden";
		document.getElementById('sLnk9').style.visibility = "hidden";
		//transfer 777
		//document.forms[0].fromSolId.disabled = true;
		document.forms[0].acctStat.disabled = true;
    	document.getElementById('sLnk2').style.visibility = "hidden";
	}
}

function fnOnLoad()
{
        objForm = document.forms[0];
        fnPopulateControlValues();
        initFocusHandler();

        if(fnIsNull(trialMode))
                checkRadio(objForm.trialMode, 'N');
        else
                checkRadio(objForm.trialMode,trialMode);


        if ( funcCode.toUpperCase() == TRANSFER )
        {
                if(fnIsNull(objForm.fromSolId.value))
                        objForm.fromSolId.value = contextSolId;
                if(fnIsNull(objForm.crncyCode.value))
                        objForm.crncyCode.value = homeCrncyCode;

        }
        else if (funcCode.toUpperCase() == VERIFY || funcCode.toUpperCase() == CANCEL)
        {
                fnDisableFormControls(funcCode, objForm, 20);
        }
        showImage("sLnk1");

        if (funcCode.toUpperCase() != TRANSFER)
                objForm.Submit.focus();

        if (!fnIsNull(objForm.xferAcctId.value)) {
                disableFields("acctStat","crncyCode","schmCode","glSubHeadCode","cifId","schmType");
                hideImage("sLnk6");
                hideImage("sLnk7");
                hideImage("sLnk11");
                hideImage("sLnk8");
                hideImage("sLnk9");
        }
        return true;
}

//transfer 777
function acxfsoldet_pre_ONCLICK(obj)
{
	if((obj.id=="Submit") || (obj.id=="Validate"))
		{
			var dco=document.forms[0].xferAcctId.value;
			var input      = "dco|"+dco;
			var outputNames    = "output|outVal";
			var scrName     =   "b_accttransfer.scr";
			var retVal = appFnExecuteScript(input,outputNames,scrName,false);
			var retBuff = retVal.split("|");
			var output = retBuff[0];
			var value = retBuff[1];
			var a = value;
			//alert(a);
			//alert(contextSolId);

			var homeSolId = "<%=(securityInfo.homeSolId)%>"
			var inputNameValues = "";
			var outputNames     = "status";
			var scrName         = "schmwrkclassvaldp001.scr";
			var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
			var ret = retVal.split("|");
			
			if(ret[1] == "Y" )
			{
				if ((document.forms[0].fromSolId.value!=contextSolId))
				{
					if (a!="777")
					{
					alert("ACCOUNT SOL TRANSFER NOT ALLOWED");
					document.forms[0].fromSolId.focus();
					return false;
					}
					if ((a=="777") &&(document.forms[0].toSolId.value!=contextSolId))
					{
						alert("TRANSFER TO ANOTHER SOL NOT ALLOWED");
						document.forms[0].toSolId.focus();
						return false;
					}
				}
			}

			if ((document.forms[0].schmCode.value=="VA300") || (document.forms[0].schmCode.value=="SB778"))
			{
						alert("TRANSFER TO ANOTHER SOL NOT ALLOWED");
						document.forms[0].xferAcctId.focus();
						return false;
			}

			if (profileId == "50")
			{
				//INC0148867/SOS/12-JAN-2023
				if (document.forms[0].fromSolId.value!="4777")
                {
					if (document.forms[0].fromSolId.value!=contextSolId)
					{
						alert("ACCOUNT SOL TRANSFER NOT ALLOWED");
						document.forms[0].fromSolId.focus();
						return false;
					}
				}
				//INC0148867/SOS/12-JAN-2023
			}
		}

}
</script>
