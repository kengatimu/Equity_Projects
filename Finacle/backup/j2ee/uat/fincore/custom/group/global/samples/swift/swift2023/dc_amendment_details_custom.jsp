<!----------------------------------------------------------------------------------------------------->
<!--   File                           : dc_amendment_details_custom.jsp
<!--   Description                    : Custom jsp for dc amendment details tab (SWIFT 2018).
<!--   Author                         : Ekta Shrivastava.
<!--   SNo         Date                               Author Name                          Description
<!--   001         19 June 2018                       Ekta Shrivastava.                    Initial Version
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
<%@ page import="java.util.List" %>
<%@ page import="java.security.PrivilegedAction" %>
<%@ page import="java.security.AccessController" %>


<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<%@ include file="/custom/commonInclude.jsp" %>

<SCRIPT language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("common_functions.js",sProfileId)%>"></SCRIPT>
<SCRIPT language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("session.js",sProfileId)%>"></SCRIPT> 
<script language="javascript" src="../Renderer/javascripts/lists/<%=VRPKeys.getFile("showTextArea.js",sProfileId)%>"></script>

<%
ContextManager ARJspCurr = (ContextManager) session.getAttribute("CustomARJspCurr");
String sSubGrpName = (String) ARJspCurr.getInput("subGroupName", "");
String sGroupName = ARJspCurr.getCurrentGroup();

String hidden_amendGoodsDesc = (String) ARJspCurr.getInput("hidden_amendGoodsDesc", "");
String screen_amendDescGoodsServ = (String) ARJspCurr.getInput("screen_amendDescGoodsServ", "");
ARJspCurr.setInput("hidden_amendGoodsDesc", hidden_amendGoodsDesc);
ARJspCurr.setInput("screen_amendDescGoodsServ", hidden_amendGoodsDesc);

String hidden_amendDocReq = (String) ARJspCurr.getInput("hidden_amendDocReq", "");
String screen_amendDocReq = (String) ARJspCurr.getInput("screen_amendDocReq", "");
ARJspCurr.setInput("hidden_amendDocReq", hidden_amendDocReq);
ARJspCurr.setInput("screen_amendDocReq", hidden_amendDocReq);

String hidden_amendAddConditions = (String) ARJspCurr.getInput("hidden_amendAddConditions", "");
String screen_amendAddConditions = (String) ARJspCurr.getInput("screen_amendAddConditions", "");
ARJspCurr.setInput("hidden_amendAddConditions", hidden_amendAddConditions);
ARJspCurr.setInput("screen_amendAddConditions", hidden_amendAddConditions);

String hidden_amendSpcPaymentConForBenf = (String) ARJspCurr.getInput("hidden_amendSpcPaymentConForBenf", "");
String screen_amendSpcPaymentConForBenf = (String) ARJspCurr.getInput("screen_amendSpcPaymentConForBenf", "");
ARJspCurr.setInput("hidden_amendSpcPaymentConForBenf", hidden_amendSpcPaymentConForBenf);
ARJspCurr.setInput("screen_amendSpcPaymentConForBenf", hidden_amendSpcPaymentConForBenf);

String hidden_amendSpecPaymentConForRecBank = (String) ARJspCurr.getInput("hidden_amendSpecPaymentConForRecBank", "");
String screen_amendSpecPaymentConForRecBank = (String) ARJspCurr.getInput("screen_amendSpecPaymentConForRecBank", "");
ARJspCurr.setInput("hidden_amendSpecPaymentConForRecBank", hidden_amendSpecPaymentConForRecBank);
ARJspCurr.setInput("screen_amendSpecPaymentConForRecBank", hidden_amendSpecPaymentConForRecBank);

String chkStandBy_value = (String) ARJspCurr.getInput(sSubGrpName + ".chkStandBy", "");

String hidden_amdPlaceIfChrg = (String) ARJspCurr.getInput("hidden_amdPlaceIfChrg", "");
String screen_amdPlaceIfChrg = (String) ARJspCurr.getInput("screen_amdPlaceIfChrg", "");
ARJspCurr.setInput("hidden_amdPlaceIfChrg", hidden_amdPlaceIfChrg);
ARJspCurr.setInput("screen_amdPlaceIfChrg", hidden_amdPlaceIfChrg);

String hidden_amdPortOfLoading = (String) ARJspCurr.getInput("hidden_amdPortOfLoading", "");
String screen_amdPortOfLoading = (String) ARJspCurr.getInput("screen_amdPortOfLoading", "");
ARJspCurr.setInput("hidden_amdPortOfLoading", hidden_amdPortOfLoading);
ARJspCurr.setInput("screen_amdPortOfLoading", hidden_amdPortOfLoading);

String hidden_amdPortOfDischarge = (String) ARJspCurr.getInput("hidden_amdPortOfDischarge", "");
String screen_amdPortOfDischarge = (String) ARJspCurr.getInput("screen_amdPortOfDischarge", "");
ARJspCurr.setInput("hidden_amdPortOfDischarge", hidden_amdPortOfDischarge);
ARJspCurr.setInput("screen_amdPortOfDischarge", hidden_amdPortOfDischarge);

String hidden_amdPlaceForFinalDest = (String) ARJspCurr.getInput("hidden_amdPlaceForFinalDest", "");
String screen_amdPlaceForFinalDest = (String) ARJspCurr.getInput("screen_amdPlaceForFinalDest", "");
ARJspCurr.setInput("hidden_amdPlaceForFinalDest", hidden_amdPlaceForFinalDest);
ARJspCurr.setInput("screen_amdPlaceForFinalDest", hidden_amdPlaceForFinalDest);

String[] custData1 = (String[]) ARJspCurr.getInput(com.infy.bbu.ons.common.CommonConstants.KEY_CUSTOM_DATA, null);
if (custData1 == null) {
    custData1 = new String[1];
    custData1[0] = "";
} else {
    String[] result = CommonFunctions.split(custData1[0], '|');
    int dcIndex = Arrays.asList(result).indexOf("~dc_amendment_details");
    if (dcIndex >= 0) {

        hidden_amendGoodsDesc = result[dcIndex + 1];
        ARJspCurr.setInput("hidden_amendGoodsDesc", result[dcIndex + 1]);
        ARJspCurr.setInput("screen_amendDescGoodsServ", result[dcIndex + 1]);

        hidden_amendDocReq = result[dcIndex + 3];
        ARJspCurr.setInput("hidden_amendDocReq", result[dcIndex + 3]);
        ARJspCurr.setInput("screen_amendDocReq", result[dcIndex + 3]);

        hidden_amendAddConditions = result[dcIndex + 5];
        ARJspCurr.setInput("hidden_amendAddConditions", result[dcIndex + 5]);
        ARJspCurr.setInput("screen_amendAddConditions", result[dcIndex + 5]);

        hidden_amendSpcPaymentConForBenf = result[dcIndex + 7];
        ARJspCurr.setInput("hidden_amendSpcPaymentConForBenf", result[dcIndex + 7]);
        ARJspCurr.setInput("screen_amendSpcPaymentConForBenf", result[dcIndex + 7]);

        hidden_amendSpecPaymentConForRecBank = result[dcIndex + 9];
        ARJspCurr.setInput("hidden_amendSpecPaymentConForRecBank", result[dcIndex + 9]);
        ARJspCurr.setInput("screen_amendSpecPaymentConForRecBank", result[dcIndex + 9]);

        chkStandBy_value = result[dcIndex + 12];
		
        hidden_amdPlaceIfChrg = result[dcIndex + 13];
        ARJspCurr.setInput("hidden_amdPlaceIfChrg", result[dcIndex + 13]);
        ARJspCurr.setInput("screen_amdPlaceIfChrg", result[dcIndex + 13]);
		
		hidden_amdPortOfLoading = result[dcIndex + 15];
		ARJspCurr.setInput("hidden_amdPortOfLoading", result[dcIndex + 15]);
		ARJspCurr.setInput("screen_amdPortOfLoading", result[dcIndex + 15]);

		hidden_amdPortOfDischarge = result[dcIndex + 17];
		ARJspCurr.setInput("hidden_amdPortOfDischarge", result[dcIndex + 17]);
		ARJspCurr.setInput("screen_amdPortOfDischarge", result[dcIndex + 17]);

		hidden_amdPlaceForFinalDest = result[dcIndex + 19];
		ARJspCurr.setInput("hidden_amdPlaceForFinalDest", result[dcIndex + 19]);
		ARJspCurr.setInput("screen_amdPlaceForFinalDest", result[dcIndex + 19]);
    }
} %>

