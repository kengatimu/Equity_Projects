<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : ictmrej_custom.jsp
<!--Description         : This file should reside in finbranch/custom/jsp folder.This is used to pass
<!--                      the values
<!--Date                : 11-07-2013
<!--Author              : Khan
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HICTMO
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------         -----------        ------------------
<!--     0.1            11-07-2013           Khan           Original version
<!---------------------------------------------------------------------------------------------------------------->
<script language="javascript" src="../Renderer/custom/javascripts/ictmrej_cust.js" ></script>
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>

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
