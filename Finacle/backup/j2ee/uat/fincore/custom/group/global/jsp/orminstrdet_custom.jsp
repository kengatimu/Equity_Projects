<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : orminstrdet_custom.jsp
<!--Description         : This file should reside in finbranch/custom/jsp folder.This is used to pass 
<!--                      the values
<!--Date                : 13-03-2013
<!--Author              : Shilpa
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HORM/HIRM
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------         -----------        ------------------
<!--     0.1            13-03-2013           Shilpa           Original version

<!---------------------------------------------------------------------------------------------------------------->
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>
<%@ include file="../commonInclude.jsp" %>
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<arjsp:init groupName="orminstr" isEntryPoint="false" />
<script type ="text/javascript">
function orminstrdet_pre_ONCLICK(obj)
{
	setFieldsToCustomData("Name","addrBB1");
}
function orminstrdet_pre_TAB_SWITCH(obj)
{
	setFieldsToCustomData("Name","addrBB1");
}
</script>


