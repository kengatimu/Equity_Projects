<!----------------------------------------------------------------------------------------------------->
<!--   File                           : transfer_amend_details_custom.jsp
<!--   Description                    : Custom jsp for transfer amend details tab (SWIFT 2018).
<!--   Author                         : Ekta Shrivastava.
<!--   SNo         Date                               Author Name                          Description
<!--   001         26 June 2018                       Ekta Shrivastava.                    Initial Version
<!----------------------------------------------------------------------------------------------------->
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="com.infy.finbranch.groups.*"%>
<%@ page import="com.infy.bbu.jsputil.*,FABInquiry.*"%>
<%@ page import="applcommon.ParseValue" %>
<%@ page import="java.io.*"  %>
<%@ page import="java.util.logging.*" %>
<%@ page import="com.infy.bbu.jsputil.*"%>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.ObjectInputStream" %>
<%@ page import="java.io.ObjectOutputStream" %>
<%@ page import="FABInquiry.TranMiscDtl" %>
<%@ page import="fabclasses.CommonFunctions" %>
<%@ page import="fabclasses.FinErrException" %>
<%@ page import="fabclasses.ServiceRoutines" %>
<%@ page import="java.util.Vector" %>
<%@ page import="FABCommon.SecurityInfo70" %>
<%@ page import="com.infy.COTP.LinkList" %>
<%@ page import="gcode.utils.ONSClassFactory" %>
<%@ page import="com.infy.bbu.context.IServiceContext" %>
<%@ page import="com.infy.bbu.context.ContextAdapter" %>
<%@ page import="com.infy.bbu.ons.common.CommonConstants" %>
<%@ page import="gcode.iface.IreportData" %>
<%@ page import="com.infy.finbranch.groups.FileOpertn" %>
<%@ page import="java.io.File" %>
<%@ page import="java.security.PrivilegedAction" %>
<%@ page import="java.security.AccessController" %>
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<%@ include file="/custom/commonInclude.jsp" %>


<SCRIPT language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("common_functions.js",sProfileId)%>" > </SCRIPT>
<script language="javascript" src="../Renderer/javascripts/lists/<%=VRPKeys.getFile("showTextArea.js",sProfileId)%>"></script>
<SCRIPT language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("custom_functions.js",sProfileId)%>"></script>


