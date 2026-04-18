<!---------------------------------------------------------------------------------------------------------------->
<!--Name		: laadisbdp003.jsp
<!--Description		: This jsp is used to populate a new popup window
<!--Date		: 04-04-2013
<!--Author		: Sateesh
<!--Called By		: ladisbdet_custom.jsp
<!--Calling jsp		: None
<!--Menu Option		: HTM
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------         -----------        ------------------
<!--     0.1            04-04-2013           Sateesh           Original version
<!---------------------------------------------------------------------------------------------------------------->

<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<arjsp:init groupName="ladisb" isEntryPoint="false" />
<custom:getRepository/>
<%@ include file='../../../custom/commonInclude.jsp'%>
<%
String acctNum=request.getParameter("loanAcctId");
String disbAmt=request.getParameter("disbAmt");

%>

<html>
<head>
	<TITLE>SAFARICOM IPO</TITLE>
	<LINK href="../../stylesheets/services.css" rel=STYLESHEET  title="Finacle Stylesheet" type=text/css />

	<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("custom_functions.js",sProfileId)%>"></script>
	<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getCustomFile("common_functions.js",sProfileId)%>"></script>
	<script type="text/javascript">
		var acctNum=<%=acctNum%>;
		function sendValues(obj)
		{
			var amt		= document.forms[0].amt.value;
			var shares	= document.forms[0].shares.value;
			var regNum	= (document.forms[0].regNum.value).toUpperCase();
			var cdsNo	= (document.forms[0].cdsNo.value).toUpperCase();
			var category	= (document.forms[0].category.value).toUpperCase();


			var refNum = ' ';

			//The following step is to Amount fields
			if( amt == "" )
			{
				alert("Please Enter the amount");
				document.forms[0].amt.focus();
				return false;
			}
			else
			{
				if(isNaN(amt))
				{
					alert("Amount Cannot be String literal,Please enter Integer Literal");
					document.forms[0].amt.value = "";
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

			//The following step is to shares fields
			if( shares == "" )
			{
				alert("Please Enter the No.of Shares");
				document.forms[0].shares.focus();
				return false;
			}
			else
			{
				if(isNaN(shares))
				{
					alert("shares Cannot be String literal,Please enter Integer Literal");
					document.forms[0].shares.focus();
					document.forms[0].shares.value = "";
					return false;
				}
			}

			if( shares == 0 )
			{
				alert("No.of Shares should be greater that zero");
				document.forms[0].shares.focus();
				return false;
			}

			//The following step is to Validate REG number
			if( regNum == "" )
			{
				alert("Please Enter the REG number of the customer");
				document.forms[0].regNum.focus();
				return false;
			}

			//The following step is to Validate CDS number
			if( cdsNo == "" )
			{
				alert("Please Enter the CDS number of the customer");
				document.forms[0].cdsNo.focus();
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
					document.forms[0].category.value = "";
					return false;
				}
			}

			var disbAmt = <%=disbAmt%>;
			var inputNameValues	= "loanAcctId|"+acctNum+"|disbAmt|"+disbAmt+"|cdsNo|"+cdsNo+"|category|"+category+"|regNum|"+regNum+"|shares|"+shares;
			var outputNames		= "";
			var scrName		= "laadisbdp002.scr";
			var retVal		= appFnExecuteScriptCust(inputNameValues, outputNames, scrName, false);
			var ret = retVal.split("|");
			if( ret[0] == "Error" && ret[1]!="dummy" )
			{
				alert(ret[1]);
				if( ret[2] == "Fld" && ret[3]!="dummy" )
				{
					if ( ret[3] == "share" ) 
						document.forms[0].shares.focus();
					if ( ret[3] == "cdcNo" ) 
						document.forms[0].cdsNo.focus();
					if ( ret[3] == "regNo" ) 
						document.forms[0].regNum.focus();
				} 
				return false;
			}

			sendObj={amt:document.forms[0].amt.value,
			cdsNo:document.forms[0].cdsNo.value,
			category:document.forms[0].category.value,
			regNum:document.forms[0].regNum.value,
			shares:document.forms[0].shares.value
			};
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
<td class="textlabel">Amount</td>
<td class="textlabel"><input class="textfieldfont" id="amt" name="amt" size="25"  value="<%=disbAmt%>" disabled="true"></td>
</tr>
<tr>
<td class="textlabel">No of shares</td>
<td class="textlabel"><input class="textfieldfont" id="shares" name="shares" size="25" value=""  ></td>
</tr>
<tr>
<td class="textlabel">ID/PP/REG Number</td>
<td class="textlabel"><input class="textfieldfont" id="regNum" name="regNum" size="25" value="" ></td>
</tr>
<tr>
<td class="textlabel">CDS Number</td>
<td class="textlabel"><input class="textfieldfont" id="cdsNo" name="cdsNo" size="25" value=""  ></td>
</tr>
<tr>
<td class="textlabel">CATEGORY (R/I/D/E)</td>
<td class="textlabel"><input class="textfieldfont" id="category" name="category" size="25" value=""  ></td>
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