<SCRIPT language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("common_functions.js",sProfileId)%>"></SCRIPT>
<SCRIPT language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("cust_post_evt.js",sProfileId)%>"></SCRIPT>
<SCRIPT language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("cust_pre_evt.js",sProfileId)%>"></SCRIPT>


<script language="javascript" >
var subGroupName = '<%=ParseValue.checkString(ARJspCurr.getInput("subGroupName",""))%>';
var chkStandBy = '<%=ParseValue.checkString(ARJspCurr.getInput(sSubGrpName+".chkStandBy",""))%>';

with(document) {
    write('<input type="hidden" id="hidden_amendGoodsDesc"   name="hidden_amendGoodsDesc">');
    write('<input type="hidden" id="hidden_amendDocReq" name="hidden_amendDocReq">');
    write('<input type="hidden" id="hidden_amendAddConditions" name="hidden_amendAddConditions">');
    write('<input type="hidden" id="hidden_amendSpcPaymentConForBenf" name="hidden_amendSpcPaymentConForBenf">');
    write('<input type="hidden" id="hidden_amendSpecPaymentConForRecBank" name="hidden_amendSpecPaymentConForRecBank">');
    write('<input type="hidden" id="hidden_amendTag40A" name="hidden_amendTag40A">');
	write('<input type="hidden" id="hidden_amdPlaceIfChrg"   name="hidden_amdPlaceIfChrg">');
	write('<input type="hidden" id="hidden_amdPortOfLoading"   name="hidden_amdPortOfLoading">');
	write('<input type="hidden" id="hidden_amdPortOfDischarge"   name="hidden_amdPortOfDischarge">');
	write('<input type="hidden" id="hidden_amdPlaceForFinalDest"   name="hidden_amdPlaceForFinalDest">');
	if(!(SWIFT2020_ENABLED=="Y" && standByFlg=="Y" && (paysysId=="SWIFT" || paysysId=="")))
    {

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

    write('<td class="textlabel" >Description Of Goods And/Or Services</td>');
    write('<td class="textfield">');

    write('<input type="text" class="textfieldfont" disabled = "true" hotKeyId="search1" id="screen_amendDescGoodsServ" maxlength = "45500"  name="screen_amendDescGoodsServ" >&nbsp;');


    write("&nbsp;");
    write("<a id=\"scLnk47\" href=\"javascript:showDynSearcher('HTFCTXT','text_type=G',':moduleId=module_id|:textId=text_id|:textType=text_type');javascript:setCustomFldFromSearcher(scLnk47);\">");
    write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search3"></a>');

    write('<a id="aLnik25"  href="javascript:showTextAreaTemp(aLnik25);">');
    write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
    write('</td>');

    //write('<td class="columnwidth">&nbsp;</td>');

    write('<td class="textlabel" >Documents Required  </td>');
    write('<td class="textfield">');
    write('<input type="text" class="textfieldfont" disabled = "true" hotKeyId="search1" id="screen_amendDocReq" maxlength = "45500"  name="screen_amendDocReq" >&nbsp;');
    write("&nbsp;");
    write("<a id=\"scLnk48\" href=\"javascript:showDynSearcher('HTFCTXT','text_type=D',':moduleId=module_id|:textId=text_id|:textType=text_type');javascript:setCustomFldFromSearcher(scLnk48);\">");
    write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search4"></a>');
    write('<a id="aLnik26"  href="javascript:showTextAreaTemp(aLnik26);">');
    write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
    write('</td>');
    write('</tr>');

    write('<tr>');

    write('<td class="textlabel" >Additional Conditions </td>');
    write('<td class="textfield">');
    write('<input type="text" class="textfieldfont" disabled = "true" hotKeyId="search1" id="screen_amendAddConditions" maxlength = "45500"  name="screen_amendAddConditions">&nbsp;');
    write("&nbsp;");
    write("<a id=\"scLnk49\" href=\"javascript:showDynSearcher('HTFCTXT','text_type=C',':moduleId=module_id|:textId=text_id|:textType=text_type');javascript:setCustomFldFromSearcher(scLnk49);\">");
    write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search5"></a>');
    write('<a id="aLnik27"  href="javascript:showTextAreaTemp(aLnik27);">');
    write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
    write('</td>');

    //write('<td class="columnwidth">&nbsp;</td>');

    write('<td class="textlabel" >Special Payment Conditions for Beneficiary  </td>');
    write('<td class="textfield">');
    write('<input type="text" class="textfieldfont" disabled = "true" hotKeyId="search1" id="screen_amendSpcPaymentConForBenf" maxlength = "45500"  name="screen_amendSpcPaymentConForBenf" >&nbsp;');
    write("&nbsp;");
    write("<a id=\"scLnk50\" href=\"javascript:showDynSearcher('HTFCTXT','text_type=I',':moduleId=module_id|:textId=text_id|:textType=text_type');javascript:setCustomFldFromSearcher(scLnk50);\">");
    write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search6"></a>');
    write('<a id="aLnik28"  href="javascript:showTextAreaTemp(aLnik28);">');
    write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
    write('</td>');
    write('</tr>');

    write('<tr>');
    write('<td class="textlabel" >Special Payment Conditions for Receiving Bank</td>');
    write('<td class="textfield">');
    write('<input type="text" class="textfieldfont" disabled = "true" hotKeyId="search1" id="screen_amendSpecPaymentConForRecBank" maxlength = "45500"  name = "screen_amendSpecPaymentConForRecBank" >&nbsp;');
    write("&nbsp;");
    write("<a id=\"scLnk51\" href=\"javascript:showDynSearcher('HTFCTXT','text_type=I',':moduleId=module_id|:textId=text_id|:textType=text_type');javascript:setCustomFldFromSearcher(scLnk51);\">");
    write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search7"></a>');
    write('<a id="aLnik29"  href="javascript:showTextAreaTemp(aLnik29);">');
    write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
    write('</td>');

    //write('<td class="columnwidth">&nbsp;</td>');

    write('<td class="textlabel" >StandBy </td>');
    write('<td class="textfielddisplaylabel"><input type="checkbox" id="chkStandBy" name="' + subGroupName + '.chkStandBy"  onClick="javascript:return fnSetData();"></td>');
    write('</tr>');
	
	write('<tr>');
	if(SWIFT2023_ENABLED=="Y" && (paysysId=="SWIFT" || paysysId==""))
	{
	write('<td class="textlabel" >Place of Taking in Charge/Dispatch From/Place of Receipt  </td>');
	}
	else
	{
	write('<td></td>');
	}
	write('<td class="textfield">');
	write('<input type="text" class ="textfieldfont" disabled = "true" hotKeyId="search1" id="screen_amdPlaceIfChrg" maxlength = "140"  name="screen_amdPlaceIfChrg" >&nbsp;');
	write("&nbsp;");
	write('<a id="aLnik30"  href="javascript:showTextAreaTemp(aLnik30);">');
	write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
	write('</td>');
	if(SWIFT2023_ENABLED=="Y" && (paysysId=="SWIFT" || paysysId==""))
	{
	write('<td class="textlabel" >Port of Loading/Airport of Departure </td>');
	}
	else
	{
	write('<td></td>');
	}
	write('<td class="textfield">');
	write('<input type="text" class ="textfieldfont" disabled = "true" hotKeyId="search1" id="screen_amdPortOfLoading" maxlength = "140" name="screen_amdPortOfLoading" >&nbsp;');
	write("&nbsp;");
	write('<a id="aLnik31"  href="javascript:showTextAreaTemp(aLnik31);">');
	write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
	write('</td>');
	write('</tr>');

	write('<tr>');
	if(SWIFT2023_ENABLED=="Y" && (paysysId=="SWIFT" || paysysId==""))
	{
	write('<td class="textlabel" >Port of Discharge/Airport of Destination </td>');
	}
	else
	{
	write('<td></td>');
	}
	write('<td class="textfield">');
	write('<input type="text" class ="textfieldfont" disabled = "true" hotKeyId="search1" id="screen_amdPortOfDischarge" maxlength = "140" name="screen_amdPortOfDischarge" >&nbsp;');
	write("&nbsp;");
	write('<a id="aLnik32"  href="javascript:showTextAreaTemp(aLnik32);">');
	write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
	write('</td>');
	if(SWIFT2023_ENABLED=="Y" && (paysysId=="SWIFT" || paysysId==""))
	{
	write('<td class="textlabel" >Place of Final Destination/For Transportation To/Place of Delivery </td>');
	}
	else
	{
	write('<td></td>');
	}
	write('<td class="textfield">');
	write('<input type="text" class ="textfieldfont" disabled = "true" hotKeyId="search1" id="screen_amdPlaceForFinalDest" maxlength = "140"  name="screen_amdPlaceForFinalDest" >&nbsp;');
	write("&nbsp;");
	write('<a id="aLnik33"  href="javascript:showTextAreaTemp(aLnik33);">');
	write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
	write('</td>');
	write('</tr>');
	
	write('</td>');
    write('</tr>');

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
    write("</table>")

    write('<tr>');
    write('<td>');
    write('</td>');
    write('</tr>');
    write('<br>');
	}

}

