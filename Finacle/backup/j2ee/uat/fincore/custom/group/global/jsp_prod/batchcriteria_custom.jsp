<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : batchcriteria_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 18-01-2013
<!--Author            : Farhan
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HREJREP,HEGOC
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		18-01-2013	Farhan		Original version
<!--	0.2		31-01-2013	Chandrasekhar	Added Population of BODDate to HEGOC Menu
<!--	0.3		21-02-2013	Chandrasekhar	Reductant code has removed
<!--	0.4		11-03-2013	Chandrasekhar	Added new statements for hclupld
<!-- 	0.5		31-03-2013	Sateesh		Added brcode checking for solid make it as protect.
<!-- 	0.6		20-06-2013	Shishira	Modified by sending field value to the form and protecting the fields.
<!---------------------------------------------------------------------------------------------------------------->
<%@ page import="com.infy.bbu.jsputil.*,FABProcess.*,FABCommon.*,FABInquiry.*,java.util.*, java.lang.*,finbranchUtil.*"%>
<%@ page import="fabclasses.*,FabServer.*,com.infy.bbu.*,applcommon.*" %> 
<%@ include file="../../javascripts/core_signature.js" %>
<%
        FABCommon.SecurityInfo70 securityInfo = (FABCommon.SecurityInfo70)session.getAttribute("FinUserInfo");
        if(null == securityInfo)
        {
                securityInfo = (FABCommon.SecurityInfo70)session.getAttribute("UserInfo");
        }

        String sBODDate = (String)((securityInfo.bodDate).substring(0,10));
        String homeSol  = (String)((securityInfo.homeSolId));
%>
<script type="text/javascript">
var bodDate = '<%=sBODDate%>';

