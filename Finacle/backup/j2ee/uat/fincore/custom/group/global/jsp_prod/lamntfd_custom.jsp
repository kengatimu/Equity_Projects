<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : lamntfd_custom.jsp 
<!--Description         : This jsp is used to validate instrument start date
<!--Date                : 18-0372013
<!--Author              : Bharath Reddy B
<!--Called By           : None    
<!--Calling jsp         : None
<!--Menu Option         : HOAACLA
<!--Modification History:
<!--	Version No.	      	Date		         Author		Description
<!--	-------        		----------        	-----------	------------------
<!--     0.1	    		18-07-2013	        Bharath		Original version
<!--														
<!---------------------------------------------------------------------------------------------------------------->
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<%@ include file="../commonInclude.jsp" %>

<script type="text/javascript">
function post_ONLOAD(obj) 
{
	if(mopId == "HOAACLA")
	{
		if(sMode=="A")
		{
			var instlStartDate = document.forms[0].flowStartDate_ui;
			instlStartDate.onblur = function(){instStrtDateVal()};
			document.forms[0].flowStartDate_ui.focus();
		}
	}
}

function instStrtDateVal()
{
	var retValue = document.forms[0].customData.value;
	var ret = retValue.split("|");
	var schmCode = ret[1].toUpperCase();
	var instlmentDate = document.forms[0].flowStartDate_ui.value;
	if ( document.forms[0].flowStartDate_ui.readOnly == false )
	{
		if ( instlmentDate != "" )
		{
			var instlmentDay = instlmentDate.substring(0 ,2);	

			var inputNameValues	= "laSchmCode|" + schmCode + "|instDateDay|" + instlmentDay;
			var outputNames		= "";
			var scrName		= "laaacctopndp001.scr";
			var retVal		= appFnExecuteScript(inputNameValues, outputNames, scrName, false);
			var ret = retVal.split("|");

			if(ret[0]=="Error" && ret[1] != "" )
			{
				alert(ret[1]);
				document.forms[0].flowStartDate_ui.focus();
				return false;
			}
		}
	}
}
</script>

