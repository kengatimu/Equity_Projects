<!----------------------------------------------------------------------------------------------------->
<!--   File                           : odcm_dc_details2_custom.jsp
<!--   Description                    : Custom jsp for odcm dc details tab (SWIFT 2018).
<!--   Author                         : Ekta Shrivastava
<!--   SNo         Date                               Author Name                          Description
<!--   001         20 June 2018                       Ekta Shrivastava.                    Initial Version
<!----------------------------------------------------------------------------------------------------->
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="com.infy.finbranch.groups.*"%>
<%@ page import="com.infy.bbu.jsputil.*,FABInquiry.*"%>
<%@ page import="applcommon.ParseValue" %>
<%@ page import="java.io.*"%>
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


<script language="javascript" src="../Renderer/javascripts/lists/<%=VRPKeys.getFile("showTextArea.js",sProfileId)%>"></script>
<%
       ContextManager ARJspCurr = (ContextManager) session.getAttribute("CustomARJspCurr");
       String sSubGrpName = (String) ARJspCurr.getInput("subGroupName", "");
       String sGrpName = ARJspCurr.getCurrentGroup();

       String goodsDesc1 = (String) ARJspCurr.getInput("goodsDesc1", "");
       String descGoodsServ1 = (String) ARJspCurr.getInput("descGoodsServ1", "");
       ARJspCurr.setInput("goodsDesc1", goodsDesc1);
       ARJspCurr.setInput("descGoodsServ1", goodsDesc1);

       String hidden_docReq = (String) ARJspCurr.getInput("hidden_docReq", "");
       String screen_docReq = (String) ARJspCurr.getInput("screen_docReq", "");
       ARJspCurr.setInput("hidden_docReq", hidden_docReq);
       ARJspCurr.setInput("screen_docReq", hidden_docReq);

       String hidden_addConditions = (String) ARJspCurr.getInput("hidden_addConditions", "");
       String screen_addConditions = (String) ARJspCurr.getInput("screen_addConditions", "");
       ARJspCurr.setInput("hidden_addConditions", hidden_addConditions);
       ARJspCurr.setInput("screen_addConditions", hidden_addConditions);

       String hidden_spcPaymentConForBenf = (String) ARJspCurr.getInput("hidden_spcPaymentConForBenf", "");
       String screen_spcPaymentConForBenf = (String) ARJspCurr.getInput("screen_spcPaymentConForBenf", "");
       ARJspCurr.setInput("hidden_spcPaymentConForBenf", hidden_spcPaymentConForBenf);
       ARJspCurr.setInput("screen_spcPaymentConForBenf", hidden_spcPaymentConForBenf);

       String hidden_specPaymentConForRecBank = (String) ARJspCurr.getInput("hidden_specPaymentConForRecBank", "");
       String screen_specPaymentConForRecBank = (String) ARJspCurr.getInput("screen_specPaymentConForRecBank", "");
       ARJspCurr.setInput("hidden_specPaymentConForRecBank", hidden_specPaymentConForRecBank);
       ARJspCurr.setInput("screen_specPaymentConForRecBank", hidden_specPaymentConForRecBank);

       String hidden_placeIfChrg = (String) ARJspCurr.getInput("hidden_placeIfChrg", "");
       String screen_placeIfChrg = (String) ARJspCurr.getInput("screen_placeIfChrg", "");
       ARJspCurr.setInput("hidden_placeIfChrg", hidden_placeIfChrg);
       ARJspCurr.setInput("screen_placeIfChrg", hidden_placeIfChrg);
	   
	   String hidden_portOfLoading = (String) ARJspCurr.getInput("hidden_portOfLoading", "");
       String screen_portOfLoading = (String) ARJspCurr.getInput("screen_portOfLoading", "");
       ARJspCurr.setInput("hidden_portOfLoading", hidden_portOfLoading);
       ARJspCurr.setInput("screen_portOfLoading", hidden_portOfLoading);
	   
	   String hidden_portOfDischarge = (String) ARJspCurr.getInput("hidden_portOfDischarge", "");
	   String screen_portOfDischarge = (String) ARJspCurr.getInput("screen_portOfDischarge", "");
	   ARJspCurr.setInput("hidden_portOfDischarge", hidden_portOfDischarge);	
	   ARJspCurr.setInput("screen_portOfDischarge", hidden_portOfDischarge);

	   String hidden_placeForFinalDest = (String) ARJspCurr.getInput("hidden_placeForFinalDest", "");
	   String screen_placeForFinalDest = (String) ARJspCurr.getInput("screen_placeForFinalDest", "");
	   ARJspCurr.setInput("hidden_placeForFinalDest", hidden_placeForFinalDest);
	   ARJspCurr.setInput("screen_placeForFinalDest", hidden_placeForFinalDest);


       String[] custData1 = (String[]) ARJspCurr.getInput(com.infy.bbu.ons.common.CommonConstants.KEY_CUSTOM_DATA, null);
       if (custData1 == null) {
           custData1 = new String[1];
           custData1[0] = "";
       } else {
           String[] result = CommonFunctions.split(custData1[0], '|');
           int odcmIndex = Arrays.asList(result).indexOf("~odcm_dc_details2");
           if (odcmIndex >= 0) {

               goodsDesc1 = result[odcmIndex + 1];
               ARJspCurr.setInput("goodsDesc1", result[odcmIndex + 1]);
               ARJspCurr.setInput("descGoodsServ1", result[odcmIndex + 1]);

               hidden_docReq = result[odcmIndex + 3];
               ARJspCurr.setInput("hidden_docReq", result[odcmIndex + 3]);
               ARJspCurr.setInput("screen_docReq", result[odcmIndex + 3]);

               hidden_addConditions = result[odcmIndex + 5];
               ARJspCurr.setInput("hidden_addConditions", result[odcmIndex + 5]);
               ARJspCurr.setInput("screen_addConditions", result[odcmIndex + 5]);

               hidden_spcPaymentConForBenf = result[odcmIndex + 7];
               ARJspCurr.setInput("hidden_spcPaymentConForBenf", result[odcmIndex + 7]);
               ARJspCurr.setInput("screen_spcPaymentConForBenf", result[odcmIndex + 7]);

               hidden_specPaymentConForRecBank = result[odcmIndex + 9];
               ARJspCurr.setInput("hidden_specPaymentConForRecBank", result[odcmIndex + 9]);
               ARJspCurr.setInput("screen_specPaymentConForRecBank", result[odcmIndex + 9]);

               hidden_placeIfChrg = result[odcmIndex + 11];
               ARJspCurr.setInput("hidden_placeIfChrg", result[odcmIndex + 11]);
               ARJspCurr.setInput("screen_placeIfChrg", result[odcmIndex + 11]);
			   
			   hidden_portOfLoading = result[odcmIndex + 13];
				ARJspCurr.setInput("hidden_portOfLoading", result[odcmIndex + 13]);
				ARJspCurr.setInput("screen_portOfLoading", result[odcmIndex + 13]);

				hidden_portOfDischarge = result[odcmIndex + 15];
				ARJspCurr.setInput("hidden_portOfDischarge", result[odcmIndex + 15]);
				ARJspCurr.setInput("screen_portOfDischarge", result[odcmIndex + 15]);

				hidden_placeForFinalDest = result[odcmIndex + 17];
				ARJspCurr.setInput("hidden_placeForFinalDest", result[odcmIndex + 17]);
				ARJspCurr.setInput("screen_placeForFinalDest", result[odcmIndex + 17]);
           }

       }
