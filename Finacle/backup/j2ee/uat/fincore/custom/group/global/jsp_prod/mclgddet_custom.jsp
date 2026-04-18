<!--------------------------------------------------------------------------------------------------------------->
<!--Name                : mclgddet_custom.jsp 
<!--Description         :
<!--Date                : 16-02-2021
<!--Author              : Vino Palani
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HMCLZOH 
<!--Modification History:
<!--    Version No.           Date                       Author                 Description
<!--    -------         ----------                       -----------        ------------------
<!--     0.1            16-02-2021                       Vino Palani          Original version
<!---------------------------------------------------------------------------------------------------------------->
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<arjsp:init groupName="mclgd" isEntryPoint="false" />
<%
        String sfuncCode   = (String)ARJspCurr.getInputWithGroup("funcCode", null);
%>
<script type="text/javascript">
function mclgddet_post_ONLOAD(){
	var funcCode = "<%=sfuncCode%>";
	if (funcCode == 'O' || funcCode == 'M'){
		finRtChk();
	}
}
function mclgddet_pre_ONLOAD(){
	var funcCode = "<%=sfuncCode%>";
	if (funcCode == 'O' || funcCode == 'M'){
		finRtChk();
	}
}
function finRtChk(){
        if(profileId=="54"){
                var1 = mopId;
                var2 = "mclgddet";
		var funcCode = "<%=sfuncCode%>";
                var inputNames = "mopId|"+var1+"|pageName|"+var2+"|funcCode|"+funcCode+"|ZoneCode|"+document.forms[0].clgZoneCode.value+"|ZoneDate|"+document.forms[0].clgZoneDate.value;
                var outputNames;
                var retVal = appFnExecuteScript(inputNames, outputNames,'ebClzcmPop.scr',false);
                var token = retVal.split("|");
                if(token[0] == "Y"){
                        var valToken = token[1].split("~");
                        document.forms[0].drAcctId.value = valToken[0];
                        document.forms[0].drAcctName.value = valToken[1];
                        document.forms[0].drSolId.value = valToken[2];
                        document.forms[0].drCrncyCode.value = valToken[3];
                        document.forms[0].drAcctId.disabled = true;
                        document.getElementById("sLnk4").style.visibility = 'hidden';
                }else{
                        document.forms[0].drAcctName.value = ""; 
                        document.forms[0].drSolId.value = ""; 
                        document.forms[0].drCrncyCode.value = ""; 
                        document.forms[0].drAcctId.value = "";
                        document.forms[0].drAcctId.disabled = false;
                        document.getElementById("sLnk4").style.visibility = 'visible';
                }

	}
}
</script>

