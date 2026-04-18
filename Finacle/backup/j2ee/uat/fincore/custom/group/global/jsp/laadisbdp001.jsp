<!---------------------------------------------------------------------------------------------------------------->
<!--Name		: laadisbdp001.jsp
<!--Description		: This jsp is used to populate a new popup window
<!--Date		: 31-03-2013
<!--Author		: Sourabh
<!--Called By		: ladisbdet_custom.jsp
<!--Calling jsp		: None
<!--Menu Option		: HTM
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------         -----------        ------------------
<!--     0.1            31-03-2013           Sourabh           Original version
<!---------------------------------------------------------------------------------------------------------------->
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<arjsp:init groupName="ladisb" isEntryPoint="false" />
<custom:getRepository/>
<%@ include file='../commonInclude.jsp'%>
<%
         String sProfileId   = ProfilesManager.getProfileInSession(session);
%>

<%
String acctNum=request.getParameter("loanAcctId");
String amt=request.getParameter("amt");
String fee=request.getParameter("fee");
String disbAmt=request.getParameter("disbAmt");

double ttlAmt=Double.parseDouble(disbAmt)+ Double.parseDouble(fee);
String totalAmt=String.valueOf(ttlAmt);
%>

<html>
<head>
	<TITLE>Shares Investment Maintainance</TITLE>
	
<LINK href="../Renderer/stylesheets/<%=VRPKeys.getFile("services.css",sProfileId)%>" rel=STYLESHEET  title="Finacle Stylesheet" type="text/css" />
<%--
	<script language="javascript" src="../../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("custom_functions.js",sProfileId)%>"></script>
	<script language="javascript" src="../../Renderer/javascripts/<%=VRPKeys.getCustomFile("common_functions.js",sProfileId)%>"></script>