function setToCustom() {
setFieldsToCustomData("screen_amendDescGoodsServ", "hidden_amendGoodsDesc", "screen_amendDocReq", "hidden_amendDocReq", "screen_amendAddConditions", "hidden_amendAddConditions", "screen_amendSpcPaymentConForBenf", "hidden_amendSpcPaymentConForBenf", "screen_amendSpecPaymentConForRecBank", "hidden_amendSpecPaymentConForRecBank", "hidden_amendTag40A", "chkStandBy","screen_amdPlaceIfChrg","hidden_amdPlaceIfChrg","screen_amdPortOfLoading","hidden_amdPortOfLoading","screen_amdPortOfDischarge","hidden_amdPortOfDischarge","screen_amdPlaceForFinalDest","hidden_amdPlaceForFinalDest");
}

var glb_amendgoodsDesc;
var glb_amendDocReq;
var glb_amendAddConditions;
var glb_amendSpcPaymentConForBenf;
var glb_amendSpecPaymentConForRecBank;
var glb_dcStandBy;
var dcStandBy;
var dcTransferFlg;
var glb_amdPlaceIfChrg;
var glb_amdPortOfLoading;
var glb_amdPortOfDischarge;
var glb_amdPlaceForFinalDest;
function showTextAreaTemp(objButton) {
    ////alert("Inside showTextAreaTemp");

    if ((mopId == "ODCM") || (mopId == "IDCM") || (mopId == "odcm") || (mopId == "idcm")) {
	//if ((funcCode == "A") || (funcCode == "M" && locEventType == "A"))
        if (funcCode == "A" || ((funcCode == "M") && (locEventType != "F") ) ){
            if (objButton.id == "aLnik25") {
                var ret = showTextArea('hidden_amendGoodsDesc', '', 'N', 'left', 'U', 'N', 65, 800, 'string', 'Y', 'Y', 'C');
            } else if (objButton.id == "aLnik26") {
                var ret = showTextArea('hidden_amendDocReq', '', 'N', 'left', 'U', 'N', 65, 800, 'string', 'Y', 'Y', 'C');
            } else if (objButton.id == "aLnik27") {
                var ret = showTextArea('hidden_amendAddConditions', '', 'N', 'left', 'U', 'N', 65, 800, 'string', 'Y', 'Y', 'C');
            } else if (objButton.id == "aLnik28") {
                var ret = showTextArea('hidden_amendSpcPaymentConForBenf', '', 'N', 'left', 'U', 'N', 65, 800, 'string', 'Y', 'Y', 'C');
            } else if (objButton.id == "aLnik29") {
                var ret = showTextArea('hidden_amendSpecPaymentConForRecBank', '', 'N', 'left', 'U', 'N', 65, 800, 'string', 'Y', 'Y', 'C');
            }else if (objButton.id == "aLnik30") {
                var ret = showTextArea('hidden_amdPlaceIfChrg', '', 'N', 'left', 'U', 'N', 140, 1, 'string', 'Y', 'Y', 'C');
			}else if (objButton.id == "aLnik31") {
                var ret = showTextArea('hidden_amdPortOfLoading', '', 'N', 'left', 'U', 'N', 140, 1, 'string', 'Y', 'Y', 'C');
			}else if (objButton.id == "aLnik32") {
                var ret = showTextArea('hidden_amdPortOfDischarge', '', 'N', 'left', 'U', 'N', 140, 1, 'string', 'Y', 'Y', 'C');
			}else if (objButton.id == "aLnik33") {
                var ret = showTextArea('hidden_amdPlaceForFinalDest', '', 'N', 'left', 'U', 'N', 140, 1, 'string', 'Y', 'Y', 'C');
            }else {}
        } else {

            if (objButton.id == "aLnik25") {
                var ret = showTextArea('hidden_amendGoodsDesc', '', 'N', 'left', 'U', 'N', 65, 800, 'string', 'N', 'Y', 'C');
            } else if (objButton.id == "aLnik26") {
                var ret = showTextArea('hidden_amendDocReq', '', 'N', 'left', 'U', 'N', 65, 800, 'string', 'N', 'Y', 'C');
            } else if (objButton.id == "aLnik27") {
                var ret = showTextArea('hidden_amendAddConditions', '', 'N', 'left', 'U', 'N', 65, 800, 'string', 'N', 'Y', 'C');
            } else if (objButton.id == "aLnik28") {
                var ret = showTextArea('hidden_amendSpcPaymentConForBenf', '', 'N', 'left', 'U', 'N', 65, 800, 'string', 'N', 'Y', 'C');
            } else if (objButton.id == "aLnik29") {
                var ret = showTextArea('hidden_amendSpecPaymentConForRecBank', '', 'N', 'left', 'U', 'N', 65, 800, 'string', 'N', 'Y', 'C');
            } else if (objButton.id == "aLnik30") {
                var ret = showTextArea('hidden_amdPlaceIfChrg', '', 'N', 'left', 'U', 'N', 140, 1, 'string', 'N', 'Y', 'C');
			}else if (objButton.id == "aLnik31") {
                var ret = showTextArea('hidden_amdPortOfLoading', '', 'N', 'left', 'U', 'N', 140, 1, 'string', 'N', 'Y', 'C');
			}else if (objButton.id == "aLnik32") {
                var ret = showTextArea('hidden_amdPortOfDischarge', '', 'N', 'left', 'U', 'N', 140, 1, 'string', 'N', 'Y', 'C');
			}else if (objButton.id == "aLnik33") {
                var ret = showTextArea('hidden_amdPlaceForFinalDest', '', 'N', 'left', 'U', 'N', 140, 1, 'string', 'N', 'Y', 'C');
            } else {}
        }

        if (ret != null && ret != undefined) {
	ret = decodeURIComponent(ret);
	//ret = decodeURIComponent(ret);
	}

        if (objButton.id == "aLnik25") {
            if (window.showModalDialog) {
                if (ret != null && ret != undefined) {
                    document.forms[0].screen_amendDescGoodsServ.value = ret;
                    document.forms[0].hidden_amendGoodsDesc.value = ret;
                    setToCustom();
                }
            }
        } else if (objButton.id == "aLnik26") {
            if (window.showModalDialog) {
                if (ret != null && ret != undefined) {
                    document.forms[0].screen_amendDocReq.value = ret;
                    document.forms[0].hidden_amendDocReq.value = ret;
                    setToCustom();
                }
            }
        } else if (objButton.id == "aLnik27") {
            if (window.showModalDialog) {
                if (ret != null && ret != undefined) {
                    document.forms[0].screen_amendAddConditions.value = ret;
                    document.forms[0].hidden_amendAddConditions.value = ret;
                    setToCustom();
                }
            }
        } else if (objButton.id == "aLnik28") {
            if (window.showModalDialog) {
                if (ret != null && ret != undefined) {
                    document.forms[0].screen_amendSpcPaymentConForBenf.value = ret;
                    document.forms[0].hidden_amendSpcPaymentConForBenf.value = ret;
                    setToCustom();
                }
            }
        } else if (objButton.id == "aLnik29") {
            if (window.showModalDialog) {
                if (ret != null && ret != undefined) {
                    document.forms[0].screen_amendSpecPaymentConForRecBank.value = ret;
                    document.forms[0].hidden_amendSpecPaymentConForRecBank.value = ret;
                    setToCustom();
                }
            }
        }else if (objButton.id == "aLnik30") {
            if (window.showModalDialog) {
                if (ret != null && ret != undefined) {
                    document.forms[0].screen_amdPlaceIfChrg.value = ret;
                    document.forms[0].hidden_amdPlaceIfChrg.value = ret;
                    setToCustom();
                }
            }
        }else if (objButton.id == "aLnik31") {
            if (window.showModalDialog) {
                if (ret != null && ret != undefined) {
                    document.forms[0].screen_amdPortOfLoading.value = ret;
                    document.forms[0].hidden_amdPortOfLoading.value = ret;
                    setToCustom();
                }
            }
        }else if (objButton.id == "aLnik32") {
            if (window.showModalDialog) {
                if (ret != null && ret != undefined) {
                    document.forms[0].screen_amdPortOfDischarge.value = ret;
                    document.forms[0].hidden_amdPortOfDischarge.value = ret;
                    setToCustom();
                }
            }
        }else if (objButton.id == "aLnik33") {
            if (window.showModalDialog) {
                if (ret != null && ret != undefined) {
                    document.forms[0].screen_amdPlaceForFinalDest.value = ret;
                    document.forms[0].hidden_amdPlaceForFinalDest.value = ret;
                    setToCustom();
                }
            }
        }else {}
    }
    doSubmit("Validate");
}