function batchcriteria_pre_ONLOAD(btn) {
    //bank
    if (mopId == "HLADSP") {
        //alert("am in");
        var radioButtons = document.getElementsByName("recovery_mode");
        radioButtons[0].checked = true;
        radioButtons[1].checked = false;
        radioButtons[1].checked = false;

    }
    //bank
    if (mopId == "HREJREP") {
        //alert("batchcriteria");
        element = document.getElementsByName("cust_flg");
        element[1].checked = true;
        return true;
    } else if (mopId == "HEGOC") {
        var boddate = '<%=sBODDate%>'
        var bod = boddate.split("-");

        var bodday = bod[0];
        var bodmonth = bod[1];
        var bodyear = bod[2];
        var ref = bodday + bodmonth + bodyear;
        document.forms[0].file.value = ref;
        return true;
    } else if (mopId == 'HCLUPLD') {
        //modified 24-06
        //to populate report to  and remarks field
        var inputNameValues = "moduleName" + "|" + "CLEARING" + "|" + "parameterId" + "|" + "REP_TOnRMK";
        var outputNames = "";
        var scrName = "getCparamValForJsp.scr";
        var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret = retVal.split("|");
        ret1 = ret[1];
        var ret2 = ret1.split(",");
        var repTo = ret2[0];
        var rmk = ret2[1];
        if (document.forms[0].report_to.value == "") {
            document.getElementById('report_to').value = repTo;
        }
        document.getElementById('remarks').value = rmk;
        //protecting the fields
        document.forms[0].report_to.readOnly = true;
        document.getElementById('sLnk_zone_code').style.visibility = "hidden";
        document.forms[0].zone_date_ui.readOnly = true;
        document.getElementById('sLnk_zone_date').style.visibility = "hidden";
        document.forms[0].zone_code.readOnly = true;
        document.forms[0].inp_file_name.readOnly = true;
        document.forms[0].dflt_acct_num.readOnly = true;
        var radioButtons2 = document.getElementsByName('mult_inst_flg');
        radioButtons2[0].disabled = true;
        radioButtons2[1].disabled = true;
        var radioButtons2 = document.getElementsByName('save_in_db');
        radioButtons2[0].disabled = false;
        radioButtons2[1].disabled = false;
        var radioButtons = document.getElementsByName('upload_file_location');
        document.forms[0].upload_file_location.disabled = true;
        radioButtons[1].checked = false;
        radioButtons[0].checked = true;
        radioButtons[0].disabled = true;
        radioButtons[1].disabled = true;

        var radioButtons2 = document.getElementsByName('save_in_db');
        radioButtons2[1].checked = false;
        radioButtons2[0].checked = true;
        radioButtons2[0].disabled = true;
        radioButtons2[1].disabled = true;

        //modifyed 20-6
        //form
        var zoneCodeM = document.forms[0].zone_code.value;
        var inpFilNameM = document.forms[0].inp_file_name.value;
        var zoneDateM = document.forms[0].zone_date.value;
        //modifyed 24-06
        if (zoneDateM == "") {
            zoneDateM = bodDate;
        }
        if ((zoneCodeM == "") || (inpFilNameM == "") || (zoneDateM == "")) {
            var argsVariable;
            var url = "../custom/54/jsp/clgUpldformmn001.jsp?zoneCodeM=" + zoneCodeM + "&zoneDateM=" + zoneDateM + "&inpFilNameM=" + inpFilNameM
            var answer = window.showModalDialog(url, argsVariable, "dialogWidth:400px; dialogHeight:300px; center:yes");
            if (answer != undefined) {
                var zoneDate = answer.zoneDate;
                var zoneCode = answer.zoneCode;
                var upldFile = answer.fileName;
                document.getElementById('zone_date_ui').value = zoneDate;
                document.getElementById('zone_code').value = zoneCode;
                document.getElementById('inp_file_name').value = upldFile;
            } //undefined
            else {
                document.forms[0].report_to.readOnly = false;
                document.getElementById('sLnk_zone_code').style.visibility = "visible";
                document.forms[0].zone_date_ui.readOnly = false;
                document.getElementById('sLnk_zone_date').style.visibility = "visible";
                document.forms[0].zone_code.readOnly = false;
                document.forms[0].inp_file_name.readOnly = false;
                document.forms[0].dflt_acct_num.readOnly = false;
                var radioButtons2 = document.getElementsByName('mult_inst_flg');
                radioButtons2[0].disabled = false;
                radioButtons2[1].disabled = false;
                var radioButtons2 = document.getElementsByName('save_in_db');
                radioButtons2[0].disabled = false;
                radioButtons2[1].disabled = false;
                var radioButtons = document.getElementsByName('upload_file_location');
                radioButtons[0].disabled = false;
                radioButtons[1].disabled = false;
            }
        } //field==""
    } //mopId
    else
    if (mopId == "HLADSP") {
        var inputNameValues = "";
        var outputNames = "";
        var scrName = "laadisbdp011.scr";
        var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret = retVal.split("|");
        if (ret[0] == "Error" && ret[1] != "") {
            alert(ret[1]);
            return false;
        }

        if (ret[2] == "brCode" && ret[3] != "")

        {
            document.forms[0].sol_set_id.disabled = true;
            document.getElementById("sLnk_sol_set_id").style.visibility = "hidden";
        }
    }

    if (mopId == "HPSP") {
        signfunction1();
        signfunction2();
    }
    return true;
}

function post_ONLOAD() {
    if (mopId == "HPSP") {
        //ebl start
        var radioButtons = document.getElementsByName("adhoc_flg");
        radioButtons[0].checked = false;
        radioButtons[1].checked = true;
        //ebl end
        element = document.forms[0].low_acct_num;
        element.onchange = function() {
            fnOnChangeAcct()
        };
        //Added by Sruthi for call id : 390110

        document.forms[0].high_tran_date_ui.value = bodDate;

    }

}

function fnOnChangeAcct() {
    retValue = txtSrh_ONCHANGE(this, "postChangeSearch('ACCT','F','low_acct_num','low_acct_crncy|low_acct_sol|low_acct_name')");
    if (retValue) {
        var inputNameValues = "acctNum|" + document.forms[0].low_acct_num.value;
        var outputNames = "";
        var scrName = "formatacctdp001.scr";
        var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret1 = retVal.split("|");
        if (ret1[0] == "MSG") {
            alert(ret1[1]);
        }
    }
}

