<!----------------------------------------------------------------------------------------------------->
<!--   File                           : dynpmt_custom.jsp
<!--   Description                    : Custom jsp for dynpmt page (SWIFT 2018)
<!--   Author                         : Ekta Shrivastava.
<!--   SNo         Date                               Author Name		           Description
<!--   001         20 June 2018			      Ekta Shrivastava.                    Initial Version
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

String hidden_amendGoodsDesc = "";
String hidden_amendDocReq = "";
String hidden_amendAddConditions = "";
String hidden_amendSpcPaymentConForBenf = "";
String hidden_amendSpecPaymentConForRecBank = "";

String goodsDesc1 = (String) ARJspCurr.getInput("goodsDesc1", "");
ARJspCurr.setInput("goodsDesc1", goodsDesc1);

String hidden_docReq = (String) ARJspCurr.getInput("hidden_docReq", "");
ARJspCurr.setInput("hidden_docReq", hidden_docReq);

String hidden_addConditions = (String) ARJspCurr.getInput("hidden_addConditions", "");
ARJspCurr.setInput("hidden_addConditions", hidden_docReq);

String hidden_spcPaymentConForBenf = (String) ARJspCurr.getInput("hidden_spcPaymentConForBenf", "");
ARJspCurr.setInput("hidden_spcPaymentConForBenf", hidden_spcPaymentConForBenf);

String hidden_specPaymentConForRecBank = (String) ARJspCurr.getInput("hidden_specPaymentConForRecBank", "");
ARJspCurr.setInput("hidden_specPaymentConForRecBank", hidden_specPaymentConForRecBank);

String tag481value = (String) ARJspCurr.getInput("tag481", "");
System.out.println("tag481value = " + tag481value);

