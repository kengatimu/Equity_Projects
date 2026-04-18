<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : tmres_custom.jsp
<!--Description         : This file should reside in finbranch/custom/jsp folder.
<!--Date                : 21-01-2013
<!--Author              : Prakash
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HTM
<!--Modification History:
<!--    Version No.       Date               Author         Description
<!--    -------         ----------         -----------      ------------------
<!--     0.1            21-01-2013           Prakash        Original version
<!---------------------------------------------------------------------------------------------------------------->
<%@ page import="com.infy.bbu.jsputil.ProfilesManager" %>
<%@ page import="com.infy.bbu.jsputil.VRPKeys" %>
<%
	String sProfileId = ProfilesManager.getProfileInSession(session);
	VRPKeys vrpInst = (VRPKeys)session.getAttribute("VRPKeysInst");
%>
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("custom_functions.js",sProfileId)%>"></script>
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("session.js",sProfileId)%>"></script>
<script>



function printFooterBlock()
{
        with (document) {
        write('<div class="ctable">');
        write('<input id="Ok" name="Ok" type="button" class="button" onClick="javascript:return tmres_ONCLICK5(this);" value="' + jspResArr.get("FLT001166") + '" hotKeyId="Go">');
	write('<input type="button" id="Print" class="button" name="Print" value="Re-Print" onClick="javascript:fnPrintOnlineAdvice()">');
	write('<input type="hidden" id="sFileName" name="sFileName">');
	writeFooter();
	write('</div>');
        } //End with()
} //End function



function post_ONLOAD()
{
	delSValue("bioStatus");
	hideImage("Print");

	if(tranType == "T"){
		showImage("Print");
	}

	if(tranType == "C"){
		if((tranSubType == "NR") || (tranSubType == "CR") || (tranSubType == "RI")){
			showImage("Print");
		}
	}
}



// Mohans Code for Online Customer Advice Generation

function fnPrintOnlineAdvice(){
    if(!fnIsNull(tranId)){
        var inputNameValues = "tranId|"+tranId+"|tranDate|"+tranDate;
        var outputNames = "errorFlg|errorMsg|rptFilePath";
        var scriptName = "tmAdviseReprintmn001.scr"
        var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
        var token = retVal.split("|");
        if(token != undefined){
                var errorFlg = token[1];
                var errorMsg = token[3];
                var rptFilePath = token[5];

                if(errorFlg == "Y"){
                        alert(errorMsg);
                        return false;
                }else{
			//alert(rptFilePath);
			var frm = document.forms[0];
		        frm.sFileName.value = rptFilePath;
			doSubmit(frm.Print.id);
			return true;
			
                }
        }
    }

        return;
}

</script>


