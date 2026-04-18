<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : clginsdetfetchmn002.jsp
<!--Description         : This file should reside in finbranch/custom/jsp folder.This script validate the MICR READER.
<!--Date                : 24-02-2013
<!--Author              : Shilpa
<!--Called By           : outward_clearing_custom.jsp
<!--Calling jsp         : None
<!--Menu Option         : HOCTM
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------         -----------        ------------------
<!--     0.1            24-02-2013           Shilpa           Original version
<!---------------------------------------------------------------------------------------------------------------->
<arjsp:init groupName="tm" isEntryPoint="false" />
<%@ include file="../../custom/commonInclude.jsp"%>

<%
         String sProfileId   = ProfilesManager.getProfileInSession(session);
%>


<html>
<head>
<TITLE> MICR READER </TITLE>

<LINK href="../Renderer/stylesheets/<%=VRPKeys.getFile("services.css",sProfileId)%>" rel=STYLESHEET  title="Finacle Stylesheet" type="text/css" />

<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getCustomFile("custom_functions.js",sProfileId)%>"></script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getCustomFile("common_functions.js",sProfileId)%>"></script>
<script type="text/javascript">
function sendValues(obj) {
	var micrstring =  document.forms[0].micrstring.value;
		
	//The following step is to Validate fields
	
	
	if( micrstring == "" )
	{
		alert("Please Enter String ");
		document.forms[0].micrstring.focus();
		return false;
	}
     
    var micrstring = document.forms[0].micrstring.value;
    var inputNameValues    = "micrstring|"+micrstring;
	var outputNames        = "";
	var scrName            = "clginsdetfetchmn002.scr";
	var retVal 		= appFnExecuteScriptCust(inputNameValues, outputNames, scrName, false);
	var ret = retVal.split("|");
	
	if( ret[0] == "Error") {
		return false;
	}
	if( ret[1] == "I" )
	{
		alert(" Pls try the swiping again");
		document.forms[0].micrstring.focus();
		return true;
	}
	if( ret[1] == "Y" )
	{
		alert("Invalid Cheque Digit");
		document.forms[0].micrstring.focus();
		return true;
	}


	sendObj={micrstring:document.forms[0].micrstring.value};
	window.returnValue = sendObj;
	window.close();
}

function appFnExecuteScriptCust(inputNameValues, outputNames, scrName, isPopulationReq)
{

    var sUrl = "../../arjspmorph/INFENG/stf_frm_fetch.jsp?";

    if(!fnIsNull(inputNameValues))
        sUrl += "&inputs="+encodeURIComponent(inputNameValues);

    if(fnIsNull(scrName))
    {
        alert("Script Name is mandatory");
        return;
    }

    sUrl += "&scrName="+scrName;

    if (isPopulationReq && fnIsNull(outputNames))
    {
        alert("Output Names are mandatory");
        return;
    }

    var xMax = screen.width, yMax = screen.height;
    var xOffset = (xMax - 120), yOffset = (yMax - 150);
    var params = "dialogWidth=0px;dialogHeight=0px;dialogLeft="+xOffset+"px;dialogTop="+yOffset+"px";
    params += ";status=no;toolbar=no;menubar=no;resizable=yes;help=no;center=no";

    var retVal = "";
    if("Microsoft Internet Explorer" == browser_name){
        retVal = window.showModalDialog(sUrl,"",params);
        if(retVal != null && typeof(retVal) == "string" && retVal == "TIMEOUT")
        {
            var logoutParams = new Array(1);
            logoutParams[0]  = finConst.FORCED_LOGOUT;
            handleWindowDisplay(finConst.DOLOGOUT,logoutParams);
            return;
        }
    }
    else {
        retVal = window.open(sUrl,"title","width=10px,height=10px,modal=yes,top="+yOffset+"px,left="+xOffset+"px,scrollbars=yes,toolbar=no,menubar=no,help=no");
        if(retVal != null && typeof(retVal) == "string" && retVal == "TIMEOUT")
        {
            var logoutParams = new Array(1);
            logoutParams[0]  = finConst.FORCED_LOGOUT;
 	    handleWindowDisplay(finConst.DOLOGOUT,logoutParams);
            return;
        }
    }
    if (retVal == null || retVal == undefined)
        return retVal;

    var retBuff = retVal.split("|");
    var retBuffLen = retBuff.length;
    if (retBuff[0] == 'Err')
    {
        var str = "";
        for (var i=1; i<retBuffLen; i++)
        {
            str += retBuff[i] + "\n";
        }
        alert(str);
        return;
    }

    if (!isPopulationReq)
        return retVal;

    var frm = document.forms[0];
    var outBuff = outputNames.split("|");
    var outBuffLen = outBuff.length;

    for (var i=0; i<outBuffLen; i++)
    {
        for (var j=0; j<retBuffLen; j++)
        {
            if (outBuff[i] == retBuff[j])
            {
                if ((eval("frm." + outBuff[i]) != undefined))
                {
                    eval("frm."+outBuff[i]+".value=\""+retBuff[j+1]+"\"");
                    break;
                }
            }
        }
    }
}

</script>
</head>
<body>
<form name="form1">
<div name="div1" id="div1">
<br>
<h3> &nbsp;&nbsp;MICR READER </h3>
<h4> &nbsp;&nbsp;Micr code capture screen</h4>
<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0" CLASS="ctable">
<TR>
<td>
<TABLE width="100%" class="tableborder" border="0" cellspacing="0" cellpadding="0">
<tr>
<td colspan="0">
<TABLE width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">
<tr><td>&nbsp;</td></tr>
<tr>
<td>
<TABLE width="50%" border="0" cellpadding="0" cellspacing="0" class="ctable">
<tr>
<td class="textlabel">MICR STRING</td>
<td class="textlabel"><input class="textfieldfont" id="micrstring" name="micrstring" size="25"  value=""  ></td>
</tr>

</TABLE>
</td>
</tr>
</TABLE>
</td>
</tr>
</TABLE>
</div>
<br>
<INPUT TYPE="button"  class="button"  VALUE="Submit" size = 1 onClick = "javascript:sendValues(this);">
<INPUT TYPE="reset"  class="button" VALUE="Clear" size = 1 >
</form>
</body>
</html>