String[] custData1 = (String[]) ARJspCurr.getInput(com.infy.bbu.ons.common.CommonConstants.KEY_CUSTOM_DATA, null);
System.out.println("cust data....." + custData1[0]);
if (custData1 == null) {
    custData1 = new String[1];
    custData1[0] = "";
} else {
    String[] result = CommonFunctions.split(custData1[0], '|');
    System.out.println("result length" + result.length);
    String pageId = "~odcm_dc_details2";
    int odcmIndex = Arrays.asList(result).indexOf("~odcm_dc_details2");
    int dcIndex = Arrays.asList(result).indexOf("~dc_amendment_details");
    int tfIndex = Arrays.asList(result).indexOf("~transfer_amend_details");
    int tfDcIndex = Arrays.asList(result).indexOf("~transfer_details_popup");
    System.out.println(" odcmIndex " + odcmIndex);
    System.out.println(" dcIndex " + dcIndex);
    System.out.println(" tfIndex " + tfIndex);
    System.out.println(" tfDcIndex " + tfDcIndex);
    if (odcmIndex >= 0) {
        System.out.println("inside if....odcmIndex .....=" + odcmIndex);
        System.out.println("result[odcmIndex+1]=" + result[odcmIndex + 1]);
        if ((goodsDesc1 != null) && (goodsDesc1.trim().length() != 0)) {
            ARJspCurr.setInput("goodsDesc1", goodsDesc1);
        } else {
            if (result.length > 1) {
                ARJspCurr.setInput("goodsDesc1", result[odcmIndex + 1]);
            }
        }


        if ((hidden_docReq != null) && (hidden_docReq.trim().length() != 0)) {
            ARJspCurr.setInput("hidden_docReq", hidden_docReq);
        } else {
            if (result.length > 1) {
                ARJspCurr.setInput("hidden_docReq", result[odcmIndex + 3]);
            }
        }

        if ((hidden_addConditions != null) && (hidden_addConditions.trim().length() != 0)) {
            ARJspCurr.setInput("hidden_addConditions", hidden_addConditions);
        } else {
            if (result.length > 1) {
                ARJspCurr.setInput("hidden_addConditions", result[odcmIndex + 5]);
            }
        }

        if ((hidden_spcPaymentConForBenf != null) && (hidden_spcPaymentConForBenf.trim().length() != 0)) {
            ARJspCurr.setInput("hidden_spcPaymentConForBenf", hidden_spcPaymentConForBenf);
        } else {
            if (result.length > 1) {
                ARJspCurr.setInput("hidden_spcPaymentConForBenf", result[odcmIndex + 7]);
            }
        }

        if ((hidden_specPaymentConForRecBank != null) && (hidden_specPaymentConForRecBank.trim().length() != 0)) {
            ARJspCurr.setInput("hidden_specPaymentConForRecBank", hidden_specPaymentConForRecBank);
        } else {
            if (result.length > 1) {
                ARJspCurr.setInput("hidden_specPaymentConForRecBank", result[odcmIndex + 9]);
            }
        }
    }
    System.out.println("Before ---- dcIndex");

    if (dcIndex >= 0) {

        System.out.println("inside if.... dcIndex=" + dcIndex);

        hidden_amendGoodsDesc = (String) ARJspCurr.getInput("hidden_amendGoodsDesc", "");
        ARJspCurr.setInput("hidden_amendGoodsDesc", hidden_amendGoodsDesc);
        System.out.println("hidden_amendGoodsDesc ... " + hidden_amendGoodsDesc);


        hidden_amendDocReq = (String) ARJspCurr.getInput("hidden_amendDocReq", "");
        ARJspCurr.setInput("hidden_amendDocReq", hidden_amendDocReq);
        System.out.println("hidden_amendDocReq ... " + hidden_amendDocReq);

        hidden_amendAddConditions = (String) ARJspCurr.getInput("hidden_amendAddConditions", "");
        ARJspCurr.setInput("hidden_amendAddConditions", hidden_amendAddConditions);
        System.out.println("hidden_amendAddConditions...." + hidden_amendAddConditions);

        hidden_amendSpcPaymentConForBenf = (String) ARJspCurr.getInput("hidden_amendSpcPaymentConForBenf", "");
        ARJspCurr.setInput("hidden_amendSpcPaymentConForBenf", hidden_amendSpcPaymentConForBenf);
        System.out.println("hidden_amendSpcPaymentConForBenf... " + hidden_amendSpcPaymentConForBenf);

        hidden_amendSpecPaymentConForRecBank = (String) ARJspCurr.getInput("hidden_amendSpecPaymentConForRecBank", "");
        ARJspCurr.setInput("hidden_amendSpecPaymentConForRecBank", hidden_amendSpecPaymentConForRecBank);
        System.out.println("hidden_amendSpecPaymentConForRecBank... " + hidden_amendSpecPaymentConForRecBank);

        String hidden_amendTag40A = (String) ARJspCurr.getInput("hidden_amendTag40A", "");
        ARJspCurr.setInput("hidden_amendTag40A", hidden_amendTag40A);
        System.out.println("hidden_amendTag40A.... " + hidden_amendTag40A);


        if ((hidden_amendGoodsDesc != null) && (hidden_amendGoodsDesc.trim().length() != 0)) {
            ARJspCurr.setInput("hidden_amendGoodsDesc", hidden_amendGoodsDesc);
        } else {
            if (result.length > 1) {
                ARJspCurr.setInput("hidden_amendGoodsDesc", result[dcIndex + 1]);
                hidden_amendGoodsDesc = result[dcIndex + 1];
            }
        }

        if ((hidden_amendDocReq != null) && (hidden_amendDocReq.trim().length() != 0)) {
            ARJspCurr.setInput("hidden_amendDocReq", hidden_amendDocReq);
        } else {
            if (result.length > 1) {
                ARJspCurr.setInput("hidden_amendDocReq", result[dcIndex + 3]);
                hidden_amendDocReq = result[dcIndex + 3];
            }
        }

        if ((hidden_amendAddConditions != null) && (hidden_amendAddConditions.trim().length() != 0)) {
            ARJspCurr.setInput("hidden_amendAddConditions", hidden_amendAddConditions);
        } else {
            if (result.length > 1) {
                ARJspCurr.setInput("hidden_amendAddConditions", result[dcIndex + 5]);
                hidden_amendAddConditions = result[dcIndex + 5];
            }
        }

        if ((hidden_amendSpcPaymentConForBenf != null) && (hidden_amendSpcPaymentConForBenf.trim().length() != 0)) {
            ARJspCurr.setInput("hidden_amendSpcPaymentConForBenf", hidden_amendSpcPaymentConForBenf);
        } else {
            if (result.length > 1) {
                ARJspCurr.setInput("hidden_amendSpcPaymentConForBenf", result[dcIndex + 7]);
                hidden_amendSpcPaymentConForBenf = result[dcIndex + 7];
            }
        }

        if ((hidden_amendSpecPaymentConForRecBank != null) && (hidden_amendSpecPaymentConForRecBank.trim().length() != 0)) {
            ARJspCurr.setInput("hidden_amendSpecPaymentConForRecBank", hidden_amendSpecPaymentConForRecBank);
        } else {
            if (result.length > 1) {
                ARJspCurr.setInput("hidden_amendSpecPaymentConForRecBank", result[dcIndex + 9]);
                hidden_amendSpecPaymentConForRecBank = result[dcIndex + 9];
            }
        }
        System.out.println("hidden_amendTag40A" + result[dcIndex + 11]);
        if ((hidden_amendTag40A != null) && (hidden_amendTag40A.trim().length() != 0)) {
            ARJspCurr.setInput("hidden_amendTag40A", hidden_amendTag40A);
        } else {
            if (result.length > 1) {
                ARJspCurr.setInput("hidden_amendTag40A", result[dcIndex + 11]);
            }
        }
    }

    System.out.println("Before ---- tfIndex");

    if (tfIndex >= 0) {
        String tag201value = (String) ARJspCurr.getInput("tag201", "");


        String[] result1 = CommonFunctions.split(custData1[0], '|');
        String pageId1 = "~transfer_amend_details";
        System.out.println("result1 = " + result1);
        for (int i = 0; i < result1.length; i++) {
            if (result1[i].equals(pageId1)) {
                System.out.println("i = " + i);
                if (i + 5 < result1.length) {
                    String trfDcCustVal = result1[i + 5];
                    String[] trfDcCustValArr = trfDcCustVal.split("\\^\\^\\^\\^\\^");

                    for (int k = 0; k < trfDcCustValArr.length; k++) {
                        if (trfDcCustValArr[k].equals(tag201value)) {
                            if (k + 1 < trfDcCustValArr.length) {
                                ARJspCurr.setInput("hidden_amendDocReq", trfDcCustValArr[k + 1]);
                                hidden_amendDocReq = trfDcCustValArr[k + 1];
                            }
                            if (k + 2 < trfDcCustValArr.length) {
                                ARJspCurr.setInput("hidden_amendAddConditions", trfDcCustValArr[k + 2]);
                                hidden_amendAddConditions = trfDcCustValArr[k + 2];
                            }

                        }

                    }
                }
            }
        }

    }

    System.out.println("Before ----tfDcIndex");

    if (tfDcIndex >= 0) {

        String tag201value = (String) ARJspCurr.getInput("tag201", "");
        int trfTagLen = tag201value.length();
        String trfTagVal = tag201value;
        String trfstrchk = "";
        if (trfTagLen >= 8) {
            String trfSubString = trfTagVal.substring(0, 8);
            if (trfSubString.equals("ZZZZZZZZ")) {
                trfstrchk = trfTagVal.substring(8);
            }
        }

        String[] result1 = CommonFunctions.split(custData1[0], '|');
        String pageId1 = "~transfer_details_popup";
        for (int i = 0; i < result1.length; i++) {
            if (result1[i].equals(pageId1)) {
                String trfDcCustVal = result1[i + 5];
                String[] trfDcCustValArr = trfDcCustVal.split("\\^\\^\\^\\^\\^");

                for (int k = 0; k < trfDcCustValArr.length; k++) {
                    if (trfDcCustValArr[k].equals(tag201value)) {
                        if (k + 1 < trfDcCustValArr.length) {
                            ARJspCurr.setInput("hidden_trfDocReq", trfDcCustValArr[k + 1]);
                        }
                        if (k + 2 < trfDcCustValArr.length) {
                            ARJspCurr.setInput("hidden_trfAddConditions", trfDcCustValArr[k + 2]);
                        }
                    }
                    if (trfstrchk != "") {
                        if (trfDcCustValArr[k].equals(trfstrchk)) {

                            String glb_trfDocReq1 = trfDcCustValArr[k + 1];
                            String glb_trfAddConditions1 = trfDcCustValArr[k + 2];
                            if (k + 1 < trfDcCustValArr.length) {
                                ARJspCurr.setInput("hidden_trfDocReq", trfDcCustValArr[k + 1]);
                            }
                            if (k + 2 < trfDcCustValArr.length) {
                                ARJspCurr.setInput("hidden_trfAddConditions", trfDcCustValArr[k + 2]);
                            }
                        }
                    }
                }
            }
        }
    }
    System.out.println("Before ---- Last");
    System.out.println("hidden_amendGoodsDesc = " + hidden_amendGoodsDesc);

}
%>



