<html>
<%@ include file="../../../custom/commonInclude.jsp" %>
<%
    ContextManager ARJspCurr =(ContextManager)session.getAttribute("CustomARJspCurr");
        String sGroupName = ARJspCurr.getCurrentGroup();
        SecurityInfo70 securityInfo = (SecurityInfo70)session.getAttribute("FinUserInfo");
        String schmCode = (String)ARJspCurr.getInput(sGroupName+".schmCode", "");
        String ccyCode = (String)ARJspCurr.getInput(sGroupName+".crncyCode", "");

%>

<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("common_functions.js",sProfileId)%>"></script>
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getFile("custom_functions.js",sProfileId)%>"></script>
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("cust_fetch_list.js",sProfileId)%>"></script>
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("cust_list.js",sProfileId)%>"></script>

</html>
