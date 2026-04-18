/*---------------------------------------------------------------------------------------------------------------->
<!--Name                : acmogddet_custom.jsp
<!--Description         :
<!--Date                : 30/jan/2020
<!--Author              : Vino Palani
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HACM
<!--Modification History:
<!--    Version No.             Date                     Author         Description
<!--    -------                 ----------              -----------     ------------------
<!---------------------------------------------------------------------------------------------------------------->*/
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<arjsp:init groupName="acmogd" isEntryPoint="false" />
<%
        String glSub   = (String)ARJspCurr.getInputWithGroup("glSubHeadCode", null);
        String schmcode   = (String)ARJspCurr.getInputWithGroup("schmCode", null);
        String cifId   = (String)ARJspCurr.getInputWithGroup("cifId", null);
%>
<script type="text/javascript">
function acmogddet_pre_ONBLUR(obj){
    if (mopId == "HACM") {
         if (profileId == 54){
                SafaricomDealChk();
         }
    }
}
function SafaricomDealChk(obj){
    var cschCode = "<%=schmcode%>"
    var ccifId = "<%=cifId%>"
    if (mopId == "HACM") {
            if ((document.forms[0].remarks.value != "") && (cschCode =="SB167")) {
                var dealCode = document.forms[0].remarks.value;
                var inputNameValues =  "DealCode" + "|" + dealCode + "|" + "cifId" + "|" + ccifId;
                var outputNames = "SucYN|DealerDetails|DealerNAme|DealerLimit";
                var scrName = "ebSafaricomDealVal.scr";
                var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
                var ret = retVal.split("|");
                //alert(ret);
                if(ret[1] == "N") {
                        alert("Safaricom Agent Validation Failed - Agent does not exist");
                        return false;
                }else if (ret[1] == "NA"){
                        alert("Safaricom Agent Validation Failed - Agent does not exist");
                        return false;
                }else if (ret[1] == "Y"){
                        //Dealer Code
                        alert(ret[3]);
                        //Dealer Name
                        alert(ret[5]);
                        //Dealer Limit
                        alert(ret[7]);
                        return true;
                }else {
                        return true;
                }
            }
    }
}
</script>