<SCRIPT language="javascript">
with (document)
{
write('<input type="hidden" id="hidden_amendGoodsDesc"   name="hidden_amendGoodsDesc">');
write('<input type="hidden" id="hidden_amendDocReq" name="hidden_amendDocReq">');
write('<input type="hidden" id="hidden_amendAddConditions" name="hidden_amendAddConditions">');
write('<input type="hidden" id="hidden_amendSpcPaymentConForBenf" name="hidden_amendSpcPaymentConForBenf">');
write('<input type="hidden" id="hidden_amendSpecPaymentConForRecBank" name="hidden_amendSpecPaymentConForRecBank">');


if ((mopId == "ODCM") || (mopId == "IDCM") || (mopId == "odcm") || (mopId == "idcm")) {
    if ((displayProperties.getTitle() == 700) || (displayProperties.getTitle() == 710)) {
        write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
        write('<tr>');
        write('<td>');
        write('<br>');
        write('<br>');
        write('<tr>');
        write('</tr>');
        write('<tr>');
        write('<td class="page-heading" colspan="2" style="height: 15px; color: #1068c2">&nbsp;Tag 45A</td>');
        write('<td class="textfield"></td>');
        write('<td class="page-heading" colspan="2" style="height: 15px; color: #1068c2">&nbsp;Tag 46A</td>');
        write('<td class="textfield"></td>');
        write('</tr>');
        write('<br>');
        write('<td class="textlabel" colspan = "2">Tag 45A 1</td>');
        write('<td>');
        write('<a id="tag45Desc1" href="javascript:showTextArea(\'goodsDesc1\',\'\',\'N\',\'left\',\'U\',\'N\',65,800,\'string\',\'N\')">');
        write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
        write('</td>');
        write('<td class="textlabel" colspan = "2">Tag 46A 1</td>');
        write('<td>');
        write('<a id="tag46Desc1" href="javascript:showTextArea(\'hidden_docReq\',\'\',\'N\',\'left\',\'U\',\'N\',65,800,\'string\',\'N\')">');
        write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
        write('</td>');
        write('</tr>');
        write('<br>');
        write('</td>');
        write('</tr>');

        write('<tr>');
        write('<td>');
        write('<br>');
        write('<br>');
        write('<tr>');
        write('</tr>');
        write('<tr>');
        write('<td class="page-heading" colspan="2" style="height: 15px; color: #1068c2">&nbsp;Tag 47A</td>');
        write('<td class="textfield"></td>');
        write('<td class="page-heading" colspan="2" style="height: 15px; color: #1068c2">&nbsp;Tag 49G</td>');
        write('<td class="textfield"></td>');
        write('</tr>');
        write('<br>');
        write('<td class="textlabel" colspan = "2">Tag 47A 1</td>');
        write('<td>');
        write('<a id="tag47Desc1" href="javascript:showTextArea(\'hidden_addConditions\',\'\',\'N\',\'left\',\'U\',\'N\',65,800,\'string\',\'N\')">');
        write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
        write('</td>');
        write('<td class="textlabel" colspan = "2">Tag 49G 1</td>');
        write('<td>');
        write('<a id="tag49Desc1" href="javascript:showTextArea(\'hidden_spcPaymentConForBenf\',\'\',\'N\',\'left\',\'U\',\'N\',65,800,\'string\',\'N\')">');
        write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
        write('</td>');
        write('</tr>');
        write('</td>');
        write('</tr>');

        write('<tr>');
        write('<td>');
        write('<br>');
        write('<br>');
        write('</tr>');
        write('<tr>');
        write('<td class="page-heading" colspan="2" style="height: 15px; color: #1068c2">&nbsp;Tag 49H</td>');
        write('<td class="textfield"></td>');
        write('</tr>');
        write('<br>');
        write('<td class="textlabel" colspan = "2">Tag 49H 1</td>');
        write('<td>');
        write('<a id="tag49HDesc1" href="javascript:showTextArea(\'hidden_specPaymentConForRecBank\',\'\',\'N\',\'left\',\'U\',\'N\',65,800,\'string\',\'N\')">');
        write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
        write('</td>');
        write('</tr>');
        write('</td>');
        write('</tr>');

        write('</table>');
    } else {
        if (displayProperties.getTitle() == 707) {
            write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
            write('<tr>');
            write('<td>');
            write('<br>');
            write('<br>');
            write('<tr>');
            write('</tr>');
            write('<tr>');
            write('<td class="page-heading" colspan="2" style="height: 15px; color: #1068c2">&nbsp;Tag 45B</td>');
            write('<td class="textfield"></td>');
            write('<td class="page-heading" colspan="2" style="height: 15px; color: #1068c2">&nbsp;Tag 46B</td>');
            write('<td class="textfield"></td>');
            write('</tr>');
            write('<br>');
            write('<td class="textlabel" colspan = "2">Tag 45B 1</td>');
            write('<td>');
            write('<a id="tag45Bdesc" href="javascript:showTextArea(\'hidden_amendGoodsDesc\',\'\',\'N\',\'left\',\'U\',\'N\',65,800,\'string\',\'N\')">');
            write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
            write('</td>');

            write('<td class="textlabel" colspan = "2">Tag 46B 1</td>');
            write('<td>');
            write('<a id="tag46Bdesc1" href="javascript:showTextArea(\'hidden_amendDocReq\',\'\',\'N\',\'left\',\'U\',\'N\',65,800,\'string\',\'N\')">');
            write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
            write('</td>');
            write('</tr>');
            write('<br>');
            write('</td>');
            write('</tr>');


            write('<tr>');
            write('<td>');
            write('<br>');
            write('<br>');
            write('<tr>');
            write('</tr>');
            write('<tr>');
            write('<td class="page-heading" colspan="2" style="height: 15px; color: #1068c2">&nbsp;Tag 47B</td>');
            write('<td class="textfield"></td>');
            write('<td class="page-heading" colspan="2" style="height: 15px; color: #1068c2">&nbsp;Tag 49M</td>');
            write('<td class="textfield"></td>');
            write('</tr>');
            write('<br>');
            write('<td class="textlabel" colspan = "2">Tag 47B 1</td>');
            write('<td>');
            write('<a id="tag47Desc1" href="javascript:showTextArea(\'hidden_amendAddConditions\',\'\',\'N\',\'left\',\'U\',\'N\',65,800,\'string\',\'N\')">');
            write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
            write('</td>');
            write('<td class="textlabel" colspan = "2">Tag 49M 1</td>');
            write('<td>');
            write('<a id="tag49Desc1" href="javascript:showTextArea(\'hidden_amendSpcPaymentConForBenf\',\'\',\'N\',\'left\',\'U\',\'N\',65,800,\'string\',\'N\')">');
            write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
            write('</td>');
            write('</tr>');
            write('</td>');
            write('</tr>');

            write('<tr>');
            write('<td>');
            write('<br>');
            write('<br>');
            write('</tr>');
            write('<tr>');
            write('<td class="page-heading" colspan="2" style="height: 15px; color: #1068c2">&nbsp;Tag 49N</td>');
            write('<td class="textfield"></td>');
            //write('<td class="page-heading" colspan="2" style="height: 15px; color: #1068c2">&nbsp;Tag 40A</td>');
            write('<td class="textfield"></td>');
            write('</tr>');
            write('<br>');
            write('<td class="textlabel" colspan = "2">Tag 49N 1</td>');
            write('<td>');
            write('<a id="tag49HDesc1" href="javascript:showTextArea(\'hidden_amendSpecPaymentConForRecBank\',\'\',\'N\',\'left\',\'U\',\'N\',65,800,\'string\',\'N\')">');
            write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
            write('</td>');
            //write('<td class="textlabel" colspan = "2">Tag 40A</td>');
            //write('<td>');
            //write('<a id="tag40A" href="javascript:showTextArea(\'hidden_amendTag40A\',\'\',\'N\',\'left\',\'U\',\'N\',65,800,\'string\',\'N\')">');
            //write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
            //write('</td>');
            write('</tr>');
            write('</td>');
            write('</tr>');
            write('</table>');

        }
        if (displayProperties.getTitle() == 720) {
            write('<input type="hidden" id="hidden_trfDocReq"   name="hidden_trfDocReq">');
            write('<input type="hidden" id="hidden_trfAddConditions" name="hidden_trfAddConditions">');

            write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
            write('<tr>');
            write('<td>');
            write('<br>');
            write('<br>');
            write('<tr>');
            write('</tr>');
            write('<tr>');
            write('<td class="page-heading" colspan="2" style="height: 15px; color: #1068c2">&nbsp;Tag 45A</td>');
            write('<td class="textfield"></td>');
            write('<td class="page-heading" colspan="2" style="height: 15px; color: #1068c2">&nbsp;Tag 46A</td>');
            write('<td class="textfield"></td>');
            write('</tr>');
            write('<br>');
            write('<td class="textlabel" colspan = "2">Tag 45A 1</td>');
            write('<td>');
            write('<a id="tag45Desc1" href="javascript:showTextArea(\'goodsDesc1\',\'\',\'N\',\'left\',\'U\',\'N\',65,800,\'string\',\'N\')">');
            write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
            write('</td>');
            write('<td class="textlabel" colspan = "2">Tag 46A 1</td>');
            write('<td>');
            //write('<a id="amdLink2" href="javascript:showTextArea(\'hidden_trfDocReq\',\'\',\'N\',\'left\',\'U\',\'N\',65,800,\'string\',\'N\')">');
            write('<a id="amdLink2" href="javascript:showTextAreaTemp(amdLink2);">');
            write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
            write('</td>');
            write('</tr>');
            write('<br>');
            write('</td>');
            write('</tr>');

            write('<tr>');
            write('<td>');
            write('<br>');
            write('<br>');
            write('<tr>');
            write('</tr>');
            write('<tr>');
            write('<td class="page-heading" colspan="2" style="height: 15px; color: #1068c2">&nbsp;Tag 47A</td>');
            write('<td class="textfield"></td>');
            write('<td class="page-heading" colspan="2" style="height: 15px; color: #1068c2">&nbsp;Tag 49G</td>');
            write('<td class="textfield"></td>');
            write('</tr>');
            write('<br>');
            write('<td class="textlabel" colspan = "2">Tag 47A 1</td>');
            write('<td>');
            write('<a id="tag47Desc1" href="javascript:showTextArea(\'hidden_trfAddConditions\',\'\',\'N\',\'left\',\'U\',\'N\',65,800,\'string\',\'N\')">');
            write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
            write('</td>');
            write('<td class="textlabel" colspan = "2">Tag 49G 1</td>');
            write('<td>');
            write('<a id="tag49Desc1" href="javascript:showTextArea(\'hidden_spcPaymentConForBenf\',\'\',\'N\',\'left\',\'U\',\'N\',65,800,\'string\',\'N\')">');
            write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
            write('</td>');
            write('</tr>');
            write('</td>');
            write('</tr>');
            write('<tr>');
            write('<td>');
            write('<br>');
            write('<br>');
            write('</tr>');
            write('<tr>');
            write('<td class="page-heading" colspan="2" style="height: 15px; color: #1068c2">&nbsp;Tag 49H</td>');
            write('<td class="textfield"></td>');
            write('</tr>');
            write('<br>');
            write('<td class="textlabel" colspan = "2">Tag 49H 1</td>');
            write('<td>');
            write('<a id="tag49HDesc1" href="javascript:showTextArea(\'hidden_specPaymentConForRecBank\',\'\',\'N\',\'left\',\'U\',\'N\',65,800,\'string\',\'N\')">');
            write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
            write('</td>');
            write('</tr>');
            write('</td>');
            write('</tr>');
            write('</table>');
        }

        if (displayProperties.getTitle() == 705) {
            write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
            write('<tr>');
            write('<td>');
            write('<br>');
            write('<br>');
            write('<tr>');
            write('</tr>');
            write('<tr>');
            write('<td class="page-heading" colspan="2" style="height: 15px; color: #1068c2">&nbsp;Tag 45A</td>');
            write('<td class="textfield"></td>');
            //write('<td class="page-heading" colspan="2" style="height: 15px; color: #1068c2">&nbsp;Tag 46A</td>');
            //write('<td class="textfield"></td>');
            write('</tr>');
            write('<br>');
            write('<td class="textlabel" colspan = "2">Tag 45A 1</td>');
            write('<td>');
            write('<a id="tag45Desc1" href="javascript:showTextArea(\'goodsDesc1\',\'\',\'N\',\'left\',\'U\',\'N\',65,800,\'string\',\'N\')">');
            write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
            write('</td>');
            //write('<td class="textlabel" colspan = "2">Tag 46A 1</td>');
            //write('<td>');
            //write('<a id="tag46Desc1" href="javascript:showTextArea(\'hidden_docReq\',\'\',\'N\',\'left\',\'U\',\'N\',65,800,\'string\',\'N\')">');
            //write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
            //write('</td>');
            write('</tr>');
            write('<br>');
            write('</td>');
            write('</tr>');

            write('<tr>');
            write('<td>');
            write('<br>');
            write('<br>');
            write('</tr>');
            write('<tr>');
            //write('<td class="page-heading" colspan="2" style="height: 15px; color: #1068c2">&nbsp;Tag 49H</td>');
            //write('<td class="textfield"></td>');
            write('</tr>');
            write('<br>');
            //write('<td class="textlabel" colspan = "2">Tag 49H 1</td>');
            //write('<td>');
            //write('<a id="tag49HDesc1" href="javascript:showTextArea(\'hidden_specPaymentConForRecBank\',\'\',\'N\',\'left\',\'U\',\'N\',65,800,\'string\',\'N\')">');
            //write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
            //write('</td>');
            write('</tr>');
            write('</td>');
            write('</tr>');

            write('</table>');
        }
    }
}
}

