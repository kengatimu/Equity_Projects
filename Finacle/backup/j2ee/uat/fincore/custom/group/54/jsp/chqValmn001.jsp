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
<!--     0.2            03-03-2013           Shishira           Modified version
<!---------------------------------------------------------------------------------------------------------------->
<arjsp:init groupName="outwardclearing" isEntryPoint="false" />
<%@ include file="../../commonInclude.jsp"%>

<%
         String sProfileId   = ProfilesManager.getProfileInSession(session);
%>
<custom:getRepository/>
<%
String iacctNum=request.getParameter("acctNo");
String iamt=request.getParameter("amt");
String ifee=request.getParameter("fee");
String iref=request.getParameter("ref");
String iben=request.getParameter("ben");
String ipart=request.getParameter("part");
String irefchoice=request.getParameter("refchoice");
String iinclforcount=request.getParameter("inclforcount");
String icountbiller=request.getParameter("countbiller");
String errormsg1=request.getParameter("errormsg1");
String errormsg2=request.getParameter("errormsg2");
String errormsg3=request.getParameter("errormsg3");
String errormsg4=request.getParameter("errormsg4");
String acctName=request.getParameter("acctName");
double ttlAmt=Double.parseDouble(iamt)+ Double.parseDouble(ifee);
String totalAmt=String.valueOf(ttlAmt);
%>

<html>
<head>
<TITLE> </TITLE>

<LINK href="../Renderer/stylesheets/<%=VRPKeys.getFile("services.css",sProfileId)%>" rel=STYLESHEET  title="Finacle Stylesheet" type="text/css" />

<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("cust_common_functions.js",sProfileId)%>"></script>
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("custom_functions.js",sProfileId)%>"></script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getCustomFile("common_functions.js",sProfileId)%>"></script>
<script type="text/javascript">
var irefchoice = '<%=irefchoice%>';
var iinclforcount ='<%=iinclforcount%>';
var icountbiller = '<%=icountbiller%>';
var errormsg1 = '<%=errormsg1%>';
var errormsg2 = '<%=errormsg2%>';
var errormsg3 = '<%=errormsg3%>';
var errormsg4 = '<%=errormsg4%>';
var field="";

