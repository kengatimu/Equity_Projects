<!---------------------------------------------------------------------------------------------------------------->
<!--Name		: cust_showtextarea.jsp
<!--Description		: This jsp is used to populate a new popup window
<!--Date		: 01-08-2013
<!--Author		: Priyansh
<!--Called By		: 
<!--Calling jsp		: None
<!--Menu Option		: 
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------         -----------        ------------------
<!--     0.1            01-08-2013         Priyansh             Original version
<!---------------------------------------------------------------------------------------------------------------->

<%
         String sProfileId   = ProfilesManager.getProfileInSession(session);
%>

<%
	String textVal = request.getParameter("inputVal")!=null?request.getParameter("inputVal"):"";
	String noOfChar = request.getParameter("noofchar")!=null?request.getParameter("noofchar"):"";
	String funcCode = request.getParameter("funcCode")!=null?request.getParameter("funcCode"):"";
%>
<html>
<head>
<TITLE>Message Text Editor</TITLE>
<LINK href="../../Renderer/stylesheets/<%=VRPKeys.getFile("services.css",sProfileId)%>" rel=STYLESHEET  title="Finacle Stylesheet" type="text/css" />

<script type="text/javascript">
function sendValues(obj) 
{
	var txtArea = document.getElementById("txtArea").value;
	
/*	if( txtArea == "" )
	{
		alert("Enter text");
		document.getElementById("txtArea").focus();
		return false;
	}*/
	var validate = fnCheckTextArea()
	if (validate == false)
	{
		return false;
	}
	if (validate == true)
	{
		sendObj={txtArea:document.getElementById("txtArea").value};
		window.returnValue = sendObj;
		window.close();
	}
}
function fnClearClk()
{
        var funcCode =  "<%=funcCode%>";
        if( funcCode=='I' ||  funcCode=='V' || funcCode=='X' )
	{
		return true;
	}
	else
	{
		document.getElementById("txtArea").value = "";
	}

}
function fnCancelClk()
{
	window.close();
}
function fnCheckTextArea()
{
	var cnt;
	var noOfChar = "<%=noOfChar%>";
        var txtArea = document.getElementById("txtArea").value
	var textArray = null;
        if(txtArea.indexOf('\n'))
	{
		textArray = txtArea.split('\n');
	}
	else
	{
		textArray =     new Array(1);
		textArray[0] = txtArea;
	}
	if(textArray.length > 1)
	{
		alert("Maximum number of rows allowed is 1");
		return false;
	}
	else
	{
        	len = txtArea.length;
		if (len > noOfChar)
		{
			alert("Maximum Number of Characters allowed is : " + noOfChar);
			return false;
		}
		else
		{
		return true;
		}
	}
}

function fnonload()
{
	var funcCode =  "<%=funcCode%>";
	if( funcCode=='I' ||  funcCode=='V' || funcCode=='X' )
	{
		document.getElementById("txtArea").setAttribute('disabled',true);
	}
	else
	{
		document.getElementById("txtArea").focus();
	}
}

</script>
</head>

<body onload="fnonload()">
<td class="popactivetab1" >Message Text Editor</td>
<table border="1" cellpadding="0" cellspacing="0" width="100%">
<tr valign="top">
<td >
<textarea  name="txtArea" id="txtArea" rows="27" cols="70"><%=textVal%></textarea>
</td>
</tr>
</table>
<INPUT TYPE="button"  class="button"  VALUE="Submit" size = 1 onClick = "javascript:sendValues(this);">
<INPUT TYPE="reset"  class="button" VALUE="Clear" size = 1 onClick = "fnClearClk()">
<INPUT TYPE="reset"  class="button" VALUE="Cancel" size = 1 OnClick = "fnCancelClk()">
</body>
</html>
