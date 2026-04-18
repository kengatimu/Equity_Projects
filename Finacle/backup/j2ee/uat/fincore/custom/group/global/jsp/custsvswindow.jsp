<%--
	Source Name : custsvswindow.jsp
--%>

<%@ include file="../commonInclude.jsp" %>
<%@ include file="../../javascripts/core_signature.js" %>

<%
	FABCommon.SecurityInfo70 securityInfo = (FABCommon.SecurityInfo70)session.getAttribute("FinUserInfo");
	if(null == securityInfo) {
			securityInfo = (FABCommon.SecurityInfo70)session.getAttribute("UserInfo");
	}
	String sBODDate = (String)((securityInfo.bodDate).substring(0,10));
%>

<script type="text/javascript">
a = document.getElementsByTagName("td");
var bodDate = '<%=sBODDate%>';
var tmpStr = "<%=acctLabel%>";
var tmpSignStr = '<a id="sigLnk" href="javascript:fnCustShowSignature();">';
var psc1 = "DR A/c. Id";
var psc2 = "Commodity Purchase A/c. Id";
tmpSignStr = tmpSignStr + '<img class="img" title="Signature" src="../Renderer/images/INFENG/sig_new1.gif" width="16" height="18" border="0"></img></a>&nbsp;'

for(i=0;i<a.length;i++)
{
	if(tmpStr =='PSC') {
		if((a[i].innerHTML.indexOf(psc1) != -1)||(a[i].innerHTML.indexOf(psc2) != -1)) {
			//if((a[i].innerHTML.indexOf('DR A/c. Id') != -1) ||( a[i].innerHTML.indexOf('Commodity Purchase A/c. Id') != -1)) {
			if(a[i+1].innerHTML.indexOf('<INPUT') != -1 && a[i+1].innerHTML.indexOf('<INPUT') == 0) {
			var str = a[i+1].innerHTML;
			var indx = str.indexOf('</A>') + 4;
			a[i+1].innerHTML = str.substr(0,indx) + tmpSignStr + str.substr(indx);
			break;
			}
		}
	}
	else
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
	var ps = "DR A/c. Id";
	// for SSO Context Switching
}

</script>
