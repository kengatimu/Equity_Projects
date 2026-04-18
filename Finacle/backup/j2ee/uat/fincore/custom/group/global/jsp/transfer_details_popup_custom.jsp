<!----------------------------------------------------------------------------------------------------->
<!--   File                           : transfer_details_popup_custom.jsp
<!--   Description                    : Custom jsp for idcm transfer dc details tab (SWIFT 2018).
<!--   Author                         : Ekta Shrivastava.
<!--   SNo         Date                               Author Name                          Description
<!--   001         27 July 2018                       EKTA SHRIVASTAVA                    Initial Version
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
<%@ page import="java.util.List" %>
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
        String hidden_trfDocReq = (String) ARJspCurr.getInput("hidden_trfDocReq", "");
        String screen_trfDocReq = (String) ARJspCurr.getInput("screen_trfDocReq", "");
        ARJspCurr.setInput("hidden_trfDocReq", hidden_trfDocReq);
        ARJspCurr.setInput("screen_trfDocReq", hidden_trfDocReq);

        String hidden_trfAddConditions = (String) ARJspCurr.getInput("hidden_trfAddConditions", "");
        String screen_trfAddConditions = (String) ARJspCurr.getInput("screen_trfAddConditions", "");
        ARJspCurr.setInput("hidden_trfAddConditions", hidden_trfAddConditions);
        ARJspCurr.setInput("screen_trfAddConditions", hidden_trfAddConditions);

        String sCurrCount = (String) ARJspCurr.getInputWithGroup("dcTransfer_CurrCount", "0");
        int iCurrentPos = 0;
        if (sCurrCount != null && !("".equals(sCurrCount.trim()))) {
            iCurrentPos = Integer.parseInt(sCurrCount);
        }
        int iSerialNo = Integer.parseInt(sCurrCount) + 1;

        String[] custData1 = (String[]) ARJspCurr.getInput(com.infy.bbu.ons.common.CommonConstants.KEY_CUSTOM_DATA, null);
        System.out.println("custData1 transfer " + custData1[0]);
        if (custData1 == null) {
            custData1 = new String[1];
            custData1[0] = "";
        } else {
            String[] result = CommonFunctions.split(custData1[0], '|');

            ARJspCurr.setInput("hidden_trfDocReq", "");
            ARJspCurr.setInput("hidden_trfAddConditions", "");
            String tag201value = "";
            String sdcTrNumGenTypeCust = (String) ARJspCurr.getInputWithGroup("dcTrNumGenType", "");
            String transferDcNumCust = (String) ARJspCurr.getInputWithGroup("transferDcNum", "");
            System.out.println("sdcTrNumGenTypeCust = " + sdcTrNumGenTypeCust);
            System.out.println("transferDcNumCust = " + transferDcNumCust);
            if (sdcTrNumGenTypeCust.equals("U")) {
                tag201value = transferDcNumCust;
            } else {
                tag201value = sCurrCount;
            }


            String pageId1 = "~transfer_details_popup";
            System.out.println("tag201value = " + tag201value);
            System.out.println("result = " + custData1);
            if (!(tag201value == null || "".equals(tag201value.trim()))) {
                System.out.println("result length " + result.length);
                System.out.println("result[0] " + result[0]);
                System.out.println("result [1] " + result[1]);
                System.out.println("result[2]  " + result[2]);
                System.out.println("result[3] " + result[3]);
                System.out.println("result[4]  " + result[4]);
                System.out.println("result[5] " + result[5]);
                System.out.println("result[6] " + result[6]);
                System.out.println("result[7] " + result[7]);
                System.out.println("result[8]  " + result[8]);
                System.out.println("result[9]  " + result[9]);
                System.out.println("result[10] " + result[10]);
                System.out.println("result[11]  " + result[11]);
                System.out.println("result[12] " + result[12]);
                System.out.println("result[13]  " + result[13]);
                System.out.println("result[14] " + result[14]);
                System.out.println("result[15] " + result[15]);
                System.out.println("result[16]  " + result[16]);

                for (int i = 0; i < result.length; i++) {
                    System.out.println("inside for loop");
                    System.out.println("i =" + i);
                    System.out.println("result[i] =[" + result[i] + "]");
                    if (result[i].equals(pageId1)) {
                        System.out.println("Inside If  of page");
                        String trfDcCustVal = result[i + 5].trim();
                        trfDcCustVal = trfDcCustVal + " ";
                        System.out.println("trfDcCustVal = [" + trfDcCustVal + "]");

                        String[] trfDcCustValArr = trfDcCustVal.split("\\^\\^\\^\\^\\^");
                        System.out.println(Arrays.toString(trfDcCustValArr));
                        System.out.println("trfDcCustValArr length= " + trfDcCustValArr.length);
                        System.out.println("trfDcCustValArr value= " + trfDcCustValArr[0]);

                        for (int k = 0; k < trfDcCustValArr.length; k++) {
                            if (trfDcCustValArr[k].equals(tag201value)) {

                                String glb_trfDocReq = trfDcCustValArr[k + 1];

                                String glb_trfAddConditions = trfDcCustValArr[k + 2];

                                if (k + 1 < trfDcCustValArr.length) {

                                    ARJspCurr.setInput("hidden_trfDocReq", glb_trfDocReq);
                                }
                                if (k + 2 < trfDcCustValArr.length) {

                                    ARJspCurr.setInput("hidden_trfAddConditions", glb_trfAddConditions);
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
var sCurrCount = '<%=ParseValue.checkString(iSerialNo)%>';

with (document)
{
	write('<input type="hidden" id="hidden_trfDocReq"   name="hidden_trfDocReq">');
	write('<input type="hidden" id="hidden_trfAddConditions" name="hidden_trfAddConditions">');
	write('<input type="hidden" id="hidden_trfDcInfo" name="hidden_trfDcInfo">');

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
	write('<input type="text"   class ="textfieldfont" disabled = "true" hotKeyId="search1" id="screen_trfDocReq" maxlength = "45500"  name="screen_trfDocReq" >&nbsp;');

	write("&nbsp;");
	write("<a id=\"scLnk5\" href=\"javascript:showDynSearcher('HTFCTXT','text_type=D|module_id=DOCCR',':moduleId=module_id|:textId=text_id|:textType=text_type');javascript:setCustomFldFromSearcher(scLnk5);\">");
	write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search6"></a>');

	write('<a id="tLnik1"  href="javascript:chkValidate(tLnik1);">');
	write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
	write('</td>');
	write('<td class="textlabel" >Additional Conditions </td>');
	write('<td class="textfield">');
	write('<input type="text" class ="textfieldfont" disabled = "true" hotKeyId="search1" id="screen_trfAddConditions" maxlength = "45500"  name="screen_trfAddConditions" >&nbsp;');
	write("&nbsp;");
	write("<a id=\"scLnk6\" href=\"javascript:showDynSearcher('HTFCTXT','text_type=C|module_id=DOCCR',':moduleId=module_id|:textId=text_id|:textType=text_type');javascript:setCustomFldFromSearcher(scLnk6);\">");
	write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search7"></a>');

	write('<a id="tLnik2"  href="javascript:chkValidate(tLnik2);">');
	write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
	write('</td>');
	write('</tr>');
	write('</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="page-heading" colspan="2" style="height: 15px; color: #1068c2" id = "trfDcInFo">&nbsp;Transfer DC Info</td>');
	write('<td class="textfield"></td>');
	write('</tr>');
	write('<br>')
	write('<td class="textlabel" colspan="2" id = "trfDcInFoField">Transfer DC Info</td>');
	write('<td>');
	write('<input type="text" class ="textfieldfont" disabled = "true" hotKeyId="search1" id="screen_trfDcInfo" maxlength = "455000"  name="screen_trfDcInfo">&nbsp;');
	//	write('<a id="tdLnik1"  href="javascript:showTextAreaTemp(tdLnik1);">');
	//	write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
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
	setFieldsToCustomData("screen_trfDocReq", "hidden_trfDocReq", "screen_trfAddConditions", "hidden_trfAddConditions", "screen_trfDcInfo", "hidden_trfDcInfo");
}

var glb_trfDocReq;
var glb_trfAddConditions;
function chkValidate(obj) {
    if (dcTrNumGenType == "U") {
        if (document.forms[0].transferDcNum.value == "") {
            alert("Enter Transfer DC number ");
            //return false;
        } else {
            showTextAreaTemp(obj);
        }

    } else {

        if (document.forms[0].bankCode.value == "") {
            alert("Enter BankCode");
        } else {
            showTextAreaTemp(obj);
        }
    }
}

function showTextAreaTemp(objButton) {


    if (funcCode == "Q" || (funcCode == "M" && (dcEventType == 'Q'))) {
        if (objButton.id == "tLnik1") {
            var ret = showTextArea('hidden_trfDocReq', '', 'N', 'left', 'U', 'N', 65, 800, 'string', 'Y', 'Y', 'Z');
        } else if (objButton.id == "tLnik2") {
            var ret = showTextArea('hidden_trfAddConditions', '', 'N', 'left', 'U', 'N', 65, 800, 'string', 'Y', 'Y', 'Z');
        } else {}
    } else {
        if (objButton.id == "tLnik1") {
            var ret = showTextArea('hidden_trfDocReq', '', 'N', 'left', 'U', 'N', 65, 800, 'string', 'N', 'Y', 'Z');
        } else if (objButton.id == "tLnik2") {
            var ret = showTextArea('hidden_trfAddConditions', '', 'N', 'left', 'U', 'N', 65, 800, 'string', 'N', 'Y', 'Z');
        } else {}
    }

	if (ret != null && ret != undefined) {
    	ret = decodeURIComponent(ret);
    	//ret = decodeURIComponent(ret);
	}

    if (objButton.id == "tLnik1") {
        if (window.showModalDialog) {
            if (ret != null && ret != undefined) {
                document.forms[0].screen_trfDocReq.value = ret;
                document.forms[0].hidden_trfDocReq.value = ret;
                setToCustom();
            }
        }
    } else if (objButton.id == "tLnik2") {
        if (window.showModalDialog) {
            if (ret != null && ret != undefined) {
                document.forms[0].screen_trfAddConditions.value = ret;
                document.forms[0].hidden_trfAddConditions.value = ret;
                setToCustom();
            }
        }
    } else {}



}


function getJavaValue() {
    glb_trfDocReq = "<%=ParseValue.checkString(hidden_trfDocReq)%>";
    glb_trfAddConditions = "<%=ParseValue.checkString(hidden_trfAddConditions)%>";
}


function transfer_details_popup_post_ONLOAD() {
    //alert("Inside Post Onload");
	
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
			document.forms[0].screen_trfDocReq.value  = "";
			document.forms[0].hidden_trfDocReq.value  = "";
			document.forms[0].screen_trfAddConditions.value  = "";
			document.forms[0].hidden_trfAddConditions.value  = "";
			document.forms[0].screen_trfDcInfo.value  = "";
			document.forms[0].hidden_trfDcInfo.value  = "";
			document.forms[0].screen_trfDocReq.disabled = true;
			document.forms[0].screen_trfAddConditions.disabled = true;
			document.forms[0].screen_trfDcInfo.disabled = true;
			hideImage("tLnik1");
			hideImage("tLnik2");
			hideImage("scLnk5");
			hideImage("scLnk6");
			
			
		}
    hideImage("trfDcInFo");
    hideImage("screen_trfDcInfo");
    hideImage("trfDcInFoField");

    //alert("inside onload");
    //alert("funcCode"+funcCode);

    if (funcCode == "Q") {

        //alert("inside Q");
        getFieldsFromCustomData("screen_trfDocReq", "hidden_trfDocReq", "screen_trfAddConditions", "hidden_trfAddConditions", "screen_trfDcInfo", "hidden_trfDcInfo");
        objForm = document.forms[0];
        //alert("document.forms[0].hidden_trfDcInfo.value"+document.forms[0].hidden_trfDcInfo.value);
        if (document.forms[0].hidden_trfDcInfo.value != "") {
            //alert("document.forms[0].transferDcNum.value "+document.forms[0].transferDcNum.value);
            if (document.forms[0].transferDcNum.value == "") {
                //alert("dcTrNumGenType"+dcTrNumGenType);
                if (dcTrNumGenType == "U") {
                    //alert("inside U");
                    //alert("document.forms[0].screen_trfDocReq.value"+document.forms[0].screen_trfDocReq.value);
                    //alert("document.forms[0].hidden_trfDocReq.value"+document.forms[0].hidden_trfDocReq.value);
                    //alert("document.forms[0].screen_trfAddConditions.value"+document.forms[0].screen_trfAddConditions.value);
                    //alert("document.forms[0].hidden_trfAddConditions.value"+document.forms[0].hidden_trfAddConditions.value);
                    document.forms[0].screen_trfDocReq.value = "";
                    document.forms[0].hidden_trfDocReq.value = "";
                    document.forms[0].screen_trfAddConditions.value = "";
                    document.forms[0].hidden_trfAddConditions.value = "";
                    setToCustom();
                    getFieldsFromCustomData("screen_trfDocReq", "hidden_trfDocReq", "screen_trfAddConditions", "hidden_trfAddConditions", "screen_trfDcInfo", "hidden_trfDcInfo");
                } else {
                    //alert("inside else");
                    var s = "^^^^^" + sCurrCount + "^^^^^";
                    //alert("s"+s);
                    var chkVal = document.forms[0].hidden_trfDcInfo.value.indexOf(s);
                    //alert("chkVal"+chkVal);
                    if (chkVal >= 0)

                    {
                        //alert("document.forms[0].hidden_trfDcInfo.value"+document.forms[0].hidden_trfDcInfo.value);
                        var CustValues = document.forms[0].hidden_trfDcInfo.value.split("^^^^^");

                        var i;
                        //alert("CustValues.length"+CustValues.length);
                        for (i = 0; i < CustValues.length; i++) {
                            if (CustValues[i] == sCurrCount) {

                                document.forms[0].screen_trfDocReq.value = CustValues[i + 1];
                                document.forms[0].hidden_trfDocReq.value = CustValues[i + 1];
                                document.forms[0].screen_trfAddConditions.value = CustValues[i + 2];
                                document.forms[0].screen_trfAddConditions.value = CustValues[i + 2];
                                //alert("document.forms[0].screen_trfDocReq.value"+document.forms[0].screen_trfDocReq.value);
                                //alert("document.forms[0].hidden_trfDocReq.value"+document.forms[0].hidden_trfDocReq.value);
                                //alert("document.forms[0].screen_trfAddConditions.value"+document.forms[0].screen_trfAddConditions.value);
                                //alert("document.forms[0].hidden_trfAddConditions.value"+document.forms[0].hidden_trfAddConditions.value);
                		setToCustom();
                                getFieldsFromCustomData("screen_trfDocReq", "hidden_trfDocReq", "screen_trfAddConditions", "hidden_trfAddConditions", "screen_trfDcInfo", "hidden_trfDcInfo");
                            }
                        }
                    } else {
                        //alert("document.forms[0].screen_trfDocReq.value"+document.forms[0].screen_trfDocReq.value);
                        //alert("document.forms[0].hidden_trfDocReq.value"+document.forms[0].hidden_trfDocReq.value);
                        //alert("document.forms[0].screen_trfAddConditions.value"+document.forms[0].screen_trfAddConditions.value);
                        //alert("document.forms[0].hidden_trfAddConditions.value"+document.forms[0].hidden_trfAddConditions.value);
                        document.forms[0].screen_trfDocReq.value = "";
                        document.forms[0].hidden_trfDocReq.value = "";
                        document.forms[0].screen_trfAddConditions.value = "";
                        document.forms[0].hidden_trfAddConditions.value = "";
                	setToCustom();
                        getFieldsFromCustomData("screen_trfDocReq", "hidden_trfDocReq", "screen_trfAddConditions", "hidden_trfAddConditions", "screen_trfDcInfo", "hidden_trfDcInfo");

                    }

                }
            } else {
                //alert(dcTrNumGenType);
                if (dcTrNumGenType == "U") {
                    var s = "^^^^^" + document.forms[0].transferDcNum.value.toUpperCase() + "^^^^^";
                    //alert("s"+s);
                } else {
                    var s = "^^^^^" + sCurrCount + "^^^^^";
                    //alert("s inside else"+s);
                }


                var chkVal = document.forms[0].hidden_trfDcInfo.value.indexOf(s);
                //alert("chkVal"+chkVal);
                if (chkVal >= 0) {
                    //alert(document.forms[0].hidden_trfDcInfo.value);
                    var CustValues = document.forms[0].hidden_trfDcInfo.value.split("^^^^^");
                    //alert("CustValues.length"+CustValues.length);
                    var i;
                    for (i = 0; i < CustValues.length; i++) {
                        if (CustValues[i] == document.forms[0].transferDcNum.value.toUpperCase()) {
                            //alert("inside if at line no 492");
                            document.forms[0].screen_trfDocReq.value = CustValues[i + 1];
                            document.forms[0].hidden_trfDocReq.value = CustValues[i + 1];
                            document.forms[0].screen_trfAddConditions.value = CustValues[i + 2];
                            document.forms[0].screen_trfAddConditions.value = CustValues[i + 2];
                            //alert("document.forms[0].screen_trfDocReq.value"+document.forms[0].screen_trfDocReq.value);
                            //alert("document.forms[0].hidden_trfDocReq.value"+document.forms[0].hidden_trfDocReq.value);
                            //alert("document.forms[0].screen_trfAddConditions.value"+document.forms[0].screen_trfAddConditions.value);
                            //alert("document.forms[0].hidden_trfAddConditions.value"+document.forms[0].hidden_trfAddConditions.value);

                	    setToCustom();
                            getFieldsFromCustomData("screen_trfDocReq", "hidden_trfDocReq", "screen_trfAddConditions", "hidden_trfAddConditions", "screen_trfDcInfo", "hidden_trfDcInfo");

                        }
                        if (CustValues[i] == sCurrCount) {
                            document.forms[0].screen_trfDocReq.value = CustValues[i + 1];
                            document.forms[0].hidden_trfDocReq.value = CustValues[i + 1];
                            document.forms[0].screen_trfAddConditions.value = CustValues[i + 2];
                            document.forms[0].screen_trfAddConditions.value = CustValues[i + 2];
                            //alert("document.forms[0].screen_trfDocReq.value"+document.forms[0].screen_trfDocReq.value);
                            //alert("document.forms[0].hidden_trfDocReq.value"+document.forms[0].hidden_trfDocReq.value);
                            //alert("document.forms[0].screen_trfAddConditions.value"+document.forms[0].screen_trfAddConditions.value);
                            //alert("document.forms[0].hidden_trfAddConditions.value"+document.forms[0].hidden_trfAddConditions.value);

                	    setToCustom();
                            getFieldsFromCustomData("screen_trfDocReq", "hidden_trfDocReq", "screen_trfAddConditions", "hidden_trfAddConditions", "screen_trfDcInfo", "hidden_trfDcInfo");

                        }
                    }

                } else {
                    getJavaValue();

                    document.forms[0].screen_trfDocReq.value = glb_trfDocReq;
                    document.forms[0].hidden_trfDocReq.value = glb_trfDocReq;
                    document.forms[0].screen_trfAddConditions.value = glb_trfAddConditions;
                    document.forms[0].hidden_trfAddConditions.value = glb_trfAddConditions;
                    //alert("document.forms[0].screen_trfDocReq.value"+document.forms[0].screen_trfDocReq.value);
                    //alert("document.forms[0].hidden_trfDocReq.value"+document.forms[0].hidden_trfDocReq.value);
                    //alert("document.forms[0].screen_trfAddConditions.value"+document.forms[0].screen_trfAddConditions.value);
                    //alert("document.forms[0].hidden_trfAddConditions.value"+document.forms[0].hidden_trfAddConditions.value);
                }
                setToCustom();
                getFieldsFromCustomData("screen_trfDocReq", "hidden_trfDocReq", "screen_trfAddConditions", "hidden_trfAddConditions", "screen_trfDcInfo", "hidden_trfDcInfo");
            }
        } else {
            getJavaValue();
            document.forms[0].screen_trfDocReq.value = glb_trfDocReq;
            document.forms[0].hidden_trfDocReq.value = glb_trfDocReq;
            document.forms[0].screen_trfAddConditions.value = glb_trfAddConditions;
            document.forms[0].hidden_trfAddConditions.value = glb_trfAddConditions;
            //alert("document.forms[0].screen_trfDocReq.value"+document.forms[0].screen_trfDocReq.value);
            //alert("document.forms[0].hidden_trfDocReq.value"+document.forms[0].hidden_trfDocReq.value);
            //alert("document.forms[0].screen_trfAddConditions.value"+document.forms[0].screen_trfAddConditions.value);
            //alert("document.forms[0].hidden_trfAddConditions.value"+document.forms[0].hidden_trfAddConditions.value);
        }

        setToCustom();
        getFieldsFromCustomData("screen_trfDocReq", "hidden_trfDocReq", "screen_trfAddConditions", "hidden_trfAddConditions", "screen_trfDcInfo", "hidden_trfDcInfo");
    } else {

        var CustValues = new Array();
        CustValues = document.forms[0].customData.value.split("|");
        var pageId = "~transfer_details_popup";
        for (var i = 0; i <= CustValues.length; i++) {
            if (CustValues[i] == pageId) {
                var trfDcCustVal = CustValues[i + 5];
                document.forms[0].screen_trfDcInfo.value = trfDcCustVal;
                document.forms[0].hidden_trfDcInfo.value = trfDcCustVal;

                var trfDcCustValArr = new Array();

                trfDcCustValArr = trfDcCustVal.split("^^^^^");
                for (var k = 0; k <= trfDcCustValArr.length; k++) {
                    if (trfDcCustValArr[k] == document.forms[0].transferDcNum.value) {
                        document.forms[0].screen_trfDocReq.value = trfDcCustValArr[k + 1];
                        document.forms[0].hidden_trfDocReq.value = trfDcCustValArr[k + 1];
                        document.forms[0].screen_trfAddConditions.value = trfDcCustValArr[k + 2];
                        document.forms[0].hidden_trfAddConditions.value = trfDcCustValArr[k + 2];
                    }

                }
            }
        }
    }
}

function transfer_details_popup_pre_ONCLICK(obj) {

    var objForm = document.forms[0];

    if (funcCode == "Q") {
        if (obj.id == "Accept") {
            getJavaValue();
            getDcInfoVal();
        }

    } else {
        setToCustom();
    }
}

function getDcInfoVal() {
    if (dcTrNumGenType == "U") {
        var s = "^^^^^" + document.forms[0].transferDcNum.value.toUpperCase() + "^^^^^";
    } else {
        var s = "^^^^^" + sCurrCount + "^^^^^";
        //alert("s"+s);
    }
    if (document.forms[0].hidden_trfDcInfo.value != "") {
        //alert("inside if...");
        var index = document.forms[0].hidden_trfDcInfo.value.indexOf(s);
        if (index < 0) {
            if (dcTrNumGenType == "U") {
                document.forms[0].hidden_trfDcInfo.value = document.forms[0].hidden_trfDcInfo.value + "^^^^^" + document.forms[0].transferDcNum.value.toUpperCase() + "^^^^^" + document.forms[0].hidden_trfDocReq.value + "^^^^^" + document.forms[0].hidden_trfAddConditions.value;
            } else {

                document.forms[0].hidden_trfDcInfo.value = document.forms[0].hidden_trfDcInfo.value + "^^^^^" + sCurrCount + "^^^^^" + document.forms[0].hidden_trfDocReq.value + "^^^^^" + document.forms[0].hidden_trfAddConditions.value;
            }
        } else {
            if (dcTrNumGenType == "U") {

                var orgStr = document.forms[0].hidden_trfDcInfo.value;
                var strVar = "^^^^^" + document.forms[0].transferDcNum.value.toUpperCase();
                var strIndex = document.forms[0].hidden_trfDcInfo.value.indexOf(strVar);

                var strPreString = document.forms[0].hidden_trfDcInfo.value.substring(0, strIndex);
                var strLen = document.forms[0].hidden_trfDcInfo.value.length;
				// Add last 5 characters as separator, so that the for loop can behave correctly
                var tempPostStr = document.forms[0].hidden_trfDcInfo.value.substring(strIndex, strLen) + "^^^^^";
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
                document.forms[0].hidden_trfDcInfo.value = strPreString + "^^^^^" + document.forms[0].transferDcNum.value.toUpperCase() + "^^^^^" + document.forms[0].screen_trfDocReq.value + "^^^^^" + document.forms[0].screen_trfAddConditions.value + postStr;
            } else {
                var orgStr = document.forms[0].hidden_trfDcInfo.value;
                var strVar = "^^^^^" + sCurrCount;
                var strIndex = document.forms[0].hidden_trfDcInfo.value.indexOf(strVar);
                var strPreString = document.forms[0].hidden_trfDcInfo.value.substring(0, strIndex);
                var strLen = document.forms[0].hidden_trfDcInfo.value.length;
				// Add last 5 characters as separator, so that the for loop can behave correctly
                var tempPostStr = document.forms[0].hidden_trfDcInfo.value.substring(strIndex, strLen) + "^^^^^";
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
                document.forms[0].hidden_trfDcInfo.value = strPreString + "^^^^^" + sCurrCount + "^^^^^" + document.forms[0].screen_trfDocReq.value + "^^^^^" + document.forms[0].screen_trfAddConditions.value + postStr;
            }

        }
    } else {
        //alert("inside else");
        if (dcTrNumGenType == "U") {

            document.forms[0].hidden_trfDcInfo.value = document.forms[0].hidden_trfDcInfo.value + "^^^^^" + document.forms[0].transferDcNum.value.toUpperCase() + "^^^^^" + document.forms[0].hidden_trfDocReq.value + "^^^^^" + document.forms[0].hidden_trfAddConditions.value;
            //alert("document.forms[0].hidden_trfDcInfo.value "+ document.forms[0].hidden_trfDcInfo.value);
            //alert("Inside getDcInfoValue:" + document.forms[0].hidden_trfDcInfo.value);
        } else {
            document.forms[0].hidden_trfDcInfo.value = document.forms[0].hidden_trfDcInfo.value + "^^^^^" + sCurrCount + "^^^^^" + document.forms[0].hidden_trfDocReq.value + "^^^^^" + document.forms[0].hidden_trfAddConditions.value;
        }
    }


    document.forms[0].screen_trfDcInfo.value = document.forms[0].hidden_trfDcInfo.value;

    var screen_trfDcInfo = document.forms[0].screen_trfDcInfo.value;
    setToCustom();

    return;
}

function transfer_details_popup_pre_TAB_SWITCH(obj) {

    getJavaValue();
    document.forms[0].screen_trfDocReq.value = glb_trfDocReq;
    document.forms[0].hidden_trfDocReq.value = glb_trfDocReq;
    var screen_trfDocReq = document.forms[0].screen_trfDocReq.value;

    document.forms[0].screen_trfAddConditions.value = glb_trfAddConditions;
    document.forms[0].hidden_trfAddConditions.value = glb_trfAddConditions;
    var screen_trfAddConditions = document.forms[0].screen_trfAddConditions.value;

    setToCustom();
    return true;


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
    	//var output = retVal.split("|");
    	//res0 = output[0];
    	//res1 = output[1];
    
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
    
        if (objButton.id == "scLnk5") {
            //alert("inside 1st loop");
            document.forms[0].screen_trfDocReq.value = res1;
            document.forms[0].hidden_trfDocReq.value = res1;
        }
        else if (objButton.id == "scLnk6") {
            //alert("inside 2nd loop");
            document.forms[0].screen_trfAddConditions.value = res1;
            document.forms[0].hidden_trfAddConditions.value = res1;

        }
	else { }

        getDcInfoVal();

    	setToCustom();
    	document.forms[0].moduleId.value = "";
    	document.forms[0].textId.value = "";
    	document.forms[0].textType.value = "";

    	doSubmitForm("docRequiredDesc");

    	setToCustom();
    }
}

</SCRIPT>

