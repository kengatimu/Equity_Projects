<!--------------------------------------------------------------------------------------------------------------->
<!--Name                : general_details_custom.jsp
<!--Description         : This is used to set localCalendar to no and it is protect.
<!--Date                : 13-03-2013 
<!--Author              : Manoj
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HOAACSB,HOAACCC,HOAACCA,HOAACOD
<!--Modification History:
<!--    Version No.           Date                       Author                 Description
<!--    -------         ----------                       -----------        ------------------
<!--     0.1            13-03-2013                       Manoj          	Original version
<!---------------------------------------------------------------------------------------------------------------->

<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<arjsp:init groupName="generaldetails" isEntryPoint="false" />
<%
	String glSub   = (String)ARJspCurr.getInputWithGroup("glSubHeadCode", null);
%>
<script language="javascript" src="../Renderer/custom/javascripts/generaldetails/general_details_glink.js"></script>
<script type="text/javascript">
//function showDynSearcher(iName,inputFields,outputFields,pWidth,pHeight) {
//alert("chck");
//}

function post_ONLOAD() {

    var glSubCode = "<%=glSub%>"
    if (mopId == "HOAACSB" || mopId == "HOAACCC" || mopId == "HOAACCA" || mopId == "HOAACOD") {
        var radioButtons = document.getElementsByName('localCalendar');
        radioButtons[0].checked = false;
        radioButtons[1].checked = true;
        radioButtons[0].disabled = true;
        radioButtons[1].disabled = true;

        var radioButtons1 = document.getElementsByName('collectCharges');
        radioButtons1[0].checked = true;
        radioButtons1[1].checked = false;
        radioButtons1[0].disabled = true;
        radioButtons1[1].disabled = true;
    }

    var pbval = document.getElementById('pbPsFlg').value;
    if (pbval != "S" && pbval != "P" && pbval != "B") {
        var modeopcode = document.forms[0].modeOfOperCode.value;
        var inputNameValues = "modeOfOperCode" + "|" + modeopcode + "|" + "glSub" + "|" + glSubCode;
        var outputNames = "paramV1|paramV2";
        var scrName = "acctopnvalmn002.scr";
        var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret = retVal.split("|");
        if (ret[0] == "Error") {
            alert(ret[1]);
            return false;
        }
        if (ret[3] == "Y") {
            document.getElementById('pbPsFlg').value = 'P';
        }
    }

    document.getElementById('pbPsFlg').onchange = function() {
        var radioButtons = document.getElementsByName('localCalendar');
        radioButtons[0].checked = false;
        radioButtons[1].checked = true;
        radioButtons[0].disabled = true;
        radioButtons[1].disabled = true;
    }

    {
        //alert("Enter account ID");
        document.forms[0].acctMgrAtAcct.focus();
        return false;

    }

}

function general_details_pre_ONCLICK(btn) {
    var glSubCode = "<%=glSub%>"
    var modeopcode = document.forms[0].modeOfOperCode.value
    if (modeopcode == "") {
        if ((btn.id != "Back") && (btn.id != 'collapse2') && (btn.id != 'expand2')) {
            var modeopcode = document.forms[0].modeOfOperCode.value;
            var inputNameValues = "modeOfOperCode" + "|" + modeopcode + "|" + "glSub" + "|" + glSubCode;
            var outputNames = "paramV1|paramV2";
            var scrName = "acctopnvalmn002.scr";
            var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
            var ret = retVal.split("|");
            if (ret[0] == "Error") {
                alert(ret[1]);
                return false;
            }
            if (ret[1] == "X") {
                alert("Enter mode of operation code");
                return false;
            } else {
                return true;
            }
        }
    }
    if (mopId == "OAACPS") {
        if ((btn.id == "Submit") || (btn.id == "Validate")) {
            if (document.forms[0].acctMgrAtAcct.value == "") {
                alert("Please Enter  Account manager");
                document.forms[0].acctMgrAtAcct.focus();
                return false;
            }
        }
    }
}

</script>