%>
	
	
<SCRIPT language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("common_functions.js",sProfileId)%>" > </SCRIPT>
<SCRIPT language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("cust_post_evt.js",sProfileId)%>" > </SCRIPT>
<SCRIPT language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("cust_pre_evt.js",sProfileId)%>" > </SCRIPT>
	

<script language="javascript">

with (document)
{
	write('<input type="hidden" id="goodsDesc1"   name="goodsDesc1">');
	write('<input type="hidden" id="hidden_docReq" name="hidden_docReq">');
	write('<input type="hidden" id="hidden_addConditions" name="hidden_addConditions">');
	write('<input type="hidden" id="hidden_spcPaymentConForBenf" name="hidden_spcPaymentConForBenf">');
	write('<input type="hidden" id="hidden_specPaymentConForRecBank" name="hidden_specPaymentConForRecBank">');
	write('<input type="hidden" id="hidden_placeIfChrg" name="hidden_placeIfChrg">');
	write('<input type="hidden" id="hidden_portOfLoading" name="hidden_portOfLoading">');
	write('<input type="hidden" id="hidden_portOfDischarge" name="hidden_portOfDischarge">');
	write('<input type="hidden" id="hidden_placeForFinalDest" name="hidden_placeForFinalDest">');
	if(!(SWIFT2020_ENABLED == "Y" && standByFlg == 'Y' && (paysysId=="SWIFT" || paysysId=="")))
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
	write('<input type="text" class ="textfieldfont" disabled = "true" hotKeyId="search1" id="descGoodsServ1" maxlength = "45500"  name="descGoodsServ1" >&nbsp;');

	write("&nbsp;");
	write("<a id=\"scLnk1\" href=\"javascript:showDynSearcher('HTFCTXT','text_type=G',':moduleId=module_id|:textId=text_id|:textType=text_type');javascript:setCustomFldFromSearcher(scLnk1);\">");
	write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search1"></a>');

	write('<a id="sLnik25"  href="javascript:showTextAreaTemp(sLnik25);">');
	write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
	write('</td>');
	write('<td class="textlabel" >Documents Required  </td>');
	write('<td class="textfield">');
	write('<input type="text" class ="textfieldfont" disabled = "true" hotKeyId="search1" id="screen_docReq" maxlength = "45500"  name="screen_docReq" >&nbsp;');

	write("&nbsp;");
	write("<a id=\"scLnk2\" href=\"javascript:showDynSearcher('HTFCTXT','text_type=D',':moduleId=module_id|:textId=text_id|:textType=text_type');javascript:setCustomFldFromSearcher(scLnk2);\">");
	write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search2"></a>');

	write('<a id="cLnik25"  href="javascript:showTextAreaTemp(cLnik25);">');
	write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
	write('</td>');
	write('</tr>');

	write('<tr>');

	write('<td class="textlabel" >Additional Conditions </td>');
	write('<td class="textfield">');
	write('<input type="text" class ="textfieldfont" disabled = "true" hotKeyId="search1" id="screen_addConditions" maxlength = "45500"  name="screen_addConditions" >&nbsp;');

	write("&nbsp;");
	write("<a id=\"scLnk3\" href=\"javascript:showDynSearcher('HTFCTXT','text_type=C',':moduleId=module_id|:textId=text_id|:textType=text_type');javascript:setCustomFldFromSearcher(scLnk3);\">");
	write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search3"></a>');


	write('<a id="cLnik26"  href="javascript:showTextAreaTemp(cLnik26);">');
	write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
	write('</td>');
	//write('<td class="columnwidth"></td>');
	write('<td class="textlabel" >Special Payment Conditions for Beneficiary  </td>');
	write('<td class="textfield">');
	write('<input type="text" class ="textfieldfont" disabled = "true" hotKeyId="search1" id="screen_spcPaymentConForBenf" maxlength = "45500"  name="screen_spcPaymentConForBenf" >&nbsp;');

	write("&nbsp;");
	write("<a id=\"scLnk4\" href=\"javascript:showDynSearcher('HTFCTXT','text_type=I',':moduleId=module_id|:textId=text_id|:textType=text_type');javascript:setCustomFldFromSearcher(scLnk4);\">");
	write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search4"></a>');

	write('<a id="cLnik27"  href="javascript:showTextAreaTemp(cLnik27);">');
	write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
	write('</td>');
	write('</tr>');

	write('<tr>');

	write('<td class="textlabel" >Special Payment Conditions for Receiving Bank</td>');
	write('<td class="textfield">');
	write('<input type="text" class ="textfieldfont" disabled = "true" hotKeyId="search1" id="screen_specPaymentConForRecBank" maxlength = "45500"  name = "screen_specPaymentConForRecBank" >&nbsp;');

	write("&nbsp;");
	write("<a id=\"scLnk5\" href=\"javascript:showDynSearcher('HTFCTXT','text_type=I',':moduleId=module_id|:textId=text_id|:textType=text_type');javascript:setCustomFldFromSearcher(scLnk5);\">");
	write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search5"></a>');

	write('<a id="cLnik28"  href="javascript:showTextAreaTemp(cLnik28);">');
	write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
	write('</td>');
	if(SWIFT2023_ENABLED=="Y" && (paysysId=="SWIFT" || paysysId==""))
	{
	write('<td class="textlabel" >Place of Taking in Charge/Dispatch From/Place of Receipt  </td>');
	}
	else
	{
	write('<td></td>');
	}
	write('<td class="textfield">');
	write('<input type="text" class ="textfieldfont" disabled = "true" hotKeyId="search1" id="screen_placeIfChrg" maxlength = "140"  name="screen_placeIfChrg" >&nbsp;');
	write("&nbsp;");
	write('<a id="cLnik29"  href="javascript:showTextAreaTemp(cLnik29);">');
	write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
	write('</td>');
	write('</tr>');
	
	write('<tr>');
	if(SWIFT2023_ENABLED=="Y" && (paysysId=="SWIFT" || paysysId==""))
	{
	write('<td class="textlabel" >Port of Loading/Airport of Departure </td>');
	}
	else
	{
	write('<td></td>');
	}
	write('<td class="textfield">');
	write('<input type="text" class ="textfieldfont" disabled = "true" hotKeyId="search1" id="screen_portOfLoading" maxlength = "140" name="screen_portOfLoading" >&nbsp;');
	write("&nbsp;");
	write('<a id="cLnik30"  href="javascript:showTextAreaTemp(cLnik30);">');
	write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
	write('</td>');
	if(SWIFT2023_ENABLED=="Y" && (paysysId=="SWIFT" || paysysId==""))
	{
	write('<td class="textlabel" >Port of Discharge/Airport of Destination </td>');
	}
	else
	{
	write('<td></td>');
	}	
	write('<td class="textfield">');
	write('<input type="text" class ="textfieldfont" disabled = "true" hotKeyId="search1" id="screen_portOfDischarge" maxlength = "140"  name="screen_portOfDischarge" >&nbsp;');
	write("&nbsp;");
	write('<a id="cLnik31"  href="javascript:showTextAreaTemp(cLnik31);">');
	write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	if(SWIFT2023_ENABLED=="Y" && (paysysId=="SWIFT" || paysysId==""))
	{
	write('<td class="textlabel" >Place of Final Destination/For Transportation To/Place of Delivery </td>');
	}
	else
	{
	write('<td></td>');
	}	
	write('<td class="textfield">');
	write('<input type="text" class ="textfieldfont" disabled = "true" hotKeyId="search1" id="screen_placeForFinalDest" maxlength = "140" name="screen_placeForFinalDest" >&nbsp;');
	write("&nbsp;");
	write('<a id="cLnik32"  href="javascript:showTextAreaTemp(cLnik32);">');
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
	write('</table>');

	write('<tr>');
	write('<td>');
	write('</td>');
	write('</tr>');
	write('<br>');
	}
 }

