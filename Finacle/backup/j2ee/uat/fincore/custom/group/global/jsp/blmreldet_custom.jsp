<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : blmreldet_custom.jsp
<!--Description       : This jsp includes cifId searcher and auto populate the details of related party.
<!--Date              : 13-08-2013
<!--Author            : Priyanka T
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HBLMM
<!--Modification History:
<!--    Version No.     Date            Author          Description
<!--    -----------     ------          ----------      ---------------------------
<!--    0.1             13-08-2013      Priyanka T            Original version
<!---------------------------------------------------------------------------------------------------------------->

<%@ page import="com.infy.bbu.jsputil.*" %>
<%@ page import="java.util.*" %>
<%@ page session="true"%>
<%@ include file='../commonInclude.jsp'%>

<SCRIPT language="javascript" src="../../javascripts/common_functions.js" ></SCRIPT>
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>
<script language="javascript" src="../Renderer/javascripts/lists/<%=VRPKeys.getFile("showCustId.js",sProfileId)%>" > </script>

<script>
//Changes done for TO - 357290

function pre_ONLOAD(obj)
{
    	var fullHtml = document.forms[0].all('freeText1').parentNode.innerHTML;
    	var newHtml = "&nbsp;<A id=\"sLnk7\" href=\"javascript:displayCustId(funcCode);\" ><img  src=\"../Renderer/images/INFENG/search_icon.gif\" width=\"16\" height=\"17\" border=\"0\" hotKeyId=\"search7\"></a>";
    	document.forms[0].all('freeText1').parentNode.innerHTML = fullHtml + newHtml;
    	document.forms[0].all('freeText1').hotKeyId ="search7";
}

function blmreldet_ONCHANGE(obj)
{
	if(obj.id == "freeText1")
	{
		fnGetCustInfo();
	}
}
	
function displayCustId(funcCode){
	if(funcCode  == "V" || funcCode  == "X")
	{
		showVerfyPendList("CCMG",funcCode,"","","M","F",document.forms[0].freeText1,"","");
	} 
	else
	{
		showCustId(document.forms[0].freeText1,'ctrl','F');
		fnGetCustInfo();
   	}
}

function fnGetCustInfo(){
	objForm = document.forms[0];
      	if(!fnIsNull(objForm.freeText1.value))
      	{
		var rtn = sendDataToServer('myframe','CIFID','F','freeText1','name|address1|address2|address3|city|state|country|postalCode|telNo1|telNo2|emailId|cityName|stateName|countryName|faxNo');
		if(fnIsNull(objForm.telNo2.value))
		{
			objForm.telNo2.value = objForm.telNo1.value;
		}
                if(rtn==false)
                {
					fnClearAddrFld();
					objForm.freeText1.focus();
                }
     	}
     	else if(fnIsNull(objForm.freeText1.value))
     	{
			fnClearAddrFld();
     	}
}


 function fnClearAddrFld(){
       objForm.name.value="";
       objForm.address1.value="";
       objForm.address2.value="";
       objForm.address3.value="";
       objForm.city.value="";
       objForm.cityName.value="";
       objForm.postalCode.value="";
       objForm.state.value="";
       objForm.stateName.value=""
       objForm.country.value="";
       objForm.countryName.value=""
       objForm.telNo1.value="";
       objForm.telNo2.value="";
       objForm.emailId.value="";
       objForm.faxNo.value="";
}


</script>