function setBoolean(obj) {
    if (obj.value == "Y") {
        //alert("inside true");
        obj.checked = true;
    } else {
        //alert("inside false");
        obj.checked = false;
    }
}

function setFlag(obj) {
    if (obj.checked == true) {
        //alert("inside true");
        obj.value = "Y";
    } else {
        //alert("inside false");
        obj.value = "N";
    }
}

function fnSetData() {
    ////alert("Inside fnSetData");
    objForm = document.forms[0];
    setFlag(document.forms[0].chkStandBy);
    setToCustom();
}

function getJavaValue() {
    ////alert("Inside getJavaValue");
    glb_amendgoodsDesc = "<%=ParseValue.checkString(hidden_amendGoodsDesc)%>";
    glb_amendDocReq = "<%=ParseValue.checkString(hidden_amendDocReq)%>";
    glb_amendAddConditions = "<%=ParseValue.checkString(hidden_amendAddConditions)%>";
    glb_amendSpcPaymentConForBenf = "<%=ParseValue.checkString(hidden_amendSpcPaymentConForBenf)%>";
    glb_amendSpecPaymentConForRecBank = "<%=ParseValue.checkString(hidden_amendSpecPaymentConForRecBank)%>";
    glb_dcStandBy = "<%=ParseValue.checkString(chkStandBy_value)%>";
	glb_amdPlaceIfChrg = "<%=ParseValue.checkString(hidden_amdPlaceIfChrg)%>";
	glb_amdPortOfLoading = "<%=ParseValue.checkString(hidden_amdPortOfLoading)%>";
	glb_amdPortOfDischarge = "<%=ParseValue.checkString(hidden_amdPortOfDischarge)%>";
	glb_amdPlaceForFinalDest= "<%=ParseValue.checkString(hidden_amdPlaceForFinalDest)%>";
}

function fnGetTag40Val() {

    getFieldsFromCustomData("screen_amendDescGoodsServ", "hidden_amendGoodsDesc", "screen_amendDocReq", "hidden_amendDocReq", "screen_amendAddConditions", "hidden_amendAddConditions", "screen_amendSpcPaymentConForBenf", "hidden_amendSpcPaymentConForBenf", "screen_amendSpecPaymentConForRecBank", "hidden_amendSpecPaymentConForRecBank", "hidden_amendTag40A", "chkStandBy" ,"screen_amdPlaceIfChrg","hidden_amdPlaceIfChrg","screen_amdPortOfLoading","hidden_amdPortOfLoading","screen_amdPortOfDischarge","hidden_amdPortOfDischarge","screen_amdPlaceForFinalDest","hidden_amdPlaceForFinalDest");


    if ((dcStandBy != document.forms[0].chkStandBy.value) || (dcTransferFlg != document.forms[0].transferable.value)) {
        if ((document.forms[0].transferable.value == "Y") && (document.forms[0].chkStandBy.value != "Y")) {
            document.forms[0].hidden_amendTag40A.value = "IRREVOCABLE TRANSFERABLE";
        } else if ((document.forms[0].transferable.value != "Y") && (document.forms[0].chkStandBy.value == "Y")) {
            document.forms[0].hidden_amendTag40A.value = "IRREVOCABLE STANDBY";
        } else if ((document.forms[0].transferable.value == "Y") && (document.forms[0].chkStandBy.value == "Y")) {
            document.forms[0].hidden_amendTag40A.value = "IRREVOC TRANS STANDBY";
        } else if ((document.forms[0].transferable.value != "Y") && (document.forms[0].chkStandBy.value != "Y")) {
            document.forms[0].hidden_amendTag40A.value = "IRREVOCABLE";
        } else {}
    }
}

function dc_amendment_details_pre_ONLOAD() {
   getFieldsFromCustomData("screen_amendDescGoodsServ", "hidden_amendGoodsDesc", "screen_amendDocReq", "hidden_amendDocReq", "screen_amendAddConditions", "hidden_amendAddConditions", "screen_amendSpcPaymentConForBenf", "hidden_amendSpcPaymentConForBenf", "screen_amendSpecPaymentConForRecBank", "hidden_amendSpecPaymentConForRecBank", "hidden_amendTag40A", "chkStandBy","screen_amdPlaceIfChrg","hidden_amdPlaceIfChrg","screen_amdPortOfLoading","hidden_amdPortOfLoading","screen_amdPortOfDischarge","hidden_amdPortOfDischarge","screen_amdPlaceForFinalDest","hidden_amdPlaceForFinalDest");
}

