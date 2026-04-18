<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : collectdp002.jsp
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
<custom:getRepository/>
<%@ include file='../../custom/commonInclude.jsp'%>


<%
         String sProfileId   = ProfilesManager.getProfileInSession(session);
%>



<html>
<head>
<TITLE>COLLECTIONS A/C </TITLE>

<LINK href="../Renderer/stylesheets/<%=VRPKeys.getFile("services.css",sProfileId)%>" rel=STYLESHEET  title="Finacle Stylesheet" type="text/css" />

<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("custom_functions.js",sProfileId)%>"></script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getCustomFile("common_functions.js",sProfileId)%>"></script>
<%
String acctnum =(String)(request.getParameter("acctno")!=null?request.getParameter("acctno"):"");
String amt=request.getParameter("amt");
String fee =(String)(request.getParameter("fee")!=null?request.getParameter("fee"):"");
String prod =(String)(request.getParameter("Product")!=null?request.getParameter("Product"):"");
%>

<script type="text/javascript">
var acctno = <%=acctnum%>; 
var tamt = <%=amt%>;
var fees = <%=fee%>;
var prodct = '<%=prod%>';

function fnPrintAction(){
document.forms[0].actno.value = acctno;
document.forms[0].amt.value = tamt;
document.forms[0].chrg.value = fees;
document.forms[0].totamt.value = tamt + fees;

return true;
}

function trim(str, chars) {
	return ltrim(rtrim(str, chars), chars);
}
 
function ltrim(str, chars) {
	chars = chars || "\\s";
	return str.replace(new RegExp("^[" + chars + "]+", "g"), "");
}
 
function rtrim(str, chars) {
	chars = chars || "\\s";
	return str.replace(new RegExp("[" + chars + "]+$", "g"), "");
}

function LPad(ContentToSize,PadLength,PadChar)
  {
     var PaddedString=ContentToSize.toString();
     for(i=ContentToSize.length+1;I<=PadLength;i++)
     {
         PaddedString=PadChar+PaddedString;
     }
     return PaddedString;
  }


function sendValues(obj)
{
	if( document.forms[0].amt.value == "" )
	{
		alert("Please Enter the amount");
		document.forms[0].amt.focus();
		return false;
	}else if( document.forms[0].amt.value == "0" )
	{
		alert("Amount should be greater that zero");
		document.forms[0].amt.focus();
		return false;


	}

	var a = document.forms[0].trnid.value;
	var  tId = ltrim(rtrim(a,'' ),'');
	document.forms[0].trnid.value = tId;
	if(tId == "" )
	{
		alert("Enter the tran id to be reversed");
		document.forms[0].trnid.focus();
		return false;
	}
	else if( tId != "NONE") {
		if( document.forms[0].trndate.value == "" )
		{
			alert("Enter the tran date for the tran id to be reversed");
			document.forms[0].trndate.focus();
			return false;
		}

	}





var inputNameValues = "acctnum|"+document.forms[0].actno.value +"|amt|"+document.forms[0].amt.value +"|tranid|"+document.forms[0].trnid.value +"|tdate|"+document.forms[0].trndate.value +"|prodct|"+prodct;
    var outputNames        = "";
    var scrName            = "collectdp002.scr";
    var retVal             = appFnExecuteScriptCust(inputNameValues, outputNames, scrName, false);
    var ret = retVal.split("|");
	alert(retVal);
	if(ret[0] == "Error"){
		alert(ret[1]);
		return false;
	}
	sendObj={amt:document.forms[0].amt.value,tranid:document.forms[0].trnid.value,trandate:document.forms[0].trndate.value,partclr:ret[1]};
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

function fnExecuteScriptForListCust(inputNameValues, outputNames, scrName, pageTitle, literalNames, hyperLnkCols, isPopulationReq)
{
        var sUrl = "cust_fetch_list.jsp?";
        if((inputNameValues.indexOf("pageNumber") != -1) && (inputNameValues.indexOf("pageSize") == -1))
        {
                alert("Page Size is mandatory");
                return;
        }

        if((inputNameValues.indexOf("pageSize") != -1) && (inputNameValues.indexOf("pageNumber") == -1))
        {
                alert("Page Number is mandatory");
                return;
        }

        if(!cust_fnIsNull(inputNameValues))
                sUrl += "&inputs="+encodeURIComponent(inputNameValues);

        if(cust_fnIsNull(scrName))
        {
                alert("Script Name is mandatory");
                return;
        }

        sUrl += "&scrName="+scrName;


        if(cust_fnIsNull(outputNames))
        {
                alert("List ouput field names are mandatory");
                return;
        }

        sUrl += "&outputs="+outputNames;


        if(cust_fnIsNull(pageTitle))
        {
                pageTitle=finbranchResource.FHP000368;
        }

        sUrl += "&pageTitle="+encodeURIComponent(pageTitle);
        
 	if(cust_fnIsNull(literalNames))
         {
                 alert("Column Literal Names are mandatory");
                 return;
         }
 
         sUrl += "&literalNames="+encodeURIComponent(literalNames);
 
         if(cust_fnIsNull(hyperLnkCols))
         {
                 hyperLnkCols="1";
         }
 
         sUrl += "&hyperLnkCols="+hyperLnkCols;
 
         var retVal = cust_popModalWindow(sUrl, "Custom List");
 
         if (retVal == null || retVal == undefined)
                 return retVal;
 
         if (!isPopulationReq)
                 return retVal;
 
         if ("Microsoft Internet Explorer" == browser_name)
         {
                 var frm = document.forms[0];
                 var outBuff = outputNames.split("|");
                 var outBuffLen = outBuff.length;
                 var retBuff = retVal.split("|");
 
                 for (var i=0; i<outBuffLen; i++)
                 {
                         if ((eval("frm." + outBuff[i]) != undefined))
                         {
                                 eval("frm."+outBuff[i]+".value=\""+retBuff[i]+"\"");
                         }
                 }
         }
}
</script>
<body onLoad="javascript:fnPrintAction();">
<form name="form1">
<div name="div1" id="div1">
<br>
<h3> &nbsp;&nbsp; </h3>
<h4> &nbsp;&nbsp;TRANSACTION REVERSAL CAPTURE SCREEN</h4>
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
<td class="textlabel">A/c Number  </td>
<td class="textlabel"><input class="textfieldfont" id="actno" name="actno" size="25"  value="" readOnly></td>
</tr>
<tr>
<tr>
<td class="textlabel">Amount </td>
<td class="textlabel"><input class="textfieldfont" id="amt" name="amt" size="25"  value=""  ></td>
</tr>
<tr>
<td class="textlabel">Charges</td>
<td class="textlabel"><input class="textfieldfont" id="chrg" name="chrg" size="25" value=""  ></td>
</tr>
<tr>
<td class="textlabel">Rev.Tran ID</td>
<td class="textlabel"><input class="textfieldfont" id="trnid" name="trnid" size="25"  value=""  ></td>
</tr>
<tr>
<td class="textlabel">Tran Date(DD-MM-YYYY)</td>
<td class="textlabel"><input class="textfieldfont" id="trndate" name="trndate" size="25"  value=""></td>
</tr>
<tr>
<td class="textlabel">Total Amount</td>
<td class="textlabel"><input class="textfieldfont" id="totamt" name="totamt" size="25"  value="" ></td>
</tr>
<tr>
<td class="textlabel">Tran Particulars</td>
<td class="textlabel"><input class="textfieldfont" id="trnprt" name="trnprt" size="25"  value="" ></td>
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
