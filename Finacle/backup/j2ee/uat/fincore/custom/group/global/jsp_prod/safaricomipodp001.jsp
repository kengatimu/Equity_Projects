<!---------------------------------------------------------------------------------------------------------------->
<!--Name		: safaricomipodp001.jsp 
<!--Description		: This jsp is used to populate a new popup window
<!--Date		: 04-04-2013
<!--Author		: Saurabh
<!--Called By		: tmdet_custom.jsp
<!--Calling jsp		: None
<!--Menu Option		: HTM
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------         -----------        ------------------
<!--     0.1            04-04-2013           Saurabh           Original version
<!---------------------------------------------------------------------------------------------------------------->
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<arjsp:init groupName="tm" isEntryPoint="false" />
<%@ include file='../../custom/commonInclude.jsp'%>


<%
String amt=(String)(request.getParameter("amt")!=null?request.getParameter("amt"):"");
%>

<html>
<head>

<LINK href="../Renderer/stylesheets/<%=VRPKeys.getFile("services.css",sProfileId)%>" rel=STYLESHEET  title="Finacle Stylesheet" type="text/css" />
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("custom_functions.js",sProfileId)%>"></script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getCustomFile("common_functions.js",sProfileId)%>"></script>
<script type="text/javascript">

	function fnPrintAction(){
		document.forms[0].amt.value = "<%=amt%>";
	}
	function trim(str) {
        return str.replace(/^\s+|\s+$/g,"");
	}
	function sendValues(obj){
		var amt			= document.forms[0].amt.value;
		var tranDate	= document.forms[0].tranDate.value;
		var tranId		= document.forms[0].tranId.value;
			tranId		= tranId.toUpperCase();
			tranId		= trim(tranId);
		if( amt == "" )
		{
			alert("Please Enter the amount for the transaction to be reversed");
			document.forms[0].amt.focus();
			return false;
		}
		else
		{
			if(isNaN(amt))
			{
				alert("Amount Cannot be String literal,Please enter Integer Literal");
				document.forms[0].amt.focus();
				return false;
			}
		}

		if( tranDate == "" )
		{
			alert("Please Enter the Transaction date...");
			document.forms[0].tranDate.focus();
			return false;
		}
		if( tranId == "" )
		{
			alert("Please Enter the Transaction ID  for transaction to be reversed");
			document.forms[0].tranId.focus();
			return false;
		}
			var inputNameValues	= "amount|"+amt+"|tranDate|"+tranDate+"|tranId|"+tranId 
			var outputNames		= "";
			var scrName			= "safaricomipomn001.scr";
			var retVal			= appFnExecuteScriptCust(inputNameValues, outputNames, scrName, false);
			var ret = retVal.split("|");
			if(ret[0]="Error" && ret[1]!="")
			{
				alert(ret[1]);
				return false;
			}
			else
			{
				var tranPtcls=ret[3];
				var tranRmks=ret[5];
				var refNo=ret[7];
		
				sendObj={
				amt:document.forms[0].amt.value,
				tranPtcls:tranPtcls,
				tranRmks:tranRmks,
				refNo:refNo,
				tranId:document.forms[0].tranId.value,
				tranDate:document.forms[0].tranDate.value
				};
				window.returnValue = sendObj;
				window.close();
			}
		}

		function appFnExecuteScriptCust(inputNameValues, outputNames, scrName, isPopulationReq)
		{
			var sUrl = "../../arjspmorph/INFENG/stf_frm_fetch.jsp?";

			if(!fnIsNull(inputNameValues))
			sUrl += "&inputs="+ encodeURIComponent(inputNameValues);

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
</head>
<body onLoad="javascript:fnPrintAction();">
<form name="form1">
<div name="div1" id="div1">
<br>
<h3> &nbsp;&nbsp; </h3>
<h3>Trading Shares Maintainance </h3>
<h4>Data Capture Screen</h4>
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
		<td class="textlabel"><input class="textfieldfont" id="amt" name="amt" size="25"  value="<%=amt%>" ></td>
	</tr>
	
<!--<input type="hidden" id="tranDate" fdt="fdate" mneb1="N" vFldId="tranDate_ui" name="tranDate_ui">-->

	<tr>
		<td class="textlabel">TRAN DATE DD-MM-YYYY</td>
		<td class="textlabel"><input class="textfieldfont" id="tranDate" name="tranDate" size="25" value=""  ></td>
		<td>
		</td>
	</tr>
	<tr>
		<td class="textlabel">TRAN ID</td>
		<td class="textlabel"><input class="textfieldfont" id="tranId" name="tranId" size="25" value="" ></td>
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