function dc_amendment_details_post_ONLOAD() {
    //alert("Inside dc_amendment_details_post_ONLOAD");
	if(!(SWIFT2020_ENABLED=="Y" && standByFlg=="Y" && (paysysId=="SWIFT" || paysysId=="")))
    {

	if(getRadioValue(document.forms[0].indicator) == 'X')
	{
		hideImage("scLnk47");
		hideImage("scLnk48");
		hideImage("scLnk49");
		hideImage("scLnk50");
		hideImage("scLnk51");
		hideImage("aLnik25");
		hideImage("aLnik26");
		hideImage("aLnik27");
		hideImage("aLnik28");
		hideImage("aLnik29");
		hideImage("aLnik30");
		hideImage("aLnik31");
		hideImage("aLnik32");
		hideImage("aLnik33");
		document.forms[0].chkStandBy.disabled = true;
	}
	else
	{
		showImage("scLnk47");
		showImage("scLnk48");
		showImage("scLnk49");
		showImage("scLnk50");
		showImage("scLnk51");
		showImage("aLnik25");
		showImage("aLnik26");
		showImage("aLnik27");
		showImage("aLnik28");
		showImage("aLnik29");
		showImage("aLnik30");
		showImage("aLnik31");
		showImage("aLnik32");
		showImage("aLnik33");
		document.forms[0].chkStandBy.disabled = false;
	}
	
	//	alert("inside postonload");
		var inputNameValues = "";
		var outputNames = "";
        var scrName = "swift2018_switch.scr";
	// Do not remove the plus symbol and the two single quotes
        var retVal = appFnExecuteScript(inputNameValues, outputNames,scrName, false) + '';
        var ret = retVal.split("|");
	//	alert("ret0"+ret[0]);
	//	alert("ret1"+ret[1]);
		if(ret[1] == "N")
        {
        
		//	alert("inside condiition");
			var SWIFT2018_enabled = "N";
		//	alert("inside function post"+SWIFT2018_enabled);
			document.forms[0].screen_amendDescGoodsServ.value  = "";
			document.forms[0].hidden_amendGoodsDesc.value  = "";
			document.forms[0].screen_amendDocReq.value  = "";
			document.forms[0].hidden_amendDocReq.value  = "";
			document.forms[0].screen_amendAddConditions.value  = "";
			document.forms[0].hidden_amendAddConditions.value  = "";
			document.forms[0].screen_amendSpcPaymentConForBenf.value  = "";
			document.forms[0].hidden_amendSpcPaymentConForBenf.value  = "";
			document.forms[0].screen_amendSpecPaymentConForRecBank.value  = "";
			document.forms[0].hidden_amendSpecPaymentConForRecBank.value  = "";
			document.forms[0].screen_amendDescGoodsServ.disabled = true;
			document.forms[0].screen_amendDocReq.disabled = true;
			document.forms[0].screen_amendAddConditions.disabled = true;
			document.forms[0].screen_amendSpcPaymentConForBenf.disabled = true;
			document.forms[0].screen_amendSpecPaymentConForRecBank.disabled = true;
			document.forms[0].chkStandBy.disabled = true;
			document.forms[0].screen_amdPlaceIfChrg.value  = "";
			document.forms[0].hidden_amdPlaceIfChrg.value  = "";
			document.forms[0].screen_amdPlaceIfChrg.disabled = true;
			document.forms[0].screen_amdPortOfLoading.value  = "";
			document.forms[0].hidden_amdPortOfLoading.value  = "";
			document.forms[0].screen_amdPortOfLoading.disabled = true;
			document.forms[0].screen_amdPortOfDischarge.value  = "";
			document.forms[0].hidden_amdPortOfDischarge.value  = "";
			document.forms[0].screen_amdPortOfDischarge.disabled = true;
			document.forms[0].screen_amdPlaceForFinalDest.value  = "";
			document.forms[0].hidden_amdPlaceForFinalDest.value  = "";
			document.forms[0].screen_amdPlaceForFinalDest.disabled = true;
			hideImage("aLnik25");
			hideImage("aLnik26");
			hideImage("aLnik27");
			hideImage("aLnik28");
			hideImage("aLnik29");
			hideImage("aLnik30");
			hideImage("aLnik31");
			hideImage("aLnik32");
			hideImage("aLnik33");
			hideImage("scLnk47");
			hideImage("scLnk48");
			hideImage("scLnk49");
			hideImage("scLnk50");
			hideImage("scLnk51");
			
		}
		
	if(((SWIFT2023_ENABLED == "Y") && (!(paysysId=="SWIFT" || paysysId==""))) || (SWIFT2023_ENABLED != "Y"))
	{
			document.forms[0].screen_amdPlaceIfChrg.value  = "";
			document.forms[0].hidden_amdPlaceIfChrg.value  = "";
			document.forms[0].screen_amdPlaceIfChrg.disabled = true;
			document.forms[0].screen_amdPortOfLoading.value  = "";
			document.forms[0].hidden_amdPortOfLoading.value  = "";
			document.forms[0].screen_amdPortOfLoading.disabled = true;
			document.forms[0].screen_amdPortOfDischarge.value  = "";
			document.forms[0].hidden_amdPortOfDischarge.value  = "";
			document.forms[0].screen_amdPortOfDischarge.disabled = true;
			document.forms[0].screen_amdPlaceForFinalDest.value  = "";
			document.forms[0].hidden_amdPlaceForFinalDest.value  = "";
			document.forms[0].screen_amdPlaceForFinalDest.disabled = true;
			hideImage("aLnik30");
			hideImage("aLnik31");
			hideImage("aLnik32");
			hideImage("aLnik33");
			hideImage("screen_amdPlaceIfChrg");
			hideImage("screen_amdPortOfLoading");
			hideImage("screen_amdPortOfDischarge");
			hideImage("screen_amdPlaceForFinalDest");
	}
	else
	{
			showImage("aLnik30");
			showImage("aLnik31");
			showImage("aLnik32");
			showImage("aLnik33");

	}

    var dcStandBy = getSValue("dcStandBy");
    var dcTransferFlg = getSValue("dcTransferFlg");

    getJavaValue();
    document.forms[0].screen_amendDescGoodsServ.value = glb_amendgoodsDesc;
  
	document.forms[0].hidden_amendGoodsDesc.value = glb_amendgoodsDesc;
 
	document.forms[0].screen_amendDocReq.value = glb_amendDocReq;
    document.forms[0].hidden_amendDocReq.value = glb_amendDocReq;
    document.forms[0].screen_amendAddConditions.value = glb_amendAddConditions;
    document.forms[0].hidden_amendAddConditions.value = glb_amendAddConditions;
    document.forms[0].screen_amendSpcPaymentConForBenf.value = glb_amendSpcPaymentConForBenf;
    document.forms[0].hidden_amendSpcPaymentConForBenf.value = glb_amendSpcPaymentConForBenf;
    document.forms[0].screen_amendSpecPaymentConForRecBank.value = glb_amendSpecPaymentConForRecBank;
    document.forms[0].hidden_amendSpecPaymentConForRecBank.value = glb_amendSpecPaymentConForRecBank;
    document.forms[0].chkStandBy.value = glb_dcStandBy;
    setBoolean(document.forms[0].chkStandBy);
	if((SWIFT2023_ENABLED == "Y") && ((paysysId=="SWIFT" || paysysId=="")))
	{
	document.forms[0].screen_amdPlaceIfChrg.value = glb_amdPlaceIfChrg;
    document.forms[0].hidden_amdPlaceIfChrg.value = glb_amdPlaceIfChrg;
	document.forms[0].screen_amdPortOfLoading.value = glb_amdPortOfLoading;
    document.forms[0].hidden_amdPortOfLoading.value = glb_amdPortOfLoading;
	document.forms[0].screen_amdPortOfDischarge.value = glb_amdPortOfDischarge;
    document.forms[0].hidden_amdPortOfDischarge.value = glb_amdPortOfDischarge;
	document.forms[0].screen_amdPlaceForFinalDest.value = glb_amdPlaceForFinalDest;
    document.forms[0].hidden_amdPlaceForFinalDest.value = glb_amdPlaceForFinalDest;
	}
	
    fnSetData();
    setToCustom();

    getFieldsFromCustomData("screen_amendDescGoodsServ", "hidden_amendGoodsDesc", "screen_amendDocReq", "hidden_amendDocReq", "screen_amendAddConditions", "hidden_amendAddConditions", "screen_amendSpcPaymentConForBenf", "hidden_amendSpcPaymentConForBenf", "screen_amendSpecPaymentConForRecBank", "hidden_amendSpecPaymentConForRecBank", "hidden_amendTag40A", "chkStandBy","screen_amdPlaceIfChrg","hidden_amdPlaceIfChrg","screen_amdPortOfLoading","hidden_amdPortOfLoading","screen_amdPortOfDischarge","hidden_amdPortOfDischarge","screen_amdPlaceForFinalDest","hidden_amdPlaceForFinalDest");
    setBoolean(document.forms[0].chkStandBy);
	}
}

function countOccurences(string, word) 
{
	   return string.split(word).length - 1;
}

