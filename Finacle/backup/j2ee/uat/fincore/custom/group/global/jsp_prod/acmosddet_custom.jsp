<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : acmosddet_custom.jsp 
<!--Description         : This file should reside in finbranch/custom/jsp folder.
<!--Date                : 24-01-2013
<!--Author              : Farhan
<!--Called By           : NA
<!--Calling jsp         : NA
<!--Menu Option         : HACM
<!--Modification History:
<!--    Version No.           Date                 Author                Description
<!--    ---------           ----------            ----------          -----------------
<!--     0.1                24-01-2013             Farhan              Original version
<!--         	            14-03-2013             Shishira            
<!---------------------------------------------------------------------------------------------------------------->
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>
<%@ include file="../commonInclude.jsp" %>

<custom:getRepository/>
<%
        String sProcRequestRet = null;
        String sFirstAccess    = (String)ARJspRep.getVal("IsFirstAccess");
        if (sFirstAccess == null)
        {
        //          sProcRequestRet = customBeanInst.procRequest();
                                ARJspRep.setVal("IsFirstAccess", "NO");
        }

        FABCommon.SecurityInfo70 securityInfo = (FABCommon.SecurityInfo70)session.getAttribute("FinUserInfo");
        if(null == securityInfo)
        {
                securityInfo = (FABCommon.SecurityInfo70)session.getAttribute("UserInfo");
        }

String workClass  = (String)((securityInfo.userWorkClass));
%>
<script type="text/javascript">
function acmosddet_pre_ONLOAD(obj)
{
		//alert("verification");
		var inputNameValues = "";
		var outputNames     = "status";
		var scrName         = "classvaldp001.scr";
		var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
		var ret = retVal.split("|");
		//alert(ret[0]);
		//alert(ret[1]);

		 if(ret[0] == "Error")
		 {
            		//alert(ret[1]);
            		return false;
        	 }

		else
		{
			if (ret[1] == "Y")
			{
				//alert("inside protected ");
				fnEnableDisableRadioButtons(document.getElementsByName("acctStatus"),'D');
			}
		}

        var inputNameValues = "moduleName" + "|" + "ACCOUNT_OPENING" + "|" + "parameterId" + "|" + "ACCTOP_WKCLS";
        var outputNames = "parameterVal";
        var scrName = "getCparamValForJsp.scr";
        var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret = retVal.split("|");
        var opMsg = ret[0];
        if(opMsg == "parameterVal")
	{
				var split = ret[1].split(",");
				var setWorkCls1=split[0];
				var setWorkCls2=split[1];
				var setWorkCls3=split[2];
				var setWorkCls4=split[3];
	}
		var workCls="<%=workClass%>";

		//alert(minBal);
        if( (workCls!=setWorkCls1) && (workCls!=setWorkCls2) && (workCls!=setWorkCls3) && (workCls!=setWorkCls4) )
	{

			var radioButtons = document.getElementsByName('acctStatus');
			//alert(workCls);
			//alert(minBal);
                		radioButtons[0].disabled = true;
                		radioButtons[1].disabled = true;
                		radioButtons[2].disabled = true;
	}
}

</script>
