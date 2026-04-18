<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : clgUpldformmn001.jsp
<!--Description         : This file should reside in finbranch/custom/jsp folder.
<!--Date                : 06-03-2013
<!--Author              : Shishira
<!--Called By           : outward_clearing_custom.jsp
<!--Calling jsp         : None
<!--Menu Option         : HCLUPLD
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------         -----------        ------------------
<!--     0.1            06-03-2013           Shishira           Original version
<!--     0.2            20-06-2013           Shishira           Fetching Data from main menu
<!--     0.3            24-06-2013           Shishira           Fetching Date
<!---------------------------------------------------------------------------------------------------------------->
<%@ page import="java.util.*,com.infy.finacle.fcutil.SecurityConstants,java.io.File,applcommon.AppProperties"%>
<arjsp:init groupName="batch" isEntryPoint="false" />
<%@ include file="../commonInclude.jsp"%>
<custom:getRepository/>
<%
String zoneCodeM=request.getParameter("zoneCodeM");
String zoneDateM=request.getParameter("zoneDateM");
String inpFilNameM=request.getParameter("inpFilNameM");
%>

<html>
<head>
<%
SecurityInfo70 securityInfo = (SecurityInfo70)session.getAttribute("FinUserInfo");
%>


<TITLE> O/W CLEARING FILE UPLOAD </TITLE>
<LINK href="../Renderer/stylesheets/<%=VRPKeys.getFile("services.css",sProfileId)%>" rel=STYLESHEET  title="Finacle Stylesheet" type="text/css" />

<script type="text/javascript">
var calbase = "00"
var rtId = "<%=(String) session.getAttribute(SecurityConstants.rtId)%>";
var dateFormat = /(0[1-9]|[12][0-9]|3[01])-(0[1-9]|1[012])-\d{4}/ ;
</script>
<%--
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getCustomFile("custom_functions.js",sProfileId)%>"></script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getCustomFile("common_functions.js",sProfileId)%>"></script>
--%>
<script language="javascript" src="../../../javascripts/hotkeyprocessor_link.js" > </script>
<script language="javascript" src="../../../javascripts/hotkeydata_link.js"></script>
<script type="text/javascript">

var BODDate= "<%=zoneDateM%>";
function fnvalues(){
document.forms[0].zoneDate_ui.value ="<%=zoneDateM%>";
document.forms[0].zoneCode.value="<%=zoneCodeM%>";
document.forms[0].fileName.value="<%=inpFilNameM%>";
}

function sendValues(obj) {
	var zoneDate = document.forms[0].zoneDate_ui.value;
	var zoneCode = document.forms[0].zoneCode.value.toUpperCase();
	var fileName =  document.forms[0].fileName.value;
	
	//The following step is to Validate fields
	
	if( zoneDate == "" )
	{
		alert("Please Enter the Zone Date");
		document.forms[0].zoneDate_ui.focus();
		return false;
	}
	
	if(zoneDate !="")
	{
		var dateFormat = /(0[1-9]|[12][0-9]|3[01])-(0[1-9]|1[012])-\d{4}/ ;
		if(!zoneDate.match(dateFormat)){
    		alert("Zone Date must be in format: DD-MM-YYYY");
    		return false;
		}
	}

	if( zoneCode == "" )
	{
		alert("Please Enter the Zone Code");
		document.forms[0].zoneCode.focus();
		return false;
	}
	if( fileName == "" )
	{
		alert("Please Enter The File Name");
		document.forms[0].fileName.focus();
		return false;
	}

    var inputNameValues    = "zoneDate|"+ zoneDate +"|zoneCode|"+ zoneCode +"|fileName|"+ fileName ;
	var outputNames        = "";
	var scrName            = "clgUpldformmn001.scr";
	var retVal 		= appFnExecuteScriptCust(inputNameValues, outputNames, scrName, false);
	var ret = retVal.split("|");
	if( ret[0] == "Err"){
		return false;
	}
	else if( ret[0] == "MSG" )
	{
		alert(ret[1]);
		return false;
	}
	else
	{
		alert(ret[1]);
	}	

	sendObj={zoneDate:document.forms[0].zoneDate_ui.value,zoneCode:document.forms[0].zoneCode.value,fileName:document.forms[0].fileName.value};
	window.returnValue = sendObj;
	window.close();
}

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