--%>
	<script type="text/javascript">
		var acctNum=<%=acctNum%>;
		function sendValues(obj) 
		{
			var shareInvAcct= (document.forms[0].shareInvAcct.value).toUpperCase();
			var amt		= document.forms[0].amt.value;
			var chrgs	= document.forms[0].chrgs.value;
			var cdscNo	= (document.forms[0].cdscNo.value).toUpperCase();
			var cdscName	= (document.forms[0].cdscName.value).toUpperCase();
			var category	= (document.forms[0].category.value).toUpperCase();
			//var srlNo	= document.forms[0].srlNo.value;
			//var shares	= document.forms[0].shares.value;
			var ttlamt	= document.forms[0].ttlamt.value;
			var tranPtclr	= document.forms[0].tranPtclr.value;
			var cnfrmObj	= document.getElementsByName("cnfrm");
			var cnfrm = cnfrmObj[0].value;
			var refNum = ' ';

			//The following step is to Validate Account No fields
			if( shareInvAcct == "" )
			{
				alert("Enter Shares Investment collections Account in the Share Investment A/c field");
				document.forms[0].shareInvAcct.focus();
				return false;
			}

			//The following step is to Amount fields
			if( amt == "" )
			{
				alert("Please Enter the amount");
				document.forms[0].amt.focus();
				return false;
			}
			else
			{
				var am = parseInt(amt);
				if(am < 0)
				{
					alert("Amount Cannot be String literal,Please enter Integer Literal");
					document.forms[0].amt.focus();
					return false;
				}
			}

			if( amt == 0 )
			{
				alert("Amount should be greater that zero");
				document.forms[0].amt.focus();
				return false;
			}

			//The following step is to Charges fields
			if( chrgs == "" )
			{
				alert("Please Enter the value for Charge");
				document.forms[0].chrgs.focus();
				return false;
			}

			//The following step is to Validate CDS number
			if( cdscNo == "" )
			{
				alert("Please Enter the CDS number of the customer");
				document.forms[0].cdscNo.focus();
				return false;
			}

			//The following step is to Category
			if( category == "" )
			{
				alert("Please Enter the value for category");
				document.forms[0].category.focus();
				return false;
			}
			else
			{
				if( (category != "R") && (category != "I") && (category != "D") && (category != "E") )
				{
					alert("Valid values for category R,I,D,E");
					document.forms[0].category.focus();
					return false;
				}
			}
			
			var disbAmt = <%=disbAmt%>;
			var inputNameValues	= "loanAcctId|"+acctNum+"|disbAmt|"+disbAmt+"|shareInvAcct|"+shareInvAcct+"|cnfrm|"+cnfrm+"|cdscNo|"+cdscNo+"|category|"+category;
			var outputNames		= "formTypeFlg";
			var scrName		= "laadisbdp006.scr";
			var retVal		= appFnExecuteScriptCust(inputNameValues, outputNames, scrName, false);
			var ret = retVal.split("|");
				
			if( ret[0] == "Error" && ret[1]!="dummy" )
			{
				alert(ret[1]);
				return false;
			}
			else
			{ 
				if( ret[2] == "iponame" && ret[3] != "dummy" )
				{
					document.forms[0].cdscName.value=ret[3];
				}

				if( ret[4] == "particulars" && ret[5] != "dummy" )
				{
					document.forms[0].tranPtclr.value = ret[5];
				}
				
				if( ret[6] == "ref" && ret[7] != "dummy" )
				{
					refNum=ret[7];
				}
			}

			sendObj={shareInvAcct:document.forms[0].shareInvAcct.value,amt:document.forms[0].amt.value,
			chrgs:document.forms[0].chrgs.value,cdscNo:document.forms[0].cdscNo.value,
			cdscName:document.forms[0].cdscName.value,category:document.forms[0].category.value,
			ttlamt:document.forms[0].ttlamt.value,tranPtclr:document.forms[0].tranPtclr.value,
			cnfrm:cnfrm,refNo:refNum};
			window.returnValue = sendObj;
			window.close();
		}

		function appFnExecuteScriptCust(inputNameValues, outputNames, scrName, isPopulationReq)
		{
			var sUrl = "../../../arjspmorph/INFENG/stf_frm_fetch.jsp?";

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

<body>
<form name="form1">
<div id="div1"></div>
<br>
<h3>Shares Investment Maintainance </h3>
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
<td class="textlabel">Share Investment A/c</td>
<td class="textlabel"><input class="textfieldfont" id="shareInvAcct" name="shareInvAcct"  size="25"  value="" ></td>
</tr>
<tr>
<td class="textlabel">Amount</td>
<td class="textlabel"><input class="textfieldfont" id="amt" name="amt" size="25"  value="<%=disbAmt%>" disabled="true"></td>
</tr>
<tr>
<td class="textlabel">Charges</td>
<td class="textlabel"><input class="textfieldfont" id="chrgs" name="chrgs" size="25" value="<%=fee%>" disabled="true"></td>
</tr>
<tr>
<td class="textlabel">Temp/CDSC Number</td>
<td class="textlabel"><input class="textfieldfont" id="cdscNo" name="cdscNo" size="25" value=""  ></td>
</tr>
<tr>
<td class="textlabel">Temp/CDSC Name</td>
<td class="textlabel"><input class="textfieldfont" id="cdscName" name="cdscName" size="25" value=""  ></td>
</tr>
<tr>
<td class="textlabel">CATEGORY (R/I/A/E)</td>
<td class="textlabel"><input class="textfieldfont" id="category" name="category" size="25" value=""  ></td>
</tr>
<tr>
<td class="textlabel">Total Amount</td>
<td class="textlabel"><input class="textfieldfont" id="ttlamt" name="ttlamt" size="25" value="<%=totalAmt%>" disabled="true" ></td>
</tr>
<tr>
<td class="textlabel">Tran Particulars</td>
<td class="textlabel"><input class="textfieldfont" id="tranPtclr" name="tranPtclr" size="50" value="" disabled="true" ></td>
</tr>
<tr>
<td class="textlabel">Confirm</td>
<td><input type="radio" name="cnfrm" value="Y"  checked="checked" disabled="true"/>Yes
<input type="radio" name="cnfrm" value="N" disabled="true"/>No</td>
</tr>
<tr>
</TABLE>
</td>
</tr>
</TABLE>
</td>
</tr>
</TABLE>
<br>
<INPUT TYPE="button"  class="button"  VALUE="Submit" size = 1 onClick = "javascript:sendValues(this);">
<INPUT TYPE="reset"   class="button"  VALUE="Clear" size = 1 >
</TABLE>
</td>
</TR>
</form>
</body>
</html>