function setToCustom() {
	//setFieldsToCustomData("descGoodsServ1", "goodsDesc1", "screen_docReq", "hidden_docReq", "screen_addConditions", "hidden_addConditions", "screen_spcPaymentConForBenf", "hidden_spcPaymentConForBenf", "screen_specPaymentConForRecBank", "hidden_specPaymentConForRecBank", "transferable", "standby");
	setFieldsToCustomData("descGoodsServ1", "goodsDesc1", "screen_docReq", "hidden_docReq", "screen_addConditions", "hidden_addConditions", "screen_spcPaymentConForBenf", "hidden_spcPaymentConForBenf", "screen_specPaymentConForRecBank", "hidden_specPaymentConForRecBank","screen_placeIfChrg","hidden_placeIfChrg","screen_portOfLoading","hidden_portOfLoading","screen_portOfDischarge","hidden_portOfDischarge","screen_placeForFinalDest","hidden_placeForFinalDest");
}

var goodsDescValue ;
var goodsDesc2;
var glb_docReq;
var glb_addConditions;
var glb_spcPaymentConForBenf;
var glb_specPaymentConForRecBank;
var glb_placeIfChrg;
var glb_portOfLoading;
var glb_portOfDischarge;
var glb_placeForFinalDest;
function showTextAreaTemp(objButton) {

    if ((mopId == "ODCM") || (mopId == "IDCM") || (mopId == "odcm") || (mopId == "idcm")) {
        if ((funcCode == "S" || funcCode == "M" || funcCode == "C" || funcCode == "K" || funcCode == "E") && (locEventType == "K" || locEventType == "S" || locEventType == "E" || locEventType == ""))
        {
            if (objButton.id == "sLnik25") {
                if (((mopId == "ODCM") || (mopId == "odcm")) && (funcCode == "K" || (funcCode == "M" && locEventType == "K"))) {
                    var ret = showTextArea('goodsDesc1', '', 'N', 'left', 'U', 'N', 65, 100, 'string', 'Y', 'Y', 'C');
                } else {
                    var ret = showTextArea('goodsDesc1', '', 'N', 'left', 'U', 'N', 65, 800, 'string', 'Y', 'Y', 'C');
                }
            } else if (objButton.id == "cLnik25") {
                var ret = showTextArea('hidden_docReq', '', 'N', 'left', 'U', 'N', 65, 800, 'string', 'Y', 'Y', 'C');
            } else if (objButton.id == "cLnik26") {
                var ret = showTextArea('hidden_addConditions', '', 'N', 'left', 'U', 'N', 65, 800, 'string', 'Y', 'Y', 'C');
            } else if (objButton.id == "cLnik27") {
                var ret = showTextArea('hidden_spcPaymentConForBenf', '', 'N', 'left', 'U', 'N', 65, 800, 'string', 'Y', 'Y', 'C');
            } else if (objButton.id == "cLnik28") {
                var ret = showTextArea('hidden_specPaymentConForRecBank', '', 'N', 'left', 'U', 'N', 65, 800, 'string', 'Y', 'Y', 'C');
        	} else if (objButton.id == "cLnik29") {
				var ret = showTextArea('hidden_placeIfChrg', '', 'N', 'left', 'U', 'N',140,1, 'string', 'Y', 'Y', 'C'); 
		    }else if (objButton.id == "cLnik30") {
				var ret = showTextArea('hidden_portOfLoading', '', 'N', 'left', 'U', 'N',140,1, 'string', 'Y', 'Y', 'C'); 
			} else if (objButton.id == "cLnik31") {
				var ret = showTextArea('hidden_portOfDischarge', '', 'N', 'left', 'U', 'N',140,1, 'string', 'Y', 'Y', 'C'); 
			}else if (objButton.id == "cLnik32") {
				var ret = showTextArea('hidden_placeForFinalDest', '', 'N', 'left', 'U', 'N',140,1, 'string', 'Y', 'Y', 'C'); 
			}else {}
			} else {

            //alert("inside this");
            //hideImage("scLnk1");
            //hideImage("scLnk2");
            //hideImage("scLnk3");
            //hideImage("scLnk4");
            //hideImage("scLnk5");

            if (objButton.id == "sLnik25") {
                var ret = showTextArea('goodsDesc1', '', 'N', 'left', 'U', 'N', 65, 800, 'string', 'N', 'Y', 'C');
            } else if (objButton.id == "cLnik25") {
                var ret = showTextArea('hidden_docReq', '', 'N', 'left', 'U', 'N', 65, 800, 'string', 'N', 'Y', 'C');
            } else if (objButton.id == "cLnik26") {
                var ret = showTextArea('hidden_addConditions', '', 'N', 'left', 'U', 'N', 65, 800, 'string', 'N', 'Y', 'C');
            } else if (objButton.id == "cLnik27") {
                var ret = showTextArea('hidden_spcPaymentConForBenf', '', 'N', 'left', 'U', 'N', 65, 800, 'string', 'N', 'Y', 'C');
            } else if (objButton.id == "cLnik28") {
                var ret = showTextArea('hidden_specPaymentConForRecBank', '', 'N', 'left', 'U', 'N', 65, 800, 'string', 'N', 'Y', 'C');
            } else if (objButton.id == "cLnik29") {
                var ret = showTextArea('hidden_placeIfChrg', '', 'N', 'left', 'U', 'N', 140, 1, 'string', 'N', 'Y', 'C');
            } else if (objButton.id == "cLnik30") {
                var ret = showTextArea('hidden_portOfLoading', '', 'N', 'left', 'U', 'N', 140, 1, 'string', 'N', 'Y', 'C');
			} else if (objButton.id == "cLnik31") {
                var ret = showTextArea('hidden_portOfDischarge', '', 'N', 'left', 'U', 'N', 140, 1, 'string', 'N', 'Y', 'C');
			} else if (objButton.id == "cLnik32") {
                var ret = showTextArea('hidden_placeForFinalDest', '', 'N', 'left', 'U', 'N', 140, 1, 'string', 'N', 'Y', 'C');
			} else {}

        }

	if (ret != null && ret != undefined) {
	ret = decodeURIComponent(ret);
	//ret = decodeURIComponent(ret);
	}

        if (objButton.id == "sLnik25") {
            if (window.showModalDialog) {
                if (ret != null && ret != undefined) {
                    document.forms[0].descGoodsServ1.value = ret;
                    document.forms[0].goodsDesc1.value = ret;
		    setToCustom();
                }
            }
        } else if (objButton.id == "cLnik25") {
            if (window.showModalDialog) {
                if (ret != null && ret != undefined) {
                    document.forms[0].screen_docReq.value = ret;
                    document.forms[0].hidden_docReq.value = ret;
		    setToCustom();
                }
            }
        } else if (objButton.id == "cLnik26") {
            if (window.showModalDialog) {
                if (ret != null && ret != undefined) {
                    document.forms[0].screen_addConditions.value = ret;
                    document.forms[0].hidden_addConditions.value = ret;
		    setToCustom();
                }
            }
        } else if (objButton.id == "cLnik27") {
            if (window.showModalDialog) {
                if (ret != null && ret != undefined) {
                    document.forms[0].screen_spcPaymentConForBenf.value = ret;
                    document.forms[0].hidden_spcPaymentConForBenf.value = ret;
		    setToCustom();
                }
            }
        } else if (objButton.id == "cLnik28") {
            if (window.showModalDialog) {
                if (ret != null && ret != undefined) {
                    document.forms[0].screen_specPaymentConForRecBank.value = ret;
                    document.forms[0].hidden_specPaymentConForRecBank.value = ret;
		    setToCustom();
                }
            }
        } else if (objButton.id == "cLnik29") {
			if (window.showModalDialog) {
				if (ret != null && ret != undefined) {
					document.forms[0].screen_placeIfChrg.value = ret;
					document.forms[0].hidden_placeIfChrg.value = ret;
				setToCustom();
				}
			} 
       } else if (objButton.id == "cLnik30") {
			if (window.showModalDialog) {
				if (ret != null && ret != undefined) {
					document.forms[0].screen_portOfLoading.value = ret;
					document.forms[0].hidden_portOfLoading.value = ret;
				setToCustom();
				}
			} 
        } else if (objButton.id == "cLnik31") {
			if (window.showModalDialog) {
				if (ret != null && ret != undefined) {
					document.forms[0].screen_portOfDischarge.value = ret;
					document.forms[0].hidden_portOfDischarge.value = ret;
				setToCustom();
				}
			} 
        } else if (objButton.id == "cLnik32") {
			if (window.showModalDialog) {
				if (ret != null && ret != undefined) {
					document.forms[0].screen_placeForFinalDest.value = ret;
					document.forms[0].hidden_placeForFinalDest.value = ret;
				setToCustom();
				}
			} 
		} else {}

    }
    doSubmit("Validate");
}

