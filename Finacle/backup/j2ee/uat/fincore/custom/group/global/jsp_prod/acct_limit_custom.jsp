<%@ page import="com.infy.bbu.jsputil.*" %>
<%@ page import="com.infy.finbranch.groups.*"%>
<%@ page import="java.util.*" %>
<%@ page import="com.infy.bbu.jsputil.*,FABProcess.*,FABCommon.*,FABInquiry.*,java.util.*, java.lang.*"%>
<%@ include file="../commonInclude.jsp" %>
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<arjsp:init groupName="acctlmt" isEntryPoint="false" />
<script language="javascript" src="../../javascripts/common_functions.js" > </script>
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>
<%
        SecurityInfo70 securityinfo=(FABCommon.SecurityInfo70)session.getAttribute("FinUserInfo");
        if(null == securityinfo){
                securityinfo = (FABCommon.SecurityInfo70)session.getAttribute("UserInfo");
        }
        FABInquiry.AcctOpenCriteria acctOpenCriteria = (FABInquiry.AcctOpenCriteria)ARJspCurr.getInputWithGroup("AcctOpenCriteria", new FABInquiry.AcctOpenCriteria());
        String sSchmCode = acctOpenCriteria.schmCode;
        String sGLSHCode = acctOpenCriteria.glSubHeadCode;
        String sCurrCode = acctOpenCriteria.crncyCode;
        String sSchmType = acctOpenCriteria.schmType;
        String sFunc = ((String)ARJspCurr.getInputWithGroup("mode",""));
        String sCifId = acctOpenCriteria.cifId;
%>
<script language="javascript">
        var sGLSub = '<%=ParseValue.checkString(sGLSHCode)%>';
        var sSchmCode = '<%=ParseValue.checkString(sSchmCode)%>';
        var sCurr = '<%=ParseValue.checkString(sCurrCode)%>';
        var sSchmType = '<%=ParseValue.checkString(sSchmType)%>';
        var sCifId = '<%=ParseValue.checkString(sCifId)%>';
        //alert(sCifId);
        //alert(sSchmType);
        //alert(sSchmCode);
</script>

<script language="javascript" src="../../javascripts/common_functions.js" > </script>
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

        if(profileId=="50"){
        if(((sSchmCode=="OD501") || (sSchmCode=="OD503")) && ((mopId == "HOAACOD")||(mopId == "HOAACVOD")||(mopId == "HOAACMOD"))){
                e1 = document.getElementById("securityDesc");
                e2 = e1.parentNode;
                e2.previousSibling.innerText = "Commission Pcnt";
                e3 = document.getElementById("remarks");
                e4 = e3.parentNode;
                e4.previousSibling.innerText = "Commission Amount";
        }
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

        if(profileId=="50"){
        if(((sSchmCode=="OD501") || (sSchmCode=="OD503")) && ((mopId == "HOAACOD")||(mopId == "HOAACVOD")||(mopId == "HOAACMOD"))){
                e1 = document.getElementById("securityDesc");
                e2 = e1.parentNode;
                e2.previousSibling.innerText = "Commission Pcnt";
                e3 = document.getElementById("remarks");
                e4 = e3.parentNode;
                e4.previousSibling.innerText = "Commission Amount";
                var commPcnt = document.forms[0].securityDesc.value;
                var commAmt = document.forms[0].remarks.value;
                var sanctLim = document.forms[0].sanctionLimit.value;

                // Harrison
                // if(commPcnt==""){
                //      alert("Enter Commission Percentage")
                //         document.forms[0].securityDesc.focus();
                //         return false;

                // }
                //alert(sanctLim);
                document.forms[0].remarks.disabled = true;
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

        if(profileId=="50"){
        if(((sSchmCode=="OD501") || (sSchmCode=="OD503")) && ((mopId == "HOAACOD")||(mopId == "HOAACVOD")||(mopId == "HOAACMOD"))){
                e1 = document.getElementById("securityDesc");
                e2 = e1.parentNode;
                e2.previousSibling.innerText = "Commission Pcnt";
                e3 = document.getElementById("remarks");
                e4 = e3.parentNode;
                e4.previousSibling.innerText = "Commission Amount";
                var commPcnt = document.forms[0].securityDesc.value;
                var commAmt = document.forms[0].remarks.value;
                var sanctLim = document.forms[0].sanctionLimit.value;

                // Harrison
                // if(commPcnt==""){
                //         alert("Enter Commission Percentage")
                //         document.forms[0].securityDesc.focus();
                //         return false;

                // }
                //alert(sanctLim);
                //parseFloat
                //var commPcnt = parseInt(commPcnt, 10)
                var commamt = (parseFloat(sanctLim.replace(/,/g, '')) * parseFloat(commPcnt))/100;
                alert(commamt);
                document.forms[0].remarks.value=commamt;
                document.forms[0].remarks.disabled = true;
        }
        }

}


function acct_limit_pre_ONCHANGE(obj){
        if(profileId=="50"){
        if(((sSchmCode=="OD501") || (sSchmCode=="OD503")) && ((mopId == "HOAACOD")||(mopId == "HOAACVOD")||(mopId == "HOAACMOD"))){
                e1 = document.getElementById("securityDesc");
                e2 = e1.parentNode;
                e2.previousSibling.innerText = "Commission Pcnt";
                e3 = document.getElementById("remarks");
                e4 = e3.parentNode;
                e4.previousSibling.innerText = "Commission Amount";
                var commPcnt = document.forms[0].securityDesc.value;
                var commAmt = document.forms[0].remarks.value;
                var sanctLim = document.forms[0].sanctionLimit.value;

                // Harrison
                // if(commPcnt==""){
                //         alert("Enter Commission Percentage")
                //         document.forms[0].securityDesc.focus();
                //         return false;

                // }
                //alert(sanctLim);
		var commamt = (parseFloat(sanctLim.replace(/,/g, '')) * parseFloat(commPcnt))/100;
		alert(commamt);
		document.forms[0].remarks.value=commamt;
		document.forms[0].remarks.disabled = true;
        }
        }
}



</script>