function dc_amendment_details_pre_ONCLICK(obj) {
	if(!(SWIFT2020_ENABLED=="Y" && standByFlg=="Y" && (paysysId=="SWIFT" || paysysId=="")))
    {

    fnGetTag40Val();
    setToCustom();

	if (obj.id == "indicator")
	{

		if(getRadioValue(document.forms[0].indicator) == 'X')
		{
			hideImage("scLnk47");
			hideImage("scLnk48");
			hideImage("scLnk49");
			hideImage("scLnk50");
			hideImage("scLnk51");
			hideImage("aLnik25");
			hideImage("aLnik26");
			hideImage("aLnik27");
			hideImage("aLnik28");
			hideImage("aLnik29");
			hideImage("aLnik30");
			hideImage("aLnik31");
			hideImage("aLnik32");
			hideImage("aLnik33");
			document.forms[0].chkStandBy.disabled = true;
		}
		else
		{
			showImage("scLnk47");
			showImage("scLnk48");
			showImage("scLnk49");
			showImage("scLnk50");
			showImage("scLnk51");
			showImage("aLnik25");
			showImage("aLnik26");
			showImage("aLnik27");
			showImage("aLnik28");
			showImage("aLnik29");
			showImage("aLnik30");
			showImage("aLnik31");
			showImage("aLnik32");
			showImage("aLnik33");
			document.forms[0].chkStandBy.disabled = false;
		}
	}

	if (obj.id == "Validate")
	{

		if(getRadioValue(document.forms[0].indicator) == 'X')
		{

			hideImage("scLnk47");
			hideImage("scLnk48");
			hideImage("scLnk49");
			hideImage("scLnk50");
			hideImage("scLnk51");
			hideImage("aLnik25");
			hideImage("aLnik26");
			hideImage("aLnik27");
			hideImage("aLnik28");
			hideImage("aLnik29");
			hideImage("aLnik30");
			hideImage("aLnik31");
			hideImage("aLnik32");
			hideImage("aLnik33");
			document.forms[0].chkStandBy.disabled = true;
		}
		else
		{
			showImage("scLnk47");
			showImage("scLnk48");
			showImage("scLnk49");
			showImage("scLnk50");
			showImage("scLnk51");
			showImage("aLnik25");
			showImage("aLnik26");
			showImage("aLnik27");
			showImage("aLnik28");
			showImage("aLnik29");
			showImage("aLnik30");
			showImage("aLnik31");
			showImage("aLnik32");
			showImage("aLnik33");
			document.forms[0].chkStandBy.disabled = false;

		}
	}

    if ((obj.id == "Validate") || (obj.id == "Submit")) {
        var chkDesc = fnTrim(document.forms[0].screen_amendDescGoodsServ.value.substring(0, 8));
        var chkDescAdd = fnTrim(document.forms[0].screen_amendDescGoodsServ.value.substring(0, 5));
		if (chkDesc != "") {
            if ((fnTrim(chkDesc.substring(0, 5)) != "/ADD/") && (fnTrim(chkDesc) != "/DELETE/") && (fnTrim(chkDesc) != "/REPALL/")) {
                alert("First word must be /ADD/,/DELETE/,/REPALL/ in Description Of Goods And/Or Services Field");
                document.forms[0].screen_amendDescGoodsServ.focus();
                return false;
            }
			if(fnTrim(chkDesc) == "/REPALL/")
			{

				var text=document.forms[0].screen_amendDescGoodsServ.value;
	
				var repallCount=countOccurences(text,"/REPALL/"); // 2
				if (repallCount > 1 )
				{
					alert("If code REPALL is used, it must be used only once in the field");
					document.forms[0].screen_amendDescGoodsServ.focus();
                	return false;
				}

				var addCount=countOccurences(text,"/ADD/");
				var deleteCount=countOccurences(text,"/DELETE/");
				if (addCount > 0)
				{
					alert("If code REPALL is used, ADD code must not be used");
					document.forms[0].screen_amendDescGoodsServ.focus();
                    return false;
				}
				if (deleteCount > 0)
				{
					alert("If code REPALL is used, DELETE code must not be used");
					document.forms[0].screen_amendDescGoodsServ.focus();
                    return false;
				}
			}

			if(fnTrim(chkDescAdd) == "/ADD/")
			{

				var text=document.forms[0].screen_amendDescGoodsServ.value;

				var repallCount=countOccurences(text,"/REPALL/"); // 2
				if (repallCount > 0 )
				{
					alert("If code REPALL is used, ADD code must not be used");
					document.forms[0].screen_amendDescGoodsServ.focus();
					return false;
				}


			}
				
			if(fnTrim(chkDesc) == "/DELETE/")
			{

				var text=document.forms[0].screen_amendDescGoodsServ.value;

				var repallCount=countOccurences(text,"/REPALL/"); // 2
				if (repallCount > 0 )
				{
					alert("If code REPALL is used, DELETE code must not be used");
					document.forms[0].screen_amendDescGoodsServ.focus();
					return false;
				}


			}

        }

        var chkDocReq = fnTrim(document.forms[0].screen_amendDocReq.value.substring(0, 8));
		var chkDocReqAdd = fnTrim(document.forms[0].screen_amendDocReq.value.substring(0, 5));

		if (chkDocReq != "") {
			if ((fnTrim(chkDocReq.substring(0, 5)) != "/ADD/") && (chkDocReq != "/DELETE/") && (chkDocReq != "/REPALL/")) {
				alert("First word must be /ADD/,/DELETE/,/REPALL/ in Documents Required Field ");
				return false;
			}
			if(fnTrim(chkDocReq) == "/REPALL/")
			{

				var text1=document.forms[0].screen_amendDocReq.value;

				var repallCount1=countOccurences(text1,"/REPALL/"); // 2
				if (repallCount1 > 1 )
				{
					alert("If code REPALL is used, it must be used only once in the field");
					document.forms[0].screen_amendDocReq.focus();
					return false;
				}

				var addCount1=countOccurences(text1,"/ADD/");
				var deleteCount1=countOccurences(text1,"/DELETE/");
				if (addCount1 > 0)
				{
					alert("If code REPALL is used, ADD code must not be used");
					document.forms[0].screen_amendDocReq.focus();
					return false;
				}
				if (deleteCount1 > 0)
				{
					alert("If code REPALL is used, DELETE code must not be used");
					document.forms[0].screen_amendDocReq.focus();
					return false;
				}
			}
			if(fnTrim(chkDocReqAdd) == "/ADD/")
			{

				var text1=document.forms[0].screen_amendDocReq.value;

				var repallCount1=countOccurences(text1,"/REPALL/"); // 2
				if (repallCount1 > 0 )
				{
					alert("If code REPALL is used, ADD code must not be used");
					document.forms[0].screen_amendDocReq.focus();
					return false;
				}

			}
			if(fnTrim(chkDocReq) == "/DELETE/")
			{

				var text1=document.forms[0].screen_amendDocReq.value;

				var repallCount1=countOccurences(text1,"/REPALL/"); // 2
				if (repallCount1 > 0 )
				{
					alert("If code REPALL is used, DELETE code must not be used");
					document.forms[0].screen_amendDocReq.focus();
					return false;
				}

			}
		}

        var chkCon = fnTrim(document.forms[0].screen_amendAddConditions.value.substring(0, 8));
		var chkConAdd = fnTrim(document.forms[0].screen_amendAddConditions.value.substring(0, 5));

		if (chkCon != "") 
		{
			if ((chkCon.substring(0, 5) != "/ADD/") && (chkCon != "/DELETE/") && (chkCon != "/REPALL/")) {
				alert("First word must be /ADD/,/DELETE/,/REPALL/ in Additional Conditions Field");
				return false;
			}
			if(fnTrim(chkCon) == "/REPALL/")
			{

				var text2=document.forms[0].screen_amendAddConditions.value;

				var repallCount2=countOccurences(text2,"/REPALL/"); // 2
				if (repallCount2 > 1 )
				{
					alert("If code REPALL is used, it must be used only once in the field");
					document.forms[0].screen_amendAddConditions.focus();
					return false;
				}

				var addCount2=countOccurences(text2,"/ADD/");
				var deleteCount2=countOccurences(text2,"/DELETE/");
				if (addCount2 > 0)
				{
					alert("If code REPALL is used, ADD code must not be used");
					document.forms[0].screen_amendAddConditions.focus();
					return false;
				}
				if (deleteCount2 > 0)
				{
					alert("If code REPALL is used, DELETE code must not be used");
					document.forms[0].screen_amendAddConditions.focus();
					return false;
				}
			}

			if(fnTrim(chkConAdd) == "/ADD/")
			{

				var text2=document.forms[0].screen_amendAddConditions.value;

				var repallCount2=countOccurences(text2,"/REPALL/"); // 2
				if (repallCount2 > 0 )
				{
					alert("If code REPALL is used, ADD code must not be used");
					document.forms[0].screen_amendAddConditions.focus();
					return false;
				}
			}
			if(fnTrim(chkCon) == "/DELETE/")
			{

				var text2=document.forms[0].screen_amendAddConditions.value;

				var repallCount2=countOccurences(text2,"/REPALL/"); // 2
				if (repallCount2 > 0 )
				{
					alert("If code REPALL is used, DELETE code must not be used");
					document.forms[0].screen_amendAddConditions.focus();
					return false;
				}
			}
		}

        var chkBenf = fnTrim(document.forms[0].screen_amendSpcPaymentConForBenf.value.substring(0, 8));
		var chkBenfAdd = fnTrim(document.forms[0].screen_amendSpcPaymentConForBenf.value.substring(0, 5));

		if (chkBenf != "") {
			if ((chkBenf.substring(0, 5) != "/ADD/") && (chkBenf != "/DELETE/") && (chkBenf != "/REPALL/")) {
				alert("First word must be /ADD/,/DELETE/,/REPALL/ in Special Payment Conditions for Beneficiary Field");
				return false;
			}
			if(fnTrim(chkBenf) == "/REPALL/")
			{
				var text2=document.forms[0].screen_amendSpcPaymentConForBenf.value;
				var repallCount2=countOccurences(text2,"/REPALL/"); // 2
				
				if (repallCount2 > 1 )
				{
					alert("If code REPALL is used, it must be used only once in the field");
					document.forms[0].screen_amendSpcPaymentConForBenf.focus();
					return false;
				}

				var addCount2=countOccurences(text2,"/ADD/");
				var deleteCount2=countOccurences(text2,"/DELETE/");
				if (addCount2 > 0)
				{
					alert("If code REPALL is used, ADD code must not be used");
					document.forms[0].screen_amendSpcPaymentConForBenf.focus();
					return false;
				}
				if (deleteCount2 > 0)
				{
					alert("If code REPALL is used, DELETE code must not be used");
					document.forms[0].screen_amendSpcPaymentConForBenf.focus();
					return false;
				}
			}
			if(fnTrim(chkBenfAdd) == "/ADD/")
			{
				var text2=document.forms[0].screen_amendSpcPaymentConForBenf.value;
				var repallCount2=countOccurences(text2,"/REPALL/"); // 2
				if (repallCount2 > 0 )
				{
					alert("If code REPALL is used, ADD code must not be used");
					document.forms[0].screen_amendSpcPaymentConForBenf.focus();
					return false;
				}


			}
			if(fnTrim(chkBenf) == "/DELETE/")
			{

				var text2=document.forms[0].screen_amendSpcPaymentConForBenf.value;

				var repallCount2=countOccurences(text2,"/REPALL/"); // 2
				if (repallCount2 > 0 )
				{
					alert("If code REPALL is used, DELETE code must not be used");
					document.forms[0].screen_amendSpcPaymentConForBenf.focus();
					return false;
				}
			}
		}

        var chkRecBank = fnTrim(document.forms[0].screen_amendSpecPaymentConForRecBank.value.substring(0, 8));
		var chkRecBankAdd = fnTrim(document.forms[0].screen_amendSpecPaymentConForRecBank.value.substring(0, 5));

		if (chkRecBank != "") {
			if ((chkRecBank.substring(0, 5) != "/ADD/") && (chkRecBank != "/DELETE/") && (chkRecBank != "/REPALL/")) {
				alert("First word must be /ADD/,/DELETE/,/REPALL/ in Special Payment Conditions for Receiving Bank Field");
				return false;
			}
			if(fnTrim(chkRecBank) == "/REPALL/")
			{

				var text2=document.forms[0].screen_amendSpecPaymentConForRecBank.value;

				var repallCount2=countOccurences(text2,"/REPALL/"); // 2
				if (repallCount2 > 1 )
				{
					alert("If code REPALL is used, it must be used only once in the field");
					document.forms[0].screen_amendSpecPaymentConForRecBank.focus();
					return false;
				}

				var addCount2=countOccurences(text2,"/ADD/");
				var deleteCount2=countOccurences(text2,"/DELETE/");
				if (addCount2 > 0)
				{
					alert("If code REPALL is used, ADD code must not be used");
					document.forms[0].screen_amendSpecPaymentConForRecBank.focus();
					return false;
				}
				if (deleteCount2 > 0)
				{
					alert("If code REPALL is used, DELETE code must not be used");
					document.forms[0].screen_amendSpecPaymentConForRecBank.focus();
					return false;
				}
			}
			if(fnTrim(chkRecBankAdd) == "/ADD/")
			{

				var text2=document.forms[0].screen_amendSpecPaymentConForRecBank.value;

				var repallCount2=countOccurences(text2,"/REPALL/"); // 2
				if (repallCount2 > 0 )
				{
					alert("If code REPALL is used, ADD code must not be used");
					document.forms[0].screen_amendSpecPaymentConForRecBank.focus();
					return false;
				}


			}
			if(fnTrim(chkRecBank) == "/DELETE/")
			{

				var text2=document.forms[0].screen_amendSpecPaymentConForRecBank.value;

				var repallCount2=countOccurences(text2,"/REPALL/"); // 2
				if (repallCount2 > 0 )
				{
					alert("If code REPALL is used, DELETE code must not be used");
					document.forms[0].screen_amendSpecPaymentConForRecBank.focus();
					return false;
				}


			}


		}
    }
	}
}