function signfunction1() {
    var a = document.getElementsByTagName("td");
    var acctLabel = "From A/c. ID";
    var tmpSignStr = '<a id="sigLnk" href="javascript:fnCustShowSignature1();">';
    tmpSignStr = tmpSignStr + '<img class="img" title="Signature" src="../Renderer/images/INFENG/sig_new1.gif" width="16" height="18" border="0"></img></a>&nbsp;'

    for (i = 0; i < a.length; i++) {
        if (a[i].innerHTML.indexOf(acctLabel) != -1) {
            if (a[i + 1].innerHTML.indexOf('<INPUT') != -1 && a[i + 1].innerHTML.indexOf('<INPUT') == 0) {
                var str = a[i + 1].innerHTML;
                var indx = str.indexOf('</A>') + 4;
                a[i + 1].innerHTML = str.substr(0, indx) + tmpSignStr + str.substr(indx);
            }
        }
    }

}

function fnCustShowSignature1() {
    var acctIdStr = "low_acct_num";
    var solIdStr = "";
    var tmpAcctObj = document.getElementById(acctIdStr);
    if ('X' + solIdStr != 'X') {
        var tmpSolObj = document.getElementById(solIdStr).value;
    } else {
        tmpSolObj = ""
    }
    if (fnIsNull(tmpAcctObj.value)) {
        alert("Enter the field.");
        tmpAcctObj.focus();
        return;
    }
    var data = '?sAcctId=' + escape(tmpAcctObj.value) + '&sSolId=' + escape(tmpSolObj) + '&sActiveDate=' + escape(bodDate) + '&fromAppId=' + escape(fromAppId) + '&toMenu=' + mopId.toLowerCase() + '&contextSwitch=Y';
    displaySVSWindow(data);
}

function signfunction2() {
    var a = document.getElementsByTagName("td");
    var acctLabel = "To A/c. ID";
    var tmpSignStr = '<a id="sigLnk" href="javascript:fnCustShowSignature2();">';
    tmpSignStr = tmpSignStr + '<img class="img" title="Signature" src="../Renderer/images/INFENG/sig_new1.gif" width="16" height="18" border="0"></img></a>&nbsp;'

    for (i = 0; i < a.length; i++) {
        if (a[i].innerHTML.indexOf(acctLabel) != -1) {
            if (a[i + 1].innerHTML.indexOf('<INPUT') != -1 && a[i + 1].innerHTML.indexOf('<INPUT') == 0) {
                var str = a[i + 1].innerHTML;
                var indx = str.indexOf('</A>') + 4;
                a[i + 1].innerHTML = str.substr(0, indx) + tmpSignStr + str.substr(indx);
            }
        }
    }

}

function fnCustShowSignature2() {
    var acctIdStr = "high_acct_num";
    var solIdStr = "";
    var tmpAcctObj = document.getElementById(acctIdStr);
    if ('X' + solIdStr != 'X') {
        var tmpSolObj = document.getElementById(solIdStr).value;
    } else {
        tmpSolObj = ""
    }
    if (fnIsNull(tmpAcctObj.value)) {
        alert("Enter the field.");
        tmpAcctObj.focus();
        return;
    }
    var data = '?sAcctId=' + escape(tmpAcctObj.value) + '&sSolId=' + escape(tmpSolObj) + '&sActiveDate=' + escape(bodDate) + '&fromAppId=' + escape(fromAppId) + '&toMenu=' + mopId.toLowerCase() + '&contextSwitch=Y';
    displaySVSWindow(data);
}

function callbackSVS(data, menu) {
    // for SSO Context Switching


    /*
    function batchcriteria_post_ONLOAD()
    {
    	 if(mopId == "HLADSP")
            {
    alert("batchcriteria");
    radioButtons[0].checked = true;
            }
    }
    */


}
</script>
