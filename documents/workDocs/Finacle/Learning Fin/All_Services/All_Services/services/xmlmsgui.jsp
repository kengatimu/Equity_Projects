<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Finacle Integrator XML Message Testing Interface</title>
		
		<META http-equiv=Content-Type content="text/html; charset=windows-1252">

		<SCRIPT LANGUAGE="JavaScript">
			
			function clearTextArea()
			{
				document.inputForm.ipXml.value = "";
				document.inputForm.opXml.value = "";
				document.inputForm.resPageBut.disabled = true;
			}
			
			function inputValid()
			{
				/*var ipStr = document.inputForm.ipXml.value;
				if(ipStr.indexOf("<IFX")==-1 && ipStr.indexOf("<FIXML")==-1)
				{
					alert("Invalid message format. Only IFX and Finacle messgae formats are supported.");
					return false;
				}*/
				return true;
			}

			function init()
			{
			        <% if(request.getAttribute("InputXML") != null) { %>
					document.inputForm.ipXml.value = "<%= request.getAttribute("InputXML") %>";
					//document.inputForm.ipXml.value = "Prasan";
				<% } %>
				
				
				
				<% if(request.getAttribute("OutputXML") != null) { %>  
				         document.inputForm.opXml.value = "<%= request.getAttribute("OutputXML") %>";
                                <% } else {%>
                                	 document.inputForm.opXml.value = "";
                                	 //document.inputForm.opXml.disabled= "true";
                                	 document.inputForm.resPageBut.disabled = "true";
                                <% } %>
                                
                                
                                
                                <% if(request.getAttribute("Route") != null) { %> 
					<% if(request.getAttribute("Route").equals("MQ")) { %>
						document.inputForm.Router[0].checked = "true";
					<% } else if(request.getAttribute("Route").equals("TCP")) { %>
						document.inputForm.Router[1].checked = "true";
					<% } else if(request.getAttribute("Route").equals("HTTP")) { %>
						document.inputForm.Router[2].checked = "true";
					<% }  else { %>
						document.inputForm.Router[3].checked = "true";
					<% }%>
				 <% } %>
				
				
				
				<% if(request.getAttribute("WSPDisplayFlg") != null) { %> 
					<% if(request.getAttribute("WSPDisplayFlg").equals("N")) { %>
						document.inputForm.WSPFlag.checked = "true";
					<% } %> 
				<% } %>
					
			}
			
		</script>

	</head>
	<body onLoad='init()' text=#000000 bgColor= #99CCCC leftmargin=0 topmargin=0 marginwidth=0 marginheight=0>
		<FORM name=inputForm  method=post ACTION="XMLMsgServlet" align=center onsubmit='return inputValid()'>
			<BR>
			<H3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;FINACLE INTEGRATOR XML MESSAGE TESTING INTERFACE</H3>
			<BR>

			<TABLE BORDER=0>
				<TR>
					<TH/>
					<TH ALIGN=CENTER><small>REQUEST XML</small></TH>
					<TH/>
					<TH ALIGN=CENTER><small>RESPONSE XML</small></TH>
				</TR>

				<TR>
						<TD width=20></TD>
						<TD>
							<TEXTAREA name="ipXml" rows=20 cols=55 wrap=off></TEXTAREA>
						</TD>
						<TD width=20></TD>
						<TD>
							<TEXTAREA name="opXml" rows=20 cols=55 wrap=off></TEXTAREA>
						</TD>
				</TR>
			</TABLE>
			
			<BR>

			<TABLE align=left>
				<TD width=20/>
				<TD valign="top">

						<TABLE align=left BORDER=1 cellspacing="0">
							<TD width=300 height=88 valign="top">
							<small>Enter the input XML message in the left handside text area. The XML should be of Finacle format. Press on Submit to view the response message in the right hand side text area. Then press on ResultPage to view the response in tabular format.</small>
							</TD>
						</TABLE>
				</TD>
				<TD width=20/>
				<TD valign="top">
					<TABLE ALIGN=CENTER border=1 cellspacing="0">
						<TR>
							<TH colSpan=3><small>ROUTES <small></TH>
						</TR>
						<TD><INPUT type=radio value=MQ name=Router CHECKED STYLE="font-size: 12px; font-weight: bold"><small>XML/MQ Route</small></TD>
						<TD><INPUT type=radio value=TCP name=Router STYLE="font-size: 12px; font-weight: bold"><small>XML/TCP Route</small>
						<TD><INPUT type=radio value=HTTP name=Router STYLE="font-size: 12px; font-weight: bold"><small>XML/HTTP Route</small></TD>
                                                <TD><INPUT type=radio value=WEB name=Router STYLE="font-size: 12px; font-weight: bold"><small>Webservices Route</small></TD>
						</TD><TR></TR>
					</TABLE>
					<TABLE ALIGN=LEFT border=1 cellspacing="0">
						<TR>
							<TH colSpan=3><small>RESULT PAGE <small></TH>
						</TR>
						<TR>
							<TD><INPUT type=checkbox name=WSPFlag value="N" STYLE="font-size: 12px; font-weight: bold">&nbsp;&nbsp;&nbsp;</TD>
							<TD><small>Do not display blank fields in the result page.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</small></TD>
						</TR>
					</TABLE>
				</TD>
				<TD width=45/>
				<TD valign="top">

						<TABLE border=0 cellspacing="0">
						<TR>
							<TD height=45 align="right" valign="top">
								<INPUT type="Submit" VALUE="    Submit   " name="submitBut" STYLE="font-size: 12px; font-weight: bold"/>
							</TD>
						</TR>
						<TR>
							<TD height=45 >
								<INPUT type="button" VALUE="   Clear   " name="clearBut" onclick="clearTextArea()" STYLE="font-size: 12px; font-weight: bold"/>
								<INPUT type="Submit" VALUE="ResultPage" name="resPageBut" STYLE="font-size: 12px; font-weight: bold"/>
							</TD>
						</TR>
						</TABLE>
				</TD>
			</TABLE>

			<BR>
			<BR>

			<TABLE align=left border=0>
			</TABLE>

		</FORM>
	</body>
</html>