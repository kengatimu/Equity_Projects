<%@ page contentType="text/html; charset=utf-8" %>
<%!
	public static final String _ARJSP_JSP_NAME = "custom/jsp/setSession.jsp";
%>

<%@ include file="../commonInclude.jsp" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
</head>
<body class="cbody">
<P>Processing......</P>
<img src="../Renderer/images/wait.gif">
<%
/**
 * setSession.jsp 
 * @author	- Vipul Bhopal
 * @version	- 1.00
 * @description	- Candy API jsp file
 */
	String signal = request.getParameter("signal");
	String inpArr = request.getQueryString();
	String sb = null;
	int i=2;
	
	if(signal.equals("C")){
		String inpCount = request.getParameter("inpCount");
		String[] inpValArr = inpArr.split("&"); 
		for(i=2; i <= Integer.parseInt(inpCount) + 1; i++)
		{
			String[] temp = inpValArr[i].split("=");
			session.setAttribute(temp[0],temp[1]);
		}
		sb = "0";
	}
	if(signal.equals("U")){
		sb = "";
		String[] inpValArr = inpArr.split("&");	
		String inpCount = request.getParameter("inpCount");
		for(i=2; i <= Integer.parseInt(inpCount) + 1; i++)
                {
			System.out.println(inpValArr[i]);
			sb = sb + (String)session.getAttribute(inpValArr[i]);
			if(i != Integer.parseInt(inpCount) + 1) {
				sb = sb + "|";
			}
                }
	}
	if(signal.equals("E")){
		String[] inpValArr = inpArr.split("&");
		String inpCount = request.getParameter("inpCount");
		for(i=2; i <= Integer.parseInt(inpCount) + 1; i++)
		{
			session.removeAttribute(inpValArr[i]);
		}
		sb = "0";
	}

%>

<script language ="javascript">
	window.returnValue = '<%=sb%>';
	top.close();
</script>
</body>
</html>