function getJavaValue() {
	var funcCode = '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("funcCode",""))%>';
    goodsDesc2 = "<%=ParseValue.checkString(goodsDesc1)%>";
    glb_docReq = "<%=ParseValue.checkString(hidden_docReq)%>";
    glb_addConditions = "<%=ParseValue.checkString(hidden_addConditions)%>";
    glb_spcPaymentConForBenf = "<%=ParseValue.checkString(hidden_spcPaymentConForBenf)%>";
    glb_specPaymentConForRecBank = "<%=ParseValue.checkString(hidden_specPaymentConForRecBank)%>";
	glb_placeIfChrg = "<%=ParseValue.checkString(hidden_placeIfChrg)%>";
	glb_portOfLoading = "<%=ParseValue.checkString(hidden_portOfLoading)%>";
	glb_portOfDischarge = "<%=ParseValue.checkString(hidden_portOfDischarge)%>";
	glb_placeForFinalDest = "<%=ParseValue.checkString(hidden_placeForFinalDest)%>";
}

function odcm_dc_details2_post_ONLOAD() {
    //alert("inside post onload");
	//alert("inside postonload");
		var inputNameValues = "";
		var outputNames = "";
        var scrName = "swift2018_switch.scr";
	// Do not remove the plus symbol and the two single quotes
        var retVal = appFnExecuteScript(inputNameValues, outputNames,scrName, false) + '';
        var ret = retVal.split("|");
	//	alert("ret0"+ret[0]);
	//	alert("ret1"+ret[1]);
	if(!(SWIFT2020_ENABLED == "Y" && standByFlg == 'Y' && (paysysId=="SWIFT" || paysysId=="")))
	{
		if(ret[1] == "N")
        {
        
			//alert("inside condiition");
			var SWIFT2018_enabled = "N";
		//	alert("inside function post"+SWIFT2018_enabled);
			document.forms[0].descGoodsServ1.value  = "";
			document.forms[0].goodsDesc1.value  = "";
			document.forms[0].screen_docReq.value  = "";
			document.forms[0].hidden_docReq.value  = "";
			document.forms[0].screen_addConditions.value  = "";
			document.forms[0].hidden_addConditions.value  = "";
			document.forms[0].screen_spcPaymentConForBenf.value  = "";
			document.forms[0].hidden_spcPaymentConForBenf.value  = "";
			document.forms[0].screen_specPaymentConForRecBank.value  = "";
			document.forms[0].hidden_specPaymentConForRecBank.value  = "";
			document.forms[0].screen_placeIfChrg = "";
			document.forms[0].hidden_placeIfChrg = "";
			document.forms[0].screen_portOfLoading = "";
			document.forms[0].hidden_portOfLoading = "";
			document.forms[0].screen_portOfDischarge = "";
			document.forms[0].hidden_portOfDischarge = "";
			document.forms[0].screen_placeForFinalDest = "";
			document.forms[0].hidden_placeForFinalDest = "";
			document.forms[0].descGoodsServ1.disabled = true;
			document.forms[0].screen_docReq.disabled = true;
			document.forms[0].screen_addConditions.disabled = true;
			document.forms[0].screen_spcPaymentConForBenf.disabled = true;
			document.forms[0].screen_specPaymentConForRecBank.disabled = true;
			document.forms[0].screen_placeIfChrg.disabled = true;
			document.forms[0].screen_portOfLoading.disabled = true;
			document.forms[0].screen_portOfDischarge.disabled = true;
			document.forms[0].screen_placeForFinalDest.disabled = true;

			hideImage("sLnik25");
			hideImage("cLnik25");
			hideImage("cLnik26");
			hideImage("cLnik27");
			hideImage("cLnik28");
			hideImage("cLnik29");
			hideImage("cLnik30");
			hideImage("cLnik31");
			hideImage("cLnik32");
			hideImage("scLnk1");
			hideImage("scLnk2");
			hideImage("scLnk3");
			hideImage("scLnk4");
			hideImage("scLnk5");
			
		}

    if ((funcCode != "S") && (funcCode != "M") && (funcCode != "C") && (funcCode != "K") && (funcCode != "E")) {
        //alert("inside loop");
        hideImage("scLnk1");
        hideImage("scLnk2");
        hideImage("scLnk3");
        hideImage("scLnk4");
        hideImage("scLnk5");
    }
	if(((SWIFT2023_ENABLED == "Y") && (!(paysysId=="SWIFT" || paysysId==""))) || (SWIFT2023_ENABLED != "Y"))
	{
		document.forms[0].screen_placeIfChrg.value = "";
		document.forms[0].hidden_placeIfChrg.value = "";
		document.forms[0].screen_portOfLoading.value = "";
		document.forms[0].hidden_portOfLoading.value = "";
		document.forms[0].screen_portOfDischarge.value = "";
		document.forms[0].hidden_portOfDischarge.value = "";
		document.forms[0].screen_placeForFinalDest.value = "";
		document.forms[0].hidden_placeForFinalDest.value = "";
		document.forms[0].screen_placeIfChrg.disabled = true;
		document.forms[0].screen_portOfLoading.disabled = true;
		document.forms[0].screen_portOfDischarge.disabled = true;
		document.forms[0].screen_placeForFinalDest.disabled = true;
		hideImage("cLnik29");
		hideImage("cLnik30");
		hideImage("cLnik31");
		hideImage("cLnik32");
		hideImage("screen_placeIfChrg");
		hideImage("screen_portOfLoading");
		hideImage("screen_portOfDischarge");
		hideImage("screen_placeForFinalDest");
	}
	else
	{
		showImage("cLnik29");
		showImage("cLnik30");
		showImage("cLnik31");
		showImage("cLnik32");
	}

    objForm = document.forms[0];
    getJavaValue();
    document.forms[0].descGoodsServ1.value = goodsDesc2;
    document.forms[0].goodsDesc1.value = goodsDesc2;
    document.forms[0].screen_docReq.value = glb_docReq;
    document.forms[0].hidden_docReq.value = glb_docReq;
    document.forms[0].screen_addConditions.value = glb_addConditions;
    document.forms[0].hidden_addConditions.value = glb_addConditions;
    document.forms[0].screen_spcPaymentConForBenf.value = glb_spcPaymentConForBenf;
    document.forms[0].hidden_spcPaymentConForBenf.value = glb_spcPaymentConForBenf;
    document.forms[0].screen_specPaymentConForRecBank.value = glb_specPaymentConForRecBank;
    document.forms[0].hidden_specPaymentConForRecBank.value = glb_specPaymentConForRecBank;
	if((SWIFT2023_ENABLED == "Y") && ((paysysId=="SWIFT" || paysysId=="")))
	{
    document.forms[0].screen_placeIfChrg.value = glb_placeIfChrg;
    document.forms[0].hidden_placeIfChrg.value = glb_placeIfChrg;
    document.forms[0].screen_portOfLoading.value = glb_portOfLoading;
    document.forms[0].hidden_portOfLoading.value = glb_portOfLoading;
    document.forms[0].screen_portOfDischarge.value = glb_portOfDischarge;
    document.forms[0].hidden_portOfDischarge.value = glb_portOfDischarge;
    document.forms[0].screen_placeForFinalDest.value = glb_placeForFinalDest;
    document.forms[0].hidden_placeForFinalDest.value = glb_placeForFinalDest;

	}
    setToCustom();

    getFieldsFromCustomData("descGoodsServ1", "goodsDesc1", "screen_docReq", "hidden_docReq", "screen_addConditions", "hidden_addConditions", "screen_spcPaymentConForBenf", "hidden_spcPaymentConForBenf", "screen_specPaymentConForRecBank", "hidden_specPaymentConForRecBank","screen_placeIfChrg","hidden_placeIfChrg","screen_portOfLoading","hidden_portOfLoading","screen_portOfDischarge","hidden_portOfDischarge","screen_placeForFinalDest","hidden_placeForFinalDest");

	}
}