//Function to show the calendar
function openDate(obj,inpDate){
       
		 var date = "";
        if(inpDate == null) inpDate = '';

        /* Date selector enhancement:Start */
		var objName = String(obj.name);
        objName = objName.substring(0,(objName.length -3));
        hidObj = document.getElementsByName(objName);
        var i = (obj.fmult == "Y")?obj.recNum:0;
        var hidVal = hidObj[i].value;
	
	//calbase = "00"

        if((calbase == "01")&&(hidVal != null)&&(hidVal != "")&&(hidVal != "undefined"))
    {
        if(!chkHijriMapping(hidVal))
        {
            alert(finbranchResArr.get("FAT002843"));
                return;
        }
    }

        hidVal = (!fnIsValidContextDate(hidObj[i]))?inpDate:hidVal;

        date = popCalendarModalWindowVar("../../../arjspmorph/"+applangcode+"/date.jsp?txtDate="+obj.id+"&date="+inpDate+"&dateVal="+hidVal+"&calbase="+calbase,"Calendar",225
,160,15,12);
    /* Date selector enhancement:End  */

        if(date != null){
                //set the value to ui and hidden fields.
                obj.value = fnConvertToUIDate(date);
                fnAssignDateOnEnter(obj);

                /*changes for the ticket 246672*/
        fnSetFocusForDate(obj);
        }
}

 function fnIsValidContextDate(dateObj){



                var lstrDobFlg;
                var liLowYear=1900;

                a_strDate=dateObj.value;

                if(a_strDate=="")
                        return false;

                if(a_strDate.indexOf("/") != -1)
                        var a_strDate = a_strDate.split("/");
                else
                        if(a_strDate.indexOf("-") != -1)
                                var a_strDate = a_strDate.split("-");
                        else
                                if(a_strDate.indexOf(".") != -1)
                                        var a_strDate = a_strDate.split(".");
                                else
                                {
                                        return false;
                                }
                a_strDay = a_strDate[0];
                a_strMonth = a_strDate[1];
                a_strYear = a_strDate[2];
                if(a_strDay.length==1)
                {
                        a_strDay="0"+a_strDay;
                }
                if(a_strMonth.length==1)
                {
                        a_strMonth="0"+a_strMonth;
                }
                lstrDobFlg = dateObj.getAttribute("fdob");
                // if it is a date of birth field set lower year as 1850
                if (lstrDobFlg != null && lstrDobFlg == "Y")
                        liLowYear=1850;

                if ( ( isNaN( a_strYear ) ) || ( isNaN( a_strMonth ) ) || ( isNaN( a_strDay ) ) || a_strDay.length <=1) {
                        return false;
                }
                else {
                        if ( ( a_strYear < liLowYear ) || ( a_strYear > 2099 ) || ( a_strMonth > 12 ) || ( a_strMonth<1 ) || ( a_strDay < 1 ) || ( a_strDay > 31 ) || (
( ( a_strMonth == 4 ) || ( a_strMonth == 6 ) || ( a_strMonth == 9 ) || (  a_strMonth == 11 ) ) && ( a_strDay > 30 ) ) )
                                return false;
                        else {
                                if ( ( a_strYear % 4 == 0 ) && ( ( a_strYear % 100 != 0 ) || ( a_strYear % 400 == 0 ) ) )       {
                                        if ( ( a_strMonth == 2 ) && ( ( a_strDay > 29 ) || ( a_strDay < 1 ) ) ) {
                                                return false;
                                        }
                                }
                                else {
                                        if ( ( a_strMonth == 2 ) && ( ( a_strDay > 28 ) || ( a_strDay < 1 ) ) ) {
                                                return false;
                                        }
                                }
                        } // end of else
                }//end of else
                return true;

}

</script>
</head>
<body onload="javascript:fnvalues();">
<form name="form1">
<div name="div1" id="div1">
<br>
<h3> &nbsp;&nbsp;O/W CLEARING FILE UPLOAD</h3>
<h4> &nbsp;&nbsp;FTP SCREEN</h4>
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
<TABLE width="150%" border="0" cellpadding="0" cellspacing="0" class="ctable">
<tr>

<td class="textlabel">Zone Date
<input type="hidden" id="zoneDate" fdt="fdate" fmnd="Y"  mneb1="N" vFldId="zoneDate_ui" name="zoneDate" >
</td>
<td class="textlabel"><input class="textfieldfont" id="zoneDate_ui" name="zoneDate_ui" fmnd="Y" size="15" fdt="uidate" mnebl="false" fblk="defaultFblk1" hotKeyId1="calender2" ></td>
<td><a id="toDateImg" href="javascript:openDate(document.forms[0].zoneDate_ui,BODDate)">
<img width="24" height="19" src="../images/INFENG/calender.gif" align="absmiddle" border="0" alt="Date picker" style="cursor:hand"></a>
<!--  <input type="hidden" id="zoneDate" fdt="fdate" fmnd="Y"  mneb1="N" vFldId="zoneDate_ui" name="zoneDate"> -->
</td>
</tr>

<tr>
<td class="textlabel">Zone Code</td>
<td class="textlabel"><input class="textfieldfont" id="zoneCode" name="zoneCode" fmnd="Y" size="15" ></td>
</tr>
<tr>
<td class="textlabel">Upload File Name</td>
<td class="textlabel"><input class="textfieldfont" id="fileName" name="fileName" fmnd="Y" size="15"></td>
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
