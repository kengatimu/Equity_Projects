<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : shareorddp001.jsp
<!--Description         : This file should reside in finbranch/custom/jsp folder.
<!--Date                : 21-01-2013
<!--Author              : Prakash
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HTM
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------         -----------        ------------------
<!--     0.1            21-01-2013           Prakash           Original version
<!---------------------------------------------------------------------------------------------------------------->
<arjsp:init groupName="tm" isEntryPoint="false" />
<%@ include file='../../custom/commonInclude.jsp'%>

<html>
<head>
<TITLE>SHARE ORDERING </TITLE>

<LINK href="../Renderer/stylesheets/<%=VRPKeys.getFile("services.css",sProfileId)%>" rel=STYLESHEET  title="Finacle Stylesheet" type="text/css" />

<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("custom_functions.js",sProfileId)%>"></script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getCustomFile("common_functions.js",sProfileId)%>"></script>
<%
String amt = (String)(request.getParameter("tramt")!= null?request.getParameter("tramt"):"");
%>


<script type="text/javascript">


var tamt = '<%=amt%>';

function fnPrintAction(){
	var temp = tamt;
	var index = temp.indexOf(",");
	 while(index != -1){
		temp = temp.replace(",","");				
		 index = temp.indexOf(",");
	}	
	document.forms[0].amt.value = temp;
	return true;
}

function sendValues(obj) {
	var amt = document.forms[0].amt.value;
	var crdno =  document.forms[0].crdno.value;
	var secrty =  document.forms[0].secrty.value;
	var prclmt =  document.forms[0].prclmt.value;
	
	//The following step is to Validate fields
	
	if( amt == "" )
	{
		alert("Please Enter the amount");
		document.forms[0].amt.focus();
		return false;
	}
	if( amt == 0 )
	{
		alert("Amount should be greater that zero");
		document.forms[0].amt.focus();
		return false;
	}


	 //The foll step is to Validate CDS number
        if( crdno == "" )
        {
                alert("Please Enter the CDS number of the customer");
                document.forms[0].crdno.focus();
                return false;
        }

        //The foll step is to Validate CDS number
        if( secrty == "" )
        {
                alert("Please Enter the Security you want to purchase");
                document.forms[0].secrty.focus();
                return false;
        }
        //The foll step is to Validate price limit

        if( prclmt == "" )
        {
                alert("Please Enter Max Price Limit for the shares");
                document.forms[0].prclmt.focus();
                return false;
        }
	

		var     inputNameValues    = "crdno1|"+crdno;
		var     outputNames        = "status";
		var     scrName            = "shareorddp002.scr";
		var     retVal   = appFnExecuteScriptCust(inputNameValues, outputNames,scrName, false);
		var ret = retVal.split("|");
		if( ret[0] == "Error") {
			alert(ret[1]);
			document.forms[0].crdno.focus();
			return false;
		}

	sendObj={amt:document.forms[0].amt.value,crdno:document.forms[0].crdno.value,secrty:document.forms[0].secrty.value,prclmt:document.forms[0].prclmt.value,name:ret[1]};
	window.returnValue = sendObj;
	window.close();
}

function valamt()
{
	if(isNaN(document.forms[0].amt.value))
	{
    alert("ENTER the Numeric value or valid amount code");
    document.forms[0].amt.focus();
	return false;
    }
}


function valnumber()
{
	if(isNaN(document.forms[0].prclmt.value))
	{
	alert("ENTER the Numeric value or valid amount code");
	document.forms[0].prclmt.focus();
	return false;
	}
}

function oncdcnoBlur(){

        var crdno =  document.forms[0].crdno.value;

        //The foll step is to Validate CDS number
    if( crdno != "" )
    {

    var     inputNameValues    = "crdno1|"+crdno;
    var     outputNames        = "status";
    var     scrName            = "shareorddp002.scr";
    var     retVal   = appFnExecuteScriptCust(inputNameValues, outputNames,scrName, false);
    var ret = retVal.split("|");
    	if( ret[0] == "Error") {
        	alert(ret[1]);
        	return false;
    	}

	    if( ret[1] == "I" )
    	{
        	alert(" Invalid CDC Number Value or Format.");
        	document.forms[0].crdno.focus();
        	return false;
    	}
	}

}
	
function fnExecuteScriptCust(inputNameValues, outputNames, scrName, isPopulationReq)
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

<body onLoad="javascript:fnPrintAction();">
<form name="form1">
<div name="div1" id="div1">
<br>
<h3> &nbsp;&nbsp;Share Ordering </h3>
<h4> &nbsp;&nbsp;Data Capture Screen</h4>
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
<td class="textlabel">Amount</td>
<td class="textlabel"><input class="textfieldfont" id="amt" name="amt" fmnd="Y" size="15"  value="" onBlur="javascript:valamt();"></td>
</tr>
<tr>
<td class="textlabel">CDS Number</td>
<td class="textlabel"><input class="textfieldfont" id="crdno" name="crdno" size="25"  value="" onBlur="javascript:oncdcnoBlur()" ></td>
</tr>
<tr>
<td class="textlabel">Security/Shares</td>
<td class="textlabel"><input class="textfieldfont" id="secrty" name="secrty" size="25" value=""  ></td>
</tr>
</tr>
<td class="textlabel">Price Limit</td>
<td class="textlabel"><input class="textfieldfont" id="prclmt" name="prclmt" size="25"  value="" ></td>
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