function showTextAreaTemp(objButton) {
    if ((mopId == "ODCM") || (mopId == "IDCM") || (mopId == "odcm") || (mopId == "idcm")) {
        hidden_trfDocReq = document.forms[0].hidden_trfDocReq.value;
        var ret = showTextArea('hidden_trfDocReq', '', 'N', 'left', 'U', 'N', 65, 800, 'string', 'N', 'Y', 'Z');
    }
}


var glb_trfDocReq;
var glb_trfAddConditions;
var glb_hidden_amendGoodsDesc;
var glb_hidden_amendDocReq;
var glb_hidden_amendAddConditions;
var glb_hidden_amendSpcPaymentConForBenf;
var glb_hidden_amendSpecPaymentConForRecBank;

function getJavaValue() {
    glb_hidden_amendGoodsDesc = "<%=ParseValue.checkString(hidden_amendGoodsDesc)%>";
    glb_hidden_amendDocReq = "<%=ParseValue.checkString(hidden_amendDocReq)%>";
    glb_hidden_amendAddConditions = "<%=ParseValue.checkString(hidden_amendAddConditions)%>";
    glb_hidden_amendSpcPaymentConForBenf = "<%=ParseValue.checkString(hidden_amendSpcPaymentConForBenf)%>";
    glb_hidden_amendSpecPaymentConForRecBank = "<%=ParseValue.checkString(hidden_amendSpecPaymentConForRecBank)%>";
}

