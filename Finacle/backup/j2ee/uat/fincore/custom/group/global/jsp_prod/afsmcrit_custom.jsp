<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : afsmcrit_custom.jsp
<!--Description         : This file should generate alert message
<!--Date                : 23-05-2013
<!--Author              : Shilpa
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HAFSM
<!--Modification History:
<!--    Version No.       Date               Author         Description
<!--    -------         ----------         -----------      ------------------
<!--     0.1            23-05-2013           Shilpa         Original version
<!--     0.2            21-06-2013           Saurabh Sinha  Signature Added
<!---------------------------------------------------------------------------------------------------------------->
<%@include file="formatAcct.jsp" %>
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
var tmpStr1 = "A/c. ID";
var acctIdStr1 ="acctId"
var solIdStr1 = ""
var tmpSignStr1 = '<a id="sigLnk" href="javascript:fnCustShowSignature1();">';
tmpSignStr1 = tmpSignStr1 + '<img class="img" title="Signature" src="../Renderer/images/INFENG/sig_new1.gif" width="16" height="18" border="0"></img></a>&nbsp;'

for(i=0;i<a.length;i++)
{
	if(a[i].innerHTML.indexOf(tmpStr1) != -1)
	{
		if(a[i+1].innerHTML.indexOf('<INPUT') != -1 && a[i+1].innerHTML.indexOf('<INPUT') == 0) {
			var str = a[i+1].innerHTML;
			var indx = str.indexOf('</A>') + 4;
			a[i+1].innerHTML = str.substr(0,indx) + tmpSignStr1 + str.substr(indx);
		}
	}
}

function fnCustShowSignature1() {

	tmpAcctObj1 = document.getElementById(acctIdStr1);
	if('X'+solIdStr1 != 'X') {
	tmpSolObj1 = document.getElementById(solIdStr1).value;
	}
	else
	{
	tmpSolObj1 = ""
	}
	if (fnIsNull(tmpAcctObj1.value)) {
		alert("Enter the field.");
		tmpAcctObj1.focus();
		return ;
	}
	var data = '?sAcctId='+escape(tmpAcctObj1.value)+'&sSolId='+escape(tmpSolObj1)+'&sActiveDate='+escape(bodDate)+'&fromAppId='+escape(fromAppId)+'&toMenu='+ mopId.toLowerCase() +'&contextSwitch=Y';
	displaySVSWindow(data);
}
var tmpStr2 = "Master/Multi-Currency A/c. Id";
var acctIdStr2 ="masterAcctId"
var solIdStr2 = ""
var tmpSignStr2 = '<a id="sigLnk" href="javascript:fnCustShowSignature2();">';
var tmpSignStr2 = tmpSignStr2 + '<img class="img" title="Signature" src="../Renderer/images/INFENG/sig_new1.gif" width="16" height="18" border="0"></img></a>&nbsp;'

for(i=0;i<a.length;i++)
{
	if(a[i].innerHTML.indexOf(tmpStr2) != -1)
	{
		if(a[i+1].innerHTML.indexOf('<INPUT') != -1 && a[i+1].innerHTML.indexOf('<INPUT') == 0) {
			var str = a[i+1].innerHTML;
			var indx = str.indexOf('</A>') + 4;
			a[i+1].innerHTML = str.substr(0,indx) + tmpSignStr2 + str.substr(indx);
		}
	}
}
function fnCustShowSignature2() {

	tmpAcctObj2 = document.getElementById(acctIdStr2);
	if('X'+solIdStr2 != 'X') {
	tmpSolObj = document.getElementById(solIdStr2).value;
	}
	else
	{
	tmpSolObj2 = ""
	}
	if (fnIsNull(tmpAcctObj2.value)) {
		alert("Enter the field.");
		tmpAcctObj2.focus();
		return ;
	}
	var data = '?sAcctId='+escape(tmpAcctObj2.value)+'&sSolId='+escape(tmpSolObj2)+'&sActiveDate='+escape(bodDate)+'&fromAppId='+escape(fromAppId)+'&toMenu='+ mopId.toLowerCase() +'&contextSwitch=Y';
	displaySVSWindow(data);
}
function callbackSVS(data,menu)
{
// for SSO Context Switching
}

function afsmcrit_pre_ONCLICK(obj)
{
	if ((obj.id=="Accept") &&(profileId=="56"))
	{
		var funcCode=document.forms[0].funcCode.value;

		if ((funcCode=="F")||(funcCode=="U")||(funcCode=="V"))
		{
				var dco=userId;
				var input      = "dco|"+dco;
				var outputNames    = "output|outVal";
				var scrName     =   "b_workclass.scr";
				var retVal = appFnExecuteScript(input,outputNames,scrName,false);
				var retBuff = retVal.split("|");
				var output = retBuff[0];
				var value = retBuff[1];
				var a = value;
				//alert(a);
				//CHG0031591
				if ((funcCode=="F")||(funcCode=="U"))
				{
					if ((a=="080")||(a=="110")||(a=="150")||(a=="200")||(a=="260"))
					{

					}
					else
					{
						alert("Freeze OR Unfreeze not allowed.Workclass 110,150,200,260")
						return false;
					}
				}
				//CHG0033692 to include W_C 051
				if (funcCode=="V")
				{
					if ((a=="146")||(a=="290")||(a=="051"))
					{

					}
					else
					{
						alert("Verification not allowed.Workclass 051,146,290")
						return false;
					}

				}


		}
	}
	
}



</script>
<script language="javascript">
function showAcctIdLst(funcCode){
        if((objForm.funcCode.value == Const.VERIFY_MODE) || (objForm.funcCode.value == Const.CANCEL_MODE)){
                var funcCode = objForm.funcCode.value;
                showVerfyPendList("GAM",funcCode,"M","","","F",objForm.acctId,"","");
        }else{
                showAccountIdList(objForm.acctId,objForm.solId,objForm.acctName,'F',objForm.crncyCode);
        }
		        memoPad();
}
function memoPad(){
        var acctNumber = document.forms[0].acctId.value ;
        var inputNameValues = "acctNum|"+acctNumber;
        var outputNames     = "";
        var scrName         = "formatacctdp001.scr";
        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret1 = retVal.split("|");
        if(ret1[0] == "MSG" ){
                alert(ret1[1]);
        }
}
</script>