function odcm_dc_details2_pre_ONCLICK(obj) {
	if(!(SWIFT2020_ENABLED == "Y" &&standByFlg == 'Y' && (paysysId=="SWIFT" || paysysId=="")))
	{

    objForm = document.forms[0];
    getJavaValue();

    document.forms[0].descGoodsServ1.value = goodsDesc2;
    var descGoodsServ1 = document.forms[0].descGoodsServ1.value;

    document.forms[0].screen_docReq.value = glb_docReq;
    var screen_docReq = document.forms[0].screen_docReq.value;

    document.forms[0].screen_addConditions.value = glb_addConditions;
    var screen_addConditions = document.forms[0].screen_addConditions.value;

    document.forms[0].screen_spcPaymentConForBenf.value = glb_spcPaymentConForBenf;
    var screen_spcPaymentConForBenf = document.forms[0].screen_spcPaymentConForBenf.value;

    document.forms[0].screen_specPaymentConForRecBank.value = glb_specPaymentConForRecBank;
    var screen_specPaymentConForRecBank = document.forms[0].screen_specPaymentConForRecBank.value;

    document.forms[0].screen_placeIfChrg.value = glb_placeIfChrg;
    var screen_placeIfChrg = document.forms[0].screen_placeIfChrg.value;
    
    document.forms[0].screen_portOfLoading.value = glb_portOfLoading;
    var screen_portOfLoading = document.forms[0].screen_portOfLoading.value;

    document.forms[0].screen_portOfDischarge.value = glb_portOfDischarge;
    var screen_portOfDischarge = document.forms[0].screen_portOfDischarge.value;

    document.forms[0].screen_placeForFinalDest.value = glb_placeForFinalDest;
    var screen_placeForFinalDest = document.forms[0].screen_placeForFinalDest.value;
	
	setToCustom();
	}

}