function dc_amendment_details_pre_TAB_SWITCH(obj) {

    ////alert("Inside dc_amendment_details_pre_TAB_SWITCH");
	if(!(SWIFT2020_ENABLED=="Y" && standByFlg=="Y" && (paysysId=="SWIFT" || paysysId=="")))
	{

		fnGetTag40Val();
		setToCustom();
		var chkDesc = fnTrim(document.forms[0].screen_amendDescGoodsServ.value.substring(0, 8));
		var chkDescAdd = fnTrim(document.forms[0].screen_amendDescGoodsServ.value.substring(0, 5));
		if (chkDesc != "") {
			if ((fnTrim(chkDesc.substring(0, 5)) != '/ADD/') && (fnTrim(chkDesc) != '/DELETE/') && (fnTrim(chkDesc) != '/REPALL/')) {
				alert("First word must be /ADD/,/DELETE/,/REPALL/ in Description Of Goods And/Or Services 1 Field");
				document.forms[0].screen_amendDescGoodsServ.focus();
				return false;
			}
			if(fnTrim(chkDesc) == "/REPALL/")
			{

				var text=document.forms[0].screen_amendDescGoodsServ.value;

				var repallCount=countOccurences(text,"/REPALL/"); // 2
				if (repallCount > 1 )
				{
					alert("If code REPALL is used, it must be used only once in the field");
					document.forms[0].screen_amendDescGoodsServ.focus();
					return false;
				}

				var addCount=countOccurences(text,"/ADD/");
				var deleteCount=countOccurences(text,"/DELETE/");
				if (addCount > 0)
				{
					alert("If code REPALL is used, ADD code must not be used");
					document.forms[0].screen_amendDescGoodsServ.focus();
					return false;
				}
				if (deleteCount > 0)
				{
					alert("If code REPALL is used, DELETE code must not be used");
					document.forms[0].screen_amendDescGoodsServ.focus();
					return false;
				}
			}
			if(fnTrim(chkDesc) == "/DELETE/")
			{

				var text=document.forms[0].screen_amendDescGoodsServ.value;

				var repallCount=countOccurences(text,"/REPALL/"); // 2
				if (repallCount > 0 )
				{

					alert("If code REPALL is used, DELETE code must not be used");

					document.forms[0].screen_amendDescGoodsServ.focus();
					return false;
				}
			}
			if(fnTrim(chkDescAdd) == "/ADD/")
			{

				var text=document.forms[0].screen_amendDescGoodsServ.value;

				var repallCount=countOccurences(text,"/REPALL/"); // 2
				if (repallCount > 0 )
				{
					alert("If code REPALL is used, ADD code must not be used");

					document.forms[0].screen_amendDescGoodsServ.focus();
					return false;
				}
			}
		}

		var chkDocReq = fnTrim(document.forms[0].screen_amendDocReq.value.substring(0, 8));
		var chkDocReqAdd = fnTrim(document.forms[0].screen_amendDocReq.value.substring(0, 5));

		if (chkDocReq != "") {
			if ((fnTrim(chkDocReq.substring(0, 5)) != "/ADD/") && (chkDocReq != "/DELETE/") && (chkDocReq != "/REPALL/")) {
				alert("First word must be /ADD/,/DELETE/,/REPALL/ in Documents Required 1 Field ");
				return false;
			}
			if(fnTrim(chkDocReq) == "/REPALL/")
			{

				var text1=document.forms[0].screen_amendDocReq.value;

				var repallCount1=countOccurences(text1,"/REPALL/"); // 2
				if (repallCount1 > 1 )
				{
					alert("If code REPALL is used, it must be used only once in the field");
					document.forms[0].screen_amendDocReq.focus();
					return false;
				}

				var addCount1=countOccurences(text1,"/ADD/");
				var deleteCount1=countOccurences(text1,"/DELETE/");
				if (addCount1 > 0)
				{
					alert("If code REPALL is used, ADD code must not be used");
					document.forms[0].screen_amendDocReq.focus();
					return false;
				}
				if (deleteCount1 > 0)
				{
					alert("If code REPALL is used, DELETE code must not be used");
					document.forms[0].screen_amendDocReq.focus();
					return false;
				}
			} 
			if(fnTrim(chkDocReqAdd) == "/ADD/")
			{

				var text1=document.forms[0].screen_amendDocReq.value;

				var repallCount1=countOccurences(text1,"/REPALL/"); // 2
				if (repallCount1 > 0 )
				{
					alert("If code REPALL is used, ADD code must not be used");
					document.forms[0].screen_amendDocReq.focus();
					return false;
				}
			}
			if(fnTrim(chkDocReq) == "/DELETE/")
			{

				var text1=document.forms[0].screen_amendDocReq.value;

				var repallCount1=countOccurences(text1,"/REPALL/"); // 2
				if (repallCount1 > 0 )
				{
					alert("If code REPALL is used, DELETE code must not be used");
					document.forms[0].screen_amendDocReq.focus();
					return false;
				}
			}
		}

		var chkCon = fnTrim(document.forms[0].screen_amendAddConditions.value.substring(0, 8));
		var chkConAdd = fnTrim(document.forms[0].screen_amendAddConditions.value.substring(0, 5));

		if (chkCon != "") {
			if ((chkCon.substring(0, 5) != "/ADD/") && (chkCon != "/DELETE/") && (chkCon != "/REPALL/")) {
				alert("First word must be /ADD/,/DELETE/,/REPALL/ in Additional Conditions 1 Field");
				return false;
			}
			if(fnTrim(chkCon) == "/REPALL/")
			{

				var text2=document.forms[0].screen_amendAddConditions.value;

				var repallCount2=countOccurences(text2,"/REPALL/"); // 2
				if (repallCount2 > 1 )
				{
					alert("If code REPALL is used, it must be used only once in the field");
					document.forms[0].screen_amendAddConditions.focus();
					return false;
				}

				var addCount2=countOccurences(text2,"/ADD/");
				var deleteCount2=countOccurences(text2,"/DELETE/");
				if (addCount2 > 0)
				{
					alert("If code REPALL is used, ADD code must not be used");
					document.forms[0].screen_amendAddConditions.focus();
					return false;
				}
				if (deleteCount2 > 0)
				{
					alert("If code REPALL is used, DELETE code must not be used");
					document.forms[0].screen_amendAddConditions.focus();
					return false;
				}
			}

			if(fnTrim(chkConAdd) == "/ADD/")
			{

				var text2=document.forms[0].screen_amendAddConditions.value;

				var repallCount2=countOccurences(text2,"/REPALL/"); // 2
				if (repallCount2 > 0 )
				{
					alert("If code REPALL is used, ADD code must not be used");
					document.forms[0].screen_amendAddConditions.focus();
					return false;
				}


			}
			if(fnTrim(chkCon) == "/DELETE/")
			{

				var text2=document.forms[0].screen_amendAddConditions.value;

				var repallCount2=countOccurences(text2,"/REPALL/"); // 2
				if (repallCount2 > 0 )
				{
					alert("If code REPALL is used, DELETE code must not be used");
					document.forms[0].screen_amendAddConditions.focus();
					return false;
				}


			}


		}


		var chkBenf = fnTrim(document.forms[0].screen_amendSpcPaymentConForBenf.value.substring(0, 8));
		var chkBenfAdd = fnTrim(document.forms[0].screen_amendSpcPaymentConForBenf.value.substring(0, 5));
		if (chkBenf != "") 
		{
			if ((chkBenf.substring(0, 5) != "/ADD/") && (chkBenf != "/DELETE/") && (chkBenf != "/REPALL/")) {
				alert("First word must be /ADD/,/DELETE/,/REPALL/ in Special Payment Conditions for Beneficiary 1 Field");
				return false;
			}
			if(fnTrim(chkBenf) == "/REPALL/")
			{

				var text2=document.forms[0].screen_amendSpcPaymentConForBenf.value;

				var repallCount2=countOccurences(text2,"/REPALL/"); // 2
				if (repallCount2 > 1 )
				{
					alert("If code REPALL is used, it must be used only once in the field");
					document.forms[0].screen_amendSpcPaymentConForBenf.focus();
					return false;
				}

				var addCount2=countOccurences(text2,"/ADD/");
				var deleteCount2=countOccurences(text2,"/DELETE/");
				if (addCount2 > 0)
				{
					alert("If code REPALL is used, ADD code must not be used");
					document.forms[0].screen_amendSpcPaymentConForBenf.focus();
					return false;
				}
				if (deleteCount2 > 0)
				{
					alert("If code REPALL is used, DELETE code must not be used");
					document.forms[0].screen_amendSpcPaymentConForBenf.focus();
					return false;
				}
			}

			if(fnTrim(chkBenfAdd) == "/ADD/")
			{

				var text2=document.forms[0].screen_amendSpcPaymentConForBenf.value;

				var repallCount2=countOccurences(text2,"/REPALL/"); // 2
				if (repallCount2 > 0 )
				{
					alert("If code REPALL is used, ADD code must not be used");
					document.forms[0].screen_amendSpcPaymentConForBenf.focus();
					return false;
				}


			}
			if(fnTrim(chkBenf) == "/DELETE/")
			{

				var text2=document.forms[0].screen_amendSpcPaymentConForBenf.value;

				var repallCount2=countOccurences(text2,"/REPALL/"); // 2
				if (repallCount2 > 0 )
				{
					alert("If code REPALL is used, DELETE code must not be used");
					document.forms[0].screen_amendSpcPaymentConForBenf.focus();
					return false;
				}


			}
		}

		var chkRecBank = fnTrim(document.forms[0].screen_amendSpecPaymentConForRecBank.value.substring(0, 8));
		var chkRecBankAdd = fnTrim(document.forms[0].screen_amendSpecPaymentConForRecBank.value.substring(0, 5));

		if (chkRecBank != "") 
		{
			if ((chkRecBank.substring(0, 5) != "/ADD/") && (chkRecBank != "/DELETE/") && (chkRecBank != "/REPALL/")) 
			{
				alert("First word must be /ADD/,/DELETE/,/REPALL/ in Special Payment Conditions for Receiving Bank 1 Field");
				return false;
			}
			if(fnTrim(chkRecBank) == "/REPALL/")
			{

				var text2=document.forms[0].screen_amendSpecPaymentConForRecBank.value;

				var repallCount2=countOccurences(text2,"/REPALL/"); // 2
				if (repallCount2 > 1 )
				{
					alert("If code REPALL is used, it must be used only once in the field");
					document.forms[0].screen_amendSpecPaymentConForRecBank.focus();
					return false;
				}

				var addCount2=countOccurences(text2,"/ADD/");
				var deleteCount2=countOccurences(text2,"/DELETE/");
				if (addCount2 > 0)
				{
					alert("If code REPALL is used, ADD code must not be used");
					document.forms[0].screen_amendSpecPaymentConForRecBank.focus();
					return false;
				}
				if (deleteCount2 > 0)
				{
					alert("If code REPALL is used, DELETE code must not be used");
					document.forms[0].screen_amendSpecPaymentConForRecBank.focus();
					return false;
				}
			}
			if(fnTrim(chkRecBankAdd) == "/ADD/")
			{
				var text2=document.forms[0].screen_amendSpecPaymentConForRecBank.value;

				var repallCount2=countOccurences(text2,"/REPALL/"); // 2
				if (repallCount2 > 0 )
				{
					alert("If code REPALL is used, ADD code must not be used");
					document.forms[0].screen_amendSpecPaymentConForRecBank.focus();
					return false;
				}

			}
			if(fnTrim(chkRecBank) == "/DELETE/")
			{
				var text2=document.forms[0].screen_amendSpecPaymentConForRecBank.value;

				var repallCount2=countOccurences(text2,"/REPALL/"); // 2
				if (repallCount2 > 0 )
				{
					alert("If code REPALL is used, DELETE code must not be used");
					document.forms[0].screen_amendSpecPaymentConForRecBank.focus();
					return false;
				}

			}
		}
		document.forms[0].screen_amdPlaceIfChrg.value = glb_amdPlaceIfChrg;
		document.forms[0].hidden_amdPlaceIfChrg.value = glb_amdPlaceIfChrg;
		var screen_amdPlaceIfChrg = document.forms[0].screen_amdPlaceIfChrg.value;
		document.forms[0].screen_amdPortOfLoading.value = glb_amdPortOfLoading;
		document.forms[0].hidden_amdPortOfLoading.value = glb_amdPortOfLoading;
		var screen_amdPortOfLoading = document.forms[0].screen_amdPortOfLoading.value;
		document.forms[0].screen_amdPortOfDischarge.value = glb_amdPortOfDischarge;
		document.forms[0].hidden_amdPortOfDischarge.value = glb_amdPortOfDischarge;
		var screen_amdPortOfDischarge = document.forms[0].screen_amdPortOfDischarge.value;
		document.forms[0].screen_amdPlaceForFinalDest.value = glb_amdPlaceForFinalDest;
		document.forms[0].hidden_amdPlaceForFinalDest.value = glb_amdPlaceForFinalDest;
		var screen_amdPlaceForFinalDest = document.forms[0].screen_amdPlaceForFinalDest.value;
	}

}

