<!---------------------------------------------------------------------------------------------------------------->
<!--Name                :salpayres_custom.jsp
<!--Description         :
<!--Date                :14-03-2013
<!--Author              :
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HTM
<!--Modification History:
<!--   Version No.       Date               Author             Description
<!--    -------         ----------         -----------        ------------------
<!--     0.1            14-03-2013           Prakash           Original version
<!---------------------------------------------------------------------------------------------------------------->

<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<arjsp:init groupName="arjspmorph" isEntryPoint="false" />
<%@ include file="../../custom/commonInclude.jsp"%>



<%
String detl=(String)(request.getParameter("trandeatail")!=null?request.getParameter("trandeatail"):"");
String headCtxSol=(String)(request.getParameter("headCtxSol")!=null?request.getParameter("headCtxSol"):"");
%>

<html>
<head>
<TITLE></TITLE>

<LINK href="../Renderer/stylesheets/<%=VRPKeys.getFile("services.css",sProfileId)%>" rel=STYLESHEET  title="Finacle Stylesheet" type="text/css" />
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("custom_functions.js",sProfileId)%>"></script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getCustomFile("common_functions.js",sProfileId)%>"></script>

<script type="text/javascript">
var trdtl=<%=detl%>;
var mysol='<%=headCtxSol%>';
/*
  Javascript trim, ltrim, rtrim
*/


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

/*
  Javascript on load values assining to the fields.
*/
function fnPrintAction(){
	var str = trdtl;	
	var n=str.indexOf("D"); 
	var n1=str.lastIndexOf("T"); 
	var a = str.substring(n+1,n1);
	
	var  tId = ltrim(rtrim(a,'' ),'');

	var p = str.indexOf("e"); 
	var q =  str.substring(p+1,str.length);
	var  tDate = ltrim(rtrim(q,'' ),'');

	document.forms[0].tranId.value = tId;
	document.forms[0].tranDate.value = tDate;
    document.forms[0].solid.value= mysol;
	return true;

}

function fnscriptcal(){

	if(document.forms[0].chgrcode.value == ""){
		alert("Please enter the charge Code");
		document.forms[0].chgrcode.focus();
		return false;	
	}

	var inputNameValues    = "tranid|"+document.forms[0].tranId.value+"|trandate|"+document.forms[0].tranDate.value+"|chgrcode|"+document.forms[0].chgrcode.value;
	var outputNames        = "";
	var scrName            = "salpaymn001.scr";
	var retVal             = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
	ret = retVal.split("|");
	if(ret[0] == "Error") {
		alert(ret[1]);
	}
	else {
		alert(ret[1]);
		window.close();	
	}
	return true;
}

function fnCustSearcher() {
	var inputNameValues = "";
        var outputNames = "chgrcode|chgrdesc";
        var scrName     = "salpaydp001.scr";
        var title       = "Charge Codes Salpay ";
        var literalNames= "Charge Code|Description";
        var hyperLnks   = "1";
        var retVal = fnExecuteScriptForList(inputNameValues, outputNames , scrName, title, literalNames, "1", true);
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
<title>SALPAY</title>
<h3> &nbsp;&nbsp;SALARY CHARGES MENU </h3>
<h4> &nbsp;&nbsp;Salary Credit Commision </h4>

</head>
<body onLoad="javascript:fnPrintAction()" >
<form>
<br>
<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0" CLASS="ctable">
<TR>
<td>
<TABLE width="100%" class="tableborder" border="0" cellspacing="0" cellpadding="0">
<tr>
<td colspan="2">
<TABLE width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">
<tr><td>&nbsp;</td></tr>
<tr>
<td>
<TABLE width="100%" border="0" cellpadding="0" cellspacing="0" class="ctable">
<tr>
<td class="textlabel">Function</td>
<td class="textlabel"><input class="textfieldfont" id="func" name="func" fmnd="Y" size="10" maxlength="10" value="C - Charge" readOnly >
</td>
</tr>
<tr>
<td class="textlabel">Sol ID</td>
<td class="textlabel"><input class="textfieldfont" id="solid" name="solid" fmnd="Y" size="10" maxlength="10" value="" readOnly >
</td>
</tr>
<tr>
<td class="textlabel">Tran Id</td>
<td class="textlabel"><input class="textfieldfont" id="tranId" name="tranId" fmnd="Y" size="10" maxlength="10" value="" readOnly >
</td>
</tr>
<tr>
<td class="textlabel">Tran Date</td>
<td class="textlabel"><input class="textfieldfont" id="tranDate" name="tranDate" size="10" maxlength="10" value="" readOnly >
</td>
</tr>
<tr>
<td class="textlabel">Charge Code</td>
<td class="textlabel">
<input class="textlabel" type="text" id="chgrcode" name="chgrcode" size="10" maxlength="10" value="">
<a href="javascript:fnCustSearcher();" id="solIdList">
<img id="benfList1" width="16" height="17" border="0"  hotKeyId="search1" src="../Renderer/images/search_icon.gif"></img></a>
<input class="label" type="text" id="chgrdesc" name="chgrdesc" size="10" maxlength="10" value="">
</td>
</td>
</tr>
</TABLE>
</td>
</TR>
</TABLE>
</td>
</TR>
</TABLE>
</TD>
</TR>
</TABLE>
&nbsp;
&nbsp;
<INPUT TYPE="BUTTON"  class="button"  VALUE="SUBMIT" size = 1 onClick="javascript:fnscriptcal()" >
&nbsp;
&nbsp;
<INPUT TYPE="BUTTON"  class="button" VALUE="Cancel" size = 1 onClick="javascript:window.close()">
</div>
</form>
</body>
</html>
