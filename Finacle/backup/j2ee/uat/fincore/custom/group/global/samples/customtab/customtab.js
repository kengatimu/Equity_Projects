<%	
  applcommon.TabResource tabRes = (applcommon.TabResource) ARJspRep.getVal("tabRes");
            
  int filePresence = tabRes.checkLiteralFileExistance(pageContext);
  String fileName = tabRes.getTabParentGroup()+"_"+tabRes.getTabResName()+"_"+LocaleMapper.getLangCode(pageContext)+".js";
  if(filePresence == 0)
  {
%>

<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("resource_functions.js",sProfileId)%>"></script>
<script language="javascript" src="../Renderer/javascripts/jspjs/<%=LocaleMapper.getLangCode(pageContext)%>/<%= VRPKeys.getResourceFile((tabRes.getTabParentGroup()+"_"+tabRes.getTabResName()+"_"+LocaleMapper.getLangCode(pageContext)+".js" ))%>"></script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("tabgen_link.js",sProfileId)%>"></script>
<script language="javascript">

var verticalTabPosition = 120;
var tabResourceDetails = <%=tabRes.getTabDetailsInJsArray()%>;
convertTabLiterals(tabResourceDetails, jstabResArr);
var DynaTabGen = new DynaTabGenClass("<%=tabRes.getSelectedTab()%>", <%=tabRes.getErrFlg()%>);
DynaTabGen.writeHtmlTabString(tabResourceDetails, verticalTabPosition);

</script>
<%
}
else
{
%>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("tabgen_link.js",sProfileId)%>"></script>
<script language="javascript">
	var fileName = '<%=ParseValue.checkString(fileName)%>';
	var filePresence = '<%=ParseValue.checkString(filePresence)%>';
	printErrorBlock(fileName,filePresence);
</script>
<%
}
%>