function fnOnclickRadio(){
element = document.getElementsByName("ref");
if(element[1].checked) {
document.getElementById('refNoL').style.visibility = "hidden";
document.getElementById('refNo').style.visibility = "hidden";
document.getElementById('custIdL').style.visibility = "visible";
document.getElementById('custId').style.visibility = "visible";
field="custId";
}
else 
{
document.getElementById('custIdL').style.visibility = "hidden";
document.getElementById('custId').style.visibility = "hidden";
document.getElementById('refNoL').style.visibility = "visible";
document.getElementById('refNo').style.visibility = "visible";
field="refNoI";
}
}
		function sendValues(obj){
			var acctNum 	= document.forms[0].acctNum.value;
			var amount 	= document.forms[0].amount.value;
			var charges 	= document.forms[0].charges.value;
			var refObj    = document.getElementsByName("ref");
			var ref       = refObj[0].checked;
			var ref1       = refObj[1].checked;
if(ref==false) 
{ if(ref1==false){ alert("RISK NOTE AVAILABLE (Y/N) SHOULD BE SELECTED IN OPTION ....VALID VALUES N AND Y"); return false;}}
			if(ref=="true"){ ref="Y"; } else {ref ="N";}
			var tAmt 	= document.forms[0].tAmt.value;
			var Ben 	= (document.forms[0].Ben.value).toUpperCase();
			var Part	= (document.forms[0].Part.value).toUpperCase();
			var cnfrmObj	= document.getElementsByName("cnfrm");
 if(field=="refNoI"){
var refNo =document.forms[0].refNo.value;
                        if(refNo==""){
                                alert("Enter Risk Note No");
                                document.forms[0].refNo.focus();
                                return false;
                        }

                        if(isNaN(refNo)){
                                alert("Enter valid Risk Note No");
                                document.forms[0].refNo.focus();
                                return false;
                        }
}
if(field=="custId"){ var refNo =document.forms[0].custId.value;
                        if(refNo==""){
                                alert("Enter cust Id");
                                document.forms[0].custId.focus();
                                return false;
                        }

                        if(isNaN(refNo)){
                                alert("Enter valid cust Id");
                                document.forms[0].custId.focus();
                                return false;
                        }
}
				if(amount==""){
					alert("Please Enter Amount");
					document.forms[0].amount.focus();
					return false;
				}
				if(isNaN(amount)){
					alert("Enter valid amount");
					document.forms[0].amount.focus();
					return false;
				}
				if(amount <= 0){
					alert("Amount Should Be Greater than Zero");
					document.forms[0].amount.focus();
					return false;
				}
                                if(Ben==""){
                                        alert("Please Enter "+'<%=iben%>');
                                        document.forms[0].Ben.focus();
                                        return false;
                                }
                                if(Part==""){
                                        alert("Please Enter "+'<%=ipart%>');
                                        document.forms[0].Part.focus();
                                        return false;
                                }
				
				var inputNameValues    ="refNo|"+refNo+"|acctNum|"+acctNum+"|amount|"+ amount +"|ref|"+ref+"|Part|"+Part+"|refchoice|"+irefchoice +"|inclforcount|"+iinclforcount +"|countbiller|"+icountbiller +"|errormsg1|"+errormsg1+"|errormsg2|"+errormsg2+"|errormsg3|"+errormsg3+"|errormsg4|"+errormsg4+"|mark|first"+"|rskNot|N"+"|srlnum|1" 
				var outputNames        = "MSG|URL|field4|field5|field6";
				var scrName            = "chqValmn004.scr";
				var retVal 		= appFnExecuteScriptCust(inputNameValues, outputNames, scrName, false);
				if(retVal==undefined){ return false; }
				var ret = retVal.split("|");
				if( ret[0] == "Err"){
					alert(ret[1]);
					return false;
				}
				if( ret[0]== "MSG" ){
					if(isNaN(ret[1])){ if(ret[1]!="Dummy"){ alert(ret[1]); }}
				}
					if (ret[3]!="Dummy"){
						var url=ret[3];
						var srlNum=ret[1];
						var rskNot=ret[5];
						window.open(url,"win1","width=600,height=520,left=20,top=80,resizable=1,status=0,toolbar=0,scrollbars=1");
						var inputNameValues    ="refNo|"+refNo+"|acctNum|"+acctNum+"|amount|"+ amount +"|ref|"+ref+"|Part|"+Part+"|refchoice|"+irefchoice +"|inclforcount|"+iinclforcount +"|countbiller|"+icountbiller +"|errormsg1|"+errormsg1+"|errormsg2|"+errormsg2+"|errormsg3|"+errormsg3+"|errormsg4|"+errormsg4+"|mark|second"+"|rskNot|"+rskNot+"|srlnum|"+srlNum
						var outputNames1        = "MSG|URL|field4|field5|field6";
						var scrName1            = "chqValmn004.scr";
						var retVal1              = appFnExecuteScriptCust(inputNameValues, outputNames1, scrName1, false);
						if(retVal1==undefined){ return false; }
						var ret1 = retVal1.split("|");
						if(ret1[0] == "Err"){
							alert(ret1[1]);
							return false;
						}
						if(ret1[0]== "MSG" ){
							if(ret1[1]!="Dummy"){ alert(ret1[1]); } 
						}
						if(ret1[5]!="Dummy"){
							if(field="refNo"){ document.forms[0].refNo.value=ret1[5]; }
							if(field="custId"){ document.forms[0].custId.value=ret1[5]; }
						}
						if(ret1[7]!="Dummy"){
							document.forms[0].Ben.value=ret1[7];
						}
						if(ret1[9]!="Dummy"){
							document.forms[0].Part.value=ret1[9];
						}
					}					
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
</script>
</head>
<body>
<form name="form1">
<div name="div1" id="div1">
<br>
<h3> &nbsp;&nbsp;COLLECTIONS A/C</h3>
<h4> &nbsp;&nbsp;ADDITIONAL DATA CAPTURE SCREEN</h4>
<h5> &nbsp;&nbsp;<%=acctName%> </h5>
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
<td class="textlabel"><input class="textfieldfont" id="acctNum" name="acctNum" fmnd="Y" size="15"  value="<%=iacctNum%>" ></td>
</tr>
<tr>
<td class="textlabel">Amount</td>
<td class="textlabel"><input class="textfieldfont" id="amount" name="amount" fmnd="Y" size="15"  value="<%=iamt%>" ></td>
</tr>
<tr>
<td class="textlabel">Charges</td>
<td class="textlabel"><input class="textfieldfont" id="charges" name="charges" fmnd="Y" size="15"  value="<%=ifee%>"  ></td>
</tr>
<tr>
<td class="textlabel">Option</td>
<td><input type="radio" name="ref" onClick="javascript:fnOnclickRadio()">Yes
<input type="radio" name="ref" onClick="javascript:fnOnclickRadio()">No</td>
</tr>
<tr>
<td class="textlabel" id="refNoL">Risk Note No</td>
<td class="textlabel"><input class="textfieldfont" id="refNo" name="refNo" fmnd="Y" size="15"  value=""  ></td>
</tr>
<tr>
<td class="textlabel" id="custIdL">Cust Id</td>
<td class="textlabel"><input class="textfieldfont" id="custId" name="custId" fmnd="Y" size="15"  value=""  ></td>
</tr>
<tr>
<td class="textlabel"><%=iben%></td>
<td class="textlabel"><input class="textfieldfont" id="Ben" name="Ben" fmnd="Y" size="15"  value=""  ></td>
</tr>
<tr>
<td class="textlabel"><%=ipart%></td>
<td class="textlabel"><input class="textfieldfont" id="Part" name="Part" fmnd="Y" size="15"  value=""  ></td>
</tr>
<tr>
<td class="textlabel">Total Amt</td>
<td class="textlabel"><input class="textfieldfont" id="tAmt" name="TAmt" fmnd="Y" size="15"  value="<%=totalAmt%>"  ></td>
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