function dynpmt_pre_ONCLICK(obj) {
    if (displayProperties.getTitle() == 707) {
        document.forms[0].hidden_amendGoodsDesc.value = glb_hidden_amendGoodsDesc;
        document.forms[0].hidden_amendDocReq.value = glb_hidden_amendDocReq;
        document.forms[0].hidden_amendAddConditions.value = glb_hidden_amendAddConditions;
        document.forms[0].hidden_amendSpcPaymentConForBenf.value = glb_hidden_amendSpcPaymentConForBenf;
        document.forms[0].hidden_amendSpecPaymentConForRecBank.value = glb_hidden_amendSpecPaymentConForRecBank;
        setFieldsToCustomData("hidden_amendGoodsDesc", "hidden_amendDocReq", "hidden_amendAddConditions", "hidden_amendSpcPaymentConForBenf", "hidden_amendSpecPaymentConForRecBank");
    }
}

function dynpmt_post_ONLOAD(obj) {

    if ((mopId == "ODCM") || (mopId == "IDCM") || (mopId == "odcm") || (mopId == "idcm")) {
		
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
			
			if((displayProperties.getTitle() == 700) || (displayProperties.getTitle() == 710)) {
				hideImage("tag45Desc1");
				hideImage("tag46Desc1");
				hideImage("tag47Desc1");
				hideImage("tag49Desc1");
				hideImage("tag49HDesc1");
			}
			
			if(displayProperties.getTitle() == 707){
				hideImage("tag45Bdesc");
				hideImage("tag46Bdesc1");
				hideImage("tag47Desc1");
				hideImage("tag49Desc1");
				hideImage("tag49HDesc1");
			}

			if(displayProperties.getTitle() == 720){
				hideImage("tag45Desc1");
				hideImage("amdLink2");
				hideImage("tag47Desc1");
				hideImage("tag49Desc1");
				hideImage("tag49HDesc1");
			}

			if(displayProperties.getTitle() == 705){
				hideImage("tag45Desc1");
			}

			
		}
		
        getJavaValue();
        var arrCriteria = displayProperties.getCriteriaAttributes();
        var fldCount = arrCriteria.length;
        for (var j = 0; j < fldCount; j++) {

            dispTag = arrCriteria[j].getDisplayTag();
            if (dispTag == "20:") {
                //alert(arrCriteria[j].getValue());

                var trfTagLen = arrCriteria[j].getValue().length;
                var trfTagVal = arrCriteria[j].getValue();
                var trfstrchk = "";
                if (trfTagLen >= 8) {
                    var trfSubString = trfTagVal.substring(0, 8);
                    if (trfSubString == "ZZZZZZZZ") {
                        trfstrchk = trfTagVal.substring(8);
                    }
                }
                var CustValues = new Array();
                CustValues = document.forms[0].customData.value.split("|");
                var pageId = "~transfer_details_popup";
                var dcPageId = "~transfer_amend_details";
                for (var i = 0; i <= CustValues.length; i++) {
                    /*      if(displayProperties.getTitle() == 720)
			{
			if(CustValues[i] == pageId)
			{
				  var trfDcCustVal = CustValues[i+5];
				  var trfDcCustValArr = new Array();

			          trfDcCustValArr  = trfDcCustVal.split("^^^^^");
				  //alert("trfDcCustValArr "+trfDcCustValArr);
				  for(var k = 0 ;k <= trfDcCustValArr.length ; k++)
				  {
				       if(trfDcCustValArr[k] == arrCriteria[j].getValue())
				       {
						//alert("inside req if");
                                                //alert("arrCriteria[j].getValue() "+arrCriteria[j].getValue());
			         		glb_trfDocReq = trfDcCustValArr[k+1];
				    		glb_trfAddConditions = trfDcCustValArr[k+2];
				    		document.forms[0].hidden_trfDocReq.value  = glb_trfDocReq;
					    	document.forms[0].hidden_trfAddConditions.value = glb_trfAddConditions;
						//alert("document.forms[0].hidden_trfDocReq.value " + document.forms[0].hidden_trfDocReq.value);
					//	alert("document.forms[0].hidden_trfAddConditions.value "+ document.forms[0].hidden_trfAddConditions.value);
					}
					if(trfstrchk != "")
					{
						if(trfDcCustValArr[k] == trfstrchk)
						{
							//alert("trfstrchk "+ trfstrchk)
					      		document.forms[0].hidden_trfDocReq.value  = trfDcCustValArr[k+1];
					      		document.forms[0].hidden_trfAddConditions.value = trfDcCustValArr[k+2];
					      		//alert("tag46a "+document.forms[0].hidden_trfDocReq.value);
					      		//alert("tag47a "+document.forms[0].hidden_trfAddConditions.value);
						}
					}

				    }
			    }	
                         }
				*/
                    if (displayProperties.getTitle() == 707) {
                        if (CustValues[i] == dcPageId) {
                            var trfAmendDcCustVal = CustValues[i + 5];
                            var trfAmendDcCustValArr = new Array();
                            //alert("trfAmendDcCustVal "+ trfAmendDcCustVal);
                            trfAmendDcCustValArr = trfAmendDcCustVal.split("^^^^^");
                            //alert("trfAmendDcCustValArr "+ trfAmendDcCustValArr);
                            for (var l = 0; l <= trfAmendDcCustValArr.length; l++) {
                                if (trfAmendDcCustValArr[l] == arrCriteria[j].getValue()) {
                                    //alert("inside if..");
                                    //alert("hidden_amendDocReq "+ trfAmendDcCustValArr[l+1]);
                                    //alert("hidden_amendAddConditions "+ trfAmendDcCustValArr[l+2]);
                                    document.forms[0].hidden_amendDocReq.value = trfAmendDcCustValArr[l + 1];
                                    document.forms[0].hidden_amendAddConditions.value = trfAmendDcCustValArr[l + 2];
                                    //alert("document.forms[0].hidden_amendDocReq.value.... "+ document.forms[0].hidden_amendDocReq.value);
                                    //alert("document.forms[0].hidden_amendAddConditions.value...."+document.forms[0].hidden_amendAddConditions.value);

                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

</SCRIPT>