<%
        ContextManager ARJspCurr = (ContextManager) session.getAttribute("CustomARJspCurr");
        String sGroupName = ARJspCurr.getCurrentGroup();

        String hidden_trfAmendDocReq = (String) ARJspCurr.getInput("hidden_trfAmendDocReq", "");
        String screen_trfAmendDocReq = (String) ARJspCurr.getInput("screen_trfAmendDocReq", "");
        ARJspCurr.setInput("hidden_trfAmendDocReq", hidden_trfAmendDocReq);
        ARJspCurr.setInput("screen_trfAmendDocReq", hidden_trfAmendDocReq);

        String hidden_trfAmendAddConditions = (String) ARJspCurr.getInput("hidden_trfAmendAddConditions", "");
        String screen_trfAmendAddConditions = (String) ARJspCurr.getInput("screen_trfAmendAddConditions", "");
        ARJspCurr.setInput("hidden_trfAmendAddConditions", hidden_trfAmendAddConditions);
        ARJspCurr.setInput("screen_trfAmendAddConditions", hidden_trfAmendAddConditions);

        String[] custData1 = (String[]) ARJspCurr.getInput(com.infy.bbu.ons.common.CommonConstants.KEY_CUSTOM_DATA, null);
        System.out.println("custData1" + custData1[0]);
        if (custData1 == null) {
            custData1 = new String[1];
            custData1[0] = "";
        } else {
            String[] result = CommonFunctions.split(custData1[0], '|');
            ARJspCurr.setInput("hidden_trfAmendDocReq", "");
            ARJspCurr.setInput("hidden_trfAmendAddConditions", "");
            String tag201value = "";
            hidden_trfAmendAddConditions = "";
            hidden_trfAmendDocReq = "";
            String transferDcNumCust = (String) ARJspCurr.getInputWithGroup("xferDcNum", "");

            tag201value = transferDcNumCust;

            String pageId1 = "~transfer_amend_details";
            if (!(tag201value == null || "".equals(tag201value.trim()))) {
                for (int i = 0; i < result.length; i++) {
                    if (result[i].equals(pageId1)) {
                        if (i + 5 < result.length) {
                            String trfDcCustVal = result[i + 5];
                            System.out.println("trfDcCustVal = " + trfDcCustVal);
                            String[] trfDcCustValArr = trfDcCustVal.split("\\^\\^\\^\\^\\^");
                            for (int k = 0; k < trfDcCustValArr.length; k++) {
                                System.out.println(" k =" + trfDcCustValArr[k]);
                                if (trfDcCustValArr[k].equals(tag201value)) {
                                    if (k + 1 < trfDcCustValArr.length) {
                                        ARJspCurr.setInput("hidden_trfAmendDocReq", trfDcCustValArr[k + 1]);
                                    }
                                    if (k + 2 < trfDcCustValArr.length) {
                                        ARJspCurr.setInput("hidden_trfAmendAddConditions", trfDcCustValArr[k + 2]);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
%>
<SCRIPT language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("cust_post_evt.js",sProfileId)%>" > </SCRIPT>
<SCRIPT language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("cust_pre_evt.js",sProfileId)%>"></script>


<script language="javascript">
with (document)
{
	write('<input type="hidden" id="hidden_trfAmendDocReq"   name="hidden_trfAmendDocReq">');
	write('<input type="hidden" id="hidden_trfAmendAddConditions" name="hidden_trfAmendAddConditions">');
	write('<input type="hidden" id="hidden_trfAmendDcInfo" name="hidden_trfAmendDcInfo">');

	write('<br>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write("<tr>");
	write('<td valign="top">	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableborder">');
	write("<tr>");
	write('<td>	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write("<tr>");
	write('<td>	<table name="TABLE1" width="100%" border="0" cellpadding="0" cellspacing="0">');
	write('<tr class="innertabletop1">');
	write('<td height="25" colspan="5" align="right">	<table border="0" cellspacing="0" cellpadding="0">');

	write("</table>");
	write("</td>");
	write("</tr>");

	write('<tr>');
	write('<td class="textlabel" >Documents Required</td>');
	write('<td class="textfield">');
	write('<input type="text" class ="textfieldfont" disabled = "true" hotKeyId="search1" id="screen_trfAmendDocReq" maxlength = "45500"  name="screen_trfAmendDocReq" >&nbsp;');

	write("&nbsp;");
	write("<a id=\"scLnk40\" href=\"javascript:showDynSearcher('HTFCTXT','text_type=D',':moduleId=module_id|:textId=text_id|:textType=text_type');javascript:setCustomFldFromSearcher(scLnk40);\">");
	write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search8"></a>');

	write('<a id="tdLnik1"  href="javascript:chkAmendmentStatus(tdLnik1);">');
	write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
	write('</td>');
	write('<td class="textlabel" >Additional Conditions </td>');
	write('<td class="textfield">');
	write('<input type="text" class ="textfieldfont" disabled = "true" hotKeyId="search1" id="screen_trfAmendAddConditions" maxlength = "45500"  name="screen_trfAmendAddConditions" >&nbsp;');
	write("&nbsp;");
	write("<a id=\"scLnk41\" href=\"javascript:showDynSearcher('HTFCTXT','text_type=C',':moduleId=module_id|:textId=text_id|:textType=text_type');javascript:setCustomFldFromSearcher(scLnk41);\">");
	write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search9"></a>');

	write('<a id="tdLnik2"  href="javascript:chkAmendmentStatus(tdLnik2);">');
	write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
	write('</td>');
	write('</tr>');
	write('</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="page-heading" colspan="2" style="height: 15px; color: #1068c2" id = "amdTrfDc">&nbsp;Amend Transfer DC Info</td>');
	write('<td class="textfield"></td>');
	write('</tr>');
	write('<br>')
	write('<td class="textlabel" colspan="2" id = "amdTrfDcTxt">Amend Transfer DC Info</td>');
	write('<td>');
	write('<input type="text" class ="textfieldfont" disabled = "true" hotKeyId="search1" id="screen_trfAmendDcInfo" maxlength = "455000"  name="screen_trfAmendDcInfo" >&nbsp;');
	//write('<a id="tdLnik1"  href="javascript:showTextAreaTemp(tdLnik1);">');
	//write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');

	write('<tr class="rowspacing">');
	write('<td colspan="5"><spacer type="block" height="1" width="1"></spacer></td>');
	write("</tr>");
	write("</table>");
	write("</td>");
	write("</tr>");
	write("</table>");
	write("</td>");
	write("</tr>");
	write("</table>");
	write("</td>");
	write("</tr>");
	write("</table>");
	write("</td>");
	write("</tr>");
	write('</table>');

	write('</td>');
	write('</tr>');
	write('</td>');
	write('</tr>');
	write('<br>');

}

function setToCustom() {
	setFieldsToCustomData("screen_trfAmendDocReq", "hidden_trfAmendDocReq", "screen_trfAmendAddConditions", "hidden_trfAmendAddConditions", "hidden_trfAmendDcInfo", "screen_trfAmendDcInfo");
}

var glb_trfAmendDocReq;
var glb_trfAmendAddConditions;
function showTextAreaTemp(objButton) {
    if (funcCode == "A") {
        if (objButton.id == "tdLnik1") {
            var ret = showTextArea('hidden_trfAmendDocReq', '', 'N', 'left', 'U', 'N', 65, 800, 'string', 'Y', 'Y', 'C');
        } else if (objButton.id == "tdLnik2") {
            var ret = showTextArea('hidden_trfAmendAddConditions', '', 'N', 'left', 'U', 'N', 65, 800, 'string', 'Y', 'Y', 'C');
        } else {}
    } else {
        if (objButton.id == "tdLnik1") {
            var ret = showTextArea('hidden_trfAmendDocReq', '', 'N', 'left', 'U', 'N', 65, 800, 'string', 'N', 'Y', 'C');
        } else if (objButton.id == "tdLnik2") {
            var ret = showTextArea('hidden_trfAmendAddConditions', '', 'N', 'left', 'U', 'N', 65, 800, 'string', 'N', 'Y', 'C');
        } else {}
    }

	if (ret != null && ret != undefined) {
    	ret = decodeURIComponent(ret);
    	//ret = decodeURIComponent(ret);
	}

    if (objButton.id == "tdLnik1") {
        if (window.showModalDialog) {
            if (ret != null && ret != undefined) {
                document.forms[0].screen_trfAmendDocReq.value = ret;
                document.forms[0].hidden_trfAmendDocReq.value = ret;
		setToCustom();
            }
        }
    } else {
        if (window.showModalDialog) {
            if (ret != null && ret != undefined) {
                document.forms[0].screen_trfAmendAddConditions.value = ret;
                document.forms[0].hidden_trfAmendAddConditions.value = ret;
		setToCustom();
            }
        }
    }
    //	doSubmit("Validate");
}

function getFieldsValue() {
    glb_trfAmendDocReq = "<%=ParseValue.checkString(hidden_trfAmendDocReq)%>";
    glb_trfAmendAddConditions = "<%=ParseValue.checkString(hidden_trfAmendAddConditions)%>";
}

function chkAmendmentStatus(obj) {
    if (document.forms[0].amendmentStatus.value == "") {
        alert("Enter Amendment Status ");
        //return false;
    } else {
        showTextAreaTemp(obj);
    }

}

function transfer_amend_details_post_ONLOAD() {
	
	
		//alert("inside postonload");
		var inputNameValues = "";
		var outputNames = "";
        var scrName = "swift2018_switch.scr";
        var retVal = appFnExecuteScript(inputNameValues, outputNames,scrName, false);
        var ret = retVal.split("|");
		//alert("ret0"+ret[0]);
		//alert("ret1"+ret[1]);
		if(ret[1] == "N")
        {
        
			//alert("inside condiition");
			var SWIFT2018_enabled = "N";
			//alert("inside function post"+SWIFT2018_enabled);
			document.forms[0].screen_trfAmendDocReq.value  = "";
			document.forms[0].hidden_trfAmendDocReq.value  = "";
			document.forms[0].screen_trfAmendAddConditions.value  = "";
			document.forms[0].hidden_trfAmendAddConditions.value  = "";
			document.forms[0].screen_trfAmendDcInfo.value  = "";
			document.forms[0].hidden_trfAmendDcInfo.value  = "";
			document.forms[0].screen_trfAmendDocReq.disabled = true;
			document.forms[0].screen_trfAmendAddConditions.disabled = true;
			document.forms[0].screen_trfAmendDcInfo.disabled = true;
			hideImage("tdLnik1");
			hideImage("tdLnik2");
			hideImage("scLnk40");
			hideImage("scLnk41");
			
		}
    hideImage("amdTrfDc");
    hideImage("amdTrfDcTxt");
    hideImage("screen_trfAmendDcInfo");
    if (funcCode == "A") {
        getFieldsFromCustomData("screen_trfAmendDocReq", "hidden_trfAmendDocReq", "screen_trfAmendAddConditions", "hidden_trfAmendAddConditions", "hidden_trfAmendDcInfo", "screen_trfAmendDcInfo");


        if (fnTrim(document.forms[0].hidden_trfAmendDcInfo.value) != "") {
            if (xferDcNum == "") {
                document.forms[0].screen_trfAmendDocReq.value = "";
                document.forms[0].hidden_trfAmendDocReq.value = "";
                document.forms[0].screen_trfAmendAddConditions.value = "";
                document.forms[0].hidden_trfAmendAddConditions.value = "";
		setToCustom();

                getFieldsFromCustomData("screen_trfAmendDocReq", "hidden_trfAmendDocReq", "screen_trfAmendAddConditions", "hidden_trfAmendAddConditions", "hidden_trfAmendDcInfo", "screen_trfAmendDcInfo");
            } else {
                var s = "^^^^^" + xferDcNum + "^^^^^";
                var chkVal = document.forms[0].hidden_trfAmendDcInfo.value.indexOf(s);
                if (chkVal >= 0) {

                    //getFieldsValue();
                    var CustValues = document.forms[0].hidden_trfAmendDcInfo.value.split("^^^^^");
                    var i;
                    for (i = 0; i < CustValues.length; i++) {
                        if (CustValues[i] == xferDcNum) {
                            document.forms[0].screen_trfAmendDocReq.value = CustValues[i + 1];
                            document.forms[0].hidden_trfAmendDocReq.value = CustValues[i + 1];
                            document.forms[0].screen_trfAmendAddConditions.value = CustValues[i + 2];
                            document.forms[0].hidden_trfAmendAddConditions.value = CustValues[i + 2];
			    setToCustom();
                            getFieldsFromCustomData("screen_trfAmendDocReq", "hidden_trfAmendDocReq", "screen_trfAmendAddConditions", "hidden_trfAmendAddConditions", "hidden_trfAmendDcInfo", "screen_trfAmendDcInfo");

                        }
                    }

                } else {
                    document.forms[0].screen_trfAmendDocReq.value = "";
                    document.forms[0].hidden_trfAmendDocReq.value = "";
                    document.forms[0].screen_trfAmendAddConditions.value = "";
                    document.forms[0].hidden_trfAmendAddConditions.value = ""
                }
		setToCustom();
                getFieldsFromCustomData("screen_trfAmendDocReq", "hidden_trfAmendDocReq", "screen_trfAmendAddConditions", "hidden_trfAmendAddConditions", "hidden_trfAmendDcInfo", "screen_trfAmendDcInfo");
            }
        } else {
            getFieldsValue();
            document.forms[0].screen_trfAmendDocReq.value = glb_trfAmendDocReq;
            document.forms[0].hidden_trfAmendDocReq.value = glb_trfAmendDocReq;
            document.forms[0].screen_trfAmendAddConditions.value = glb_trfAmendAddConditions;
            document.forms[0].hidden_trfAmendAddConditions.value = glb_trfAmendAddConditions;
        }
	setToCustom();
        getFieldsFromCustomData("screen_trfAmendDocReq", "hidden_trfAmendDocReq", "screen_trfAmendAddConditions", "hidden_trfAmendAddConditions", "hidden_trfAmendDcInfo", "screen_trfAmendDcInfo");
    } else {
        var CustValues = new Array();
        CustValues = document.forms[0].customData.value.split("|");
        var pageId = "~transfer_amend_details";
        for (var i = 0; i <= CustValues.length; i++) {
            if (CustValues[i] == pageId) {
                var trfDcCustVal = CustValues[i + 5];
                document.forms[0].screen_trfAmendDcInfo.value = trfDcCustVal;
                document.forms[0].hidden_trfAmendDcInfo.value = trfDcCustVal;
                var trfDcCustValArr = new Array();

                trfDcCustValArr = trfDcCustVal.split("^^^^^");
                for (var k = 0; k <= trfDcCustValArr.length; k++) {
                    if (trfDcCustValArr[k] == xferDcNum) {
                        document.forms[0].screen_trfAmendDocReq.value = trfDcCustValArr[k + 1];
                        document.forms[0].hidden_trfAmendDocReq.value = trfDcCustValArr[k + 1];
                        document.forms[0].screen_trfAmendAddConditions.value = trfDcCustValArr[k + 2];
                        document.forms[0].hidden_trfAmendAddConditions.value = trfDcCustValArr[k + 2];
                    }

                }
            }
        }
    }

}

function transfer_amend_details_pre_ONCLICK(obj) {

    var chkDocReq = fnTrim(document.forms[0].screen_trfAmendDocReq.value.substring(0, 8));

    if (chkDocReq != "") {
        if ((fnTrim(chkDocReq.substring(0, 5)) != "/ADD/") && (chkDocReq != "/DELETE/") && (chkDocReq != "/REPALL/")) {
            alert("First word must be /ADD/,/DELETE/,/REPALL/ in Documents Required 1 Field ");
            return false;
        }
    }

    var chkCon = fnTrim(document.forms[0].screen_trfAmendAddConditions.value.substring(0, 8));

    if (chkCon != "") {
        if ((chkCon.substring(0, 5) != "/ADD/") && (chkCon != "/DELETE/") && (chkCon != "/REPALL/")) {
            alert("First word must be /ADD/,/DELETE/,/REPALL/ in Additional Conditions 1 Field");
            return false;
        }
    }
    if (funcCode == "A") {
        if (obj.id == "Accept") {
            getFieldsValue();
            getDcInfoVal();
        }
    } else {
	setToCustom();
    }

}

function getDcInfoVal() {

    var s = "^^^^^" + xferDcNum + "^^^^^";
    if (document.forms[0].hidden_trfAmendDcInfo.value != "") {
        var index = document.forms[0].hidden_trfAmendDcInfo.value.indexOf(s);
        if (index < 0) {
            document.forms[0].hidden_trfAmendDcInfo.value = document.forms[0].hidden_trfAmendDcInfo.value + "^^^^^" + xferDcNum + "^^^^^" + document.forms[0].hidden_trfAmendDocReq.value + "^^^^^" + document.forms[0].hidden_trfAmendAddConditions.value;
        } else {
            var orgStr = document.forms[0].hidden_trfAmendDcInfo.value;
            var strVar = "^^^^^" + xferDcNum;
            var strIndex = document.forms[0].hidden_trfAmendDcInfo.value.indexOf(strVar);

            var strPreString = document.forms[0].hidden_trfAmendDcInfo.value.substring(0, strIndex);
            var strLen = document.forms[0].hidden_trfAmendDcInfo.value.length;
			// Add last 5 characters as separator, so that the for loop can behave correctly
            var tempPostStr = document.forms[0].hidden_trfAmendDcInfo.value.substring(strIndex, strLen) + "^^^^^";

            for (var i = 0; i < 4; i++) {
                var crtIndex = tempPostStr.indexOf("^^^^^");
                var tempPostStrLen = tempPostStr.length;
                var newPos = crtIndex + 5;
                tempPostStr = tempPostStr.substring(newPos, tempPostStrLen);
            }
			// Remove the last 5 characters of separator which was added earlier
			var tempPostStrLen = tempPostStr.length-5;
			tempPostStr = tempPostStr.substring(0, tempPostStrLen);

            var postStr = "^^^^^" + tempPostStr;
            document.forms[0].hidden_trfAmendDcInfo.value = strPreString + "^^^^^" + xferDcNum + "^^^^^" + document.forms[0].screen_trfAmendDocReq.value + "^^^^^" + document.forms[0].screen_trfAmendAddConditions.value + postStr;

        }
    } else {
        document.forms[0].hidden_trfAmendDcInfo.value = document.forms[0].hidden_trfAmendDcInfo.value + "^^^^^" + xferDcNum + "^^^^^" + document.forms[0].hidden_trfAmendDocReq.value + "^^^^^" + document.forms[0].hidden_trfAmendAddConditions.value;
    }



    document.forms[0].screen_trfAmendDcInfo.value = document.forms[0].hidden_trfAmendDcInfo.value;
    var screen_trfAmendDcInfo = document.forms[0].screen_trfAmendDcInfo.value;

    setToCustom();

    return true;
}

function transfer_amend_details_pre_TAB_SWITCH(obj) {
    getFieldsValue();
    document.forms[0].screen_trfAmendDocReq.value = glb_trfAmendDocReq;
    document.forms[0].hidden_trfAmendDocReq.value = glb_trfAmendDocReq;
    var screen_trfAmendDocReq = document.forms[0].screen_trfAmendDocReq.value;

    document.forms[0].screen_trfAmendAddConditions.value = glb_trfAmendAddConditions;
    document.forms[0].hidden_trfAmendAddConditions.value = glb_trfAmendAddConditions;
    var screen_trfAmendAddConditions = document.forms[0].screen_trfAmendAddConditions.value;

    setToCustom();

    //return true;




}

function setCustomFldFromSearcher(objButton) {
    var objForm = document.forms[0];

    var moduleId = document.getElementById("moduleId").value;
    var textId = document.getElementById("textId").value;
    var textType = document.getElementById("textType").value;
    var inputNameValues = "moduleId|" + moduleId + "|textId|" + textId + "|textType|" + textType;
    var outputNames = "";

    if (textId != null && textId != undefined && textId != "")
    {
    	var scrName = "getCustomTagValue.scr";
    	var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        if (retVal == "" || retVal == null || retVal == undefined)
        {
                return;
        }
    	// var output = retVal.split("|");
    	// res0 = output[0];
    	// res1 = output[1];
  
     
	var  output = retVal.split("|");
    	var  outputsize = output.length;
    	//alert("output length:"+output);

        counter = 1;
        var out_res = "";
        //alert(counter);
        while (counter < outputsize)
        {
                var res = output[counter];
                out_res = out_res + res;
		counter = counter + 2;
        }

        if (out_res == "" || out_res == null || out_res == undefined)
        {
                return;
        }
	var res1 = out_res;
   
        if (objButton.id == "scLnk40") {
            document.forms[0].screen_trfAmendDocReq.value = res1;
            document.forms[0].hidden_trfAmendDocReq.value = res1;

        }
        else if (objButton.id == "scLnk41") {
            document.forms[0].screen_trfAmendAddConditions.value = res1;
            document.forms[0].hidden_trfAmendAddConditions.value = res1;
        }
	else {}
        getDcInfoVal();

    	setToCustom();
    	document.forms[0].moduleId.value = "";
    	document.forms[0].textId.value = "";
    	document.forms[0].textType.value = "";
    	doSubmitForm("narrativeDesc");
    	setToCustom();
    }
}

</SCRIPT>
