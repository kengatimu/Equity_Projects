<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : sharedtmmn001.jsp
<!--Description         : This file should reside in finbranch/custom/jsp folder.
<!--Date                : 20-03-2013
<!--Author              : Divya
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HTM
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------         -----------        ------------------
<!--     0.1            20-03-2013           Divya           Original version
<!---------------------------------------------------------------------------------------------------------------->

<arjsp:init groupName="tm" isEntryPoint="false" />
<%@ include file='../../custom/commonInclude.jsp'%>

<html>
<head>
<TITLE>SHARED SERVICES </TITLE>

<LINK href="../../stylesheets/services.css" rel=STYLESHEET  title="Finacle Stylesheet" type=text/css />
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("custom_functions.js",sProfileId)%>"></script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getCustomFile("common_functions.js",sProfileId)%>"></script>
<%
String acctnum =(String)(request.getParameter("acctno")!=null?request.getParameter("acctno"):"");
String amt=request.getParameter("amt");
String feeamt =(String)(request.getParameter("feeamt")!=null?request.getParameter("feeamt"):"");
String alcy =(String)(request.getParameter("alcy")!=null?request.getParameter("alcy"):"");
String clcy =(String)(request.getParameter("clcy")!=null?request.getParameter("clcy"):"");
String trxtype =(String)(request.getParameter("trxtype")!=null?request.getParameter("trxtype"):"");
String pTranType =(String)(request.getParameter("pTranType")!=null?request.getParameter("pTranType"):"");
String tranType =(String)(request.getParameter("tranType")!=null?request.getParameter("tranType"):"");
String refAmt =(String)(request.getParameter("refAmt")!=null?request.getParameter("refAmt"):"");
%>


<script type="text/javascript">

var acctno = '<%=acctnum%>'; 
var tamt = '<%=amt%>';
var feeccy = '<%=feeamt%>';
var amtlcy = '<%=alcy%>';
var chargelcy = '<%=clcy%>';
var txntype = '<%=trxtype%>';
var partTranType = '<%=pTranType%>';
var trType = '<%=tranType%>';
var tranAmt = '<%=refAmt%>';

function fnPrintAction(){
document.forms[0].actno.value = acctno;
document.forms[0].amt.value = tamt;
document.forms[0].abal.value = tamt;
document.forms[0].ebal.value = tamt;
document.forms[0].fcy.value = feeccy;
document.forms[0].lcy.value = amtlcy;
document.forms[0].clcy.value = chargelcy;
document.forms[0].trxtype.value = tranAmt;

return true;
}



function sendValues(obj)
{

	if( document.forms[0].actno.value == "" )
	{
		alert("Please Enter the account number");
		document.forms[0].actno.focus();
		return false;
	}
	
	if( document.forms[0].amt.value == "" )
	{
		alert("Please Enter the amount");
		document.forms[0].amt.focus();
		return false;
	}else if( document.forms[0].amt.value == "0" )
	{
		alert("Amount should be greater than zero");
		document.forms[0].amt.focus();
		return false;
	}

	if( document.forms[0].conf.value == "" )
    {
        alert("Please Enter Y-Yes or N-No in the Confirm(Y/N) Field");
        document.forms[0].conf.focus();
        return false;
     }else if(document.forms[0].conf.value != "Y" && document.forms[0].conf.value != "N" )
    {
    	alert(document.forms[0].conf.value); 
	   alert("Valid Values N and Y");
        document.forms[0].conf.focus();
        return false;
    }



	var inputNameValues = "acctnum|"+document.forms[0].actno.value +"|amt|"+document.forms[0].amt.value +"|confirm|"+document.forms[0].conf.value + "|partTranType|" + partTranType + "|trType|" + trType;
    	var outputNames        = "";
    	var scrName            = "sharedtmdp002.scr";
    	var retVal             = appFnExecuteScriptCust(inputNameValues, outputNames, scrName, false);
    	var ret = retVal.split("|");	
		if(ret[0] =="Error"){
		alert(ret[1]);
		return false;
	}

	sendObj={remarks:ret[1],foracid:ret[3],acctName:ret[5]};
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

<body onLoad="javascript:fnPrintAction();">
<form name="form1">
<div name="div1" id="div1">
<br>
<h3> &nbsp;&nbsp;SHARED SERVICES </h3>
<h4> &nbsp;&nbsp;Transaction Data Capture Screen</h4>
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
<td class="textlabel"><input class="textfieldfont" id="actno" name="actno" size="25"  value=""  ></td>
</tr>
<tr>
<tr>
<td class="textlabel">A/c Bal </td>
<td class="textlabel"><input class="textfieldfont" id="amt" name="amt" size="25"  value=""  ></td>
</tr>
<tr>
<td class="textlabel">Shadow Bal</td>
<td class="textlabel"><input class="textfieldfont" id="sbal" name="sbal" size="25" value=""  ></td>
</tr>
<tr>
<td class="textlabel">Available Bal</td>
<td class="textlabel"><input class="textfieldfont" id="abal" name="abal" size="25"  value=""  ></td>
</tr>
<tr>
<td class="textlabel">Eff.Avail.Amt</td>
<td class="textlabel"><input class="textfieldfont" id="ebal" name="ebal" size="25"  value=""  ></td>
</tr>
<tr>
<td class="textlabel"><%=trxtype%></td>
<td class="textlabel"><input class="textfieldfont" id="trxtype" name="trxtype" size="25"  value=""  ></td>
</tr>
<tr>
<td class="textlabel">Charges in FCY</td>
<td class="textlabel"><input class="textfieldfont" id="fcy" name="fcy" size="25"  value="" ></td>
</tr>
<tr>
<td class="textlabel">Amount in Lcy</td>
<td class="textlabel"><input class="textfieldfont" id="lcy" name="lcy" size="25"  value="" ></td>
</tr>
<tr>
<td class="textlabel">Charges in LCY</td>
<td class="textlabel"><input class="textfieldfont" id="clcy" name="clcy" size="25"  value="" ></td>
</tr>
<tr>
<td class="textlabel">Confirm(Y/N)</td>
<td class="textlabel"><input class="textfieldfont" id="conf" name="conf" size="25"  value="" ></td>
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
