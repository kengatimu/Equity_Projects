<!---------------------------------------------------------------------------------------------------------------->
<!--Description		: This jsp is used to populate a new popup window
<!--Date		: 03-03-2013
<!--Author		: Shishira
<!--Called By		: outward_clearing_custom.jsp
<!--Calling jsp		: None
<!--Menu Option		: HOCTM
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------         -----------        ------------------
<!--     0.1            03-03-2013           Shishira          Original version
<!--     0.2            25-04-2013           Shishira          Modified JSP
<!---------------------------------------------------------------------------------------------------------------->
<arjsp:init groupName="outwardclearing" isEntryPoint="false" />
<%@ include file="../commonInclude.jsp"%>
<%
         String sProfileId   = ProfilesManager.getProfileInSession(session);
%>


<custom:getRepository/>
<%
String iacctNo=request.getParameter("acctNo");
String itranRmk=request.getParameter("tranRmk");
%>

<html>
<head>
	<TITLE> </TITLE>
	<LINK href="../Renderer/stylesheets/<%=VRPKeys.getFile("services.css",sProfileId)%>" rel=STYLESHEET  title="Finacle Stylesheet" type="text/css" />
	<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("cust_common_functions.js",sProfileId)%>"></script>
	<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("custom_functions.js",sProfileId)%>"></script>
	<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getCustomFile("common_functions.js",sProfileId)%>"></script>
	<script type="text/javascript">
		function sendValues(obj) 
		{
			var phonenumberCol=document.forms[0].phNo.value;
			var acctNumCol=document.forms[0].acctNum.value;
			var tranRmksCol=document.forms[0].billNo.value;
			var locationDescCol=(document.forms[0].custLoc.value).toUpperCase();
			var locCode =document.forms[0].hiddenLocCode.value;
			if(phonenumberCol == "" )
			{
				alert("Please Enter the Phone Number");
				document.forms[0].phNo.focus();
				return false;
			}
			if(isNaN(phonenumberCol) )
			{
				alert("Please Enter Valid Phone Number");
				document.forms[0].phNo.focus();
				return false;
			}
			if(locationDescCol == "" )
			{
				alert("Please Enter the Cusromer Location");
				document.forms[0].custLoc.focus();
				return false;
			}

			var inputNameValues    = "phonenumberCol|"+ phonenumberCol +"|acctNumCol|"+ acctNumCol +"|tranRmksCol|"+ tranRmksCol +"|locationDescCol|"+ locationDescCol;
			var outputNames        = "";
			var scrName            = "chqValmn005.scr";
			var retVal              = appFnExecuteScriptCust(inputNameValues, outputNames, scrName, false);
			if(retVal==undefined){
				return false;	 }
			var ret = retVal.split("|");
			if(ret[0]=="locCod"){ 
				document.forms[0].hiddenLocCode.value=ret[1];
			}

		var inputNameValues = "phonenumberCol|"+phonenumberCol+"|acctNumCol|"+acctNumCol+"|tranRmksCol|"+tranRmksCol+"|locationDescCol|"+locationDescCol+"|locationCodeCol|"+locCode;
		var outputNames = "EMsg|PopPert|PopTran";
		var scrName = "chqValmn004.scr";
		var retValo = appFnExecuteScriptCust(inputNameValues, outputNames, scrName, false);
                        if(retValo==undefined){
                                return false;   
			}
			document.forms[0].hiddenGetVal.value=retValo;

		sendObj={retValo:document.forms[0].hiddenGetVal.value};
		window.returnValue = sendObj;
		window.close();
}//SendVal Function

function appFnExecuteScriptCust(inputNameValues, outputNames, scrName, isPopulationReq)
{
	var sUrl = "../../../arjspmorph/INFENG/stf_frm_fetch.jsp?";
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
<h3> &nbsp;&nbsp;COLLECTIONS A/C</h3>
<h4> &nbsp;&nbsp;TRANSACTION DATA CAPTURE SCREEN </h4>
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
<td class="textlabel">Acct No</td>
<td class="textlabel"><input class="textfieldfont" id="acctNum" name="acctNum" fmnd="Y" size="15"  value="<%=iacctNo%>" disabled="true" ></td>
</tr>
<tr>
<td class="textlabel">Bill No</td>
<td class="textlabel"><input class="textfieldfont" id="billNo" name="billNo" fmnd="Y" size="15"  value="<%=itranRmk%>" disabled="true" ></td>
</tr>
<tr>
<td class="textlabel">Phone No</td>
<td class="textlabel"><input class="textfieldfont" id="phNo" name="phNo" fmnd="Y" size="15"  value=""  ></td>
</tr>
<tr>
<td class="textlabel">Customer Location</td>
<td class="textlabel"><input class="textfieldfont" id="custLoc" name="custLoc" fmnd="Y" size="15"  value=""  ></td>
</tr>
<tr>
<input type="hidden" class="textfieldfont" id="hiddenLocCode" name="hiddeLocCode">
<input type="hidden" class="textfieldfont" id="hiddenGetVal" name="hiddeLocCode">
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
<br>
<input type="button"  class="button"  VALUE="Submit" size = 1 onClick = "javascript:sendValues(this);">
<input type="reset"   class="button"  VALUE="Clear" size = 1 >
</TABLE>
</form>
</body>
</html>