function setCustomFldFromSearcher(objButton) {
    var objForm = document.forms[0];

    var moduleId = document.getElementById("moduleId").value;
    var textId = document.getElementById("textId").value;
    var textType = document.getElementById("textType").value;
    //alert(moduleId);
    //alert(textId);
    //alert(textType);
    var inputNameValues = "moduleId|" + moduleId + "|textId|" + textId + "|textType|" + textType;
    var outputNames = "";
    var scrName = "getCustomTagValue.scr";
	// Do not remove the plus symbol and the two single quotes
    var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false) + '';

	if (retVal == "" || retVal == null || retVal == undefined) 
	{
		return;
	}
  	//var output = retVal.split("|");
    	//alert("output:"+output);
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
   
        if (objButton.id == "scLnk47") {
            //alert("inside 1st loop");
            document.forms[0].screen_amendDescGoodsServ.value = res1;
            document.forms[0].hidden_amendGoodsDesc.value = res1;
    	    setToCustom();

        }
        else if (objButton.id == "scLnk48") {
            //alert("inside 2nd loop");
            document.forms[0].screen_amendDocReq.value = res1;
            document.forms[0].hidden_amendDocReq.value = res1;
    	    setToCustom();

        }
        else if (objButton.id == "scLnk49") {
            //alert("inside 3rd loop");
            document.forms[0].screen_amendAddConditions.value = res1;
            document.forms[0].hidden_amendAddConditions.value = res1;
    	    setToCustom();

        }
        else if (objButton.id == "scLnk50") {
            //alert("inside 4th loop");
            document.forms[0].screen_amendSpcPaymentConForBenf.value = res1;
            document.forms[0].hidden_amendSpcPaymentConForBenf.value = res1;
    	    setToCustom();

        }
        else if (objButton.id == "scLnk51") {
            //alert("inside 5th loop");
            document.forms[0].screen_amendSpecPaymentConForRecBank.value = res1;
            document.forms[0].hidden_amendSpecPaymentConForRecBank.value = res1;
    	    setToCustom();
        }
     else { }

    doSubmit("Validate");
}

</SCRIPT>
