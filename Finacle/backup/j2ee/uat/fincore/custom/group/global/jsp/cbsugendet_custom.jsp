<!------------------------------------------------------------------------------------------------>
<!--    Name        :   cbsugendet_custom.jsp                                                   -->
<!--    Menu        :   HCBSU                                                                   -->
<!--    Author      :   Nithya Murugesan                                                        -->
<!--    Description :   customization done for collection the charges.                          --> 
<!--    <Serial No>     <Date>          <Author>        <Description>                           -->
<!--     0.1           02-AUG-2013       Nithya         Original version                        -->
<!------------------------------------------------------------------------------------------------>
<%@ page import="com.infy.bbu.jsputil.*" %>
<%@ page import="java.util.*" %>
<%@ page session="true"%>
<%@ include file='../commonInclude.jsp'%>

<SCRIPT language="javascript" src="../../javascripts/common_functions.js" ></SCRIPT>
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>
<script language="JavaScript" src="../Renderer/custom/javascripts/rbcz_<%=LocaleMapper.getLangCode(pageContext)%>.js" ></script>
<script language="javascript" src="../Renderer/javascripts/lists/<%=VRPKeys.getFile("getEvtIdList.js",sProfileId)%>" > </script>

<script>
function pre_ONLOAD(obj)
{
    var fullHtml = document.forms[0].all('freeText1').parentNode.innerHTML;
    //var newHtml = "&nbsp;<A id=\"sLnk6\" href=\"javascript:showDynCritSearcher(\'HSREVTID\',\'\',\':freeText1=event_id\',\'Wintype1\')\" ><img  src=\"../Renderer/images/INFENG/search_icon.gif\" width=\"16\" height=\"17\" border=\"0\" hotKeyId=\"search6\"></a>";
    var newHtml = "&nbsp;<A id=\"sLnk6\" href=\"javascript:getEvtIdList(objForm.freeText1,\'ctrl\',\'F\',null,\'N\',\'Y\',\'GCHRG\')\" ><img  src=\"../Renderer/images/INFENG/search_icon.gif\" width=\"16\" height=\"17\" border=\"0\" hotKeyId=\"search6\"></a>";
    document.forms[0].all('freeText1').parentNode.innerHTML = fullHtml + newHtml;
    document.forms[0].all('freeText1').hotKeyId ="search6";
}
function cbsugendet_pre_ONCHANGE(obj)
{
    if(obj.id == "pymtMode")
    {
        if(document.forms[0].pymtMode.value == "R")
        {
            document.forms[0].freeText1.disabled = true;
            hideImage("sLnk6");
        }
        else
        {
            document.forms[0].freeText1.disabled = false;
            showImage("sLnk6");
        }
        
    }
}

function cbsugendet_pre_ONLOAD(obj)
{
    if(funcCode == "I" || funcCode == "D")
    {
        document.forms[0].freeText1.disabled = true;
        hideImage("sLnk6");
    }
}
</script>