function odcm_dc_details2_pre_TAB_SWITCH(obj) {

if(!(SWIFT2020_ENABLED == "Y" &&standByFlg == 'Y' && (paysysId=="SWIFT" || paysysId=="")))
	{
    getJavaValue();

    document.forms[0].descGoodsServ1.value = goodsDesc2;
    document.forms[0].goodsDesc1.value = goodsDesc2;
    var descGoodsServ1 = document.forms[0].descGoodsServ1.value;

    document.forms[0].screen_docReq.value = glb_docReq;
    document.forms[0].hidden_docReq.value = glb_docReq;
    var screen_docReq = document.forms[0].screen_docReq.value;

    document.forms[0].screen_addConditions.value = glb_addConditions;
    document.forms[0].hidden_addConditions.value = glb_addConditions;
    var screen_addConditions = document.forms[0].screen_addConditions.value;

    document.forms[0].screen_spcPaymentConForBenf.value = glb_spcPaymentConForBenf;
    document.forms[0].hidden_spcPaymentConForBenf.value = glb_spcPaymentConForBenf;
    var screen_spcPaymentConForBenf = document.forms[0].screen_spcPaymentConForBenf.value;

    document.forms[0].screen_specPaymentConForRecBank.value = glb_specPaymentConForRecBank;
    document.forms[0].hidden_specPaymentConForRecBank.value = glb_specPaymentConForRecBank;
    var screen_specPaymentConForRecBank = document.forms[0].screen_specPaymentConForRecBank.value;

    document.forms[0].screen_placeIfChrg.value = glb_placeIfChrg;
    document.forms[0].hidden_placeIfChrg.value = glb_placeIfChrg;
    var screen_placeIfChrg = document.forms[0].screen_placeIfChrg.value;

    document.forms[0].screen_portOfLoading.value = glb_portOfLoading;
    document.forms[0].hidden_portOfLoading.value = glb_portOfLoading;
    var screen_portOfLoading = document.forms[0].screen_portOfLoading.value;

    document.forms[0].screen_portOfDischarge.value = glb_portOfDischarge;
    document.forms[0].hidden_portOfDischarge.value = glb_portOfDischarge;
    var screen_portOfDischarge = document.forms[0].screen_portOfDischarge.value;

    document.forms[0].screen_placeForFinalDest.value = glb_placeForFinalDest;
    document.forms[0].hidden_placeForFinalDest.value = glb_placeForFinalDest;
    var screen_placeForFinalDest = document.forms[0].screen_placeForFinalDest.value;
    
	setToCustom();
	}
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
	// Do not remove the plus symbol and the two single quotes
    var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false) + '';

    if (retVal == "" || retVal == null || retVal == undefined)
    {
    	return;
    }
    // var output = retVal.split("|");
    // alert("output:"+output);
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

        if (objButton.id == "scLnk1") {
            //alert("inside 1st loop");
            document.forms[0].descGoodsServ1.value = res1;
            document.forms[0].goodsDesc1.value = res1;
            setToCustom();
        }
        else if (objButton.id == "scLnk2") {
            //alert("inside 2nd loop");
            document.forms[0].screen_docReq.value = res1;
            document.forms[0].hidden_docReq.value = res1;
            setToCustom();
        }
        else if (objButton.id == "scLnk3") {
            //alert("inside 3rd loop");
            document.forms[0].screen_addConditions.value = res1;
            document.forms[0].hidden_addConditions.value = res1;
            setToCustom();
        }
        else if (objButton.id == "scLnk4") {
            //alert("inside 4th loop");
            document.forms[0].screen_spcPaymentConForBenf.value = res1;
            document.forms[0].hidden_spcPaymentConForBenf.value = res1;
            setToCustom();
        }
        else if (objButton.id == "scLnk5") {
            //alert("inside 5th loop");
            document.forms[0].screen_specPaymentConForRecBank.value = res1;
            document.forms[0].hidden_specPaymentConForRecBank.value = res1;
            setToCustom();
        }
    	else { }

    	doSubmit("Validate");
    }
}
</SCRIPT>
