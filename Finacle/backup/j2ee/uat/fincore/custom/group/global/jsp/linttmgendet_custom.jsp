<!-------------------------------------------------------------------------------------------------------------->
<!--Name                : linttmgendet_custom.jsp
<!--Description         : This is used to disable cust pref and Default the start date
<!--Date                : 11-05-2017 
<!--Author              : Jane
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HLINTTM
<!--Modification History:
<!--    Version No.           Date                       Author                 Description
<!--    -------         ----------                       -----------        ------------------
<!--     0.1            11-05-2017                       Jane          Original version
<!---------------------------------------------------------------------------------------------------------------->
<html>
<%@ include file="/custom/commonInclude.jsp" %>
<%
    ContextManager ARJspCurr =(ContextManager)session.getAttribute("CustomARJspCurr");
        String sGroupName = ARJspCurr.getCurrentGroup();
        SecurityInfo70 securityInfo = (SecurityInfo70)session.getAttribute("FinUserInfo");
        String  acctNo = (String)ARJspCurr.getInput(sGroupName+".laAcct", "");
        String funcCode = (String)ARJspCurr.getInput(sGroupName+".funcCode", "");
        String crncyCode = (String)ARJspCurr.getInput(sGroupName+".crncyCode", "");

%>

<script language="javascript" src="../../javascripts/common_functions.js" > </script>
<script language="javascript" src="../../javascripts/cust_post_evt.js" ></script>
<script language="javascript" src="../../javascripts/cust_pre_evt.js" ></script>
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>
<script language="javascript" src="../Renderer/custom/javascripts/linttmgendet_cust.js" ></script>
<script type="text/javascript">

function linttmgendet_pre_ONLOAD(obj)
{
	if (mopId == "HLINTTM")
	{
	document.forms[0].custPrefInt.disabled=true;

		
		
			var input      = "";
            var outputNames    = "output|outVal";
            var scrName     =   "b_workclass.scr";
            var retVal = appFnExecuteScript(input,outputNames,scrName,false);
            var retBuff = retVal.split("|");
            var output = retBuff[0];
            var value = retBuff[1];
            var a = value;
			//alert(a);
			if ((a!= 600)&& (a!= 650)&& (a!= 999) && (a!= 310) && (a!= 311))
			{
				startDate=BODDate;
				disableFields("startDate");
			}
		dateVal();
	}

}

function dateVal() 

	{
        var acctNum="<%=acctNo%>";

	var input ="acctNum|" + acctNum;
	var outputNames ="errorFlg|errorMsg";
	var scrName ="hlinttmVal.scr";
	var retVal = appFnExecuteScript(input,outputNames,scrName,false);
	var result = retVal.split("|");
                                                                var errorFlg = result[1];
                                                                var errorMsg = result[3];
	if (errorFlg == "Y") {
	 disableFields("startDate");
	hideImage("daysOfMonth3Pos");
}
	else{
	enableFields("startDate");	
	showImage("daysOfMonth3Pos");
	}
}
</script>
</html>
